package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;

import java.time.LocalDate;
import java.util.List;

public interface PTScheduleDAO {
    boolean isScheduleConflict(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime);
    boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId);
    List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate);
    List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date);
    boolean updateAttendance(int scheduleId, String attendanceStatus, String sessionStatus);
}
