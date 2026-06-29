package com.mycompany.gymcentermanagement.dto;

import java.sql.Time;
import java.time.LocalDate;

public class PTScheduleDetailDTO {
    private int scheduleId; // Thêm mã lịch để điểm danh
    private LocalDate sessionDate;
    private Time startTime;
    private Time endTime;
    private String sessionStatus;
    private String memberName;
    private String packageName;
    private String ptName; // Thêm tên PT để hiển thị ở trang quản lý lịch của Admin/Staff
    private String attendanceStatus; // Thêm trường này để chứa kết quả điểm danh

    public PTScheduleDetailDTO() {
    }

    public String getPtName() {
        return ptName;
    }

    public void setPtName(String ptName) {
        this.ptName = ptName;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public String getAttendanceStatus() {
        return attendanceStatus;
    }

    public void setAttendanceStatus(String attendanceStatus) {
        this.attendanceStatus = attendanceStatus;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
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

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }
}
