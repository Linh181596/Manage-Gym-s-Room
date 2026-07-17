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
    boolean existsCheckinForShift(int userId, String shiftBlock, LocalDate date) throws SQLException;
    int checkinUser(StaffPTAttendance attendance) throws SQLException;
    boolean checkoutAttendance(int attendanceId, int checkedBy) throws SQLException;
    boolean undoCheckout(int attendanceId, int updatedBy) throws SQLException;
    boolean cancelAttendance(int attendanceId, int cancelledBy) throws SQLException;
    List<StaffPTAttendance> getCheckinStatusList(String shiftBlock, LocalDate date, String keyword) throws SQLException;
    List<StaffPTAttendance> searchHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword, int offset, int limit) throws SQLException;
    int countHistory(int userId, String userRole, String shiftBlock, LocalDate fromDate, LocalDate toDate, String keyword) throws SQLException;
    StaffPTAttendance findById(int attendanceId) throws SQLException;
}
