/**
 * =========================================================================
 *
 * @file : PTRegistrationDAO.java
 * @description : Lớp truy cập dữ liệu để quản lý thông tin đăng ký dịch vụ PT.
 * @author : Nguyễn Đình Phú (phund)
 * @created : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;

import java.time.LocalDate;
import java.util.List;

/**
 * DAO class for managing Personal Trainer registrations and service prices.
 */
public interface PTRegistrationDAO {
    /**
     * Gets active PT service prices for a selected Personal Trainer.
     */
    public List<PTServicePrice> findActiveServicePricesByTrainerId(int ptId);

    public PTServicePrice findServicePriceById(int ptServicePriceId);

    public boolean insert(PTRegistration registration);

    /**
     * Finds a PT service registration by ID.
     */
    public PTRegistration findById(int ptRegistrationId);

    /**
     * Gets PT service registrations of a member.
     */
    public List<PTRegistration> findByMemberId(int memberId);

    /**
     * Gets all PT service registrations for Staff/Admin processing.
     */
    public List<PTRegistration> findAllForManagement();

    /**
     * Processes a PT service registration by Staff/Admin.
     */
    public boolean processRegistration(int ptRegistrationId, String status,
                                       String paymentStatus, int processedByUserId,
                                       String updatedBy);

    List<PTRegistrationDTO> getPendingRegistrations();
    PTRegistrationDTO getRegistrationById(int regId);
    boolean updateRegistrationAndPaymentStatus(int regId, String status, String paymentStatus);
    boolean cancelRegistration(int regId, String cancelReason, int processedByUserId, String updatedBy);

    List<PTServicePrice> getAllServicePricesByTrainerId(int ptId);
    boolean saveOrUpdateServicePrice(PTServicePrice price);

    List<PTRegistrationDTO> getProcessedRegistrations(int page, int pageSize);
    int getProcessedRegistrationsCount();
    boolean deleteRegistrationPermanent(int regId);
    List<PTRegistrationDTO> getActivePaidRegistrationsWithoutScheduleByPT(int ptId);
    int countSchedulesByRegistration(int regId);
    boolean updateActualDates(int regId, LocalDate startDate, LocalDate endDate);
}
