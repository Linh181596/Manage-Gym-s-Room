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
import java.util.Map;

public class PTScheduleDAOImpl implements PTScheduleDAO {
    @Override
    public boolean isScheduleConflict(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE PTID = ? 
                      AND SessionDate = ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND (
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
                      )
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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
                         s.PTID, s.MemberID,
                         u.DisplayName AS MemberName,
                         p.PackageName,
                         s.Note,
                         s.OriginalPTID,
                         u_opt.DisplayName AS OriginalPTName,
                         u_curr.DisplayName AS CurrentPTName,
                         s.CancellationReason,
                         req.RequestID AS RescheduleRequestID,
                         req.Status AS RescheduleStatus,
                         req.ProposedDate AS RescheduleProposedDate,
                         req.ProposedStartTime AS RescheduleProposedStartTime,
                         req.ProposedEndTime AS RescheduleProposedEndTime,
                         req.Reason AS RescheduleReason,
                         req.SenderUserID AS RescheduleSenderUserID,
                         req.ResponseReason AS RescheduleResponseReason,
                         req.EscalationReason AS RescheduleEscalationReason
                    FROM PTSchedules s
                    JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                    JOIN Members m ON r.MemberID = m.MemberID
                    JOIN Users u ON m.UserID = u.UserID
                    JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                    LEFT JOIN PersonalTrainers opt ON s.OriginalPTID = opt.PTID
                    LEFT JOIN Users u_opt ON opt.UserID = u_opt.UserID
                    LEFT JOIN PersonalTrainers pt_curr ON s.PTID = pt_curr.PTID
                    LEFT JOIN Users u_curr ON pt_curr.UserID = u_curr.UserID
                    LEFT JOIN RescheduleRequests req ON s.PTScheduleID = req.PTScheduleID 
                      AND req.OriginalDate = s.SessionDate
                      AND CAST(req.OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      AND req.RequestID = (
                          SELECT MAX(RequestID) 
                          FROM RescheduleRequests 
                          WHERE PTScheduleID = s.PTScheduleID
                            AND OriginalDate = s.SessionDate
                            AND CAST(OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      )
                    WHERE (s.PTID = ? OR s.OriginalPTID = ?)
                      AND s.SessionDate >= ?
                      AND s.SessionDate <= ?
                      AND s.IsDeleted = 0
                    ORDER BY s.SessionDate ASC, s.StartTime ASC                                  
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);
            ps.setInt(2, ptId);
            ps.setDate(3, java.sql.Date.valueOf(startDate));
            ps.setDate(4, java.sql.Date.valueOf(endDate));

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
                    dto.setCancellationReason(rs.getString("CancellationReason"));
                    dto.setPtId(rs.getInt("PTID"));
                    dto.setPtName(rs.getString("CurrentPTName"));
                    dto.setMemberId(rs.getInt("MemberID"));
                    dto.setOriginalPtName(rs.getString("OriginalPTName"));
                    int origPtId = rs.getInt("OriginalPTID");
                    if (!rs.wasNull()) {
                        dto.setOriginalPtId(origPtId);
                    }
                    
                    int reqId = rs.getInt("RescheduleRequestID");
                    if (!rs.wasNull()) {
                        dto.setRescheduleRequestId(reqId);
                        dto.setRescheduleStatus(rs.getString("RescheduleStatus"));
                        java.sql.Date pDate = rs.getDate("RescheduleProposedDate");
                        if (pDate != null) {
                            dto.setRescheduleProposedDate(pDate.toLocalDate());
                        }
                        dto.setRescheduleProposedStartTime(rs.getTime("RescheduleProposedStartTime"));
                        dto.setRescheduleProposedEndTime(rs.getTime("RescheduleProposedEndTime"));
                        dto.setRescheduleReason(rs.getString("RescheduleReason"));
                        dto.setRescheduleSenderUserId(rs.getInt("RescheduleSenderUserID"));
                        dto.setRescheduleResponseReason(rs.getString("RescheduleResponseReason"));
                        dto.setRescheduleEscalationReason(rs.getString("RescheduleEscalationReason"));
                    }
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus, String updatedBy) {
        String sql = """
                UPDATE PTSchedules 
                SET PTAttendanceResult = ?, SessionStatus = ?, UpdatedBy = ?, UpdatedDate = GETDATE()
                WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, attendanceStatus);
            ps.setString(2, sessionStatus);
            ps.setString(3, updatedBy);
            ps.setInt(4, scheduleId);
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
                        pt.PTID,
                        pt.Specialization AS PTSpecialization,
                        u_mem.DisplayName AS MemberName,
                        p.PackageName,
                        s.Note,
                        s.OriginalPTID,
                        u_opt.DisplayName AS OriginalPTName,
                        s.CancellationReason,
                        req.RequestID AS RescheduleRequestID,
                        req.Status AS RescheduleStatus,
                        req.ProposedDate AS RescheduleProposedDate,
                        req.ProposedStartTime AS RescheduleProposedStartTime,
                        req.ProposedEndTime AS RescheduleProposedEndTime
                    FROM PTSchedules s
                    INNER JOIN PersonalTrainers pt ON s.PTID = pt.PTID
                    INNER JOIN Users u_pt ON pt.UserID = u_pt.UserID
                    INNER JOIN Members m ON s.MemberID = m.MemberID
                    INNER JOIN Users u_mem ON m.UserID = u_mem.UserID
                    INNER JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                    LEFT JOIN PersonalTrainers opt ON s.OriginalPTID = opt.PTID
                    LEFT JOIN Users u_opt ON opt.UserID = u_opt.UserID
                    LEFT JOIN RescheduleRequests req ON s.PTScheduleID = req.PTScheduleID 
                      AND req.OriginalDate = s.SessionDate
                      AND CAST(req.OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      AND req.RequestID = (
                          SELECT MAX(RequestID) 
                          FROM RescheduleRequests 
                          WHERE PTScheduleID = s.PTScheduleID
                            AND OriginalDate = s.SessionDate
                            AND CAST(OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      )
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
                    dto.setPtId(rs.getInt("PTID"));
                    dto.setPtSpecialization(rs.getString("PTSpecialization"));
                    dto.setNote(rs.getString("Note"));
                    dto.setOriginalPtName(rs.getString("OriginalPTName"));
                    dto.setCancellationReason(rs.getString("CancellationReason"));
                    
                    int origPtId = rs.getInt("OriginalPTID");
                    if (!rs.wasNull()) {
                        dto.setOriginalPtId(origPtId);
                    }
                    
                    int resReqId = rs.getInt("RescheduleRequestID");
                    if (!rs.wasNull()) {
                        dto.setRescheduleRequestId(resReqId);
                        dto.setRescheduleStatus(rs.getString("RescheduleStatus"));
                        if (rs.getDate("RescheduleProposedDate") != null) {
                            dto.setRescheduleProposedDate(rs.getDate("RescheduleProposedDate").toLocalDate());
                        }
                        dto.setRescheduleProposedStartTime(rs.getTime("RescheduleProposedStartTime"));
                        dto.setRescheduleProposedEndTime(rs.getTime("RescheduleProposedEndTime"));
                    }
                    
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
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND (
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
                      )
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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
    public boolean cancelSession(int scheduleId, String reason, int cancelledByUserId, String updatedBy) {
        String sql = """
                UPDATE PTSchedules 
                SET SessionStatus = 'Cancelled', 
                    PTAttendanceResult = 'Pending', 
                    CancellationReason = ?, 
                    CancelledByUserID = ?,
                    CancelledAt = GETDATE(),
                    UpdatedDate = GETDATE(), 
                    UpdatedBy = ? 
                WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reason);
            ps.setInt(2, cancelledByUserId);
            ps.setString(3, updatedBy);
            ps.setInt(4, scheduleId);
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
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
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
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
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

    @Override
    public boolean isScheduleConflictExcluding(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime, int excludedScheduleId) {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE PTID = ? 
                      AND SessionDate = ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND PTScheduleID != ?
                      AND (
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
                      )
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ptId);
            ps.setDate(2, java.sql.Date.valueOf(sessionDate));
            ps.setInt(3, excludedScheduleId);
            ps.setTime(4, startTime);
            ps.setTime(5, startTime);
            ps.setTime(6, endTime);
            ps.setTime(7, endTime);
            ps.setTime(8, startTime);
            ps.setTime(9, endTime);
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
    public boolean isMemberScheduleConflictExcluding(int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime, int excludedScheduleId) {
        String sql = """
                    SELECT COUNT(*) FROM PTSchedules 
                    WHERE MemberID = ? 
                      AND SessionDate = ? 
                      AND SessionStatus != 'Cancelled' 
                      AND IsDeleted = 0
                      AND PTScheduleID != ?
                      AND (
                          (CAST(StartTime AS TIME) <= CAST(? AS TIME) AND CAST(EndTime AS TIME) > CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) < CAST(? AS TIME) AND CAST(EndTime AS TIME) >= CAST(? AS TIME)) OR 
                          (CAST(StartTime AS TIME) >= CAST(? AS TIME) AND CAST(EndTime AS TIME) <= CAST(? AS TIME))
                      )
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            ps.setDate(2, java.sql.Date.valueOf(sessionDate));
            ps.setInt(3, excludedScheduleId);
            ps.setTime(4, startTime);
            ps.setTime(5, startTime);
            ps.setTime(6, endTime);
            ps.setTime(7, endTime);
            ps.setTime(8, startTime);
            ps.setTime(9, endTime);
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
    public List<PTScheduleDetailDTO> getMemberScheduleDetailsForWeek(int memberId, LocalDate startDate, LocalDate endDate) {
        List<PTScheduleDetailDTO> list = new ArrayList<>();
        String sql = """
                    SELECT
                         s.PTScheduleID, s.SessionDate, s.StartTime, s.EndTime, s.SessionStatus, s.PTAttendanceResult,
                         s.PTID, s.MemberID,
                         u.DisplayName AS PTName,
                         p.PackageName,
                         s.Note,
                         s.CancellationReason,
                         req.RequestID AS RescheduleRequestID,
                         req.Status AS RescheduleStatus,
                         req.ProposedDate AS RescheduleProposedDate,
                         req.ProposedStartTime AS RescheduleProposedStartTime,
                         req.ProposedEndTime AS RescheduleProposedEndTime,
                         req.Reason AS RescheduleReason,
                         req.SenderUserID AS RescheduleSenderUserID,
                         req.ResponseReason AS RescheduleResponseReason,
                         req.EscalationReason AS RescheduleEscalationReason
                    FROM PTSchedules s
                    JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                    JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                    JOIN PersonalTrainers pt ON s.PTID = pt.PTID
                    JOIN Users u ON pt.UserID = u.UserID
                    LEFT JOIN RescheduleRequests req ON s.PTScheduleID = req.PTScheduleID 
                      AND req.OriginalDate = s.SessionDate
                      AND CAST(req.OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      AND req.RequestID = (
                          SELECT MAX(RequestID) 
                          FROM RescheduleRequests 
                          WHERE PTScheduleID = s.PTScheduleID
                            AND OriginalDate = s.SessionDate
                            AND CAST(OriginalStartTime AS TIME) = CAST(s.StartTime AS TIME)
                      )
                    WHERE s.MemberID = ?
                      AND s.SessionDate >= ?
                      AND s.SessionDate <= ?
                      AND s.IsDeleted = 0
                    ORDER BY s.SessionDate ASC, s.StartTime ASC
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
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
                    dto.setPtName(rs.getString("PTName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setNote(rs.getString("Note"));
                    dto.setCancellationReason(rs.getString("CancellationReason"));
                    dto.setPtId(rs.getInt("PTID"));
                    dto.setMemberId(rs.getInt("MemberID"));

                    int reqId = rs.getInt("RescheduleRequestID");
                    if (!rs.wasNull()) {
                        dto.setRescheduleRequestId(reqId);
                        dto.setRescheduleStatus(rs.getString("RescheduleStatus"));
                        java.sql.Date pDate = rs.getDate("RescheduleProposedDate");
                        if (pDate != null) {
                            dto.setRescheduleProposedDate(pDate.toLocalDate());
                        }
                        dto.setRescheduleProposedStartTime(rs.getTime("RescheduleProposedStartTime"));
                        dto.setRescheduleProposedEndTime(rs.getTime("RescheduleProposedEndTime"));
                        dto.setRescheduleReason(rs.getString("RescheduleReason"));
                        dto.setRescheduleSenderUserId(rs.getInt("RescheduleSenderUserID"));
                        dto.setRescheduleResponseReason(rs.getString("RescheduleResponseReason"));
                        dto.setRescheduleEscalationReason(rs.getString("RescheduleEscalationReason"));
                    }
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean substitutePT(int scheduleId, int substitutePtId, String reason, int substituteByUserId, String updatedBy) {
        String updateSchedSql = """
                UPDATE PTSchedules 
                SET PTID = ?, 
                    OriginalPTID = COALESCE(OriginalPTID, PTID), 
                    SubstituteReason = ?, 
                    SubstituteByUserID = ?, 
                    SubstituteAt = GETDATE(), 
                    UpdatedBy = ?, 
                    UpdatedDate = GETDATE() 
                WHERE PTScheduleID = ? AND IsDeleted = 0
                """;
        String cancelRequestsSql = """
                UPDATE RescheduleRequests 
                SET Status = 'Rejected', 
                    ResponseReason = N'Đã phân công HLV thay thế mới', 
                    RespondedByUserID = ?, 
                    RespondedAt = SYSDATETIME(), 
                    UpdatedDate = SYSDATETIME() 
                WHERE PTScheduleID = ? AND Status IN ('Pending', 'Escalated')
                """;
        
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            try (PreparedStatement psSched = conn.prepareStatement(updateSchedSql);
                 PreparedStatement psReq = conn.prepareStatement(cancelRequestsSql)) {
                
                psSched.setInt(1, substitutePtId);
                psSched.setString(2, reason);
                psSched.setInt(3, substituteByUserId);
                psSched.setString(4, updatedBy);
                psSched.setInt(5, scheduleId);
                int schedRows = psSched.executeUpdate();
                
                if (schedRows > 0) {
                    psReq.setInt(1, substituteByUserId);
                    psReq.setInt(2, scheduleId);
                    psReq.executeUpdate();
                    
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            } catch (SQLException ex) {
                if (conn != null) {
                    conn.rollback();
                }
                throw ex;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<PTScheduleDetailDTO> getUpcomingSubstituteSessions(int ptId) {
        List<PTScheduleDetailDTO> list = new ArrayList<>();
        String sql = """
                SELECT 
                    s.PTScheduleID, s.SessionDate, s.StartTime, s.EndTime, s.SessionStatus,
                    u_opt.DisplayName AS OriginalPTName,
                    u_mem.DisplayName AS MemberName,
                    p.PackageName,
                    s.SubstituteReason
                FROM PTSchedules s
                INNER JOIN PersonalTrainers opt ON s.OriginalPTID = opt.PTID
                INNER JOIN Users u_opt ON opt.UserID = u_opt.UserID
                INNER JOIN Members m ON s.MemberID = m.MemberID
                INNER JOIN Users u_mem ON m.UserID = u_mem.UserID
                INNER JOIN PTRegistrations r ON s.PTRegistrationID = r.PTRegistrationID
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                WHERE s.PTID = ? 
                  AND s.OriginalPTID IS NOT NULL
                  AND s.SessionStatus = 'Upcoming'
                  AND (s.SessionDate > CAST(GETDATE() AS DATE) 
                       OR (s.SessionDate = CAST(GETDATE() AS DATE) AND s.StartTime >= CAST(GETDATE() AS TIME)))
                  AND s.IsDeleted = 0
                ORDER BY s.SessionDate ASC, s.StartTime ASC
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
                    dto.setOriginalPtName(rs.getString("OriginalPTName"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setNote(rs.getString("SubstituteReason"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int massCancelSessions(LocalDate cancelDate, java.sql.Time startTime, java.sql.Time endTime, String reason, int cancelledByUserId, String updatedBy) {
        String sql = """
                UPDATE PTSchedules
                SET SessionStatus = 'Cancelled',
                    PTAttendanceResult = 'Pending',
                    CancelledByUserID = ?,
                    CancelledAt = GETDATE(),
                    CancellationReason = ?,
                    UpdatedBy = ?,
                    UpdatedDate = GETDATE()
                WHERE SessionDate = ?
                  AND (CAST(? AS TIME) IS NULL OR CAST(StartTime AS TIME) = CAST(? AS TIME))
                  AND (CAST(? AS TIME) IS NULL OR CAST(EndTime AS TIME) = CAST(? AS TIME))
                  AND SessionStatus = 'Upcoming'
                  AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cancelledByUserId);
            ps.setString(2, reason);
            ps.setString(3, updatedBy);
            ps.setDate(4, java.sql.Date.valueOf(cancelDate));
            if (startTime != null) {
                ps.setTime(5, startTime);
                ps.setTime(6, startTime);
            } else {
                ps.setNull(5, java.sql.Types.TIME);
                ps.setNull(6, java.sql.Types.TIME);
            }
            if (endTime != null) {
                ps.setTime(7, endTime);
                ps.setTime(8, endTime);
            } else {
                ps.setNull(7, java.sql.Types.TIME);
                ps.setNull(8, java.sql.Types.TIME);
            }
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public boolean isSlotMassCancelled(LocalDate date, java.sql.Time startTime, java.sql.Time endTime) {
        String sql = """
                SELECT COUNT(*) FROM PTSchedules
                WHERE SessionDate = ?
                  AND SessionStatus = 'Cancelled'
                  AND IsDeleted = 0
                  AND (
                      UpdatedBy LIKE 'MC_ALL:%'
                      OR UpdatedBy LIKE '%Hủy hàng loạt Tất cả các ca%'
                      OR (
                          CAST(StartTime AS TIME) = CAST(? AS TIME)
                          AND CAST(EndTime AS TIME) = CAST(? AS TIME)
                          AND (UpdatedBy LIKE 'MC_SLOT:%' OR UpdatedBy LIKE '%Hủy hàng loạt%')
                      )
                  )
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(date));
            ps.setTime(2, startTime);
            ps.setTime(3, endTime);
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
    public List<Map<String, Object>> getMassCancelledSlots() {
        List<Map<String, Object>> list = new java.util.ArrayList<>();
        String sql = """
                SELECT DISTINCT SessionDate, StartTime, EndTime, UpdatedBy
                FROM PTSchedules
                WHERE SessionStatus = 'Cancelled'
                  AND IsDeleted = 0
                  AND (UpdatedBy LIKE 'MC_ALL:%' OR UpdatedBy LIKE 'MC_SLOT:%' OR UpdatedBy LIKE '%Hủy hàng loạt%')
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new java.util.HashMap<>();
                map.put("date", rs.getDate("SessionDate").toLocalDate().toString());
                java.sql.Time start = rs.getTime("StartTime");
                java.sql.Time end = rs.getTime("EndTime");
                String updatedBy = rs.getString("UpdatedBy");
                boolean isAllDay = updatedBy != null && (updatedBy.startsWith("MC_ALL:") || updatedBy.contains("Tất cả các ca"));
                map.put("isAllDay", isAllDay);
                if (start != null && end != null) {
                    map.put("slot", start.toString().substring(0, 5) + "-" + end.toString().substring(0, 5));
                } else {
                    map.put("slot", "All");
                }
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
