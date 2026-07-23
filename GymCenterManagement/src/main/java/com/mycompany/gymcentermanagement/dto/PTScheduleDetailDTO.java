package com.mycompany.gymcentermanagement.dto;

import java.sql.Time;
import java.time.LocalDate;

/**
 * DTO chứa thông tin chi tiết của một lịch tập PT (1 ca tập cụ thể).
 * Bao gồm thời gian, trạng thái điểm danh, thông tin hội viên, PT phụ trách và các yêu cầu dời lịch (reschedule).
 */
public class PTScheduleDetailDTO {
    private int scheduleId; // Thêm mã lịch để điểm danh
    private LocalDate sessionDate;
    private Time startTime;
    private Time endTime;
    private String sessionStatus;
    private String memberName;
    private String packageName;
    private String ptName; // Thêm tên PT để hiển thị ở trang quản lý lịch của Admin/Staff
    private String ptSpecialization; // Chuyên môn của PT
    private String originalPtName; // Tên HLV cũ trước khi bị thay thế
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

    public boolean isFuture() {
        if (sessionDate == null || startTime == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        java.time.LocalTime nowTime = java.time.LocalTime.now();
        return sessionDate.isAfter(today) || (sessionDate.isEqual(today) && startTime.toLocalTime().isAfter(nowTime));
    }

    private String note;
    private String cancellationReason;
    private int ptId;
    private int memberId;
    private Integer originalPtId;

    // Reschedule request fields
    private Integer rescheduleRequestId;
    private String rescheduleStatus;
    private LocalDate rescheduleProposedDate;
    private Time rescheduleProposedStartTime;
    private Time rescheduleProposedEndTime;
    private String rescheduleReason;
    private Integer rescheduleSenderUserId;
    private String rescheduleResponseReason;
    private String rescheduleEscalationReason;

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }

    public Integer getRescheduleRequestId() {
        return rescheduleRequestId;
    }

    public void setRescheduleRequestId(Integer rescheduleRequestId) {
        this.rescheduleRequestId = rescheduleRequestId;
    }

    public String getRescheduleStatus() {
        return rescheduleStatus;
    }

    public void setRescheduleStatus(String rescheduleStatus) {
        this.rescheduleStatus = rescheduleStatus;
    }

    public LocalDate getRescheduleProposedDate() {
        return rescheduleProposedDate;
    }

    public void setRescheduleProposedDate(LocalDate rescheduleProposedDate) {
        this.rescheduleProposedDate = rescheduleProposedDate;
    }

    public Time getRescheduleProposedStartTime() {
        return rescheduleProposedStartTime;
    }

    public void setRescheduleProposedStartTime(Time rescheduleProposedStartTime) {
        this.rescheduleProposedStartTime = rescheduleProposedStartTime;
    }

    public Time getRescheduleProposedEndTime() {
        return rescheduleProposedEndTime;
    }

    public void setRescheduleProposedEndTime(Time rescheduleProposedEndTime) {
        this.rescheduleProposedEndTime = rescheduleProposedEndTime;
    }

    public String getRescheduleReason() {
        return rescheduleReason;
    }

    public void setRescheduleReason(String rescheduleReason) {
        this.rescheduleReason = rescheduleReason;
    }

    public Integer getRescheduleSenderUserId() {
        return rescheduleSenderUserId;
    }

    public void setRescheduleSenderUserId(Integer rescheduleSenderUserId) {
        this.rescheduleSenderUserId = rescheduleSenderUserId;
    }

    public String getRescheduleResponseReason() {
        return rescheduleResponseReason;
    }

    public void setRescheduleResponseReason(String rescheduleResponseReason) {
        this.rescheduleResponseReason = rescheduleResponseReason;
    }

    public String getRescheduleEscalationReason() {
        return rescheduleEscalationReason;
    }

    public void setRescheduleEscalationReason(String rescheduleEscalationReason) {
        this.rescheduleEscalationReason = rescheduleEscalationReason;
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

    public String getPtSpecialization() {
        return ptSpecialization;
    }

    public void setPtSpecialization(String ptSpecialization) {
        this.ptSpecialization = ptSpecialization;
    }

    public String getOriginalPtName() {
        return originalPtName;
    }

    public void setOriginalPtName(String originalPtName) {
        this.originalPtName = originalPtName;
    }

    public Integer getOriginalPtId() {
        return originalPtId;
    }

    public void setOriginalPtId(Integer originalPtId) {
        this.originalPtId = originalPtId;
    }
}
