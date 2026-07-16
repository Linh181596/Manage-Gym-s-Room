package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MaintenanceSchedule {
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DateTimeFormatter DATE_TIME_FORMAT = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private int maintenanceScheduleId;
    private int equipmentId;
    private Integer issueId;
    private LocalDate scheduledDate;
    private String maintenanceType;
    private String description;
    private String status;
    private LocalDateTime completionDate;
    private String completionNote;
    private String completionImageUrl;
    private LocalDateTime submittedForApprovalAt;
    private String submittedBy;
    private boolean requestedIssueResolution;
    private String approvedBy;
    private LocalDateTime approvedAt;
    private String approvalNote;
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;

    private String equipmentCode;
    private String equipmentName;
    private String equipmentLocation;
    private String issueDescription;
    private String issueStatus;

    public int getMaintenanceScheduleId() {
        return maintenanceScheduleId;
    }

    public void setMaintenanceScheduleId(int maintenanceScheduleId) {
        this.maintenanceScheduleId = maintenanceScheduleId;
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
    }

    public Integer getIssueId() {
        return issueId;
    }

    public void setIssueId(Integer issueId) {
        this.issueId = issueId;
    }

    public LocalDate getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(LocalDate scheduledDate) {
        this.scheduledDate = scheduledDate;
    }

    public String getMaintenanceType() {
        return maintenanceType;
    }

    public void setMaintenanceType(String maintenanceType) {
        this.maintenanceType = maintenanceType;
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

    public LocalDateTime getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(LocalDateTime completionDate) {
        this.completionDate = completionDate;
    }

    public String getCompletionNote() {
        return completionNote;
    }

    public void setCompletionNote(String completionNote) {
        this.completionNote = completionNote;
    }

    public String getCompletionImageUrl() {
        return completionImageUrl;
    }

    public void setCompletionImageUrl(String completionImageUrl) {
        this.completionImageUrl = completionImageUrl;
    }

    public LocalDateTime getSubmittedForApprovalAt() {
        return submittedForApprovalAt;
    }

    public void setSubmittedForApprovalAt(LocalDateTime submittedForApprovalAt) {
        this.submittedForApprovalAt = submittedForApprovalAt;
    }

    public String getSubmittedBy() {
        return submittedBy;
    }

    public void setSubmittedBy(String submittedBy) {
        this.submittedBy = submittedBy;
    }

    public boolean isRequestedIssueResolution() {
        return requestedIssueResolution;
    }

    public void setRequestedIssueResolution(boolean requestedIssueResolution) {
        this.requestedIssueResolution = requestedIssueResolution;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public LocalDateTime getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(LocalDateTime approvedAt) {
        this.approvedAt = approvedAt;
    }

    public String getApprovalNote() {
        return approvalNote;
    }

    public void setApprovalNote(String approvalNote) {
        this.approvalNote = approvalNote;
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

    public String getEquipmentCode() {
        return equipmentCode;
    }

    public void setEquipmentCode(String equipmentCode) {
        this.equipmentCode = equipmentCode;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentLocation() {
        return equipmentLocation;
    }

    public void setEquipmentLocation(String equipmentLocation) {
        this.equipmentLocation = equipmentLocation;
    }

    public String getIssueDescription() {
        return issueDescription;
    }

    public void setIssueDescription(String issueDescription) {
        this.issueDescription = issueDescription;
    }

    public String getIssueStatus() {
        return issueStatus;
    }

    public void setIssueStatus(String issueStatus) {
        this.issueStatus = issueStatus;
    }

    public String getScheduledDateDisplay() {
        return scheduledDate == null ? "" : scheduledDate.format(DATE_FORMAT);
    }

    public String getCompletionDateDisplay() {
        return completionDate == null ? "" : completionDate.format(DATE_TIME_FORMAT);
    }

    public String getSubmittedForApprovalAtDisplay() {
        return submittedForApprovalAt == null ? "" : submittedForApprovalAt.format(DATE_TIME_FORMAT);
    }

    public String getApprovedAtDisplay() {
        return approvedAt == null ? "" : approvedAt.format(DATE_TIME_FORMAT);
    }

    public String getCreatedDateDisplay() {
        return createdDate == null ? "" : createdDate.format(DATE_TIME_FORMAT);
    }

    public String getUpdatedDateDisplay() {
        return updatedDate == null ? "" : updatedDate.format(DATE_TIME_FORMAT);
    }

    public String getMaintenanceTypeDisplay() {
        return switch (maintenanceType == null ? "" : maintenanceType) {
            case "Preventive" -> "Bảo trì phòng ngừa";
            case "Corrective" -> "Bảo trì sửa chữa";
            default -> maintenanceType;
        };
    }

    public String getStatusDisplay() {
        return switch (status == null ? "" : status) {
            case "Scheduled" -> "Đã lên lịch";
            case "InProgress" -> "Đang bảo trì";
            case "PendingApproval" -> "Chờ duyệt";
            case "Completed" -> "Đã hoàn thành";
            case "Cancelled" -> "Đã hủy";
            default -> status;
        };
    }
}
