package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.RescheduleRequestDAO;
import com.mycompany.gymcentermanagement.dto.RescheduleRequestDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.RescheduleRequest;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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
            ps.setDate(4, Date.valueOf(request.getOriginalDate()));
            ps.setTime(5, request.getOriginalStartTime());
            ps.setTime(6, request.getOriginalEndTime());
            ps.setDate(7, Date.valueOf(request.getProposedDate()));
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
    public boolean approveAndUpdateSchedule(int requestId, int scheduleId, LocalDate newDate, Time newStart, Time newEnd, int responderUserId) {
        String updateReqSql = "UPDATE RescheduleRequests SET Status = 'Approved', RespondedByUserID = ?, RespondedAt = SYSDATETIME(), UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        String updateSchedSql = "UPDATE PTSchedules SET SessionDate = ?, StartTime = ?, EndTime = ?, UpdatedDate = GETDATE(), UpdatedBy = 'System (Reschedule)' WHERE PTScheduleID = ?";
        
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psReq = conn.prepareStatement(updateReqSql);
                 PreparedStatement psSched = conn.prepareStatement(updateSchedSql)) {
                
                psReq.setInt(1, responderUserId);
                psReq.setInt(2, requestId);
                psReq.executeUpdate();
                
                psSched.setDate(1, Date.valueOf(newDate));
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
                ps.setNull(2, Types.NVARCHAR);
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
                ps.setNull(2, Types.NVARCHAR);
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

    @Override
    public List<RescheduleRequestDetailDTO> getEscalatedRequests() {
        List<RescheduleRequestDetailDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "  r.RequestID, "
                + "  r.PTScheduleID, "
                + "  r.SenderUserID, "
                + "  r.ReceiverUserID, "
                + "  r.OriginalDate, "
                + "  r.OriginalStartTime, "
                + "  r.OriginalEndTime, "
                + "  r.ProposedDate, "
                + "  r.ProposedStartTime, "
                + "  r.ProposedEndTime, "
                + "  r.Status, "
                + "  r.Reason, "
                + "  r.ResponseReason, "
                + "  r.EscalationReason, "
                + "  r.CreatedDate, "
                + "  r.UpdatedDate, "
                + "  u_send.DisplayName AS SenderName, "
                + "  u_recv.DisplayName AS ReceiverName, "
                + "  u_pt.DisplayName AS PTName, "
                + "  u_memb.DisplayName AS MemberName, "
                + "  p.PackageName "
                + "FROM RescheduleRequests r "
                + "INNER JOIN Users u_send ON r.SenderUserID = u_send.UserID "
                + "INNER JOIN Users u_recv ON r.ReceiverUserID = u_recv.UserID "
                + "INNER JOIN PTSchedules s ON r.PTScheduleID = s.PTScheduleID "
                + "INNER JOIN PersonalTrainers pt ON s.PTID = pt.PTID "
                + "INNER JOIN Users u_pt ON pt.UserID = u_pt.UserID "
                + "INNER JOIN PTRegistrations reg ON s.PTRegistrationID = reg.PTRegistrationID "
                + "INNER JOIN Members m ON reg.MemberID = m.MemberID "
                + "INNER JOIN Users u_memb ON m.UserID = u_memb.UserID "
                + "INNER JOIN PTServicePrices sp ON reg.PTServicePriceID = sp.PTServicePriceID "
                + "INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID "
                + "WHERE r.Status = 'Escalated' "
                + "ORDER BY r.CreatedDate DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RescheduleRequestDetailDTO dto = new RescheduleRequestDetailDTO();
                dto.setRequestId(rs.getInt("RequestID"));
                dto.setScheduleId(rs.getInt("PTScheduleID"));
                dto.setSenderUserId(rs.getInt("SenderUserID"));
                dto.setReceiverUserId(rs.getInt("ReceiverUserID"));
                
                Date origDateVal = rs.getDate("OriginalDate");
                if (origDateVal != null) {
                    dto.setOriginalDate(origDateVal.toLocalDate());
                }
                dto.setOriginalStartTime(rs.getTime("OriginalStartTime"));
                dto.setOriginalEndTime(rs.getTime("OriginalEndTime"));
                
                Date propDateVal = rs.getDate("ProposedDate");
                if (propDateVal != null) {
                    dto.setProposedDate(propDateVal.toLocalDate());
                }
                dto.setProposedStartTime(rs.getTime("ProposedStartTime"));
                dto.setProposedEndTime(rs.getTime("ProposedEndTime"));
                
                dto.setStatus(rs.getString("Status"));
                dto.setReason(rs.getString("Reason"));
                dto.setResponseReason(rs.getString("ResponseReason"));
                dto.setEscalationReason(rs.getString("EscalationReason"));
                
                Timestamp createdVal = rs.getTimestamp("CreatedDate");
                if (createdVal != null) {
                    dto.setCreatedDate(createdVal.toLocalDateTime());
                }
                Timestamp updatedVal = rs.getTimestamp("UpdatedDate");
                if (updatedVal != null) {
                    dto.setUpdatedDate(updatedVal.toLocalDateTime());
                }
                
                dto.setSenderName(rs.getString("SenderName"));
                dto.setReceiverName(rs.getString("ReceiverName"));
                dto.setPtName(rs.getString("PTName"));
                dto.setMemberName(rs.getString("MemberName"));
                dto.setPackageName(rs.getString("PackageName"));
                
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
