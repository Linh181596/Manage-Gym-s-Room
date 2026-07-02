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

    public StaffPTAttendanceServiceImpl() {
        this(new StaffPTAttendanceDAOImpl());
    }

    StaffPTAttendanceServiceImpl(StaffPTAttendanceDAO attendanceDAO) {
        this.attendanceDAO = attendanceDAO;
    }

    @Override
    public boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException {
        return attendanceDAO.existsCheckinForShift(userId, shiftBlock, date);
    }

    @Override
    public int checkinUser(StaffPTAttendance attendance) throws SQLException {
        return attendanceDAO.create(attendance);
    }

    @Override
    public boolean checkoutAttendance(int attendanceId, int checkedBy) throws SQLException {
        return attendanceDAO.checkout(attendanceId, checkedBy);
    }

    @Override
    public boolean undoCheckout(int attendanceId, int updatedBy) throws SQLException {
        return attendanceDAO.undoCheckout(attendanceId, updatedBy);
    }

    @Override
    public boolean cancelAttendance(int attendanceId, int cancelledBy) throws SQLException {
        return attendanceDAO.cancel(attendanceId, cancelledBy);
    }

    @Override
    public List<StaffPTAttendance> getCheckinStatusList(String shiftBlock, LocalDate date, String keyword) throws SQLException {
        return attendanceDAO.listUsersWithCheckinStatus(shiftBlock, date, keyword);
    }

    @Override
    public List<StaffPTAttendance> searchHistory(int userId, String userRole, LocalDate fromDate, LocalDate toDate, String keyword, int offset, int limit) throws SQLException {
        return attendanceDAO.searchHistory(userId, userRole, fromDate, toDate, keyword, offset, limit);
    }

    @Override
    public int countHistory(int userId, String userRole, LocalDate fromDate, LocalDate toDate, String keyword) throws SQLException {
        return attendanceDAO.countHistory(userId, userRole, fromDate, toDate, keyword);
    }

    @Override
    public StaffPTAttendance findById(int attendanceId) throws SQLException {
        return attendanceDAO.findById(attendanceId);
    }
}
