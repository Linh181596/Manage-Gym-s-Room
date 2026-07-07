/**
 * =========================================================================
 * @file          : PTRegistration.java
 * @description   : Thực thể đại diện cho thông tin đăng ký dịch vụ PT của hội viên.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Entity representing the 'PTRegistrations' table in the database.
 */
public class PTRegistration {

    private int ptRegistrationId;
    private int memberId;
    private int ptId;
    private int ptServicePriceId;

    private LocalDate preferredStartDate;
    private LocalDate startDate;
    private LocalDate endDate;

    private BigDecimal totalAmount;

    private String status; // Pending, Active, Completed, Cancelled
    private String paymentStatus; // Unpaid, Paid, Cancelled

    private String note;

    private Integer processedByUserId;
    private LocalDateTime processedAt;

    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;
    private int purchasedSessions;

    // Optional joined/display fields
    private String memberName;
    private String trainerName;
    private String packageTypeName;

    public PTRegistration() {
    }

    /**
     * Constructor used when creating a new PT service registration request.
     */
    public PTRegistration(int memberId, int ptId, int ptServicePriceId,
            LocalDate preferredStartDate, LocalDate startDate,
            LocalDate endDate, BigDecimal totalAmount, String note) {
        this.memberId = memberId;
        this.ptId = ptId;
        this.ptServicePriceId = ptServicePriceId;
        this.preferredStartDate = preferredStartDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalAmount = totalAmount;
        this.status = "Pending";
        this.paymentStatus = "Unpaid";
        this.note = note;
        this.deleted = false;
    }

    public PTRegistration(int ptRegistrationId, int memberId, int ptId, int ptServicePriceId, LocalDate preferredStartDate, LocalDate startDate, LocalDate endDate, BigDecimal totalAmount, String status, String paymentStatus, String note, Integer processedByUserId, LocalDateTime processedAt, String createdBy, LocalDateTime createdDate, String updatedBy, LocalDateTime updatedDate, boolean deleted) {
        this.ptRegistrationId = ptRegistrationId;
        this.memberId = memberId;
        this.ptId = ptId;
        this.ptServicePriceId = ptServicePriceId;
        this.preferredStartDate = preferredStartDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.note = note;
        this.processedByUserId = processedByUserId;
        this.processedAt = processedAt;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
        this.updatedBy = updatedBy;
        this.updatedDate = updatedDate;
        this.deleted = deleted;
    }

    public int getPtRegistrationId() {
        return ptRegistrationId;
    }

    public void setPtRegistrationId(int ptRegistrationId) {
        this.ptRegistrationId = ptRegistrationId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getPtServicePriceId() {
        return ptServicePriceId;
    }

    public void setPtServicePriceId(int ptServicePriceId) {
        this.ptServicePriceId = ptServicePriceId;
    }

    public LocalDate getPreferredStartDate() {
        return preferredStartDate;
    }

    public void setPreferredStartDate(LocalDate preferredStartDate) {
        this.preferredStartDate = preferredStartDate;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Integer getProcessedByUserId() {
        return processedByUserId;
    }

    public void setProcessedByUserId(Integer processedByUserId) {
        this.processedByUserId = processedByUserId;
    }

    public LocalDateTime getProcessedAt() {
        return processedAt;
    }

    public void setProcessedAt(LocalDateTime processedAt) {
        this.processedAt = processedAt;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    public String getPackageTypeName() {
        return packageTypeName;
    }

    public void setPackageTypeName(String packageTypeName) {
        this.packageTypeName = packageTypeName;
    }

    public int getPurchasedSessions() {
        return purchasedSessions;
    }

    public void setPurchasedSessions(int purchasedSessions) {
        this.purchasedSessions = purchasedSessions;
    }

    public boolean isPending() {
        return "Pending".equalsIgnoreCase(status);
    }

    public boolean isPaid() {
        return "Paid".equalsIgnoreCase(paymentStatus);
    }
}
