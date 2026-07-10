package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;

import java.sql.Time;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface PTScheduleService {
    boolean isScheduleConflict(int ptId, LocalDate sessionDate, Time startTime, Time endTime);
    boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, Time startTime, Time endTime);

    boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId);

    List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTSchedule> getMemberSchedulesForWeek(int memberId, LocalDate startDate, LocalDate endDate);

    List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date);
    boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus, String updatedBy);
    PTSchedule getScheduleById(int scheduleId);
    List<PTScheduleDetailDTO> getCompletedSessions(int ptId);
    boolean cancelSession(int scheduleId, String reason, int cancelledByUserId, String updatedBy);
    String generateFixedScheduleForPT(int regId, int loggedInPtId, LocalDate actualStartDate, Map<String, String> dayTimeSlots, int createdByUserId);
    boolean insertSchedulesAndUpdateRegistration(List<PTSchedule> schedules, int createdByUserId, LocalDate actualStartDate, LocalDate actualEndDate);
    List<PTScheduleDetailDTO> getMemberScheduleDetailsForWeek(int memberId, LocalDate startDate, LocalDate endDate);
    String assignSubstitutePT(int scheduleId, int substitutePtId, String reason, int substituteByUserId, String updatedBy);
    List<PTScheduleDetailDTO> getUpcomingSubstituteSessions(int ptId);
    int massCancelSessions(LocalDate cancelDate, Time startTime, Time endTime, String reason, int cancelledByUserId, String updatedBy);
    List<java.util.Map<String, Object>> getMassCancelledSlots();
}
