package com.mycompany.gymcentermanagement.dto;

import java.time.LocalDate;

public class PTMemberDTO {
    private int ptRegistrationId;
    private String memberName;
    private String memberPhone;
    private String packageName;
    private LocalDate startDate;
    private LocalDate endDate;
    private int totalSessions;
    private int completedSessions;
    private String daysOfWeek;
    private String timeSlot;

    public PTMemberDTO() {
    }

    public int getPtRegistrationId() {
        return ptRegistrationId;
    }

    public void setPtRegistrationId(int ptRegistrationId) {
        this.ptRegistrationId = ptRegistrationId;
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

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public String getFormattedStartDate() {
        return startDate != null ? startDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public String getFormattedEndDate() {
        return endDate != null ? endDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public int getTotalSessions() {
        return totalSessions;
    }

    public void setTotalSessions(int totalSessions) {
        this.totalSessions = totalSessions;
    }

    public int getCompletedSessions() {
        return completedSessions;
    }

    public void setCompletedSessions(int completedSessions) {
        this.completedSessions = completedSessions;
    }

    public String getDaysOfWeek() {
        return daysOfWeek;
    }

    public void setDaysOfWeek(String daysOfWeek) {
        this.daysOfWeek = daysOfWeek;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }
}
