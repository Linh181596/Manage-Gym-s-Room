package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.MemberPackageDAO;
import com.mycompany.gymcentermanagement.dao.PTRegistrationDAO;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberPackageDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.PTRegistrationDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
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
        PTServicePrice servicePrice = registrationDAO.findServicePriceById(registration.getPtServicePriceId());
        if (servicePrice == null) {
            return false;
        }

        // Validate status is active
        if (!"Active".equalsIgnoreCase(servicePrice.getStatus())) {
            return false;
        }

        // Validate PT is active
        PersonalTrainerDAO ptDAO = new PersonalTrainerDAOImpl();
        PersonalTrainer pt = ptDAO.findById(servicePrice.getPtId());
        if (pt == null || !"Active".equalsIgnoreCase(pt.getStatus())) {
            return false;
        }

        // Validate price and sessions
        if (servicePrice.getPrice() == null || servicePrice.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        if (servicePrice.getNumberOfSessions() <= 0) {
            return false;
        }

        // Validate member has active gym membership package
        try {
            MemberPackageDAO memberPackageDAO = new MemberPackageDAOImpl();
            MemberPackage activePackage = memberPackageDAO.findActiveByMemberId(registration.getMemberId());
            if (activePackage == null) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        registration.setTotalAmount(servicePrice.getPrice());
        registration.setPurchasedSessions(servicePrice.getNumberOfSessions());
        registration.setStatus("Pending");
        registration.setPaymentStatus("Unpaid");
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
        boolean success = registrationDAO.processRegistration(ptRegistrationId, status, paymentStatus, processedByUserId, updatedBy);
        if (!success) {
            throw new IllegalStateException("Đơn đăng ký PT không còn ở trạng thái chờ duyệt hoặc chưa thanh toán.");
        }
        return true;
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

    @Override
    public List<PTRegistrationDTO> getActivePaidRegistrationsWithoutScheduleByPT(int ptId) {
        return registrationDAO.getActivePaidRegistrationsWithoutScheduleByPT(ptId);
    }

    @Override
    public int countSchedulesByRegistration(int regId) {
        return registrationDAO.countSchedulesByRegistration(regId);
    }

    @Override
    public boolean updateActualDates(int regId, LocalDate startDate, LocalDate endDate) {
        return registrationDAO.updateActualDates(regId, startDate, endDate);
    }

    @Override
    public List<PTRegistrationDTO> getPTRegistrationsWithProgress(int ptId) {
        return registrationDAO.getPTRegistrationsWithProgress(ptId);
    }
}
