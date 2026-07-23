package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTScheduleDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.dao.NotificationDAO;
import com.mycompany.gymcentermanagement.dao.impl.NotificationDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.time.LocalDateTime;

import java.sql.Time;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class PTScheduleServiceImpl implements PTScheduleService {
    private PTScheduleDAO ptScheduleDAO = new PTScheduleDAOImpl();
    private final PersonalTrainerDAO personalTrainerDAO = new PersonalTrainerDAOImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();
    private final NotificationDAO notificationDAO = new NotificationDAOImpl();

    /**
     * Kiểm tra xem PT có bị trùng lịch trong một khung giờ cụ thể không.
     * Luồng nghiệp vụ: Truy vấn kiểm tra giao thoa giữa các thời gian của các Schedule 'Upcoming'/'Completed'.
     * [BR-CONS-41]: System prevents the scheduling of training sessions for a member or a PT if either is already booked for that specific time.
     * 
     * @param ptId ID của PT
     * @param sessionDate Ngày học
     * @param startTime Thời gian bắt đầu
     * @param endTime Thời gian kết thúc
     * @return true nếu bị trùng lịch
     */
    @Override
    public boolean isScheduleConflict(int ptId, LocalDate sessionDate, Time startTime, Time endTime) {
        return ptScheduleDAO.isScheduleConflict(ptId, sessionDate, startTime, endTime);
    }

    @Override
    public boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId) {
        return ptScheduleDAO.insertSchedules(schedules, createdByUserId);
    }

    @Override
    public List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getSchedulesForWeek(ptId, startDate, endDate);
    }

    @Override
    public List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getPTScheduleDetailsForWeek(ptId, startDate, endDate);
    }

    @Override
    public List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date) {
        return ptScheduleDAO.getAllSchedulesByDate(date);
    }

    /**
     * Kiểm tra xem Hội viên có bị trùng lịch trong một khung giờ cụ thể không.
     * Luồng nghiệp vụ: Truy vấn kiểm tra giao thoa giữa các thời gian của các Schedule.
     * [BR-CONS-41]: System prevents the scheduling of training sessions for a member or a PT if either is already booked for that specific time.
     * 
     * @param memberId ID của hội viên
     * @param sessionDate Ngày học
     * @param startTime Thời gian bắt đầu
     * @param endTime Thời gian kết thúc
     * @return true nếu bị trùng lịch
     */
    @Override
    public boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, Time startTime, Time endTime) {
        return ptScheduleDAO.isMemberScheduleConflict(memberId, sessionDate, startTime, endTime);
    }

    @Override
    public List<PTSchedule> getMemberSchedulesForWeek(int memberId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getMemberSchedulesForWeek(memberId, startDate, endDate);
    }

    @Override
    public boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus, String updatedBy) {
        return ptScheduleDAO.updateAttendance(scheduleId, attendanceStatus, sessionStatus, updatedBy);
    }

    @Override
    public PTSchedule getScheduleById(int scheduleId) {
        return ptScheduleDAO.getScheduleById(scheduleId);
    }

    @Override
    public List<PTScheduleDetailDTO> getCompletedSessions(int ptId) {
        return ptScheduleDAO.getCompletedSessions(ptId);
    }

    @Override
    public boolean cancelSession(int scheduleId, String reason, int cancelledByUserId, String updatedBy) {
        return ptScheduleDAO.cancelSession(scheduleId, reason, cancelledByUserId, updatedBy);
    }

    /**
     * Lưu danh sách các buổi học và cập nhật ngày bắt đầu, kết thúc của đơn đăng ký.
     * Dùng cho xếp lịch cố định toàn bộ số buổi (Generate Fixed Schedule).
     * [BR-CONS-41]: Đảm bảo không trùng lịch khi save (check lại lần cuối bằng Transaction).
     * 
     * @param schedules Danh sách các buổi học
     * @param createdByUserId ID người tạo
     * @param actualStartDate Ngày bắt đầu thực tế (ngày học buổi đầu tiên)
     * @param actualEndDate Ngày kết thúc thực tế (ngày học buổi cuối cùng)
     * @return true nếu lưu thành công
     */
    @Override
    public boolean insertSchedulesAndUpdateRegistration(List<PTSchedule> schedules, int createdByUserId,
            LocalDate actualStartDate, LocalDate actualEndDate) {
        return ptScheduleDAO.insertSchedulesAndUpdateRegistration(schedules, createdByUserId, actualStartDate,
                actualEndDate);
    }

    @Override
    public String generateFixedScheduleForPT(int regId, int loggedInPtId, LocalDate actualStartDate,
            Map<String, String> dayTimeSlots, int createdByUserId) {
        PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();

        // 1. Validate actualStartDate is not in the past
        if (actualStartDate.isBefore(LocalDate.now())) {
            return "Ngày bắt đầu chính thức không được sớm hơn ngày hiện tại.";
        }

        // 2. Validate weekdays: non-empty, Monday-Saturday only
        if (dayTimeSlots == null || dayTimeSlots.isEmpty()) {
            return "Vui lòng chọn ít nhất một thứ trong tuần.";
        }

        List<String> validSlots = Arrays.asList(
                "08:15-09:45", "10:00-11:30", "13:30-15:00", "15:15-16:45", "17:00-18:30", "18:45-20:15");

        Set<DayOfWeek> selectedDays = new HashSet<>();
        for (Map.Entry<String, String> entry : dayTimeSlots.entrySet()) {
            String day = entry.getKey();
            String slot = entry.getValue();
            if (day == null || slot == null || slot.trim().isEmpty()) {
                return "Khung giờ cho ngày " + day + " không được để trống.";
            }
            String upperDay = day.trim().toUpperCase();
            if (!upperDay.equals("MONDAY") && !upperDay.equals("TUESDAY") && !upperDay.equals("WEDNESDAY") &&
                    !upperDay.equals("THURSDAY") && !upperDay.equals("FRIDAY") && !upperDay.equals("SATURDAY")) {
                return "Thứ trong tuần không hợp lệ (Chỉ chấp nhận từ Thứ 2 đến Thứ 7).";
            }
            if (!validSlots.contains(slot.trim())) {
                return "Ca tập cho " + day + " không hợp lệ (Không thuộc khung giờ quy định).";
            }
            selectedDays.add(DayOfWeek.valueOf(upperDay));
        }

        // 4. Get and validate registration detail
        PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);
        if (reg == null) {
            return "Đơn đăng ký không tồn tại.";
        }

        // 5. Validate ownership
        if (reg.getPtId() != loggedInPtId) {
            return "Bạn không có quyền xếp lịch cho đơn đăng ký này (Không phải PT của đơn).";
        }

        // 6. Validate Active/Paid
        if (!"Active".equalsIgnoreCase(reg.getStatus()) || !"Paid".equalsIgnoreCase(reg.getPaymentStatus())) {
            return "Đơn đăng ký phải ở trạng thái Đang hoạt động (Active) và Đã thanh toán (Paid) mới được xếp lịch.";
        }

        // 7. Validate chưa có schedule
        int existingSchedulesCount = ptRegistrationService.countSchedulesByRegistration(regId);
        if (existingSchedulesCount > 0) {
            return "Đơn đăng ký này đã được xếp lịch trước đó.";
        }

        // 8. Generate candidate sessions
        int totalSessions = reg.getPurchasedSessions();
        if (totalSessions <= 0) {
            totalSessions = reg.getNumberOfSessions(); // fallback
        }

        LocalDate checkDate = actualStartDate;
        int sessionsSimulated = 0;
        int searchCounter = 0;
        int maxDaysToSearch = 180;
        List<String> conflictDetails = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        List<PTSchedule> generatedSchedules = new ArrayList<>();

        while (sessionsSimulated < totalSessions && searchCounter < maxDaysToSearch) {
            DayOfWeek dayOfWeek = checkDate.getDayOfWeek();
            if (selectedDays.contains(dayOfWeek)) {
                String dayKey = dayOfWeek.name();
                String timeSlot = dayTimeSlots.get(dayKey);
                String[] timeParts = timeSlot.split("-");
                Time startTime = Time.valueOf(timeParts[0] + ":00");
                Time endTime = Time.valueOf(timeParts[1] + ":00");

                boolean isPtConflict = isScheduleConflict(loggedInPtId, checkDate, startTime, endTime);
                boolean isMemberConflict = isMemberScheduleConflict(reg.getMemberId(), checkDate, startTime, endTime);

                if (isPtConflict || isMemberConflict) {
                    String daysInWeekVietnam = checkDate.getDayOfWeek().getDisplayName(
                            TextStyle.FULL,
                            new Locale("vi", "VN"));
                    String reason = isPtConflict && isMemberConflict ? "trùng lịch cả HLV & hội viên"
                            : (isPtConflict ? "HLV trùng lịch" : "hội viên trùng lịch");
                    conflictDetails.add(checkDate.format(formatter) + " (" + daysInWeekVietnam + " " + timeSlot + " - "
                            + reason + ")");
                }

                PTSchedule schedule = new PTSchedule();
                schedule.setPtId(loggedInPtId);
                schedule.setRegistrationId(regId);
                schedule.setMemberId(reg.getMemberId());
                schedule.setSessionDate(checkDate);
                schedule.setStartTime(startTime);
                schedule.setEndTime(endTime);
                generatedSchedules.add(schedule);

                sessionsSimulated++;
            }
            checkDate = checkDate.plusDays(1);
            searchCounter++;
        }

        // 9. Check conflict
        if (!conflictDetails.isEmpty()) {
            StringBuilder errorMsg = new StringBuilder("Ca tập bị trùng vào các ngày: ");
            for (int i = 0; i < conflictDetails.size(); i++) {
                errorMsg.append(conflictDetails.get(i));
                if (i < conflictDetails.size() - 1) {
                    errorMsg.append(", ");
                }
            }
            return errorMsg.toString();
        }

        if (generatedSchedules.size() < totalSessions) {
            return "Không tìm đủ ngày trống trong phạm vi 180 ngày để xếp lịch.";
        }

        // Validate generated session count must equal PurchasedSessions
        if (generatedSchedules.size() != totalSessions) {
            return "Số lượng ca tập mô phỏng (" + generatedSchedules.size() + ") không khớp với số buổi đã mua ("
                    + totalSessions + ").";
        }

        // 10. Atomic transaction: Save schedules and update actual dates in a single
        // transaction
        LocalDate actualStart = generatedSchedules.get(0).getSessionDate();
        LocalDate actualEnd = generatedSchedules.get(generatedSchedules.size() - 1).getSessionDate();

        boolean isSaved = insertSchedulesAndUpdateRegistration(generatedSchedules, createdByUserId, actualStart,
                actualEnd);
        if (!isSaved) {
            return "Lỗi hệ thống khi lưu lịch tập và cập nhật ngày bắt đầu/kết thúc gói tập.";
        }

        return "SUCCESS";
    }

    @Override
    public List<PTScheduleDetailDTO> getMemberScheduleDetailsForWeek(int memberId, LocalDate startDate,
            LocalDate endDate) {
        return ptScheduleDAO.getMemberScheduleDetailsForWeek(memberId, startDate, endDate);
    }

    /**
     * Phân công HLV dạy thay thế cho một buổi tập.
     * Luồng nghiệp vụ:
     * 1. Validate HLV thay thế phải tồn tại, đang Active, không trùng HLV gốc.
     * 2. [BR-CONS-41] Check HLV thay thế không bị trùng lịch vào giờ này.
     * 3. Update buổi học thành PT thay thế (OriginalPTID giữ HLV gốc).
     * 4. [BR-CONS-27] Gửi Notification thông báo cho cả HLV dạy thay và HLV gốc.
     * 
     * @param scheduleId ID lịch tập
     * @param substitutePtId ID HLV thay thế
     * @param reason Lý do
     * @param substituteByUserId Người phân công (Staff)
     * @param updatedBy Tên người phân công
     * @return Chuỗi thông báo kết quả ("SUCCESS" nếu thành công)
     */
    @Override
    public String assignSubstitutePT(int scheduleId, int substitutePtId, String reason, int substituteByUserId,
            String updatedBy) {
        PTSchedule schedule = ptScheduleDAO.getScheduleById(scheduleId);
        if (schedule == null) {
            return "Ca dạy không tồn tại.";
        }

        if (!"Upcoming".equalsIgnoreCase(schedule.getSessionStatus())) {
            return "Chỉ có thể thay thế PT cho ca dạy ở trạng thái Upcoming.";
        }

        if (schedule.getPtId() == substitutePtId) {
            return "PT thay thế phải khác PT hiện tại.";
        }

        PersonalTrainer pt = personalTrainerDAO.findById(substitutePtId);
        if (pt == null || !"Active".equalsIgnoreCase(pt.getStatus())) {
            return "PT thay thế không hoạt động hoặc không tồn tại.";
        }

        boolean conflict = ptScheduleDAO.isScheduleConflictExcluding(
                substitutePtId,
                schedule.getSessionDate(),
                schedule.getStartTime(),
                schedule.getEndTime(),
                scheduleId);
        if (conflict) {
            return "PT thay thế bị trùng lịch vào khung giờ này.";
        }

        boolean success = ptScheduleDAO.substitutePT(scheduleId, substitutePtId, reason, substituteByUserId, updatedBy);
        if (success) {
            try {
                PersonalTrainer originalPt = personalTrainerDAO.findById(schedule.getPtId());
                Member member = memberDAO.findById(schedule.getMemberId());
                String originalPtName = (originalPt != null) ? originalPt.getDisplayName() : "HLV cũ";
                String memberName = (member != null && member.getUserDetails() != null)
                        ? member.getUserDetails().getFullName()
                        : "Hội viên";

                // Gửi thông báo cho HLV dạy thay
                Notification notif = new Notification();
                notif.setTitle("Thông báo nhận ca dạy mới (Lịch thay thế)");
                notif.setContent("Bạn đã được phân công dạy thay cho HLV " + originalPtName
                        + " vào ngày " + schedule.getSessionDate()
                        + " khung giờ " + schedule.getStartTime().toString().substring(0, 5)
                        + " - " + schedule.getEndTime().toString().substring(0, 5)
                        + " phụ trách hội viên " + memberName
                        + ". Lý do: " + reason);
                notif.setCreatedBy(substituteByUserId);
                notif.setTargetRole("Specific");
                notif.setCreatedByRole("Staff");
                notif.setCreatedDate(LocalDateTime.now());
                notif.setPublishDate(LocalDateTime.now());
                notif.setRecipientUserId(pt.getUserId());
                notificationDAO.insert(notif);

                // Gửi thông báo cho HLV gốc (HLV nhờ dạy hộ)
                if (originalPt != null) {
                    Notification origNotif = new Notification();
                    origNotif.setTitle("Thông báo chuyển giao ca dạy");
                    origNotif.setContent("Ca dạy của bạn với hội viên " + memberName
                            + " vào ngày " + schedule.getSessionDate()
                            + " khung giờ " + schedule.getStartTime().toString().substring(0, 5)
                            + " - " + schedule.getEndTime().toString().substring(0, 5)
                            + " đã được chuyển giao cho HLV " + pt.getDisplayName()
                            + " dạy thay thế. Lý do: " + reason);
                    origNotif.setCreatedBy(substituteByUserId);
                    origNotif.setTargetRole("Specific");
                    origNotif.setCreatedByRole("Staff");
                    origNotif.setCreatedDate(LocalDateTime.now());
                    origNotif.setPublishDate(LocalDateTime.now());
                    origNotif.setRecipientUserId(originalPt.getUserId());
                    notificationDAO.insert(origNotif);
                }

            } catch (Exception e) {
                System.err.println("Không thể gửi thông báo chuyển giao ca dạy: " + e.getMessage());
                e.printStackTrace();
            }
            return "SUCCESS";
        }
        return "Lỗi hệ thống khi cập nhật PT thay thế.";
    }

    @Override
    public List<PTScheduleDetailDTO> getUpcomingSubstituteSessions(int ptId) {
        return ptScheduleDAO.getUpcomingSubstituteSessions(ptId);
    }

    /**
     * Hủy hàng loạt các lịch học của trung tâm trong một khoảng thời gian (Lễ tết, bảo trì...).
     * Luồng nghiệp vụ: Cập nhật SessionStatus = 'Cancelled'.
     * [BR-CONS-27]: System cannot allow a staff to randomly cancel member's schedule without notifying.
     * Ghi chú: Notification hàng loạt được xử lý độc lập hoặc bổ sung sau.
     * 
     * @param cancelDate Ngày hủy
     * @param startTime Thời gian bắt đầu
     * @param endTime Thời gian kết thúc
     * @param reason Lý do
     * @param cancelledByUserId Người hủy
     * @param updatedBy Tên người hủy
     * @return Số lượng buổi học đã bị hủy
     */
    @Override
    public int massCancelSessions(LocalDate cancelDate, Time startTime, Time endTime, String reason,
            int cancelledByUserId, String updatedBy) {
        return ptScheduleDAO.massCancelSessions(cancelDate, startTime, endTime, reason, cancelledByUserId, updatedBy);
    }

    @Override
    public List<Map<String, Object>> getMassCancelledSlots() {
        return ptScheduleDAO.getMassCancelledSlots();
    }
}
