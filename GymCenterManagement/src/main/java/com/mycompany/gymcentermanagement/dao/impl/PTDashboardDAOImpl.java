package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.PTDashboardDAO;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PTDashboardDAOImpl extends BaseDAO implements PTDashboardDAO {

    public PTDashboardDAOImpl() {
        super();
    }

    public PTDashboardDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public int countActiveMembers(int ptId) throws SQLException {
        String sql = """
                SELECT COUNT(DISTINCT r.MemberID) 
                FROM PTRegistrations r
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                WHERE sp.PTID = ? 
                  AND r.Status = 'Active' 
                  AND r.IsDeleted = 0
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public int countWeeklySessions(int ptId, LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException {
        String sql = """
                SELECT COUNT(*) 
                FROM PTSchedules 
                WHERE PTID = ? 
                  AND SessionDate >= ? 
                  AND SessionDate <= ? 
                  AND IsDeleted = 0
                  AND SessionStatus != 'Cancelled'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(startOfWeek));
            ps.setDate(3, java.sql.Date.valueOf(endOfWeek));
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public double sumCompletedTrainingHours(int ptId) throws SQLException {
        String sql = """
                SELECT COALESCE(SUM(DATEDIFF(minute, StartTime, EndTime) / 60.0), 0) 
                FROM PTSchedules 
                WHERE PTID = ? 
                  AND SessionStatus = 'Completed' 
                  AND IsDeleted = 0
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getDouble(1) : 0.0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public int countTotalTodaySessions(int ptId) throws SQLException {
        String sql = """
                SELECT COUNT(*) 
                FROM PTSchedules 
                WHERE PTID = ? 
                  AND SessionDate = CAST(GETDATE() AS Date) 
                  AND IsDeleted = 0 
                  AND SessionStatus != 'Cancelled'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public int countCompletedTodaySessions(int ptId) throws SQLException {
        String sql = """
                SELECT COUNT(*) 
                FROM PTSchedules 
                WHERE PTID = ? 
                  AND SessionDate = CAST(GETDATE() AS Date) 
                  AND IsDeleted = 0 
                  AND SessionStatus = 'Completed'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public List<Map<String, Object>> getTodaySchedule(int ptId) throws SQLException {
        String sql = """
                SELECT s.PTScheduleID, s.StartTime, s.EndTime, u.DisplayName AS MemberName, p.PackageName, s.SessionStatus, s.PTAttendanceResult, s.Note, s.CancellationReason, s.OriginalPTID, s.PTID, u_curr.DisplayName AS CurrentPTName, u_opt.DisplayName AS OriginalPTName
                FROM PTSchedules s
                INNER JOIN Members m ON s.MemberID = m.MemberID
                INNER JOIN Users u ON m.UserID = u.UserID
                INNER JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                LEFT JOIN PersonalTrainers opt ON s.OriginalPTID = opt.PTID
                LEFT JOIN Users u_opt ON opt.UserID = u_opt.UserID
                LEFT JOIN PersonalTrainers pt_curr ON s.PTID = pt_curr.PTID
                LEFT JOIN Users u_curr ON pt_curr.UserID = u_curr.UserID
                WHERE (s.PTID = ? OR s.OriginalPTID = ?) 
                  AND s.SessionDate = CAST(GETDATE() AS Date) 
                  AND s.IsDeleted = 0
                ORDER BY s.StartTime ASC
                """;
        List<Map<String, Object>> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            ps.setInt(2, ptId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("scheduleId", rs.getInt("PTScheduleID"));
                map.put("startTime", rs.getTime("StartTime"));
                map.put("endTime", rs.getTime("EndTime"));
                map.put("memberName", rs.getString("MemberName"));
                map.put("packageName", rs.getString("PackageName"));
                map.put("sessionStatus", rs.getString("SessionStatus"));
                map.put("attendanceStatus", rs.getString("PTAttendanceResult"));
                map.put("note", rs.getString("Note"));
                map.put("cancellationReason", rs.getString("CancellationReason"));
                map.put("originalPtId", rs.getObject("OriginalPTID") != null ? rs.getInt("OriginalPTID") : null);
                map.put("ptId", rs.getInt("PTID"));
                map.put("currentPtName", rs.getString("CurrentPTName"));
                map.put("originalPtName", rs.getString("OriginalPTName"));
                list.add(map);
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }
}
