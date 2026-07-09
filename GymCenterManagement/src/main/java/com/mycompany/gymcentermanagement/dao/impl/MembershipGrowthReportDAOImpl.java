/**
 * =========================================================================
 * @file          : MembershipGrowthReportDAOImpl.java
 * @description   : Implementation of MembershipGrowthReportDAO
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.MembershipGrowthReportDAO;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class MembershipGrowthReportDAOImpl extends BaseDAO implements MembershipGrowthReportDAO {
    private static final String STATUS_NEW = "new";
    private static final String STATUS_ACTIVE = "active";
    private static final String STATUS_EXPIRED = "expired";
    private static final String[] MONTH_LABELS = {
        "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
        "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"
    };

    public MembershipGrowthReportDAOImpl() {
        super();
    }

    public MembershipGrowthReportDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public List<Integer> getAvailableYears() throws SQLException {
        List<Integer> years = new ArrayList<>();
        String sql = """
                SELECT DISTINCT YEAR(m.CreatedDate) AS ReportYear
                FROM Members m
                INNER JOIN Users u ON m.UserID = u.UserID
                WHERE m.IsDeleted = 0
                  AND u.IsDeleted = 0
                ORDER BY ReportYear DESC
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                years.add(rs.getInt("ReportYear"));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return years;
    }

    @Override
    public MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException {
        DateRange currentPeriod = buildPeriod(year, month);
        DateRange previousPeriod = buildPreviousPeriod(year, month);
        MembershipGrowthSummary summary = new MembershipGrowthSummary();

        String sql = """
                WITH CurrentMembers AS (
                    SELECT m.MemberID, latest.EndDate
                    FROM Members m
                    INNER JOIN Users u ON m.UserID = u.UserID
                    OUTER APPLY (
                        SELECT TOP 1 mp.EndDate
                        FROM MemberPackages mp
                        WHERE mp.MemberID = m.MemberID
                          AND mp.IsDeleted = 0
                        ORDER BY mp.EndDate DESC, mp.MemberPackageID DESC
                    ) latest
                    WHERE m.IsDeleted = 0
                      AND u.IsDeleted = 0
                      AND m.CreatedDate >= ?
                      AND m.CreatedDate < ?
                ),
                PreviousMembers AS (
                    SELECT m.MemberID
                    FROM Members m
                    INNER JOIN Users u ON m.UserID = u.UserID
                    WHERE m.IsDeleted = 0
                      AND u.IsDeleted = 0
                      AND m.CreatedDate >= ?
                      AND m.CreatedDate < ?
                )
                SELECT
                    (SELECT COUNT(*) FROM CurrentMembers) AS NewMembers,
                    (SELECT COUNT(*) FROM CurrentMembers WHERE EndDate >= CAST(GETDATE() AS date)) AS ActiveMembers,
                    (SELECT COUNT(*) FROM CurrentMembers WHERE EndDate < CAST(GETDATE() AS date)) AS ExpiredMembers,
                    (SELECT COUNT(*) FROM PreviousMembers) AS PreviousPeriodNewMembers
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setDate(1, Date.valueOf(currentPeriod.startDate));
            stmt.setDate(2, Date.valueOf(currentPeriod.endDate));
            stmt.setDate(3, Date.valueOf(previousPeriod.startDate));
            stmt.setDate(4, Date.valueOf(previousPeriod.endDate));
            rs = stmt.executeQuery();

            if (rs.next()) {
                summary.setNewMembers(rs.getInt("NewMembers"));
                summary.setActiveMembers(rs.getInt("ActiveMembers"));
                summary.setExpiredMembers(rs.getInt("ExpiredMembers"));
                summary.setPreviousPeriodNewMembers(rs.getInt("PreviousPeriodNewMembers"));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }

        if (summary.getPreviousPeriodNewMembers() > 0) {
            double growthRate = (summary.getNewMembers() - summary.getPreviousPeriodNewMembers()) * 100.0
                    / summary.getPreviousPeriodNewMembers();
            summary.setGrowthRate(growthRate);
        }
        return summary;
    }

    @Override
    public List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException {
        if (month == null) {
            return getYearGrowthChart(year);
        }
        return getMonthGrowthChart(year, month);
    }

    @Override
    public List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException {
        List<MembershipGrowthMember> members = new ArrayList<>();
        String sql = buildMemberDataCte()
                + """
                SELECT MemberID, FullName, Gender, Phone, PackageName, RegistrationDate,
                       MembershipEndDate, MembershipStatus
                FROM MemberData
                WHERE (? IS NULL
                    OR ? = 'new'
                    OR (? = 'active' AND MembershipStatus = 'Active')
                    OR (? = 'expired' AND MembershipStatus = 'Expired'))
                ORDER BY RegistrationDate DESC, MemberID DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            int index = bindMemberFilters(stmt, year, month, status, searchKeyword);
            stmt.setInt(index++, Math.max(0, offset));
            stmt.setInt(index, Math.max(1, limit));
            rs = stmt.executeQuery();
            while (rs.next()) {
                members.add(mapMember(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return members;
    }

    @Override
    public int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException {
        String sql = buildMemberDataCte()
                + """
                SELECT COUNT(*) AS Total
                FROM MemberData
                WHERE (? IS NULL
                    OR ? = 'new'
                    OR (? = 'active' AND MembershipStatus = 'Active')
                    OR (? = 'expired' AND MembershipStatus = 'Expired'))
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            bindMemberFilters(stmt, year, month, status, searchKeyword);
            rs = stmt.executeQuery();
            return rs.next() ? rs.getInt("Total") : 0;
        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    @Override
    public List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return getMemberGrowthList(year, month, STATUS_NEW, searchKeyword, offset, limit);
    }

    @Override
    public List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return getMemberGrowthList(year, month, STATUS_ACTIVE, searchKeyword, offset, limit);
    }

    @Override
    public List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return getMemberGrowthList(year, month, STATUS_EXPIRED, searchKeyword, offset, limit);
    }

    private List<MembershipGrowthChartPoint> getYearGrowthChart(int year) throws SQLException {
        List<MembershipGrowthChartPoint> points = new ArrayList<>();
        DateRange period = buildPeriod(year, null);
        String sql = """
                WITH MonthNumbers AS (
                    SELECT 1 AS PeriodNumber UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
                    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
                    UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
                )
                SELECT mn.PeriodNumber, COUNT(u.UserID) AS MemberCount
                FROM MonthNumbers mn
                LEFT JOIN Members m ON m.IsDeleted = 0
                    AND m.CreatedDate >= ?
                    AND m.CreatedDate < ?
                    AND MONTH(m.CreatedDate) = mn.PeriodNumber
                LEFT JOIN Users u ON m.UserID = u.UserID
                    AND u.IsDeleted = 0
                GROUP BY mn.PeriodNumber
                ORDER BY mn.PeriodNumber
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setDate(1, Date.valueOf(period.startDate));
            stmt.setDate(2, Date.valueOf(period.endDate));
            rs = stmt.executeQuery();
            while (rs.next()) {
                int periodNumber = rs.getInt("PeriodNumber");
                points.add(new MembershipGrowthChartPoint(
                        periodNumber,
                        MONTH_LABELS[periodNumber - 1],
                        rs.getInt("MemberCount")));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return points;
    }

    private List<MembershipGrowthChartPoint> getMonthGrowthChart(int year, int month) throws SQLException {
        List<MembershipGrowthChartPoint> points = new ArrayList<>();
        DateRange period = buildPeriod(year, month);
        int lastDay = YearMonth.of(year, month).lengthOfMonth();
        String sql = """
                WITH DayNumbers AS (
                    SELECT 1 AS PeriodNumber
                    UNION ALL
                    SELECT PeriodNumber + 1
                    FROM DayNumbers
                    WHERE PeriodNumber < ?
                )
                SELECT dn.PeriodNumber, COUNT(u.UserID) AS MemberCount
                FROM DayNumbers dn
                LEFT JOIN Members m ON m.IsDeleted = 0
                    AND m.CreatedDate >= ?
                    AND m.CreatedDate < ?
                    AND DAY(m.CreatedDate) = dn.PeriodNumber
                LEFT JOIN Users u ON m.UserID = u.UserID
                    AND u.IsDeleted = 0
                GROUP BY dn.PeriodNumber
                ORDER BY dn.PeriodNumber
                OPTION (MAXRECURSION 31)
                """;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, lastDay);
            stmt.setDate(2, Date.valueOf(period.startDate));
            stmt.setDate(3, Date.valueOf(period.endDate));
            rs = stmt.executeQuery();
            while (rs.next()) {
                int periodNumber = rs.getInt("PeriodNumber");
                points.add(new MembershipGrowthChartPoint(
                        periodNumber,
                        "Ngày " + periodNumber,
                        rs.getInt("MemberCount")));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return points;
    }

    private String buildMemberDataCte() {
        return """
                WITH LatestPackage AS (
                    SELECT mp.MemberID, gp.PackageName, mp.EndDate,
                           ROW_NUMBER() OVER (
                               PARTITION BY mp.MemberID
                               ORDER BY mp.EndDate DESC, mp.MemberPackageID DESC
                           ) AS RowNumber
                    FROM MemberPackages mp
                    LEFT JOIN GymPackages gp ON mp.PackageID = gp.PackageID
                        AND gp.IsDeleted = 0
                    WHERE mp.IsDeleted = 0
                ),
                MemberData AS (
                    SELECT m.MemberID,
                           u.DisplayName AS FullName,
                           m.Gender,
                           u.Phone,
                           COALESCE(lp.PackageName, N'N/A') AS PackageName,
                           CAST(m.CreatedDate AS date) AS RegistrationDate,
                           lp.EndDate AS MembershipEndDate,
                           CASE
                               WHEN lp.EndDate IS NULL THEN m.MembershipStatus
                               WHEN lp.EndDate >= CAST(GETDATE() AS date) THEN 'Active'
                               ELSE 'Expired'
                           END AS MembershipStatus
                    FROM Members m
                    INNER JOIN Users u ON m.UserID = u.UserID
                    LEFT JOIN LatestPackage lp ON lp.MemberID = m.MemberID
                        AND lp.RowNumber = 1
                    WHERE m.IsDeleted = 0
                      AND u.IsDeleted = 0
                      AND m.CreatedDate >= ?
                      AND m.CreatedDate < ?
                      AND (? IS NULL
                          OR CAST(m.MemberID AS varchar(20)) LIKE ?
                          OR CONCAT('MEM-', m.MemberID) LIKE ?
                          OR u.DisplayName LIKE ?)
                )
                """;
    }

    private int bindMemberFilters(PreparedStatement stmt, int year, Integer month, String status,
            String searchKeyword) throws SQLException {
        DateRange period = buildPeriod(year, month);
        String normalizedSearch = normalizeBlank(searchKeyword);
        String searchPattern = normalizedSearch == null ? null : "%" + normalizedSearch + "%";
        String normalizedStatus = normalizeStatus(status);

        int index = 1;
        stmt.setDate(index++, Date.valueOf(period.startDate));
        stmt.setDate(index++, Date.valueOf(period.endDate));
        stmt.setString(index++, normalizedSearch);
        stmt.setString(index++, searchPattern);
        stmt.setString(index++, searchPattern);
        stmt.setString(index++, searchPattern);
        stmt.setString(index++, normalizedStatus);
        stmt.setString(index++, normalizedStatus);
        stmt.setString(index++, normalizedStatus);
        stmt.setString(index++, normalizedStatus);
        return index;
    }

    private MembershipGrowthMember mapMember(ResultSet rs) throws SQLException {
        MembershipGrowthMember member = new MembershipGrowthMember();
        member.setMemberId(rs.getInt("MemberID"));
        member.setFullName(rs.getString("FullName"));
        member.setGender(rs.getString("Gender"));
        member.setPhone(rs.getString("Phone"));
        member.setPackageName(rs.getString("PackageName"));

        Date registrationDate = rs.getDate("RegistrationDate");
        if (registrationDate != null) {
            member.setRegistrationDate(registrationDate.toLocalDate());
        }

        Date membershipEndDate = rs.getDate("MembershipEndDate");
        if (membershipEndDate != null) {
            member.setMembershipEndDate(membershipEndDate.toLocalDate());
        }

        member.setMembershipStatus(rs.getString("MembershipStatus"));
        return member;
    }

    private DateRange buildPeriod(int year, Integer month) {
        if (month == null) {
            LocalDate startDate = LocalDate.of(year, 1, 1);
            return new DateRange(startDate, startDate.plusYears(1));
        }

        LocalDate startDate = LocalDate.of(year, month, 1);
        return new DateRange(startDate, startDate.plusMonths(1));
    }

    private DateRange buildPreviousPeriod(int year, Integer month) {
        DateRange currentPeriod = buildPeriod(year, month);
        if (month == null) {
            return new DateRange(currentPeriod.startDate.minusYears(1), currentPeriod.endDate.minusYears(1));
        }
        return new DateRange(currentPeriod.startDate.minusMonths(1), currentPeriod.startDate);
    }

    private String normalizeStatus(String status) {
        String normalized = normalizeBlank(status);
        if (normalized == null) {
            return null;
        }
        normalized = normalized.toLowerCase(Locale.ROOT);
        if (STATUS_NEW.equals(normalized) || STATUS_ACTIVE.equals(normalized) || STATUS_EXPIRED.equals(normalized)) {
            return normalized;
        }
        return null;
    }

    private String normalizeBlank(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }

    private static class DateRange {
        private final LocalDate startDate;
        private final LocalDate endDate;

        private DateRange(LocalDate startDate, LocalDate endDate) {
            this.startDate = startDate;
            this.endDate = endDate;
        }
    }
}
