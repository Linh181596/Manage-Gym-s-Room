package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;

public class PTSchedule {
    private int scheduleId;
    private int ptId;
    private int registrationId; // ID của đơn đăng ký gốc
    private LocalDate sessionDate; // Ngày tập
    private java.sql.Time startTime;
    private java.sql.Time endTime;
    private String sessionStatus;  // Trạng thái (VD: "Active", "Completed", "Cancelled")
    private int memberId;

    // --- Constructor rỗng ---
    public PTSchedule() {
    }

    // --- Getter và Setter ---
    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public LocalDate getSessionDate() {
        return sessionDate;
    }

    public void setSessionDate(LocalDate sessionDate) {
        this.sessionDate = sessionDate;
    }

    public String getSessionStatus() {
        return sessionStatus;
    }

    public void setSessionStatus(String sessionStatus) {
        this.sessionStatus = sessionStatus;
    }

    public java.sql.Time getStartTime() {
        return startTime;
    }

    public void setStartTime(java.sql.Time startTime) {
        this.startTime = startTime;
    }

    public java.sql.Time getEndTime() {
        return endTime;
    }

    public void setEndTime(java.sql.Time endTime) {
        this.endTime = endTime;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
}
