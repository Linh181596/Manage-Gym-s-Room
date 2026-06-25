package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;

import java.util.List;

/**
 * Service interface for managing Personal Trainer registrations.
 */
public interface PTRegistrationService {
    List<PTServicePrice> getActiveServicePricesByTrainerId(int ptId);

    PTServicePrice getServicePriceById(int ptServicePriceId);

    boolean registerPTService(PTRegistration registration);

    List<PTRegistration> getRegistrationsByMemberId(int memberId);

    List<PTRegistration> getAllRegistrationsForManagement();

    boolean processRegistration(int ptRegistrationId, String status,
                                String paymentStatus, int processedByUserId,
                                String updatedBy);

    List<PTRegistrationDTO> getPendingRegistrations();
    PTRegistrationDTO getRegistrationById(int regId);
    boolean updateRegistrationAndPaymentStatus(int regId, String status, String paymentStatus);
    boolean cancelRegistration(int regId, String cancelReason, int processedByUserId, String updatedBy);
}
