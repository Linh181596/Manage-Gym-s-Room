package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.RescheduleRequestDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.RescheduleRequest;
import java.sql.Time;
import java.time.LocalDate;
import java.util.List;

public interface RescheduleRequestDAO {
    boolean create(RescheduleRequest request);
    boolean hasPendingRequestForSchedule(int scheduleId);
    RescheduleRequest getById(int requestId);
    boolean updateStatus(int requestId, String status);
    boolean approveAndUpdateSchedule(int requestId, int scheduleId, LocalDate newDate, Time newStart, Time newEnd, int responderUserId);
    boolean rejectRequest(int requestId, int responderUserId, String responseReason);
    boolean escalateRequest(int requestId, int escalatorUserId, String escalationReason);
    List<RescheduleRequestDetailDTO> getEscalatedRequests();
}
