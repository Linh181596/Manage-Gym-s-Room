package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
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

    @Override
    public List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        List<PTScheduleDetailDTO> list = new ArrayList<>();
        // JOIN 4 bảng để lấy chi tiết: Lịch -> Đơn Đăng Ký -> Hội Viên -> Gói Tập
        String sql = """
                    SELECT
                                 s.PTScheduleID, s.SessionDate, s.StartTime, s.EndTime, s.SessionStatus, s.PTAttendanceResult,
                                u.DisplayName AS MemberName,
                                p.PackageName 
                        FROM PTSchedules s
                                                               JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                                                               JOIN Members m ON r.MemberID = m.MemberID
                                                               JOIN Users u ON m.UserID = u.UserID
                                                               JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                                                               JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                                                               WHERE s.PTID = ?
                                                                 AND s.SessionDate >= ?
                                                                 AND s.SessionDate <= ?
                                                                 AND s.IsDeleted = 0
                                                               ORDER BY s.SessionDate ASC, s.StartTime ASC                                  
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(startDate));
            ps.setDate(3, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTScheduleDetailDTO dto = new PTScheduleDetailDTO();
                    dto.setScheduleId(rs.getInt("PTScheduleID"));
                    dto.setSessionDate(rs.getDate("SessionDate").toLocalDate());
                    dto.setStartTime(rs.getTime("StartTime"));
                    dto.setEndTime(rs.getTime("EndTime"));
                    dto.setSessionStatus(rs.getString("SessionStatus"));
                    dto.setAttendanceStatus(rs.getString("PTAttendanceResult"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus) {
        String sql = """
                UPDATE PTSchedules 
                SET PTAttendanceResult = ?, SessionStatus = ?, UpdatedDate = GETDATE()
                WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, attendanceStatus);
            ps.setString(2, sessionStatus);
            ps.setInt(3, scheduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date) {
        List<PTScheduleDetailDTO> list = new ArrayList<>();
        String sql = """
                    SELECT 
                        s.PTScheduleID, s.SessionDate, s.StartTime, s.EndTime, s.SessionStatus, s.PTAttendanceResult,
                        u_pt.DisplayName AS PTName,
                        u_mem.DisplayName AS MemberName,
                        p.PackageName
                    FROM PTSchedules s
                    INNER JOIN PersonalTrainers pt ON s.PTID = pt.PTID
                    INNER JOIN Users u_pt ON pt.UserID = u_pt.UserID
                    INNER JOIN Members m ON s.MemberID = m.MemberID
                    INNER JOIN Users u_mem ON m.UserID = u_mem.UserID
                    INNER JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                    WHERE s.SessionDate = ? AND s.IsDeleted = 0
                    ORDER BY s.StartTime ASC
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(date));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTScheduleDetailDTO dto = new PTScheduleDetailDTO();
                    dto.setScheduleId(rs.getInt("PTScheduleID"));
                    dto.setSessionDate(rs.getDate("SessionDate").toLocalDate());
                    dto.setStartTime(rs.getTime("StartTime"));
                    dto.setEndTime(rs.getTime("EndTime"));
                    dto.setSessionStatus(rs.getString("SessionStatus"));
                    dto.setAttendanceStatus(rs.getString("PTAttendanceResult"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setPtName(rs.getString("PTName"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
