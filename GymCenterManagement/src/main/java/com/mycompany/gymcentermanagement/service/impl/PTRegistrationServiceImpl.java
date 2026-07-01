package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTRegistrationDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTRegistrationDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import java.util.List;

/**
 * Service implementation for managing Personal Trainer registrations.
 */
public class PTRegistrationServiceImpl implements PTRegistrationService {

    private final PTRegistrationDAO registrationDAO = new PTRegistrationDAOImpl();

    @Override
    public List<PTServicePrice> getActiveServicePricesByTrainerId(int ptId) {
        return registrationDAO.findActiveServicePricesByTrainerId(ptId);
    }

    @Override
    public PTServicePrice getServicePriceById(int ptServicePriceId) {
        return registrationDAO.findServicePriceById(ptServicePriceId);
    }

    @Override
    public boolean registerPTService(PTRegistration registration) {
        return registrationDAO.insert(registration);
    }

    @Override
    public List<PTRegistration> getRegistrationsByMemberId(int memberId) {
        return registrationDAO.findByMemberId(memberId);
    }

    @Override
    public List<PTRegistration> getAllRegistrationsForManagement() {
        return registrationDAO.findAllForManagement();
    }

    @Override
    public boolean processRegistration(int ptRegistrationId, String status,
                                       String paymentStatus, int processedByUserId,
                                       String updatedBy) {
        return registrationDAO.processRegistration(ptRegistrationId, status, paymentStatus, processedByUserId, updatedBy);
    }

    @Override
    public List<PTRegistrationDTO> getPendingRegistrations() {
        return registrationDAO.getPendingRegistrations();
    }

    @Override
    public PTRegistrationDTO getRegistrationById(int regId) {
        return registrationDAO.getRegistrationById(regId);
    }

    @Override
    public boolean updateRegistrationAndPaymentStatus(int regId, String status, String paymentStatus) {
        return registrationDAO.updateRegistrationAndPaymentStatus(regId, status, paymentStatus);
    }

    @Override
    public boolean cancelRegistration(int regId, String cancelReason, int processedByUserId, String updatedBy) {
        return registrationDAO.cancelRegistration(regId, cancelReason, processedByUserId, updatedBy);
    }

    @Override
    public List<PTServicePrice> getAllServicePricesByTrainerId(int ptId) {
        return registrationDAO.getAllServicePricesByTrainerId(ptId);
    }

    @Override
    public boolean saveOrUpdateServicePrice(PTServicePrice price) {
        return registrationDAO.saveOrUpdateServicePrice(price);
    }

    @Override
    public List<PTRegistrationDTO> getProcessedRegistrations(int page, int pageSize) {
        return registrationDAO.getProcessedRegistrations(page, pageSize);
    }

    @Override
    public int getProcessedRegistrationsCount() {
        return registrationDAO.getProcessedRegistrationsCount();
    }

    @Override
    public boolean deleteRegistrationPermanent(int regId) {
        return registrationDAO.deleteRegistrationPermanent(regId);
    }
}
