package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTScheduleDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTScheduleDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.service.PTScheduleService;

import java.time.LocalDate;
import java.util.List;

public class PTScheduleServiceImpl implements PTScheduleService {
    private PTScheduleDAO ptScheduleDAO = new PTScheduleDAOImpl();
    @Override
    public boolean isScheduleConflict(int ptId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) {
        return ptScheduleDAO.isScheduleConflict(ptId, sessionDate, startTime, endTime);
    }

    @Override
    public boolean insertSchedules(List<PTSchedule> schedules, int createdByUserId) {
        return ptScheduleDAO.insertSchedules(schedules,  createdByUserId);
    }

    @Override
    public List<PTSchedule> getSchedulesForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        return ptScheduleDAO.getSchedulesForWeek(ptId, startDate, endDate);
    }

    @Override
    public List<PTScheduleDetailDTO> getPTScheduleDetailsForWeek(int ptId, LocalDate startDate, LocalDate endDate) {
        return  ptScheduleDAO.getPTScheduleDetailsForWeek(ptId, startDate, endDate);
    }

    @Override
    public List<PTScheduleDetailDTO> getAllSchedulesByDate(LocalDate date) {
        return ptScheduleDAO.getAllSchedulesByDate(date);
    }

    @Override
    public boolean isMemberScheduleConflict(int memberId, LocalDate sessionDate, java.sql.Time startTime, java.sql.Time endTime) {
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
    public boolean cancelSession(int scheduleId, String reason, String updatedBy) {
        return ptScheduleDAO.cancelSession(scheduleId, reason, updatedBy);
    }
}
