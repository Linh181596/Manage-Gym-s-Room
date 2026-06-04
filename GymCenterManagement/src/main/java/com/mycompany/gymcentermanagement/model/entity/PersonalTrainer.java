/**
 * =========================================================================
 * @file          : PersonalTrainer.java
 * @description   : Thực thể đại diện cho thông tin hồ sơ của Huấn luyện viên cá nhân (PT).
 * @author        : Phạm Ngọc Duy (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Phạm Ngọc Duy
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;

/**
 * Entity representing the 'PersonalTrainers' table in the database.
 */
public class PersonalTrainer {

    private int ptId;
    private int userId;

    // Verified information managed by Staff/Admin
    private String fullName;
    private String specialization;
    private LocalDate careerStartDate;
    private String certificateFileName;
    private String certificateFilePath;

    // Public profile information
    private String displayName;
    private String description;
    private String avatarPath;

    // Trainer working status: Active / Inactive
    private String status;

    // Audit / soft delete
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;

    // Optional joined fields from Users table
    private String email;
    private String phone;
    private String accountStatus;
    private boolean mustChangePassword;

    public PersonalTrainer() {
    }

    public PersonalTrainer(int ptId, int userId, String fullName, String displayName,
            String specialization, LocalDate careerStartDate,
            String certificateFileName, String certificateFilePath,
            String description, String avatarPath, String status,
            String email, String phone, String accountStatus) {
        this.ptId = ptId;
        this.userId = userId;
        this.fullName = fullName;
        this.displayName = displayName;
        this.specialization = specialization;
        this.careerStartDate = careerStartDate;
        this.certificateFileName = certificateFileName;
        this.certificateFilePath = certificateFilePath;
        this.description = description;
        this.avatarPath = avatarPath;
        this.status = status;
        this.email = email;
        this.phone = phone;
        this.accountStatus = accountStatus;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    /**
     * Returns the public display name of the trainer. If displayName is empty,
     * fullName is used instead.
     */
    public String getPublicName() {
        if (displayName != null && !displayName.trim().isEmpty()) {
            return displayName;
        }
        return fullName;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public LocalDate getCareerStartDate() {
        return careerStartDate;
    }

    public void setCareerStartDate(LocalDate careerStartDate) {
        this.careerStartDate = careerStartDate;
    }

    /**
     * Calculates the trainer's experience years based on careerStartDate.
     */
    public int getExperienceYears() {
        if (careerStartDate == null) {
            return 0;
        }

        LocalDate currentDate = LocalDate.now();

        if (careerStartDate.isAfter(currentDate)) {
            return 0;
        }

        return Period.between(careerStartDate, currentDate).getYears();
    }

    public String getCertificateFileName() {
        return certificateFileName;
    }

    public void setCertificateFileName(String certificateFileName) {
        this.certificateFileName = certificateFileName;
    }

    public String getCertificateFilePath() {
        return certificateFilePath;
    }

    public void setCertificateFilePath(String certificateFilePath) {
        this.certificateFilePath = certificateFilePath;
    }

    public boolean hasCertificate() {
        return certificateFilePath != null && !certificateFilePath.trim().isEmpty();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isActive() {
        return "Active".equalsIgnoreCase(status);
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }

    public boolean isMustChangePassword() {
        return mustChangePassword;
    }

    public void setMustChangePassword(boolean mustChangePassword) {
        this.mustChangePassword = mustChangePassword;
    }
}
