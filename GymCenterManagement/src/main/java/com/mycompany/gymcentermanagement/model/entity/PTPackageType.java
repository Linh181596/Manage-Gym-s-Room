package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDateTime;

public class PTPackageType {
    private int ptPackageTypeId;
    private String packageName;
    private String description;
    private int durationMonths;
    private int numberOfSessions;
    private String status; // 'Active', 'Inactive'
    

    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean isDeleted;

    public PTPackageType() {
    }

    public PTPackageType(int ptPackageTypeId, String packageName, String description, int durationMonths, int numberOfSessions, String status) {
        this.ptPackageTypeId = ptPackageTypeId;
        this.packageName = packageName;
        this.description = description;
        this.durationMonths = durationMonths;
        this.numberOfSessions = numberOfSessions;
        this.status = status;
    }

    public int getPtPackageTypeId() {
        return ptPackageTypeId;
    }

    public void setPtPackageTypeId(int ptPackageTypeId) {
        this.ptPackageTypeId = ptPackageTypeId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDurationMonths() {
        return durationMonths;
    }

    public void setDurationMonths(int durationMonths) {
        this.durationMonths = durationMonths;
    }

    public int getNumberOfSessions() {
        return numberOfSessions;
    }

    public void setNumberOfSessions(int numberOfSessions) {
        this.numberOfSessions = numberOfSessions;
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
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public boolean isActive() {
        return "Active".equalsIgnoreCase(status);
    }

    @Override
    public String toString() {
        return "PTPackageType{" +
                "ptPackageTypeId=" + ptPackageTypeId +
                ", packageName='" + packageName + '\'' +
                ", durationMonths=" + durationMonths +
                ", numberOfSessions=" + numberOfSessions +
                ", status='" + status + '\'' +
                '}';
    }
}
