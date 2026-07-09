/**
 * =========================================================================
 * @file          : MemberDashboardDAOImpl.java
 * @description   : Lớp triển khai truy xuất CSDL phục vụ dashboard hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.MemberDashboardDAO;
import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MemberDashboardDAOImpl extends BaseDAO implements MemberDashboardDAO {

    public MemberDashboardDAOImpl() {
        super();
    }

    public MemberDashboardDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public int countUpcomingAppointments(int memberId) throws SQLException {
        String sql = """
                SELECT COUNT(*) FROM PTSchedules 
                WHERE MemberID = ? 
                  AND SessionDate >= CAST(GETDATE() AS date) 
                  AND IsDeleted = 0 
                  AND SessionStatus = 'Upcoming'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, memberId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public Map<String, Object> getActivePackageInfo(int memberId) throws SQLException {
        String sql = """
                SELECT TOP 1 gp.PackageName, mp.EndDate 
                FROM MemberPackages mp 
                INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID 
                WHERE mp.MemberID = ? 
                  AND mp.Status = 'Active' 
                  AND mp.IsDeleted = 0 
                  AND mp.EndDate >= CAST(GETDATE() AS date) 
                ORDER BY mp.EndDate DESC
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<String, Object> result = new HashMap<>();
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, memberId);
            rs = ps.executeQuery();
            if (rs.next()) {
                result.put("packageName", rs.getString("PackageName"));
                Date endDate = rs.getDate("EndDate");
                result.put("endDate", endDate != null ? endDate.toLocalDate() : null);
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return result;
    }

    @Override
    public BigDecimal getSpendThisMonth(int memberId) throws SQLException {
        String sql = """
                SELECT COALESCE(SUM(Amount), 0) FROM Invoices 
                WHERE MemberID = ? 
                  AND Status = 'Paid' 
                  AND IsDeleted = 0 
                  AND PaymentDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) 
                  AND PaymentDate < DATEADD(month, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, memberId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public int countNotifications(int userId) throws SQLException {
        String roleSql = """
                SELECT TOP 1 r.RoleName 
                FROM UserRoles ur 
                INNER JOIN Roles r ON ur.RoleID = r.RoleID 
                WHERE ur.UserID = ? AND r.IsDeleted = 0 
                ORDER BY r.RoleLevel DESC
                """;
        String notiSql = """
                SELECT COUNT(DISTINCT n.NotificationID)
                FROM Notifications n
                LEFT JOIN NotificationRecipients nr
                    ON nr.NotificationID = n.NotificationID AND nr.UserID = ?
                WHERE n.IsDeleted = 0
                  AND n.PublishDate <= SYSDATETIME()
                  AND (n.ExpiryDate IS NULL OR n.ExpiryDate > SYSDATETIME())
                  AND (n.TargetRole = ? OR n.TargetRole = 'All' OR nr.UserID IS NOT NULL)
                  AND (nr.UserID IS NULL OR nr.IsRead = 0)
                """;
        Connection conn = null;
        PreparedStatement psRole = null;
        PreparedStatement psNoti = null;
        ResultSet rsRole = null;
        ResultSet rsNoti = null;
        try {
            conn = getActiveConnection();
            psRole = conn.prepareStatement(roleSql);
            psRole.setInt(1, userId);
            rsRole = psRole.executeQuery();
            String role = "Member";
            if (rsRole.next()) {
                role = rsRole.getString("RoleName");
            }

            psNoti = conn.prepareStatement(notiSql);
            psNoti.setInt(1, userId);
            psNoti.setString(2, role);
            rsNoti = psNoti.executeQuery();
            return rsNoti.next() ? rsNoti.getInt(1) : 0;
        } finally {
            if (rsRole != null) rsRole.close();
            if (psRole != null) psRole.close();
            closeResource(conn, psNoti, rsNoti);
        }
    }

    @Override
    public List<RevenuePoint> getMonthlySpendTrend(int memberId, int months) throws SQLException {
        String sql = """
                SELECT 
                    DATEFROMPARTS(YEAR(PaymentDate), MONTH(PaymentDate), 1) AS SpendMonth,
                    SUM(Amount) AS TotalAmount
                FROM Invoices
                WHERE MemberID = ? AND Status = 'Paid' AND IsDeleted = 0
                  AND PaymentDate >= DATEADD(month, ?, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
                GROUP BY DATEFROMPARTS(YEAR(PaymentDate), MONTH(PaymentDate), 1)
                ORDER BY SpendMonth ASC
                """;
        List<RevenuePoint> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, memberId);
            ps.setInt(2, -Math.max(months - 1, 0));
            rs = ps.executeQuery();
            while (rs.next()) {
                Date date = rs.getDate("SpendMonth");
                list.add(new RevenuePoint(
                        date != null ? date.toLocalDate() : null,
                        rs.getBigDecimal("TotalAmount")
                ));
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }

    @Override
    public List<Map<String, Object>> getUpcomingSessions(int memberId, int limit) throws SQLException {
        String sql = """
                SELECT TOP (?) s.SessionDate, s.StartTime, s.EndTime, u_pt.DisplayName AS PTName, gp.PackageName, s.PTScheduleID
                FROM PTSchedules s
                INNER JOIN PTRegistrations reg ON s.PTRegistrationID = reg.PTRegistrationID
                INNER JOIN PersonalTrainers pt ON s.PTID = pt.PTID
                INNER JOIN Users u_pt ON pt.UserID = u_pt.UserID
                LEFT JOIN PTServicePrices psp ON reg.PTServicePriceID = psp.PTServicePriceID
                LEFT JOIN PTPackageTypes gp ON psp.PTPackageTypeID = gp.PTPackageTypeID
                WHERE s.MemberID = ? 
                  AND s.SessionDate >= CAST(GETDATE() AS date) 
                  AND s.IsDeleted = 0 
                  AND s.SessionStatus = 'Upcoming'
                ORDER BY s.SessionDate ASC, s.StartTime ASC
                """;
        List<Map<String, Object>> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, memberId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                Date sDate = rs.getDate("SessionDate");
                map.put("sessionDate", sDate != null ? sDate.toLocalDate() : null);
                map.put("startTime", rs.getTime("StartTime"));
                map.put("endTime", rs.getTime("EndTime"));
                map.put("ptName", rs.getString("PTName"));
                map.put("packageName", rs.getString("PackageName"));
                map.put("scheduleId", rs.getInt("PTScheduleID"));
                list.add(map);
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }

    @Override
    public List<DashboardInvoice> getRecentInvoices(int memberId, int limit) throws SQLException {
        String sql = """
                SELECT TOP (?) i.InvoiceID, i.PaymentDate, i.Amount, i.Status, gp.PackageName, i.PTRegistrationID
                FROM Invoices i
                LEFT JOIN MemberPackages mp ON i.MemberPackageID = mp.MemberPackageID
                LEFT JOIN GymPackages gp ON mp.PackageID = gp.PackageID
                WHERE i.MemberID = ? AND i.IsDeleted = 0
                ORDER BY i.InvoiceID DESC
                """;
        List<DashboardInvoice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, memberId);
            rs = ps.executeQuery();
            while (rs.next()) {
                DashboardInvoice div = new DashboardInvoice();
                int id = rs.getInt("InvoiceID");
                div.setInvoiceId(id);
                div.setInvoiceCode("INV-" + id);
                Timestamp payDate = rs.getTimestamp("PaymentDate");
                if (payDate != null) {
                    div.setPaymentDate(payDate.toLocalDateTime());
                }
                div.setAmount(rs.getBigDecimal("Amount"));
                div.setStatus(rs.getString("Status"));
                
                String pkgName = rs.getString("PackageName");
                int ptRegId = rs.getInt("PTRegistrationID");
                if (pkgName != null) {
                    div.setServiceName(pkgName);
                    div.setServiceType("Gói tập");
                } else if (ptRegId > 0) {
                    div.setServiceName("Thuê huấn luyện viên (PT)");
                    div.setServiceType("Huấn luyện");
                } else {
                    div.setServiceName("Phí dịch vụ khác");
                    div.setServiceType("Dịch vụ");
                }
                list.add(div);
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }
}
