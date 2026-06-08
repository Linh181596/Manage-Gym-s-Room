/**
 * =========================================================================
 * @file          : PTServicePrice.java
 * @description   : Thực thể đại diện cho cấu hình giá và thời hạn của các gói dịch vụ PT.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.math.BigDecimal;

/**
 * Entity representing the 'PTServicePrices' table in the database.
 */
public class PTServicePrice {

    private int ptServicePriceId;
    private int ptId;
    private int ptPackageTypeId;

    private String trainerName;
    private String packageName;
    private String packageDescription;
    private Integer durationMonths;
    private Integer numberOfSessions;

    private BigDecimal price;
    private String status;

    public PTServicePrice() {
    }

    /**
     * Constructor used when creating or updating a PT service price.
     */
    public PTServicePrice(int ptId, int ptPackageTypeId, BigDecimal price, String status) {
        this.ptId = ptId;
        this.ptPackageTypeId = ptPackageTypeId;
        this.price = price;
        this.status = status;
    }

    /**
     * Full constructor used when loading PT service price data from database.
     */
    public PTServicePrice(int ptServicePriceId, int ptId, int ptPackageTypeId,
            String trainerName, String packageName, String packageDescription,
            Integer durationMonths, Integer numberOfSessions,
            BigDecimal price, String status) {
        this.ptServicePriceId = ptServicePriceId;
        this.ptId = ptId;
        this.ptPackageTypeId = ptPackageTypeId;
        this.trainerName = trainerName;
        this.packageName = packageName;
        this.packageDescription = packageDescription;
        this.durationMonths = durationMonths;
        this.numberOfSessions = numberOfSessions;
        this.price = price;
        this.status = status;
    }

    public int getPtServicePriceId() {
        return ptServicePriceId;
    }

    public void setPtServicePriceId(int ptServicePriceId) {
        this.ptServicePriceId = ptServicePriceId;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getPtPackageTypeId() {
        return ptPackageTypeId;
    }

    public void setPtPackageTypeId(int ptPackageTypeId) {
        this.ptPackageTypeId = ptPackageTypeId;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getPackageDescription() {
        return packageDescription;
    }

    public void setPackageDescription(String packageDescription) {
        this.packageDescription = packageDescription;
    }

    public Integer getDurationMonths() {
        return durationMonths;
    }

    public void setDurationMonths(Integer durationMonths) {
        this.durationMonths = durationMonths;
    }

    public Integer getNumberOfSessions() {
        return numberOfSessions;
    }

    public void setNumberOfSessions(Integer numberOfSessions) {
        this.numberOfSessions = numberOfSessions;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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
}
