package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PTScheduleDAOImpl implements PTScheduleDAO {
    @Override
    public boolean isScheduleConflict(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE PTID = ? 
                      AND SessionDate = ? 
                      AND StartTime = CAST(? AS TIME)
                      AND EndTime = CAST(? AS TIME)
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(sessionDate));
            ps.setTime(3, startTime);
            ps.setTime(4, endTime);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId) {

        String sql = "INSERT INTO PTSchedules (PTID, PTRegistrationID, MemberID, SessionDate, StartTime, EndTime, SessionStatus, PTAttendanceResult, CreatedByUserID, CreatedDate, IsDeleted) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'Upcoming', 'Pending', ?, GETDATE(), 0)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            conn.setAutoCommit(false);
            for (PTSchedule s : schedules) {
                ps.setInt(1, s.getPtId());
                ps.setInt(2, s.getRegistrationId());
                ps.setInt(3, s.getMemberId());
                ps.setDate(4, java.sql.Date.valueOf(s.getSessionDate()));
                ps.setTime(5, s.getStartTime());
                ps.setTime(6, s.getEndTime());
                ps.setInt(7, createdByUserId);

                ps.addBatch();
            }
            ps.executeBatch();
            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Lỗi lưu lịch: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        List<PTSchedule> list = new ArrayList<>();
        String sql = """
                    SELECT SessionDate, StartTime FROM PTSchedules 
                    WHERE PTID = ? 
                      AND SessionDate >= ? 
                      AND SessionDate <= ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(startDate));
            ps.setDate(3, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTSchedule s = new PTSchedule();
                    s.setSessionDate(rs.getDate("SessionDate").toLocalDate());
                    s.setStartTime(rs.getTime("StartTime"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
