package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.User;
import java.time.LocalDate;

public interface RescheduleRequestService {
    String createRequest(int actorUserId, User.Role actorRole, int scheduleId, LocalDate proposedDate, String proposedSlot, String reason);
    String respondToRequest(int requestId, String action, int responderUserId, String responseReason);
}
