package com.mycompany.gymcentermanagement.dto;

import java.time.LocalDate;

public class PTRegistrationDTO {
    private int ptRegistrationId;
    private int memberId;
    private String memberName;
    private String memberPhone;
    private int ptId;
    private String ptDisplayName;
    private String packageName;
    private int numberOfSessions;
    private LocalDate preferredStartDate;
    private double totalAmount;
    private String note; // Hoặc description (Ghi chú/Mong muốn của khách)
    private String ptStatus; // Trạng thái của PT (Active/Inactive)
    private String status; // Trạng thái đơn (Pending, Active, Completed, Cancelled)

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone;
    }

    public int getNumberOfSessions() {
        return numberOfSessions;
    }

    public void setNumberOfSessions(int numberOfSessions) {
        this.numberOfSessions = numberOfSessions;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public LocalDate getPreferredStartDate() {
        return preferredStartDate;
    }

    public void setPreferredStartDate(LocalDate preferredStartDate) {
        this.preferredStartDate = preferredStartDate;
    }

    public String getPtDisplayName() {
        return ptDisplayName;
    }

    public void setPtDisplayName(String ptDisplayName) {
        this.ptDisplayName = ptDisplayName;
    }

    public int getPtRegistrationId() {
        return ptRegistrationId;
    }

    public void setPtRegistrationId(int ptRegistrationId) {
        this.ptRegistrationId = ptRegistrationId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPtStatus() {
        return ptStatus;
    }

    public void setPtStatus(String ptStatus) {
        this.ptStatus = ptStatus;
    }
}
