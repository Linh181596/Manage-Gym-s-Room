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

    /**
     * Tạo một yêu cầu đổi lịch / học bù mới.
     * Luồng nghiệp vụ: Insert dữ liệu vào RescheduleRequests.
     * 
     * @param request Đối tượng yêu cầu
     * @return true nếu insert thành công
     */
    @Override
    public boolean create(RescheduleRequest request) {
        // SQL: Thêm mới một yêu cầu đổi lịch với trạng thái truyền vào (Pending)
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
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATETIME())
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
             ps.setString(10, request.getStatus());
             ps.setString(11, request.getReason());
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

    /**
     * Duyệt yêu cầu đổi lịch và cập nhật/thêm mới lịch học.
     * Luồng nghiệp vụ:
     * 1. Lấy thông tin lịch học hiện tại.
     * 2. Nếu lịch cũ là Cancelled -> Insert lịch học mới (học bù) và trỏ lại PT gốc nếu có.
     * 3. Nếu lịch cũ là Upcoming -> Cập nhật trực tiếp ngày/giờ trên record cũ.
     * 4. [BR-CONS-48]: Các lịch trong quá khứ không được đổi (đã bị chặn ở bước validate của Service).
     * 
     * @param requestId ID yêu cầu
     * @param scheduleId ID lịch học
     * @param newDate Ngày mới
     * @param newStart Giờ bắt đầu mới
     * @param newEnd Giờ kết thúc mới
     * @param responderUserId Người duyệt (PT/Member/Staff)
     * @return true nếu duyệt và cập nhật thành công
     */
    @Override
    public boolean approveAndUpdateSchedule(int requestId, int scheduleId, LocalDate newDate, Time newStart, Time newEnd, int responderUserId) {
        // SQL: Lấy thông tin lịch cũ để kiểm tra trạng thái
        String selectSql = "SELECT SessionStatus, PTID, PTRegistrationID, MemberID, OriginalPTID, SessionDate FROM PTSchedules WHERE PTScheduleID = ?";
        // SQL: Cập nhật trạng thái yêu cầu
        String updateReqSql = "UPDATE RescheduleRequests SET Status = 'Approved', RespondedByUserID = ?, RespondedAt = SYSDATETIME(), UpdatedDate = SYSDATETIME() WHERE RequestID = ?";
        // SQL: Cập nhật lịch cũ nếu là Upcoming
        String updateSchedSql = "UPDATE PTSchedules SET SessionDate = ?, StartTime = ?, EndTime = ?, UpdatedDate = GETDATE(), UpdatedBy = 'System (Reschedule)' WHERE PTScheduleID = ?";
        // SQL: Insert lịch mới nếu lịch cũ là Cancelled (Học bù)
        String insertSchedSql = """
                INSERT INTO PTSchedules (PTID, PTRegistrationID, MemberID, SessionDate, StartTime, EndTime, SessionStatus, PTAttendanceResult, CreatedByUserID, CreatedDate, IsDeleted, OriginalPTID, Note) 
                VALUES (?, ?, ?, ?, ?, ?, 'Upcoming', 'Pending', ?, GETDATE(), 0, ?, ?)
                """;

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psSelect = conn.prepareStatement(selectSql);
                 PreparedStatement psReq = conn.prepareStatement(updateReqSql)) {
                
                psSelect.setInt(1, scheduleId);
                String status = "Upcoming";
                int ptId = 0, regId = 0, memberId = 0;
                Integer originalPtId = null;
                Date oldDate = null;
                try (ResultSet rs = psSelect.executeQuery()) {
                    if (rs.next()) {
                        status = rs.getString("SessionStatus");
                        ptId = rs.getInt("PTID");
                        regId = rs.getInt("PTRegistrationID");
                        memberId = rs.getInt("MemberID");
                        originalPtId = rs.getObject("OriginalPTID") != null ? rs.getInt("OriginalPTID") : null;
                        oldDate = rs.getDate("SessionDate");
                    } else {
                        return false;
                    }
                }

                // Update request
                psReq.setInt(1, responderUserId);
                psReq.setInt(2, requestId);
                psReq.executeUpdate();

                if ("Cancelled".equalsIgnoreCase(status)) {
                    // Trạng thái cũ là Cancelled -> Tạo record học bù mới, không sửa record cũ
                    try (PreparedStatement psInsert = conn.prepareStatement(insertSchedSql)) {
                        psInsert.setInt(1, ptId);
                        psInsert.setInt(2, regId);
                        psInsert.setInt(3, memberId);
                        psInsert.setDate(4, Date.valueOf(newDate));
                        psInsert.setTime(5, newStart);
                        psInsert.setTime(6, newEnd);
                        psInsert.setInt(7, responderUserId);
                        if (originalPtId != null) {
                            psInsert.setInt(8, originalPtId);
                        } else {
                            psInsert.setNull(8, Types.INTEGER);
                        }
                        String note = "Học bù cho ca bị hủy ngày " + (oldDate != null ? oldDate.toString() : "");
                        psInsert.setString(9, note);
                        psInsert.executeUpdate();
                    }
                } else {
                    // Trạng thái cũ là Upcoming -> Cập nhật trực tiếp trên record cũ
                    try (PreparedStatement psSched = conn.prepareStatement(updateSchedSql)) {
                        psSched.setDate(1, Date.valueOf(newDate));
                        psSched.setTime(2, newStart);
                        psSched.setTime(3, newEnd);
                        psSched.setInt(4, scheduleId);
                        psSched.executeUpdate();
                    }
                }

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
}
