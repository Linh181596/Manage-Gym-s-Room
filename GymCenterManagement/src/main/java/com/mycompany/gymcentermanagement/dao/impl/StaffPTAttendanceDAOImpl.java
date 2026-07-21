/**
 * =========================================================================
 * @file          : StaffPTAttendanceDAOImpl.java
 * @description   : Lớp triển khai truy xuất cơ sở dữ liệu JDBC cho điểm danh Staff và PT.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.StaffPTAttendanceDAO;
import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StaffPTAttendanceDAOImpl extends BaseDAO implements StaffPTAttendanceDAO {

    public StaffPTAttendanceDAOImpl() {
        super();
    }

    public StaffPTAttendanceDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    /**
     * Kiểm tra xem nhân viên/PT đã check-in trong ca làm việc của ngày đó chưa.
     * Luồng nghiệp vụ:
     * - [BR-CONS-62]: Mỗi Staff/PT chỉ có tối đa 1 check-in record mỗi shift block trong một ngày.
     * 
     * @param userId ID nhân viên
     * @param shiftBlock Ca làm việc
     * @param date Ngày
     * @return true nếu đã check-in
     * @throws SQLException 
     */
    @Override
    public boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException {
        // SQL: Đếm số record Active, chưa bị xóa cho user trong ca và ngày đó
        String sql = """
                SELECT COUNT(*) AS Total
                FROM StaffPTAttendance
                WHERE UserID = ?
                  AND ShiftBlock = ?
                  AND AttendanceDate = ?
                  AND IsDeleted = 0
                  AND Status = 'Active'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, shiftBlock);
            ps.setDate(3, Date.valueOf(date));
            rs = ps.executeQuery();
            return rs.next() && rs.getInt("Total") > 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public int create(StaffPTAttendance attendance) throws SQLException {
        String sql = """
                INSERT INTO StaffPTAttendance
                    (CheckedInAt, UserID, UserRole, ShiftBlock, CheckedBy, Note, Status, CreatedBy, IsDeleted)
                VALUES (SYSDATETIME(), ?, ?, ?, ?, ?, 'Active', ?, 0)
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet keys = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, attendance.getUserId());
            ps.setString(2, attendance.getUserRole().name());
            ps.setString(3, attendance.getShiftBlock().name());
            ps.setInt(4, attendance.getCheckedBy());
            ps.setString(5, attendance.getNote());
            ps.setString(6, attendance.getCreatedBy());

            int affected = ps.executeUpdate();
            if (affected == 0)
                return 0;

            keys = ps.getGeneratedKeys();
            return keys.next() ? keys.getInt(1) : 0;
        } finally {
            closeResource(conn, ps, keys);
        }
    }

    /**
     * Checkout điểm danh.
     * Luồng nghiệp vụ: Cập nhật giờ checkout cho record đang Active.
     * 
     * @param attendanceId ID điểm danh
     * @param checkedBy ID người checkout (Staff/Admin)
     * @return true nếu checkout thành công
     * @throws SQLException 
     */
    @Override
    public boolean checkout(int attendanceId, int checkedBy) throws SQLException {
        // SQL: Cập nhật CheckedOutAt = SYSDATETIME() cho các record chưa checkout
        String sql = """
                UPDATE StaffPTAttendance
                SET CheckedOutAt = SYSDATETIME(),
                    UpdatedBy = CAST(? AS nvarchar(50)),
                    UpdatedDate = SYSDATETIME()
                WHERE AttendanceID = ?
                  AND IsDeleted = 0
                  AND Status = 'Active'
                  AND CheckedOutAt IS NULL
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, checkedBy);
            ps.setInt(2, attendanceId);
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    @Override
    public boolean undoCheckout(int attendanceId, int updatedBy) throws SQLException {
        String sql = """
                UPDATE StaffPTAttendance
                SET CheckedOutAt = NULL,
                    UpdatedBy = CAST(? AS nvarchar(50)),
                    UpdatedDate = SYSDATETIME()
                WHERE AttendanceID = ?
                  AND IsDeleted = 0
                  AND Status = 'Active'
                  AND CheckedOutAt IS NOT NULL
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, updatedBy);
            ps.setInt(2, attendanceId);
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    @Override
    public boolean cancel(int attendanceId, int cancelledBy) throws SQLException {
        String sql = """
                UPDATE StaffPTAttendance
                SET Status = 'Cancelled',
                    IsDeleted = 1,
                    UpdatedBy = CAST(? AS nvarchar(50)),
                    UpdatedDate = SYSDATETIME()
                WHERE AttendanceID = ?
                  AND IsDeleted = 0
                  AND Status = 'Active'
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cancelledBy);
            ps.setInt(2, attendanceId);
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    @Override
    public List<StaffPTAttendance> listUsersWithCheckinStatus(String shiftBlock, LocalDate date, String keyword) throws SQLException {
        String sql = """
                SELECT
                    u.UserID,
                    u.DisplayName           AS TargetFullName,
                    u.Email                 AS TargetEmail,
                    r.RoleName             AS UserRole,
                    COALESCE(a.AttendanceID, 0)      AS AttendanceID,
                    a.CheckedInAt,
                    a.CheckedOutAt,
                    a.Status,
                    a.ShiftBlock,
                    a.CheckedBy,
                    cb.DisplayName          AS CheckedByName,
                    a.Note,
                    a.IsDeleted
                FROM Users u
                INNER JOIN UserRoles  ur ON ur.UserID = u.UserID
                INNER JOIN Roles       r ON r.RoleID  = ur.RoleID
                                        AND r.RoleName IN ('Staff', 'PT')
                LEFT JOIN StaffPTAttendance a
                    ON  a.UserID       = u.UserID
                    AND a.ShiftBlock   = ?
                    AND a.AttendanceDate = ?
                    AND a.IsDeleted    = 0
                    AND a.Status       = 'Active'
                LEFT JOIN Users cb ON cb.UserID = a.CheckedBy
                WHERE u.IsDeleted = 0
                  AND u.Status    = 'Active'
                  AND (? = '' OR u.DisplayName LIKE ? OR u.Email LIKE ?)
                ORDER BY r.RoleName, u.DisplayName
                """;
        List<StaffPTAttendance> results = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, shiftBlock);
            ps.setDate(2, Date.valueOf(date));
            String kw = keyword == null ? "" : keyword.trim();
            ps.setString(3, kw);
            ps.setString(4, "%" + kw + "%");
            ps.setString(5, "%" + kw + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                results.add(mapStatusRow(rs));
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return results;
    }

    @Override
    public List<StaffPTAttendance> searchHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate,
            String keyword, int offset, int limit) throws SQLException {
        StringBuilder sql = new StringBuilder("""
                SELECT
                    a.AttendanceID,
                    a.UserID,
                    a.UserRole,
                    a.CheckedInAt,
                    a.CheckedOutAt,
                    a.AttendanceDate,
                    a.ShiftBlock,
                    a.Status,
                    a.CheckedBy,
                    a.Note,
                    a.CreatedBy,
                    a.CreatedDate,
                    a.IsDeleted,
                    u.DisplayName  AS TargetFullName,
                    u.Email        AS TargetEmail,
                    cb.DisplayName AS CheckedByName
                FROM StaffPTAttendance a
                INNER JOIN Users u  ON u.UserID  = a.UserID
                INNER JOIN Users cb ON cb.UserID = a.CheckedBy
                WHERE a.IsDeleted = 0
                """);

        List<Object> params = new ArrayList<>();
        appendFilters(sql, params, userId, userRole, shiftBlock, fromDate, toDate, keyword);

        sql.append(" ORDER BY a.CheckedInAt DESC, a.AttendanceID DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(Math.max(0, offset));
        params.add(Math.max(1, limit));

        List<StaffPTAttendance> results = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql.toString());
            bindParams(ps, params);
            rs = ps.executeQuery();
            while (rs.next()) {
                results.add(mapHistoryRow(rs));
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return results;
    }

    @Override
    public int countHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword)
            throws SQLException {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) AS Total
                FROM StaffPTAttendance a
                INNER JOIN Users u ON u.UserID = a.UserID
                WHERE a.IsDeleted = 0
                """);
        List<Object> params = new ArrayList<>();
        appendFilters(sql, params, userId, userRole, shiftBlock, fromDate, toDate, keyword);

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql.toString());
            bindParams(ps, params);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt("Total") : 0;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public StaffPTAttendance findById(int attendanceId) throws SQLException {
        String sql = """
                SELECT
                    a.AttendanceID, a.UserID, a.UserRole, a.CheckedInAt, a.CheckedOutAt,
                    a.AttendanceDate, a.ShiftBlock, a.Status, a.CheckedBy, a.Note,
                    a.CreatedBy, a.CreatedDate, a.IsDeleted,
                    u.DisplayName  AS TargetFullName,
                    u.Email        AS TargetEmail,
                    cb.DisplayName AS CheckedByName
                FROM StaffPTAttendance a
                INNER JOIN Users u  ON u.UserID  = a.UserID
                INNER JOIN Users cb ON cb.UserID = a.CheckedBy
                WHERE a.AttendanceID = ? AND a.IsDeleted = 0
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, attendanceId);
            rs = ps.executeQuery();
            return rs.next() ? mapHistoryRow(rs) : null;
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    private void appendFilters(StringBuilder sql, List<Object> params,
            int userId, String userRole, String shiftBlock,
            LocalDate fromDate, LocalDate toDate,
            String keyword) {
        if (userId > 0) {
            sql.append(" AND a.UserID = ?");
            params.add(userId);
        }
        if (userRole != null && !userRole.isBlank()) {
            sql.append(" AND a.UserRole = ?");
            params.add(userRole);
        }
        if (shiftBlock != null && !shiftBlock.isBlank()) {
            sql.append(" AND a.ShiftBlock = ?");
            params.add(shiftBlock);
        }
        if (fromDate != null) {
            sql.append(" AND a.AttendanceDate >= ?");
            params.add(Date.valueOf(fromDate));
        }
        if (toDate != null) {
            sql.append(" AND a.AttendanceDate <= ?");
            params.add(Date.valueOf(toDate));
        }
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (u.DisplayName LIKE ? OR u.Email LIKE ?)");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
        }
    }

    private void bindParams(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
    }

    private StaffPTAttendance mapStatusRow(ResultSet rs) throws SQLException {
        StaffPTAttendance a = new StaffPTAttendance();
        a.setAttendanceId(rs.getInt("AttendanceID"));
        a.setUserId(rs.getInt("UserID"));
        a.setTargetFullName(rs.getString("TargetFullName"));
        a.setTargetEmail(rs.getString("TargetEmail"));

        String role = rs.getString("UserRole");
        if (role != null) {
            try {
                a.setUserRole(role);
            } catch (IllegalArgumentException ignored) {
            }
        }

        Timestamp checkedInAt = rs.getTimestamp("CheckedInAt");
        if (checkedInAt != null)
            a.setCheckedInAt(checkedInAt.toLocalDateTime());

        Timestamp checkedOutAt = rs.getTimestamp("CheckedOutAt");
        if (checkedOutAt != null)
            a.setCheckedOutAt(checkedOutAt.toLocalDateTime());

        String shift = rs.getString("ShiftBlock");
        if (shift != null) {
            try {
                a.setShiftBlock(shift);
            } catch (IllegalArgumentException ignored) {
            }
        }

        String status = rs.getString("Status");
        if (status != null) {
            try {
                a.setStatus(status);
            } catch (IllegalArgumentException ignored) {
            }
        }

        a.setCheckedBy(rs.getInt("CheckedBy"));
        a.setCheckedByName(rs.getString("CheckedByName"));
        a.setNote(rs.getString("Note"));

        return a;
    }

    private StaffPTAttendance mapHistoryRow(ResultSet rs) throws SQLException {
        StaffPTAttendance a = new StaffPTAttendance();
        a.setAttendanceId(rs.getInt("AttendanceID"));
        a.setUserId(rs.getInt("UserID"));

        String role = rs.getString("UserRole");
        if (role != null) {
            try {
                a.setUserRole(role);
            } catch (IllegalArgumentException ignored) {
            }
        }

        Timestamp checkedInAt = rs.getTimestamp("CheckedInAt");
        if (checkedInAt != null)
            a.setCheckedInAt(checkedInAt.toLocalDateTime());

        Timestamp checkedOutAt = rs.getTimestamp("CheckedOutAt");
        if (checkedOutAt != null)
            a.setCheckedOutAt(checkedOutAt.toLocalDateTime());

        Date attDate = rs.getDate("AttendanceDate");
        if (attDate != null)
            a.setAttendanceDate(attDate.toLocalDate());

        String shift = rs.getString("ShiftBlock");
        if (shift != null) {
            try {
                a.setShiftBlock(shift);
            } catch (IllegalArgumentException ignored) {
            }
        }

        String status = rs.getString("Status");
        if (status != null) {
            try {
                a.setStatus(status);
            } catch (IllegalArgumentException ignored) {
            }
        }

        a.setCheckedBy(rs.getInt("CheckedBy"));
        a.setNote(rs.getString("Note"));
        a.setCreatedBy(rs.getString("CreatedBy"));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null)
            a.setCreatedDate(createdDate.toLocalDateTime());

        a.setDeleted(rs.getBoolean("IsDeleted"));
        a.setTargetFullName(rs.getString("TargetFullName"));
        a.setTargetEmail(rs.getString("TargetEmail"));
        a.setCheckedByName(rs.getString("CheckedByName"));
        return a;
    }
}
