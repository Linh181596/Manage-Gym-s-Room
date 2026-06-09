/**
 * =========================================================================
 * @file          : Equipment.java
 * @description   : Thực thể đại diện cho thông tin thiết bị/dụng cụ phòng gym trong cơ sở dữ liệu.
 * @author        : Đào Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đào Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Equipment {
    private static final DateTimeFormatter DATE_DISPLAY_FORMAT = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private int equipmentId;
    private String equipmentCode;
    private String equipmentName;
    private String equipmentType;
    private LocalDate purchaseDate;
    private LocalDate warrantyDate;
    private String location;
    private String imageUrl;
    private String status;
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;
    private int issueCount;
    private int latestIssueId;

    public int getLatestIssueId() {
        return latestIssueId;
    }

    public void setLatestIssueId(int latestIssueId) {
        this.latestIssueId = latestIssueId;
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
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

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    // Convert stored equipment type codes to the Vietnamese labels used by the UI.
    public String getEquipmentTypeDisplay() {
        if (equipmentType == null || equipmentType.isBlank()) {
            return "";
        }
        return switch (equipmentType) {
            case "Cardio" -> "Cardio";
            case "Ta" -> "Tạ";
            case "May keo" -> "Máy kéo";
            case "Phu kien" -> "Phụ kiện";
            case "Khac" -> "Khác";
            default -> equipmentType;
        };
    }

    public LocalDate getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(LocalDate purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    // Keep date display consistent across list and detail pages.
    public String getPurchaseDateDisplay() {
        return purchaseDate == null ? "" : purchaseDate.format(DATE_DISPLAY_FORMAT);
    }

    public LocalDate getWarrantyDate() {
        return warrantyDate;
    }

    public void setWarrantyDate(LocalDate warrantyDate) {
        this.warrantyDate = warrantyDate;
    }

    // Keep date display consistent across list and detail pages.
    public String getWarrantyDateDisplay() {
        return warrantyDate == null ? "" : warrantyDate.format(DATE_DISPLAY_FORMAT);
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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

    public int getIssueCount() {
        return issueCount;
    }

    public void setIssueCount(int issueCount) {
        this.issueCount = issueCount;
    }
}
