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
                                p.PackageName,
                                s.Note
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
                    dto.setNote(rs.getString("Note"));
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
                        p.PackageName,
                        s.Note
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
                    dto.setNote(rs.getString("Note"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE MemberID = ? 
                      AND SessionDate = ? 
                      AND StartTime = CAST(? AS TIME)
                      AND EndTime = CAST(? AS TIME)
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
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
    public List<PTSchedule> getMemberSchedulesForWeek(int memberId, LocalDate startDate, LocalDate endDate) {
        List<PTSchedule> list = new ArrayList<>();
        String sql = """
                    SELECT SessionDate, StartTime FROM PTSchedules 
                    WHERE MemberID = ? 
                      AND SessionDate >= ? 
                      AND SessionDate <= ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
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
    public PTSchedule getScheduleById(int scheduleId) {
        String sql = """
                    SELECT PTScheduleID, PTRegistrationID, PTID, MemberID, SessionDate, StartTime, EndTime, SessionStatus, PTAttendanceResult
                    FROM PTSchedules 
                    WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, scheduleId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PTSchedule s = new PTSchedule();
                    s.setScheduleId(rs.getInt("PTScheduleID"));
                    s.setRegistrationId(rs.getInt("PTRegistrationID"));
                    s.setPtId(rs.getInt("PTID"));
                    s.setMemberId(rs.getInt("MemberID"));
                    s.setSessionDate(rs.getDate("SessionDate").toLocalDate());
                    s.setStartTime(rs.getTime("StartTime"));
                    s.setEndTime(rs.getTime("EndTime"));
                    s.setSessionStatus(rs.getString("SessionStatus"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<PTScheduleDetailDTO> getCompletedSessions(int ptId) {
        List<PTScheduleDetailDTO> list = new ArrayList<>();
        String sql = """
                SELECT 
                    s.PTScheduleID, s.SessionDate, s.StartTime, s.EndTime, s.SessionStatus, s.PTAttendanceResult,
                    u.DisplayName AS MemberName,
                    p.PackageName,
                    s.Note
                FROM PTSchedules s
                JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                JOIN Members m ON r.MemberID = m.MemberID
                JOIN Users u ON m.UserID = u.UserID
                JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                WHERE s.PTID = ? 
                  AND s.SessionStatus = 'Completed' 
                  AND s.IsDeleted = 0
                ORDER BY s.SessionDate DESC, s.StartTime DESC
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);

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
                    dto.setNote(rs.getString("Note"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean cancelSession(int scheduleId, String reason, String updatedBy) {
        String sql = """
                UPDATE PTSchedules 
                SET SessionStatus = 'Cancelled', 
                    PTAttendanceResult = 'Pending', 
                    Note = ?, 
                    UpdatedDate = GETDATE(), 
                    UpdatedBy = ? 
                WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reason);
            ps.setString(2, updatedBy);
            ps.setInt(3, scheduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean isScheduleConflictTx(Connection conn, int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) throws SQLException {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE PTID = ? 
                      AND SessionDate = ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND (
                          (StartTime <= ? AND EndTime > ?) OR 
                          (StartTime < ? AND EndTime >= ?) OR 
                          (StartTime >= ? AND EndTime <= ?)
                      )
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(sessionDate));
            ps.setTime(3, startTime);
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setTime(6, endTime);
            ps.setTime(7, startTime);
            ps.setTime(8, endTime);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    private boolean isMemberScheduleConflictTx(Connection conn, int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) throws SQLException {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE MemberID = ? 
                      AND SessionDate = ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND (
                          (StartTime <= ? AND EndTime > ?) OR 
                          (StartTime < ? AND EndTime >= ?) OR 
                          (StartTime >= ? AND EndTime <= ?)
                      )
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            ps.setDate(2, java.sql.Date.valueOf(sessionDate));
            ps.setTime(3, startTime);
            ps.setTime(4, startTime);
            ps.setTime(5, endTime);
            ps.setTime(6, endTime);
            ps.setTime(7, startTime);
            ps.setTime(8, endTime);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    @Override
    public boolean insertSchedulesAndUpdateRegistration(List<PTSchedule> schedules, int createdByUserId, LocalDate actualStartDate, LocalDate actualEndDate) {
        if (schedules == null || schedules.isEmpty()) {
            return false;
        }
        int regId = schedules.get(0).getRegistrationId();
        
        String insertSql = "INSERT INTO PTSchedules (PTID, PTRegistrationID, MemberID, SessionDate, StartTime, EndTime, SessionStatus, PTAttendanceResult, CreatedByUserID, CreatedDate, IsDeleted) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'Upcoming', 'Pending', ?, GETDATE(), 0)";
                
        String updateSql = "UPDATE PTRegistrations SET StartDate = ?, EndDate = ? WHERE PTRegistrationID = ?";
        
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            
            // Re-check conflict for all schedules inside the same transaction
            for (PTSchedule s : schedules) {
                if (isScheduleConflictTx(conn, s.getPtId(), s.getSessionDate(), s.getStartTime(), s.getEndTime()) ||
                    isMemberScheduleConflictTx(conn, s.getMemberId(), s.getSessionDate(), s.getStartTime(), s.getEndTime())) {
                    conn.rollback();
                    System.err.println("Xung đột lịch xảy ra trong phiên giao dịch đồng thời!");
                    return false;
                }
            }
            
            try (PreparedStatement insertPs = conn.prepareStatement(insertSql);
                 PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                
                // 1. Insert schedules in batch
                for (PTSchedule s : schedules) {
                    insertPs.setInt(1, s.getPtId());
                    insertPs.setInt(2, s.getRegistrationId());
                    insertPs.setInt(3, s.getMemberId());
                    insertPs.setDate(4, java.sql.Date.valueOf(s.getSessionDate()));
                    insertPs.setTime(5, s.getStartTime());
                    insertPs.setTime(6, s.getEndTime());
                    insertPs.setInt(7, createdByUserId);
                    insertPs.addBatch();
                }
                insertPs.executeBatch();
                
                // 2. Update registration actual dates
                updatePs.setDate(1, java.sql.Date.valueOf(actualStartDate));
                updatePs.setDate(2, java.sql.Date.valueOf(actualEndDate));
                updatePs.setInt(3, regId);
                updatePs.executeUpdate();
                
                conn.commit();
                return true;
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lưu lịch và cập nhật ngày đăng ký: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
