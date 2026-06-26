/**
 * =========================================================================
 * @file          : StaffPTAttendanceDAO.java
 * @description   : Lớp truy cập dữ liệu để quản lý điểm danh Staff và PT.
 *                  Hỗ trợ UC 2.3.4 (Manage Staff & PT Check-ins) và
 *                  UC 2.3.5 (View Staff & PT Work History).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for managing Staff and Personal Trainer attendance records.
 */
public class StaffPTAttendanceDAO {

    // ------------------------------------------------------------------ //
    //  UC 2.3.4 – Manage Staff & PT Check-ins
    // ------------------------------------------------------------------ //

    /**
     * Kiểm tra xem người dùng đã được điểm danh trong ca này chưa.
     * Dùng để phát hiện trường hợp A1: Duplicate Check-in.
     *
     * @param userId     UserID của người cần kiểm tra
     * @param shiftBlock Ca làm việc ('Morning', 'Afternoon', 'Evening')
     * @param date       Ngày cần kiểm tra
     * @return true nếu đã có bản ghi điểm danh trong ca đó
     */
    public boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date)
            throws SQLException {
        String sql = """
                SELECT COUNT(*) AS Total
                FROM StaffPTAttendance
                WHERE UserID = ?
                  AND ShiftBlock = ?
                  AND AttendanceDate = ?
                  AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, shiftBlock);
            ps.setDate(3, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt("Total") > 0;
            }
        }
    }

    /**
     * Tạo bản ghi điểm danh mới.
     * Được gọi khi Staff xác nhận check-in cho Staff/PT khác.
     *
     * @param attendance Đối tượng điểm danh chứa đầy đủ thông tin
     * @return AttendanceID vừa được tạo, hoặc 0 nếu thất bại
     */
    public int create(StaffPTAttendance attendance) throws SQLException {
        String sql = """
                INSERT INTO StaffPTAttendance
                    (UserID, UserRole, ShiftBlock, CheckedBy, Note, CreatedBy, IsDeleted)
                VALUES (?, ?, ?, ?, ?, ?, 0)
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, attendance.getUserId());
            ps.setString(2, attendance.getUserRole().name());
            ps.setString(3, attendance.getShiftBlock().name());
            ps.setInt(4, attendance.getCheckedBy());
            ps.setString(5, attendance.getNote());
            ps.setString(6, attendance.getCreatedBy());

            int affected = ps.executeUpdate();
            if (affected == 0) return 0;

            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : 0;
            }
        }
    }

    /**
     * Lấy danh sách người dùng (Staff + PT) có thể điểm danh,
     * kèm trạng thái đã điểm danh hay chưa trong ca và ngày được chỉ định.
     * Dùng để hiển thị bảng danh sách ở trang Check-in (UC 2.3.4).
     *
     * @param shiftBlock Ca cần xem ('Morning', 'Afternoon', 'Evening')
     * @param date       Ngày cần xem
     * @return Danh sách bản ghi – attendance.attendanceId = 0 nếu chưa điểm danh
     */
    public List<StaffPTAttendance> listUsersWithCheckinStatus(String shiftBlock, LocalDate date)
            throws SQLException {
        String sql = """
                SELECT
                    u.UserID,
                    u.DisplayName           AS TargetFullName,
                    u.Email                 AS TargetEmail,
                    r.RoleName             AS UserRole,
                    COALESCE(a.AttendanceID, 0)      AS AttendanceID,
                    a.CheckedInAt,
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
                LEFT JOIN Users cb ON cb.UserID = a.CheckedBy
                WHERE u.IsDeleted = 0
                  AND u.Status    = 'Active'
                ORDER BY r.RoleName, u.DisplayName
                """;
        List<StaffPTAttendance> results = new ArrayList<>();
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shiftBlock);
            ps.setDate(2, Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(mapStatusRow(rs));
                }
            }
        }
        return results;
    }

    // ------------------------------------------------------------------ //
    //  UC 2.3.5 – View Staff & PT Work History
    // ------------------------------------------------------------------ //

    /**
     * Lấy lịch sử điểm danh với phân trang và bộ lọc.
     *
     * @param userId     Lọc theo UserID cụ thể (0 = tất cả)
     * @param userRole   Lọc theo role ('Staff' | 'PT' | null = tất cả)
     * @param fromDate   Ngày bắt đầu (null = không giới hạn)
     * @param toDate     Ngày kết thúc (null = không giới hạn)
     * @param keyword    Tìm kiếm theo tên hoặc email (null = tất cả)
     * @param offset     Vị trí bắt đầu (phân trang)
     * @param limit      Số bản ghi mỗi trang
     * @return Danh sách bản ghi điểm danh
     */
    public List<StaffPTAttendance> searchHistory(
            int userId, String userRole,
            LocalDate fromDate, LocalDate toDate,
            String keyword,
            int offset, int limit) throws SQLException {

        StringBuilder sql = new StringBuilder("""
                SELECT
                    a.AttendanceID,
                    a.UserID,
                    a.UserRole,
                    a.CheckedInAt,
                    a.AttendanceDate,
                    a.ShiftBlock,
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
        appendFilters(sql, params, userId, userRole, fromDate, toDate, keyword);

        sql.append(" ORDER BY a.CheckedInAt DESC, a.AttendanceID DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(Math.max(0, offset));
        params.add(Math.max(1, limit));

        List<StaffPTAttendance> results = new ArrayList<>();
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            bindParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(mapHistoryRow(rs));
                }
            }
        }
        return results;
    }

    /**
     * Đếm tổng số bản ghi theo điều kiện lọc (dùng cho phân trang).
     */
    public int countHistory(
            int userId, String userRole,
            LocalDate fromDate, LocalDate toDate,
            String keyword) throws SQLException {

        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) AS Total
                FROM StaffPTAttendance a
                INNER JOIN Users u ON u.UserID = a.UserID
                WHERE a.IsDeleted = 0
                """);
        List<Object> params = new ArrayList<>();
        appendFilters(sql, params, userId, userRole, fromDate, toDate, keyword);

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            bindParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("Total") : 0;
            }
        }
    }

    /**
     * Lấy một bản ghi điểm danh theo ID.
     * Dùng để hiển thị chi tiết hoặc kiểm tra trước khi xoá.
     */
    public StaffPTAttendance findById(int attendanceId) throws SQLException {
        String sql = """
                SELECT
                    a.AttendanceID, a.UserID, a.UserRole, a.CheckedInAt,
                    a.AttendanceDate, a.ShiftBlock, a.CheckedBy, a.Note,
                    a.CreatedBy, a.CreatedDate, a.IsDeleted,
                    u.DisplayName  AS TargetFullName,
                    u.Email        AS TargetEmail,
                    cb.DisplayName AS CheckedByName
                FROM StaffPTAttendance a
                INNER JOIN Users u  ON u.UserID  = a.UserID
                INNER JOIN Users cb ON cb.UserID = a.CheckedBy
                WHERE a.AttendanceID = ? AND a.IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attendanceId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapHistoryRow(rs) : null;
            }
        }
    }

    // ------------------------------------------------------------------ //
    //  Private helpers
    // ------------------------------------------------------------------ //

    private void appendFilters(StringBuilder sql, List<Object> params,
                                int userId, String userRole,
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

    /** Map row từ query listUsersWithCheckinStatus */
    private StaffPTAttendance mapStatusRow(ResultSet rs) throws SQLException {
        StaffPTAttendance a = new StaffPTAttendance();
        a.setAttendanceId(rs.getInt("AttendanceID"));
        a.setUserId(rs.getInt("UserID"));
        a.setTargetFullName(rs.getString("TargetFullName"));
        a.setTargetEmail(rs.getString("TargetEmail"));

        String role = rs.getString("UserRole");
        if (role != null) {
            try { a.setUserRole(role); } catch (IllegalArgumentException ignored) {}
        }

        Timestamp checkedInAt = rs.getTimestamp("CheckedInAt");
        if (checkedInAt != null) a.setCheckedInAt(checkedInAt.toLocalDateTime());

        String shift = rs.getString("ShiftBlock");
        if (shift != null) {
            try { a.setShiftBlock(shift); } catch (IllegalArgumentException ignored) {}
        }

        a.setCheckedBy(rs.getInt("CheckedBy"));
        a.setCheckedByName(rs.getString("CheckedByName"));
        a.setNote(rs.getString("Note"));

        return a;
    }

    /** Map row từ query searchHistory / findById */
    private StaffPTAttendance mapHistoryRow(ResultSet rs) throws SQLException {
        StaffPTAttendance a = new StaffPTAttendance();
        a.setAttendanceId(rs.getInt("AttendanceID"));
        a.setUserId(rs.getInt("UserID"));

        String role = rs.getString("UserRole");
        if (role != null) {
            try { a.setUserRole(role); } catch (IllegalArgumentException ignored) {}
        }

        Timestamp checkedInAt = rs.getTimestamp("CheckedInAt");
        if (checkedInAt != null) a.setCheckedInAt(checkedInAt.toLocalDateTime());

        Date attDate = rs.getDate("AttendanceDate");
        if (attDate != null) a.setAttendanceDate(attDate.toLocalDate());

        String shift = rs.getString("ShiftBlock");
        if (shift != null) {
            try { a.setShiftBlock(shift); } catch (IllegalArgumentException ignored) {}
        }

        a.setCheckedBy(rs.getInt("CheckedBy"));
        a.setNote(rs.getString("Note"));
        a.setCreatedBy(rs.getString("CreatedBy"));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null) a.setCreatedDate(createdDate.toLocalDateTime());

        a.setDeleted(rs.getBoolean("IsDeleted"));
        a.setTargetFullName(rs.getString("TargetFullName"));
        a.setTargetEmail(rs.getString("TargetEmail"));
        a.setCheckedByName(rs.getString("CheckedByName"));
        return a;
    }
}