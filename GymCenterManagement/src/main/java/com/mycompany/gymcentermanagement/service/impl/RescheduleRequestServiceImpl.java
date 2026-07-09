package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.RescheduleRequestDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.PTScheduleDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.RescheduleRequestDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.dto.RescheduleRequestDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.RescheduleRequest;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.RescheduleRequestService;
import com.mycompany.gymcentermanagement.utils.PTFixedSlotHelper;

import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.util.List;

public class RescheduleRequestServiceImpl implements RescheduleRequestService {

    private final PTScheduleDAO ptScheduleDAO = new PTScheduleDAOImpl();
    private final PersonalTrainerDAO personalTrainerDAO = new PersonalTrainerDAOImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();
    private final RescheduleRequestDAO rescheduleRequestDAO = new RescheduleRequestDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public String createRequest(int actorUserId, User.Role actorRole, int scheduleId, LocalDate proposedDate, String proposedSlot, String reason) {
        if (actorRole != User.Role.PT && actorRole != User.Role.Member) {
            return "Chỉ hội viên hoặc PT mới được gửi yêu cầu đổi lịch.";
        }

        if (scheduleId <= 0) {
            return "Mã buổi tập không hợp lệ.";
        }

        if (proposedDate == null) {
            return "Vui lòng chọn ngày đề xuất mới.";
        }

        if (proposedDate.isBefore(LocalDate.now())) {
            return "Ngày đề xuất mới không được nằm trong quá khứ.";
        }

        if (reason == null || reason.trim().isEmpty()) {
            return "Vui lòng nhập lý do đổi lịch.";
        }

        PTSchedule schedule = ptScheduleDAO.getScheduleById(scheduleId);
        if (schedule == null) {
            return "Không tìm thấy buổi tập cần đổi lịch.";
        }

        if (!"Upcoming".equalsIgnoreCase(schedule.getSessionStatus()) && !"Cancelled".equalsIgnoreCase(schedule.getSessionStatus())) {
            return "Chỉ được tạo yêu cầu đổi lịch/xếp bù cho buổi tập Upcoming hoặc Cancelled.";
        }

        PersonalTrainer pt = personalTrainerDAO.findById(schedule.getPtId());
        if (pt == null) {
            return "Không tìm thấy thông tin PT của buổi tập.";
        }

        Member member;
        try {
            member = memberDAO.findById(schedule.getMemberId());
        } catch (Exception e) {
            e.printStackTrace();
            return "Không tìm thấy thông tin hội viên của buổi tập.";
        }
        if (member == null) {
            return "Không tìm thấy thông tin hội viên của buổi tập.";
        }

        int senderUserId;
        int receiverUserId;
        if (actorRole == User.Role.PT) {
            if (pt.getUserId() != actorUserId) {
                return "Bạn không liên quan đến buổi tập này.";
            }
            senderUserId = pt.getUserId();
            receiverUserId = member.getUserId();
        } else {
            if (member.getUserId() != actorUserId) {
                return "Bạn không liên quan đến buổi tập này.";
            }
            senderUserId = member.getUserId();
            receiverUserId = pt.getUserId();
        }

        if (rescheduleRequestDAO.hasPendingRequestForSchedule(scheduleId)) {
            return "Buổi tập này đã có yêu cầu đổi lịch đang chờ xử lý.";
        }

        PTFixedSlotHelper.FixedSlot slot = PTFixedSlotHelper.parseSlot(proposedSlot);
        if (slot == null) {
            return "Khung giờ đề xuất phải thuộc fixed slots của hệ thống.";
        }

        Time proposedStartTime = slot.startTime();
        Time proposedEndTime = slot.endTime();
        boolean sameAsOriginal = proposedDate.equals(schedule.getSessionDate())
                && proposedStartTime.equals(schedule.getStartTime())
                && proposedEndTime.equals(schedule.getEndTime());
        if (sameAsOriginal) {
            return "Khung giờ mới phải khác lịch gốc hiện tại.";
        }

        if (ptScheduleDAO.isSlotMassCancelled(proposedDate, proposedStartTime, proposedEndTime)) {
            return "Khung giờ này đã bị hủy hàng loạt bởi Admin (Ví dụ: sự cố vận hành, bảo trì...). Vui lòng đề xuất ngày hoặc khung giờ khác.";
        }

        boolean ptConflict = ptScheduleDAO.isScheduleConflictExcluding(
                schedule.getPtId(),
                proposedDate,
                proposedStartTime,
                proposedEndTime,
                scheduleId
        );
        boolean memberConflict = ptScheduleDAO.isMemberScheduleConflictExcluding(
                schedule.getMemberId(),
                proposedDate,
                proposedStartTime,
                proposedEndTime,
                scheduleId
        );
        if (ptConflict || memberConflict) {
            if (ptConflict && memberConflict) {
                return "Khung giờ đề xuất bị trùng lịch cả PT và hội viên.";
            }
            if (ptConflict) {
                return "Khung giờ đề xuất bị trùng lịch của PT.";
            }
            return "Khung giờ đề xuất bị trùng lịch của hội viên.";
        }

        RescheduleRequest request = new RescheduleRequest();
        request.setScheduleId(scheduleId);
        request.setSenderUserId(senderUserId);
        request.setReceiverUserId(receiverUserId);
        request.setOriginalDate(schedule.getSessionDate());
        request.setOriginalStartTime(schedule.getStartTime());
        request.setOriginalEndTime(schedule.getEndTime());
        request.setProposedDate(proposedDate);
        request.setProposedStartTime(proposedStartTime);
        request.setProposedEndTime(proposedEndTime);
        request.setStatus("Pending");
        request.setReason(reason.trim());

        boolean created = rescheduleRequestDAO.create(request);
        return created ? "SUCCESS" : "Không thể tạo yêu cầu đổi lịch lúc này.";
    }

    @Override
    public String respondToRequest(int requestId, String action, int responderUserId, String responseReason) {
        RescheduleRequest req = rescheduleRequestDAO.getById(requestId);
        if (req == null) {
            return "Yêu cầu đổi lịch không tồn tại.";
        }

        if (!"Pending".equalsIgnoreCase(req.getStatus()) && !"Escalated".equalsIgnoreCase(req.getStatus())) {
            return "Yêu cầu này đã được xử lý từ trước.";
        }

        User responder = null;
        try {
            responder = userDAO.findById(responderUserId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (responder == null) {
            return "Người thực hiện không tồn tại.";
        }

        boolean isStaffOrAdmin = (responder.getRole() == User.Role.Staff || responder.getRole() == User.Role.Admin);
        if (!isStaffOrAdmin && req.getReceiverUserId() != responderUserId) {
            return "Bạn không có quyền phản hồi yêu cầu này.";
        }

        if ("approve".equalsIgnoreCase(action)) {
            PTSchedule schedule = ptScheduleDAO.getScheduleById(req.getScheduleId());
            if (schedule == null) {
                return "Không tìm thấy buổi tập liên quan.";
            }

            if (ptScheduleDAO.isSlotMassCancelled(req.getProposedDate(), req.getProposedStartTime(), req.getProposedEndTime())) {
                return "Không thể duyệt do khung giờ đề xuất mới đã bị hủy hàng loạt bởi Admin (Ví dụ: sự cố vận hành, bảo trì...).";
            }

            boolean ptConflict = ptScheduleDAO.isScheduleConflictExcluding(
                    schedule.getPtId(),
                    req.getProposedDate(),
                    req.getProposedStartTime(),
                    req.getProposedEndTime(),
                    req.getScheduleId()
            );
            boolean memberConflict = ptScheduleDAO.isMemberScheduleConflictExcluding(
                    schedule.getMemberId(),
                    req.getProposedDate(),
                    req.getProposedStartTime(),
                    req.getProposedEndTime(),
                    req.getScheduleId()
            );

            if (ptConflict || memberConflict) {
                return "Khung giờ đề xuất mới bị trùng lịch của " + 
                       (ptConflict && memberConflict ? "cả PT và hội viên" : (ptConflict ? "PT" : "hội viên")) + ".";
            }

            boolean success = rescheduleRequestDAO.approveAndUpdateSchedule(
                    requestId,
                    req.getScheduleId(),
                    req.getProposedDate(),
                    req.getProposedStartTime(),
                    req.getProposedEndTime(),
                    responderUserId
            );
            return success ? "SUCCESS" : "Lỗi hệ thống khi cập nhật lịch mới.";
        } else if ("reject".equalsIgnoreCase(action)) {
            if (responseReason == null || responseReason.trim().isEmpty()) {
                return "Vui lòng nhập lý do từ chối.";
            }
            boolean success = rescheduleRequestDAO.rejectRequest(requestId, responderUserId, responseReason);
            return success ? "SUCCESS" : "Lỗi hệ thống khi từ chối yêu cầu.";
        } else if ("escalate".equalsIgnoreCase(action)) {
            if (responseReason == null || responseReason.trim().isEmpty()) {
                return "Vui lòng nhập lý do yêu cầu hỗ trợ.";
            }
            boolean success = rescheduleRequestDAO.escalateRequest(requestId, responderUserId, responseReason);
            return success ? "SUCCESS" : "Lỗi hệ thống khi gửi yêu cầu hỗ trợ.";
        }

        return "Hành động không hợp lệ.";
    }

    @Override
    public List<RescheduleRequestDetailDTO> getEscalatedRequests() {
        List<RescheduleRequestDetailDTO> list = rescheduleRequestDAO.getEscalatedRequests();
        for (RescheduleRequestDetailDTO req : list) {
            PTSchedule schedule = ptScheduleDAO.getScheduleById(req.getScheduleId());
            if (schedule != null) {
                boolean ptConflict = ptScheduleDAO.isScheduleConflictExcluding(
                        schedule.getPtId(),
                        req.getProposedDate(),
                        req.getProposedStartTime(),
                        req.getProposedEndTime(),
                        req.getScheduleId()
                );
                boolean memberConflict = ptScheduleDAO.isMemberScheduleConflictExcluding(
                        schedule.getMemberId(),
                        req.getProposedDate(),
                        req.getProposedStartTime(),
                        req.getProposedEndTime(),
                        req.getScheduleId()
                );
                req.setPtConflict(ptConflict);
                req.setMemberConflict(memberConflict);
            }
        }
        return list;
    }
}
