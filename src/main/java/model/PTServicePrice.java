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

    private String packageName;
    private String packageDescription;
    private Integer durationMonths;
    private Integer numberOfSessions;

    private BigDecimal price;
    private String status;

    public PTServicePrice() {
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
}
