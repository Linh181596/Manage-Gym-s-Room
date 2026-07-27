package com.mycompany.gymcentermanagement.model.entity;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class RescheduleRequest {
    private int requestId;
    private int scheduleId;
    private int senderUserId;
    private int receiverUserId;
    private LocalDate originalDate;
    private Time originalStartTime;
    private Time originalEndTime;
    private LocalDate proposedDate;
    private Time proposedStartTime;
    private Time proposedEndTime;
    private String status;
    private String reason;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;

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

    public LocalDate getOriginalDate() {
        return originalDate;
    }

    public void setOriginalDate(LocalDate originalDate) {
        this.originalDate = originalDate;
    }

    public Time getOriginalStartTime() {
        return originalStartTime;
    }

    public void setOriginalStartTime(Time originalStartTime) {
        this.originalStartTime = originalStartTime;
    }

    public Time getOriginalEndTime() {
        return originalEndTime;
    }

    public void setOriginalEndTime(Time originalEndTime) {
        this.originalEndTime = originalEndTime;
    }

    public LocalDate getProposedDate() {
        return proposedDate;
    }

    public void setProposedDate(LocalDate proposedDate) {
        this.proposedDate = proposedDate;
    }

    public Time getProposedStartTime() {
        return proposedStartTime;
    }

    public void setProposedStartTime(Time proposedStartTime) {
        this.proposedStartTime = proposedStartTime;
    }

    public Time getProposedEndTime() {
        return proposedEndTime;
    }

    public void setProposedEndTime(Time proposedEndTime) {
        this.proposedEndTime = proposedEndTime;
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
}
