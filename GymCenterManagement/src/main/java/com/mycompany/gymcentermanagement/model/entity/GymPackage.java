/**
 * =========================================================================
 * @file          : GymPackage.java
 * @description   : Entity đại diện cho bảng GymPackages lưu trữ thông tin gói tập
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Entity representing the 'GymPackages' table in the database.
 */
public class GymPackage {
    private int packageId;
    private String packageName;
    private int durationMonths;
    private BigDecimal price;
    private String description;
    private String status; // 'Active', 'Inactive'
    
    // Audit Metadata
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean isDeleted;

    public GymPackage() {
    }

    public GymPackage(int packageId, String packageName, int durationMonths, BigDecimal price, String description, String status) {
        this.packageId = packageId;
        this.packageName = packageName;
        this.durationMonths = durationMonths;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public int getDurationMonths() {
        return durationMonths;
    }

    public void setDurationMonths(int durationMonths) {
        this.durationMonths = durationMonths;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    @Override
    public String toString() {
        return "GymPackage{" +
                "packageId=" + packageId +
                ", packageName='" + packageName + '\'' +
                ", durationMonths=" + durationMonths +
                ", price=" + price +
                ", status='" + status + '\'' +
                '}';
    }
}
