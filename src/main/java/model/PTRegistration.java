/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author phuga
 */
public class PTRegistration {

    private int ptRegistrationId;
    private int memberId;
    private int ptServicePriceId;

    private LocalDate preferredStartDate;
    private LocalDate startDate;
    private LocalDate endDate;

    private String status;
    private String note;

    public PTRegistration() {
    }

    public int getPtRegistrationId() {
        return ptRegistrationId;
    }

    public void setPtRegistrationId(int ptRegistrationId) {
        this.ptRegistrationId = ptRegistrationId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getPtServicePriceId() {
        return ptServicePriceId;
    }

    public void setPtServicePriceId(int ptServicePriceId) {
        this.ptServicePriceId = ptServicePriceId;
    }

    public LocalDate getPreferredStartDate() {
        return preferredStartDate;
    }

    public void setPreferredStartDate(LocalDate preferredStartDate) {
        this.preferredStartDate = preferredStartDate;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
