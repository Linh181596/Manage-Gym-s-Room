package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.RescheduleRequest;

public interface RescheduleRequestDAO {
    boolean create(RescheduleRequest request);
    boolean hasPendingRequestForSchedule(int scheduleId);
    RescheduleRequest getById(int requestId);
    boolean updateStatus(int requestId, String status);
    boolean approveAndUpdateSchedule(int requestId, int scheduleId, java.time.LocalDate newDate, java.sql.Time newStart, java.sql.Time newEnd, int responderUserId);
    boolean rejectRequest(int requestId, int responderUserId, String responseReason);
    boolean escalateRequest(int requestId, int escalatorUserId, String escalationReason);
}
