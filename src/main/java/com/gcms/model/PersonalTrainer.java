/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author daiduong
 */
public class PersonalTrainer {
    private int ptId;                    // Khớp khóa chính [PTID] int IDENTITY
    private int userId;                  // Khớp khóa ngoại [UserID] int liên kết bảng Users
    private String specialization;       // [Specialization] nvarchar(255)
    private String description;          // [Description] nvarchar(max)
    private String status;               // [Status] varchar(20)
    private String createdBy;            // [CreatedBy] nvarchar(50)
    private Timestamp createdDate;       // [CreatedDate] datetime2(7)
    private String updatedBy;            // [UpdatedBy] nvarchar(50)
    private Timestamp updatedDate;       // [UpdatedDate] datetime2(7)
    private boolean isDeleted;           // [IsDeleted] bit
    private Date careerStartDate;        // [CareerStartDate] date (Dùng tính năm kinh nghiệm)
    private String certificateFileName;  // [CertificateFileName] nvarchar(255)
    private String certificateFilePath;  // [CertificateFilePath] nvarchar(255)
    private String fullName;             // [FullName] nvarchar(100)
    private String displayName;          // [DisplayName] nvarchar(100)
    private String avatarPath;           // [AvatarPath] nvarchar(255)
    
    public PersonalTrainer(){
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

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Date getCareerStartDate() {
        return careerStartDate;
    }

    public void setCareerStartDate(Date careerStartDate) {
        this.careerStartDate = careerStartDate;
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

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
    
    
    
    
    
    
}
