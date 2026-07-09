package com.mycompany.gymcentermanagement.dto;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class RescheduleRequestDetailDTO {
    private int requestId;
    private int scheduleId;
    private int senderUserId;
    private int receiverUserId;
    private String senderName;
    private String receiverName;
    private String ptName;
    private String memberName;
    private String packageName;
    private LocalDate originalDate;
    private Time originalStartTime;
    private Time originalEndTime;
    private LocalDate proposedDate;
    private Time proposedStartTime;
    private Time proposedEndTime;
    private String status;
    private String reason;
    private String responseReason;
    private String escalationReason;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private boolean ptConflict;
    private boolean memberConflict;

    public boolean isPtConflict() {
        return ptConflict;
    }

    public void setPtConflict(boolean ptConflict) {
        this.ptConflict = ptConflict;
    }

    public boolean isMemberConflict() {
        return memberConflict;
    }

    public void setMemberConflict(boolean memberConflict) {
        this.memberConflict = memberConflict;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getSenderUserId() {
        return senderUserId;
    }

    public void setSenderUserId(int senderUserId) {
        this.senderUserId = senderUserId;
    }

    public int getReceiverUserId() {
        return receiverUserId;
    }

    public void setReceiverUserId(int receiverUserId) {
        this.receiverUserId = receiverUserId;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getPtName() {
        return ptName;
    }

    public void setPtName(String ptName) {
        this.ptName = ptName;
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

    public LocalDate getOriginalDate() {
        return originalDate;
    }

    public void setOriginalDate(LocalDate originalDate) {
        this.originalDate = originalDate;
    }

    public String getFormattedOriginalDate() {
        if (originalDate == null) return "";
        return originalDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public Time getOriginalStartTime() {
        return originalStartTime;
    }

    public void setOriginalStartTime(Time originalStartTime) {
        this.originalStartTime = originalStartTime;
    }

    public String getFormattedOriginalStartTime() {
        if (originalStartTime == null) return "";
        String s = originalStartTime.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }

    public Time getOriginalEndTime() {
        return originalEndTime;
    }

    public void setOriginalEndTime(Time originalEndTime) {
        this.originalEndTime = originalEndTime;
    }

    public String getFormattedOriginalEndTime() {
        if (originalEndTime == null) return "";
        String s = originalEndTime.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }

    public LocalDate getProposedDate() {
        return proposedDate;
    }

    public void setProposedDate(LocalDate proposedDate) {
        this.proposedDate = proposedDate;
    }

    public String getFormattedProposedDate() {
        if (proposedDate == null) return "";
        return proposedDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public Time getProposedStartTime() {
        return proposedStartTime;
    }

    public void setProposedStartTime(Time proposedStartTime) {
        this.proposedStartTime = proposedStartTime;
    }

    public String getFormattedProposedStartTime() {
        if (proposedStartTime == null) return "";
        String s = proposedStartTime.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }


    public Time getProposedEndTime() {
        return proposedEndTime;
    }

    public void setProposedEndTime(Time proposedEndTime) {
        this.proposedEndTime = proposedEndTime;
    }

    public String getFormattedProposedEndTime() {
        if (proposedEndTime == null) return "";
        String s = proposedEndTime.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getResponseReason() {
        return responseReason;
    }

    public void setResponseReason(String responseReason) {
        this.responseReason = responseReason;
    }

    public String getEscalationReason() {
        return escalationReason;
    }

    public void setEscalationReason(String escalationReason) {
        this.escalationReason = escalationReason;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getFormattedCreatedDate() {
        if (createdDate == null) return "";
        return createdDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
