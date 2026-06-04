package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EquipmentIssue {
    private int issueId;
    private int equipmentId;
    private int reportedBy;
    private String issueType;
    private String description;
    private LocalDateTime reportedAt;
    private String status;
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;
    private String equipmentCode;
    private String equipmentName;
    private String reporterName;
    private String issueImageUrl;

    public int getIssueId() {
        return issueId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
    }

    public int getReportedBy() {
        return reportedBy;
    }

    public void setReportedBy(int reportedBy) {
        this.reportedBy = reportedBy;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getReportedAt() {
        return reportedAt;
    }

    public void setReportedAt(LocalDateTime reportedAt) {
        this.reportedAt = reportedAt;
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

    public String getReporterName() {
        return reporterName;
    }

    public void setReporterName(String reporterName) {
        this.reporterName = reporterName;
    }

    public String getIssueImageUrl() {
        return issueImageUrl;
    }

    public void setIssueImageUrl(String issueImageUrl) {
        this.issueImageUrl = issueImageUrl;
    }

    public String getReportedAtDisplay() {
        if (reportedAt == null) {
            return "";
        }
        return reportedAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    // Normalize old/new issue type codes so every screen shows one Vietnamese label.
    public String getIssueTypeDisplay() {
        if (issueType == null || issueType.isBlank()) {
            return "";
        }
        return switch (issueType) {
            case "Hu hong", "Broken", "Damaged", "Damage" -> "Hư hỏng";
            case "Bao tri", "Maintenance", "Maintain" -> "Bảo trì";
            case "An toan", "Safety" -> "An toàn";
            case "Khac", "Other" -> "Khác";
            default -> issueType;
        };
    }

    // Database stores processing statuses as stable codes; UI shows Vietnamese labels.
    public String getStatusDisplay() {
        if (status == null || status.isBlank()) {
            return "";
        }
        return switch (status) {
            case "Pending" -> "Chờ xử lý";
            case "InProgress" -> "Đang xử lý";
            case "Resolved" -> "Đã khắc phục";
            default -> status;
        };
    }
}
