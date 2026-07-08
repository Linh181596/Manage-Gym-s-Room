package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.RescheduleRequestDAO;
import com.mycompany.gymcentermanagement.model.entity.RescheduleRequest;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RescheduleRequestDAOImpl implements RescheduleRequestDAO {

    @Override
    public boolean create(RescheduleRequest request) {
        String sql = """
                INSERT INTO RescheduleRequests (
                    PTScheduleID,
                    SenderUserID,
                    ReceiverUserID,
                    OriginalDate,
                    OriginalStartTime,
                    OriginalEndTime,
                    ProposedDate,
                    ProposedStartTime,
                    ProposedEndTime,
                    Status,
                    Reason,
                    CreatedDate
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', ?, SYSDATETIME())
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, request.getScheduleId());
            ps.setInt(2, request.getSenderUserId());
            ps.setInt(3, request.getReceiverUserId());
            ps.setDate(4, java.sql.Date.valueOf(request.getOriginalDate()));
            ps.setTime(5, request.getOriginalStartTime());
            ps.setTime(6, request.getOriginalEndTime());
            ps.setDate(7, java.sql.Date.valueOf(request.getProposedDate()));
            ps.setTime(8, request.getProposedStartTime());
            ps.setTime(9, request.getProposedEndTime());
            ps.setString(10, request.getReason());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean hasPendingRequestForSchedule(int scheduleId) {
        String sql = """
                SELECT 1
                FROM RescheduleRequests
                WHERE PTScheduleID = ?
                  AND Status = 'Pending'
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public RescheduleRequest getById(int requestId) {
        String sql = """
                SELECT RequestID AS RescheduleRequestID, PTScheduleID, SenderUserID, ReceiverUserID,
                       OriginalDate, OriginalStartTime, OriginalEndTime,
                       ProposedDate, ProposedStartTime, ProposedEndTime, Status, Reason
                FROM RescheduleRequests
                WHERE RequestID = ?
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    RescheduleRequest req = new RescheduleRequest();
                    req.setRequestId(rs.getInt("RescheduleRequestID"));
                    req.setScheduleId(rs.getInt("PTScheduleID"));
                    req.setSenderUserId(rs.getInt("SenderUserID"));
                    req.setReceiverUserId(rs.getInt("ReceiverUserID"));
                    req.setOriginalDate(rs.getDate("OriginalDate").toLocalDate());
                    req.setOriginalStartTime(rs.getTime("OriginalStartTime"));
                    req.setOriginalEndTime(rs.getTime("OriginalEndTime"));
                    req.setProposedDate(rs.getDate("ProposedDate").toLocalDate());
                    req.setProposedStartTime(rs.getTime("ProposedStartTime"));
                    req.setProposedEndTime(rs.getTime("ProposedEndTime"));
                    req.setStatus(rs.getString("Status"));
                    req.setReason(rs.getString("Reason"));
                    return req;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateStatus(int requestId, String status) {
        String sql = "UPDATE RescheduleRequests SET Status = ?, UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean approveAndUpdateSchedule(int requestId, int scheduleId, java.time.LocalDate newDate, java.sql.Time newStart, java.sql.Time newEnd, int responderUserId) {
        String updateReqSql = "UPDATE RescheduleRequests SET Status = 'Approved', RespondedByUserID = ?, RespondedAt = SYSDATETIME(), UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        String updateSchedSql = "UPDATE PTSchedules SET SessionDate = ?, StartTime = ?, EndTime = ?, UpdatedDate = GETDATE(), UpdatedBy = 'System (Reschedule)' WHERE PTScheduleID = ?";
        
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psReq = conn.prepareStatement(updateReqSql);
                 PreparedStatement psSched = conn.prepareStatement(updateSchedSql)) {
                
                psReq.setInt(1, responderUserId);
                psReq.setInt(2, requestId);
                psReq.executeUpdate();
                
                psSched.setDate(1, java.sql.Date.valueOf(newDate));
                psSched.setTime(2, newStart);
                psSched.setTime(3, newEnd);
                psSched.setInt(4, scheduleId);
                psSched.executeUpdate();
                
                conn.commit();
                return true;
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean rejectRequest(int requestId, int responderUserId, String responseReason) {
        String sql = "UPDATE RescheduleRequests SET Status = 'Rejected', RespondedByUserID = ?, RespondedAt = SYSDATETIME(), ResponseReason = ?, UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, responderUserId);
            if (responseReason == null) {
                ps.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(2, responseReason);
            }
            ps.setInt(3, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean escalateRequest(int requestId, int escalatorUserId, String escalationReason) {
        String sql = "UPDATE RescheduleRequests SET Status = 'Escalated', EscalatedByUserID = ?, EscalatedAt = SYSDATETIME(), EscalationReason = ?, UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, escalatorUserId);
            if (escalationReason == null) {
                ps.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(2, escalationReason);
            }
            ps.setInt(3, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
