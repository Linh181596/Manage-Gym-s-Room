/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author phuga
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
     *
     * @param ptId ID of the Personal Trainer
     * @param ptPackageTypeId ID of the PT package type
     * @param price configured service price
     * @param status current price status, such as Active or Inactive
     */
    public PTServicePrice(int ptId, int ptPackageTypeId, BigDecimal price, String status) {
        this.ptId = ptId;
        this.ptPackageTypeId = ptPackageTypeId;
        this.price = price;
        this.status = status;
    }

    /**
     * Full constructor used when loading PT service price data from database.
     *
     * @param ptServicePriceId unique ID of the PT service price record
     * @param ptId ID of the Personal Trainer
     * @param ptPackageTypeId ID of the PT package type
     * @param trainerName display name of the Personal Trainer
     * @param packageName name of the PT package type
     * @param packageDescription description of the PT package type
     * @param durationMonths package duration in months
     * @param numberOfSessions number of sessions included in the package
     * @param price configured service price
     * @param status current price status
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
