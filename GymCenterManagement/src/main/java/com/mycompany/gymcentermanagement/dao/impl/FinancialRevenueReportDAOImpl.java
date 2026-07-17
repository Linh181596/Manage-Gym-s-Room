package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.FinancialRevenueReportDAO;
import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
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

public class FinancialRevenueReportDAOImpl extends BaseDAO implements FinancialRevenueReportDAO {

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public void populateRevenueSummary(FinancialRevenueReportData data, String fromDate, String toDate, String revenueType) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            
            // 1. Get Gym Package Revenue
            String sqlGym = "SELECT COALESCE(SUM(Amount), 0) FROM Invoices "
                    + "WHERE IsDeleted = 0 AND Status = 'Paid' "
                    + "AND MemberPackageID IS NOT NULL "
                    + "AND PaymentDate >= ? AND PaymentDate < DATEADD(day, 1, ?) ";
            stmt = conn.prepareStatement(sqlGym);
            stmt.setDate(1, Date.valueOf(fromDate));
            stmt.setDate(2, Date.valueOf(toDate));
            rs = stmt.executeQuery();
            if (rs.next()) {
                data.setGymPackageRevenue(rs.getBigDecimal(1));
            }
            rs.close();
            stmt.close();

            // 2. Get PT Revenue
            String sqlPT = "SELECT COALESCE(SUM(Amount), 0) FROM Invoices "
                    + "WHERE IsDeleted = 0 AND Status = 'Paid' "
                    + "AND PTRegistrationID IS NOT NULL "
                    + "AND PaymentDate >= ? AND PaymentDate < DATEADD(day, 1, ?) ";
            stmt = conn.prepareStatement(sqlPT);
            stmt.setDate(1, Date.valueOf(fromDate));
            stmt.setDate(2, Date.valueOf(toDate));
            rs = stmt.executeQuery();
            if (rs.next()) {
                data.setPtRevenue(rs.getBigDecimal(1));
            }
            rs.close();
            stmt.close();
            
            data.setTotalRevenue(data.getGymPackageRevenue().add(data.getPtRevenue()));

            // 3. Count Paid Invoices
            String typeCondition = getRevenueTypeCondition(revenueType);
            String sqlPaid = "SELECT COUNT(*) FROM Invoices i "
                    + "WHERE i.IsDeleted = 0 AND i.Status = 'Paid' "
                    + "AND i.PaymentDate >= ? AND i.PaymentDate < DATEADD(day, 1, ?) "
                    + typeCondition;
            stmt = conn.prepareStatement(sqlPaid);
            stmt.setDate(1, Date.valueOf(fromDate));
            stmt.setDate(2, Date.valueOf(toDate));
            rs = stmt.executeQuery();
            if (rs.next()) {
                data.setPaidInvoicesCount(rs.getInt(1));
            }
            rs.close();
            stmt.close();

            // 4. Count Unpaid Invoices
            String sqlUnpaid = "SELECT COUNT(*) FROM Invoices i "
                    + "WHERE i.IsDeleted = 0 AND i.Status = 'Pending' "
                    + "AND i.PaymentDate >= ? AND i.PaymentDate < DATEADD(day, 1, ?) "
                    + typeCondition;
            stmt = conn.prepareStatement(sqlUnpaid);
            stmt.setDate(1, Date.valueOf(fromDate));
            stmt.setDate(2, Date.valueOf(toDate));
            rs = stmt.executeQuery();
            if (rs.next()) {
                data.setUnpaidInvoicesCount(rs.getInt(1));
            }
            
        } finally {
            closeResource(conn, stmt, rs);
        }
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

    @Override
    public List<DashboardInvoice> getFilteredInvoices(String fromDate, String toDate, String revenueType, int limit) throws SQLException {
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
                + "AND i.PaymentDate >= ? AND i.PaymentDate < DATEADD(day, 1, ?) "
                + getRevenueTypeCondition(revenueType)
                + "ORDER BY i.PaymentDate DESC, i.InvoiceID DESC";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            stmt.setDate(2, Date.valueOf(fromDate));
            stmt.setDate(3, Date.valueOf(toDate));
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
}
