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
    private String processedByUserName;
    private java.time.LocalDateTime processedAt;
    private String paymentStatus;
    private LocalDate endDate;
    private int purchasedSessions;

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getFormattedEndDate() {
        if (endDate == null) return "";
        return endDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getProcessedByUserName() {
        return processedByUserName;
    }

    public void setProcessedByUserName(String processedByUserName) {
        this.processedByUserName = processedByUserName;
    }

    public java.time.LocalDateTime getProcessedAt() {
        return processedAt;
    }

    public void setProcessedAt(java.time.LocalDateTime processedAt) {
        this.processedAt = processedAt;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

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

    public String getFormattedPreferredStartDate() {
        if (preferredStartDate == null) return "";
        return preferredStartDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getFormattedProcessedAt() {
        if (processedAt == null) return "";
        return processedAt.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
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

    public int getPurchasedSessions() {
        return purchasedSessions;
    }

    public void setPurchasedSessions(int purchasedSessions) {
        this.purchasedSessions = purchasedSessions;
    }

    private LocalDate startDate;
    private int upcomingCount;
    private int completedCount;
    private int cancelledCount;

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public String getFormattedStartDate() {
        if (startDate == null) return "";
        return startDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public int getUpcomingCount() {
        return upcomingCount;
    }

    public void setUpcomingCount(int upcomingCount) {
        this.upcomingCount = upcomingCount;
    }

    public int getCompletedCount() {
        return completedCount;
    }

    public void setCompletedCount(int completedCount) {
        this.completedCount = completedCount;
    }

    public int getCancelledCount() {
        return cancelledCount;
    }

    public void setCancelledCount(int cancelledCount) {
        this.cancelledCount = cancelledCount;
    }

    public int getProgressPercentage() {
        if (purchasedSessions <= 0) {
            return 0;
        }
        int pct = (completedCount * 100) / purchasedSessions;
        return pct > 100 ? 100 : pct;
    }
}
