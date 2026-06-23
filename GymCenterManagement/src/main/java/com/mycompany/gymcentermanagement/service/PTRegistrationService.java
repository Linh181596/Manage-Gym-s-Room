package com.mycompany.gymcentermanagement.service;

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

    PTRegistration getRegistrationById(int ptRegistrationId);

    List<PTRegistration> getRegistrationsByMemberId(int memberId);

    List<PTRegistration> getAllRegistrationsForManagement();

    boolean processRegistration(int ptRegistrationId, String status,
                                String paymentStatus, int processedByUserId,
                                String updatedBy);
}
