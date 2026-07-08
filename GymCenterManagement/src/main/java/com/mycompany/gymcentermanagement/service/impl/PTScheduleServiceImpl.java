package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTScheduleDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.PTScheduleService;

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

    @Override
    public boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, Time startTime, Time endTime) {
        return ptScheduleDAO.isMemberScheduleConflict(memberId, sessionDate, startTime, endTime);
    }

    @Override
    public List<PTSchedule> getMemberSchedulesForWeek(int memberId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getMemberSchedulesForWeek(memberId, startDate, endDate);
    }

    @Override
    public boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus) {
        return ptScheduleDAO.updateAttendance(scheduleId, attendanceStatus, sessionStatus);
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

    @Override
    public boolean insertSchedulesAndUpdateRegistration(List<PTSchedule> schedules, int createdByUserId, LocalDate actualStartDate, LocalDate actualEndDate) {
        return ptScheduleDAO.insertSchedulesAndUpdateRegistration(schedules, createdByUserId, actualStartDate, actualEndDate);
    }

    @Override
    public String generateFixedScheduleForPT(int regId, int loggedInPtId, LocalDate actualStartDate, Map<String, String> dayTimeSlots, int createdByUserId) {
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
            "08:15-09:45", "10:00-11:30", "13:30-15:00", "15:15-16:45", "17:00-18:30", "18:45-20:15"
        );
        
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
                            new Locale("vi", "VN")
                    );
                    String reason = isPtConflict && isMemberConflict ? "trùng lịch cả HLV & hội viên" :
                                   (isPtConflict ? "HLV trùng lịch" : "hội viên trùng lịch");
                    conflictDetails.add(checkDate.format(formatter) + " (" + daysInWeekVietnam + " " + timeSlot + " - " + reason + ")");
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
            return "Số lượng ca tập mô phỏng (" + generatedSchedules.size() + ") không khớp với số buổi đã mua (" + totalSessions + ").";
        }
        
        // 10. Atomic transaction: Save schedules and update actual dates in a single transaction
        LocalDate actualStart = generatedSchedules.get(0).getSessionDate();
        LocalDate actualEnd = generatedSchedules.get(generatedSchedules.size() - 1).getSessionDate();
        
        boolean isSaved = insertSchedulesAndUpdateRegistration(generatedSchedules, createdByUserId, actualStart, actualEnd);
        if (!isSaved) {
            return "Lỗi hệ thống khi lưu lịch tập và cập nhật ngày bắt đầu/kết thúc gói tập.";
        }
        
        return "SUCCESS";
    }

    @Override
    public List<PTScheduleDetailDTO> getMemberScheduleDetailsForWeek(int memberId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getMemberScheduleDetailsForWeek(memberId, startDate, endDate);
    }
}
