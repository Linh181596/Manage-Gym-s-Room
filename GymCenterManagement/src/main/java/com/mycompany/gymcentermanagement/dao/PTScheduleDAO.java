package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import java.time.LocalDate;
import java.util.List;

public interface PTScheduleDAO {
    boolean isScheduleConflict(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime);
    boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime);
    boolean isScheduleConflictExcluding(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime, int excludedScheduleId);
    boolean isMemberScheduleConflictExcluding(int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime, int excludedScheduleId);
    boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId);
    List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTSchedule> getMemberSchedulesForWeek(int memberId, LocalDate startDate, LocalDate endDate);
    List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date);
    boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus);
    PTSchedule getScheduleById(int scheduleId);
    List<PTScheduleDetailDTO> getCompletedSessions(int ptId);
    boolean cancelSession(int scheduleId, String reason, int cancelledByUserId, String updatedBy);
    boolean insertSchedulesAndUpdateRegistration(List<PTSchedule> schedules, int createdByUserId, LocalDate actualStartDate, LocalDate actualEndDate);
    List<PTScheduleDetailDTO> getMemberScheduleDetailsForWeek(int memberId, LocalDate startDate, LocalDate endDate);
}
