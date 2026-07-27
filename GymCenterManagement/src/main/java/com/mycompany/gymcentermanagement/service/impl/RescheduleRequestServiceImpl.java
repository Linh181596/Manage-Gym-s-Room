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
import com.mycompany.gymcentermanagement.dao.NotificationDAO;
import com.mycompany.gymcentermanagement.dao.impl.NotificationDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.time.LocalDateTime;

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

    /**
     * Tạo yêu cầu đổi lịch học (Từ Hội viên hoặc PT).
     * Luồng nghiệp vụ:
     * 1. Validate quyền, ngày đề xuất.
     * 2. [BR-CONS-48]: Validate ngày không được ở trong quá khứ.
     * 3. [BR-ACT-49], [BR-ACT-50], [BR-CONS-15]: PT và Hội viên có thể gửi yêu cầu đổi lịch.
     * 4. Check khung giờ hợp lệ, không trùng lịch, không trùng ca bị hủy hàng loạt.
     * 5. Lưu vào Database (Trạng thái Pending).
     * 
     * @param actorUserId UserID của người gửi
     * @param actorRole Role của người gửi
     * @param scheduleId ID ca học
     * @param proposedDate Ngày đề xuất
     * @param proposedSlot Khung giờ đề xuất (VD: 08:15-09:45)
     * @param reason Lý do
     * @return Chuỗi kết quả ("SUCCESS" nếu thành công)
     */
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
            return "Khung giờ đề xuất mới phải khác với khung giờ gốc của ca tập đã bị hủy/đổi.";
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
        if (created) {
            try {
                NotificationDAO notifDAO = new NotificationDAOImpl();
                Notification notif = new Notification();
                
                // Lấy tên của người gửi (PT hoặc Hội viên) để hiển thị trong nội dung
                User senderUser = userDAO.findById(senderUserId);
                String senderName = (senderUser != null) ? senderUser.getFullName() : "Đối tác";
                
                boolean isCancelled = "Cancelled".equalsIgnoreCase(schedule.getSessionStatus());
                if (actorRole == User.Role.PT) {
                    notif.setTitle(isCancelled ? "Yêu cầu xếp lịch học bù từ HLV" : "Yêu cầu đổi lịch học mới từ HLV");
                    notif.setContent("HLV " + senderName + " đề xuất " 
                            + (isCancelled ? "xếp ca học bù" : "đổi ca học") + " ngày " 
                            + schedule.getSessionDate() + " sang ngày " + proposedDate + " ca " + proposedSlot + ".");
                } else {
                    notif.setTitle(isCancelled ? "Yêu cầu xếp lịch học bù từ Hội viên" : "Yêu cầu đổi lịch học mới từ Hội viên");
                    notif.setContent("Hội viên " + senderName + " đề xuất " 
                            + (isCancelled ? "xếp ca học bù" : "đổi ca học") + " ngày " 
                            + schedule.getSessionDate() + " sang ngày " + proposedDate + " ca " + proposedSlot + ".");
                }
                
                notif.setCreatedBy(senderUserId);
                notif.setTargetRole("Specific");
                notif.setCreatedByRole(actorRole.name());
                notif.setCreatedDate(LocalDateTime.now());
                notif.setPublishDate(LocalDateTime.now());
                notif.setRecipientUserId(receiverUserId); // Gửi cho người nhận yêu cầu
                notifDAO.insert(notif);
            } catch (Exception e) {
                System.err.println("Lỗi gửi thông báo khi tạo yêu cầu đổi lịch: " + e.getMessage());
            }
        }
        return created ? "SUCCESS" : "Không thể tạo yêu cầu đổi lịch lúc này.";
    }

    /**
     * Xử lý (Duyệt/Từ chối) một yêu cầu đổi lịch.
     * Luồng nghiệp vụ:
     * - Approve: Check lại trùng lịch, update lịch học cũ hoặc tạo lịch học bù.
     * - Reject: Cập nhật trạng thái Rejected kèm lý do.
     * 
     * @param requestId ID yêu cầu
     * @param action Hành động (approve, reject)
     * @param responderUserId Người thực hiện
     * @param responseReason Lý do phản hồi
     * @return Chuỗi kết quả
     */
    @Override
    public String respondToRequest(int requestId, String action, int responderUserId, String responseReason) {
        RescheduleRequest req = rescheduleRequestDAO.getById(requestId);
        if (req == null) {
            return "Yêu cầu đổi lịch không tồn tại.";
        }

        if (!"Pending".equalsIgnoreCase(req.getStatus())) {
            return "Yêu cầu này đã được xử lý từ trước.";
        }

        if (req.getReceiverUserId() != responderUserId) {
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
            if (success) {
                sendRespondNotification(req, "Approved", responderUserId, null);
                return "SUCCESS";
            }
            return "Lỗi hệ thống khi cập nhật lịch mới.";
        } else if ("reject".equalsIgnoreCase(action)) {
            if (responseReason == null || responseReason.trim().isEmpty()) {
                return "Vui lòng nhập lý do từ chối.";
            }
            boolean success = rescheduleRequestDAO.rejectRequest(requestId, responderUserId, responseReason);
            if (success) {
                sendRespondNotification(req, "Rejected", responderUserId, responseReason);
                return "SUCCESS";
            }
            return "Lỗi hệ thống khi từ chối yêu cầu.";
        }

        return "Hành động không hợp lệ.";
    }

    private void sendRespondNotification(RescheduleRequest req, String action, int responderUserId, String reason) {
        try {
            NotificationDAO notifDAO = new NotificationDAOImpl();
            Notification notif = new Notification();
            if ("Approved".equals(action)) {
                notif.setTitle("Yêu cầu đổi lịch/học bù đã được đồng ý");
                notif.setContent("Yêu cầu đổi/bù ca tập ngày " + req.getOriginalDate() 
                        + " sang ngày " + req.getProposedDate() + " đã được đồng ý.");
            } else if ("Rejected".equals(action)) {
                notif.setTitle("Yêu cầu đổi lịch/học bù đã bị từ chối");
                notif.setContent("Yêu cầu đổi/bù ca tập ngày " + req.getOriginalDate() 
                        + " sang ngày " + req.getProposedDate() + " đã bị từ chối. Lý do: " + reason);
            }
            notif.setCreatedBy(responderUserId);
            notif.setTargetRole("Specific");
            notif.setCreatedByRole("System");
            notif.setCreatedDate(LocalDateTime.now());
            notif.setPublishDate(LocalDateTime.now());
            notif.setRecipientUserId(req.getSenderUserId());
            notifDAO.insert(notif);
        } catch (Exception e) {
            System.err.println("Lỗi gửi thông báo phản hồi yêu cầu đổi lịch: " + e.getMessage());
        }
    }
}
