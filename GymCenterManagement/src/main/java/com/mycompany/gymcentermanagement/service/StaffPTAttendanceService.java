/**
 * =========================================================================
 * @file          : StaffPTAttendanceService.java
 * @description   : Giao diện định nghĩa các nghiệp vụ điểm danh Staff và PT.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * Service interface for Staff and PT attendance operations.
 */
public interface StaffPTAttendanceService {
    /**
     * Kiểm tra một người đã có bản ghi check-in active trong ca và ngày được
     * chọn hay chưa.
     */
    boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException;

    /**
     * Tạo bản ghi check-in mới cho Staff/PT.
     */
    int checkinUser(StaffPTAttendance attendance) throws SQLException;

    /**
     * Ghi giờ ra cho một bản ghi điểm danh.
     */
    boolean checkoutAttendance(int attendanceId, int checkedBy) throws SQLException;

    /**
     * Hoàn tác giờ ra của một bản ghi điểm danh.
     */
    boolean undoCheckout(int attendanceId, int updatedBy) throws SQLException;

    /**
     * Hủy mềm một bản ghi điểm danh.
     */
    boolean cancelAttendance(int attendanceId, int cancelledBy) throws SQLException;

    /**
     * Lấy danh sách Staff/PT kèm trạng thái check-in theo ca, ngày và từ khóa.
     */
    List<StaffPTAttendance> getCheckinStatusList(String shiftBlock, LocalDate date, String keyword) throws SQLException;

    /**
     * Tìm lịch sử điểm danh theo người dùng, vai trò, ca, khoảng ngày, từ khóa
     * và phân trang.
     */
    List<StaffPTAttendance> searchHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword, int offset, int limit) throws SQLException;

    /**
     * Đếm số bản ghi lịch sử điểm danh theo cùng bộ lọc với hàm tìm kiếm.
     */
    int countHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword) throws SQLException;

    /**
     * Lấy một bản ghi điểm danh theo mã bản ghi.
     */
    StaffPTAttendance findById(int attendanceId) throws SQLException;
}
