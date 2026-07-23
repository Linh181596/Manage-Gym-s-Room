/**
 * =========================================================================
 * @file          : DashboardDAOImpl.java
 * @description   : Lớp truy vấn dữ liệu tổng quan, doanh thu, hóa đơn gần đây và cảnh báo vận hành cho bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.DashboardDAO;
import com.mycompany.gymcentermanagement.dto.DashboardAlert;
import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.DashboardMetric;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAOImpl extends BaseDAO implements DashboardDAO {

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public DashboardMetric getMetrics() throws SQLException {
        DashboardMetric metric = new DashboardMetric();
        metric.setActiveMembers(queryInt(
                "SELECT COUNT(*) FROM Members m "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "WHERE m.MembershipStatus = 'Active' AND m.IsDeleted = 0 "
                + "AND u.Status = 'Active' AND u.IsDeleted = 0"));
        metric.setNewMembershipsToday(queryInt(
                "SELECT COUNT(*) FROM MemberPackages "
                + "WHERE IsDeleted = 0 AND Status = 'Active' "
                + "AND CAST(CreatedDate AS date) = CAST(GETDATE() AS date)"));
        metric.setTodayRevenue(queryDecimal(
                "SELECT COALESCE(SUM(Amount), 0) FROM Invoices "
                + "WHERE IsDeleted = 0 AND Status = 'Paid' "
                + "AND CAST(PaymentDate AS date) = CAST(GETDATE() AS date)"));
        metric.setMonthRevenue(queryDecimal(
                "SELECT COALESCE(SUM(Amount), 0) FROM Invoices "
                + "WHERE IsDeleted = 0 AND Status = 'Paid' "
                + "AND PaymentDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) "
                + "AND PaymentDate < DATEADD(month, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))"));
        metric.setActiveTrainers(queryInt(
                "SELECT COUNT(*) FROM PersonalTrainers pt "
                + "INNER JOIN Users u ON pt.UserID = u.UserID "
                + "WHERE pt.IsDeleted = 0 "
                + "AND u.Status = 'Active' AND u.IsDeleted = 0"));
        metric.setTodayPtSessions(queryInt(
                "SELECT COUNT(*) FROM PTSchedules "
                + "WHERE IsDeleted = 0 AND SessionStatus <> 'Cancelled' "
                + "AND SessionDate = CAST(GETDATE() AS date)"));
        metric.setPendingAlerts(
                queryInt("SELECT COUNT(*) FROM EquipmentIssues WHERE IsDeleted = 0 AND Status IN ('Pending', 'InProgress')")
                + queryInt("SELECT COUNT(*) FROM Invoices WHERE IsDeleted = 0 AND Status = 'Pending'")
                + queryInt("SELECT COUNT(*) FROM MemberPackages WHERE IsDeleted = 0 AND Status = 'Active' AND EndDate BETWEEN CAST(GETDATE() AS date) AND DATEADD(day, 7, CAST(GETDATE() AS date))")
                + queryInt("SELECT COUNT(*) FROM RescheduleRequests WHERE Status = 'Escalated'"));
        return metric;
    }

    @Override
    public List<RevenuePoint> getRevenueTrend(RevenueChartFilter filter) throws SQLException {
        List<RevenuePoint> points = new ArrayList<>();
        String bucketExpression = getRevenueBucketExpression(filter.getGroupBy());
        String sql = "SELECT " + bucketExpression + " AS RevenueDate, COALESCE(SUM(i.Amount), 0) AS TotalAmount "
                + "FROM Invoices i "
                + "WHERE i.IsDeleted = 0 AND i.Status = 'Paid' "
                + "AND i.PaymentDate >= ? AND i.PaymentDate < DATEADD(day, 1, ?) "
                + getRevenueTypeCondition(filter.getRevenueType())
                + "GROUP BY " + bucketExpression + " "
                + "ORDER BY RevenueDate";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setDate(1, Date.valueOf(filter.getFromDate()));
            stmt.setDate(2, Date.valueOf(filter.getToDate()));
            rs = stmt.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("RevenueDate");
                points.add(new RevenuePoint(
                        date != null ? date.toLocalDate() : null,
                        rs.getBigDecimal("TotalAmount")));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return points;
    }

    private String getRevenueBucketExpression(String groupBy) {
        if (RevenueChartFilter.GROUP_WEEK.equals(groupBy)) {
            return "DATEADD(day, -(DATEDIFF(day, '19000101', CAST(i.PaymentDate AS date)) % 7), CAST(i.PaymentDate AS date))";
        }
        if (RevenueChartFilter.GROUP_MONTH.equals(groupBy)) {
            return "DATEFROMPARTS(YEAR(i.PaymentDate), MONTH(i.PaymentDate), 1)";
        }
        return "CAST(i.PaymentDate AS date)";
    }

    private String getRevenueTypeCondition(String revenueType) {
        if (RevenueChartFilter.TYPE_GYM_PACKAGE.equals(revenueType)) {
            return "AND i.MemberPackageID IS NOT NULL ";
        }
        if (RevenueChartFilter.TYPE_PT_SERVICE.equals(revenueType)) {
            return "AND i.PTRegistrationID IS NOT NULL ";
        }
        return "";
    }

    @Override
    public List<DashboardInvoice> getRecentInvoices(int limit) throws SQLException {
        List<DashboardInvoice> invoices = new ArrayList<>();
        String sql = "SELECT TOP (?) i.InvoiceID, i.PaymentDate, i.Amount, i.Status, "
                + "u.DisplayName AS CustomerName, "
                + "CASE WHEN i.MemberPackageID IS NOT NULL THEN N'Gói tập thể hình' ELSE N'Dịch vụ huấn luyện viên cá nhân' END AS ServiceType, "
                + "COALESCE(gp.PackageName, ptpkg.PackageName, N'Dịch vụ phòng tập') AS ServiceName "
                + "FROM Invoices i "
                + "INNER JOIN Members m ON i.MemberID = m.MemberID "
                + "INNER JOIN Users u ON m.UserID = u.UserID "
                + "LEFT JOIN MemberPackages mp ON i.MemberPackageID = mp.MemberPackageID "
                + "LEFT JOIN GymPackages gp ON mp.PackageID = gp.PackageID "
                + "LEFT JOIN PTRegistrations ptr ON i.PTRegistrationID = ptr.PTRegistrationID "
                + "LEFT JOIN PTServicePrices psp ON ptr.PTServicePriceID = psp.PTServicePriceID "
                + "LEFT JOIN PTPackageTypes ptpkg ON psp.PTPackageTypeID = ptpkg.PTPackageTypeID "
                + "WHERE i.IsDeleted = 0 "
                + "ORDER BY i.PaymentDate DESC, i.InvoiceID DESC";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                DashboardInvoice invoice = new DashboardInvoice();
                int invoiceId = rs.getInt("InvoiceID");
                Timestamp paymentDate = rs.getTimestamp("PaymentDate");
                invoice.setInvoiceId(invoiceId);
                invoice.setInvoiceCode(String.format("INV-%05d", invoiceId));
                invoice.setPaymentDate(paymentDate != null ? paymentDate.toLocalDateTime() : null);
                invoice.setCustomerName(rs.getString("CustomerName"));
                invoice.setServiceName(rs.getString("ServiceName"));
                invoice.setServiceType(rs.getString("ServiceType"));
                invoice.setAmount(rs.getBigDecimal("Amount"));
                invoice.setStatus(rs.getString("Status"));
                invoices.add(invoice);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return invoices;
    }

    @Override
    public List<DashboardAlert> getOperationalAlerts() throws SQLException {
        List<DashboardAlert> alerts = new ArrayList<>();
        addCountAlert(alerts,
                "Equipment",
                "Sự cố thiết bị đang xử lý",
                "thiết bị/sự cố cần kiểm tra",
                "danger",
                "/staff/equipment-issues",
                "SELECT COUNT(*) FROM EquipmentIssues WHERE IsDeleted = 0 AND Status IN ('Pending', 'InProgress')");
        addCountAlert(alerts,
                "PT Registration",
                "Đăng ký huấn luyện viên đang chờ",
                "đăng ký huấn luyện viên chưa hoàn tất thanh toán/xử lý",
                "warning",
                "/admin/schedule/manage",
                "SELECT COUNT(*) FROM PTRegistrations WHERE IsDeleted = 0 AND (Status = 'Pending' OR PaymentStatus = 'Unpaid')");
        addCountAlert(alerts,
                "Package Expiration",
                "Gói tập sắp hết hạn",
                "gói tập hết hạn trong 7 ngày tới",
                "info",
                "/staff/members",
                "SELECT COUNT(*) FROM MemberPackages WHERE IsDeleted = 0 AND Status = 'Active' AND EndDate BETWEEN CAST(GETDATE() AS date) AND DATEADD(day, 7, CAST(GETDATE() AS date))");
        addCountAlert(alerts,
                "Pending Payment",
                "Hóa đơn đang chờ thanh toán",
                "hóa đơn đang ở trạng thái chờ",
                "warning",
                "/staff/record-payment",
                "SELECT COUNT(*) FROM Invoices WHERE IsDeleted = 0 AND Status = 'Pending'");
        addCountAlert(alerts,
                "Reschedule Complaint",
                "Yêu cầu hỗ trợ đổi lịch tập",
                "yêu cầu hỗ trợ đổi lịch đang chờ xử lý",
                "danger",
                "/admin/schedule/manage?activeTab=reschedules",
                "SELECT COUNT(*) FROM RescheduleRequests WHERE Status = 'Escalated'");
        return alerts;
    }

    private void addCountAlert(List<DashboardAlert> alerts, String type, String title, String suffix,
            String severity, String targetUrl, String sql) throws SQLException {
        int count = queryInt(sql);
        if (count > 0) {
            alerts.add(new DashboardAlert(type, title, count + " " + suffix, severity, targetUrl));
        }
    }

    private int queryInt(String sql) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    private BigDecimal queryDecimal(String sql) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
        } finally {
            closeResource(conn, stmt, rs);
        }
    }
}
