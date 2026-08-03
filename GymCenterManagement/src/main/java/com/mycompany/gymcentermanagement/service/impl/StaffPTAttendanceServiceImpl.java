/**
 * =========================================================================
 * @file          : StaffPTAttendanceServiceImpl.java
 * @description   : Lớp triển khai các nghiệp vụ điểm danh Staff và PT.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.StaffPTAttendanceDAO;
import com.mycompany.gymcentermanagement.dao.impl.StaffPTAttendanceDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.service.StaffPTAttendanceService;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class StaffPTAttendanceServiceImpl implements StaffPTAttendanceService {

    private final StaffPTAttendanceDAO attendanceDAO;

    /**
     * Khởi tạo service với DAO JDBC mặc định.
     */
    public StaffPTAttendanceServiceImpl() {
        this(new StaffPTAttendanceDAOImpl());
    }

    /**
     * Khởi tạo service với DAO được truyền vào để hỗ trợ kiểm thử hoặc tái sử
     * dụng nguồn dữ liệu khác.
     */
    StaffPTAttendanceServiceImpl(StaffPTAttendanceDAO attendanceDAO) {
        this.attendanceDAO = attendanceDAO;
    }

    /**
     * Kiểm tra người dùng đã được check-in trong cùng ca và cùng ngày hay chưa.
     */
    @Override
    public boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException {
        return attendanceDAO.existsCheckinForShift(userId, shiftBlock, date);
    }

    /**
     * Tạo bản ghi check-in mới và trả về mã bản ghi vừa tạo.
     */
    @Override
    public int checkinUser(StaffPTAttendance attendance) throws SQLException {
        return attendanceDAO.create(attendance);
    }

    /**
     * Ghi giờ ra cho bản ghi điểm danh đang active.
     */
    @Override
    public boolean checkoutAttendance(int attendanceId, int checkedBy) throws SQLException {
        return attendanceDAO.checkout(attendanceId, checkedBy);
    }

    /**
     * Hoàn tác giờ ra của bản ghi điểm danh đã check-out.
     */
    @Override
    public boolean undoCheckout(int attendanceId, int updatedBy) throws SQLException {
        return attendanceDAO.undoCheckout(attendanceId, updatedBy);
    }

    /**
     * Hủy mềm một bản ghi điểm danh.
     */
    @Override
    public boolean cancelAttendance(int attendanceId, int cancelledBy) throws SQLException {
        return attendanceDAO.cancel(attendanceId, cancelledBy);
    }

    /**
     * Lấy danh sách Staff/PT kèm dữ liệu check-in của ca và ngày đang chọn.
     */
    @Override
    public List<StaffPTAttendance> getCheckinStatusList(String shiftBlock, LocalDate date, String keyword) throws SQLException {
        return attendanceDAO.listUsersWithCheckinStatus(shiftBlock, date, keyword);
    }

    /**
     * Tìm lịch sử điểm danh theo bộ lọc và phân trang.
     */
    @Override
    public List<StaffPTAttendance> searchHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword, int offset, int limit) throws SQLException {
        return attendanceDAO.searchHistory(userId, userRole, shiftBlock, fromDate, toDate, keyword, offset, limit);
    }

    /**
     * Đếm số bản ghi lịch sử điểm danh theo bộ lọc.
     */
    @Override
    public int countHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword) throws SQLException {
        return attendanceDAO.countHistory(userId, userRole, shiftBlock, fromDate, toDate, keyword);
    }

    /**
     * Lấy chi tiết một bản ghi điểm danh theo attendanceId.
     */
    @Override
    public StaffPTAttendance findById(int attendanceId) throws SQLException {
        return attendanceDAO.findById(attendanceId);
    }
}
