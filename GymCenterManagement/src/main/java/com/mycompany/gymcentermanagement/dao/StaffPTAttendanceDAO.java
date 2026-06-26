/**
 * =========================================================================
 * @file          : StaffPTAttendanceDAO.java
 * @description   : Giao diện định nghĩa các thao tác truy xuất dữ liệu điểm danh Staff và PT.
 *                  Hỗ trợ UC 2.3.4 (Manage Staff & PT Check-ins) và
 *                  UC 2.3.5 (View Staff & PT Work History).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * Interface definition for Staff and PT attendance data access.
 */
public interface StaffPTAttendanceDAO {
        /**
         * Kiểm tra xem người dùng đã được điểm danh trong ca này chưa.
         */
        boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException;

        /**
         * Tạo bản ghi điểm danh mới.
         */
        int create(StaffPTAttendance attendance) throws SQLException;

        /**
         * Lấy danh sách người dùng kèm trạng thái đã điểm danh hay chưa trong ca và
         * ngày.
         */
        List<StaffPTAttendance> listUsersWithCheckinStatus(String shiftBlock, LocalDate date) throws SQLException;

        /**
         * Lấy lịch sử điểm danh với phân trang và bộ lọc.
         */
        List<StaffPTAttendance> searchHistory(
                        int userId, String userRole,
                        LocalDate fromDate, LocalDate toDate,
                        String keyword,
                        int offset, int limit) throws SQLException;

        /**
         * Đếm tổng số bản ghi theo điều kiện lọc.
         */
        int countHistory(
                        int userId, String userRole,
                        LocalDate fromDate, LocalDate toDate,
                        String keyword) throws SQLException;

        /**
         * Lấy một bản ghi điểm danh theo ID.
         */
        StaffPTAttendance findById(int attendanceId) throws SQLException;
}