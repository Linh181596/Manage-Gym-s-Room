package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDateTime;

public class Notification {
    private int notificationId;
    private String title;
    private String content;
    private int createdBy;
    private String targetRole;
    private String createdByRole;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean deleted;
    private LocalDateTime publishDate;
    private LocalDateTime expiryDate;
    private String notificationImageUrl;
    private Integer recipientUserId;
    private String recipientDisplayName;
    private String recipientEmail;

    public Notification() {
    }

    public Notification(int notificationId, String title, String content, int createdBy, String targetRole) {
        this.notificationId = notificationId;
        this.title = title;
        this.content = content;
        this.createdBy = createdBy;
        this.targetRole = targetRole;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getTargetRole() {
        return targetRole;
    }

    public void setTargetRole(String targetRole) {
        this.targetRole = targetRole;
    }

    public String getCreatedByRole() {
        return createdByRole;
    }

    public void setCreatedByRole(String createdByRole) {
        this.createdByRole = createdByRole;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public LocalDateTime getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(LocalDateTime publishDate) {
        this.publishDate = publishDate;
    }

    public LocalDateTime getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDateTime expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getNotificationImageUrl() {
        return notificationImageUrl;
    }

    public void setNotificationImageUrl(String notificationImageUrl) {
        this.notificationImageUrl = notificationImageUrl;
    }

    public Integer getRecipientUserId() {
        return recipientUserId;
    }

    public void setRecipientUserId(Integer recipientUserId) {
        this.recipientUserId = recipientUserId;
    }

    public String getRecipientDisplayName() {
        return recipientDisplayName;
    }

    public void setRecipientDisplayName(String recipientDisplayName) {
        this.recipientDisplayName = recipientDisplayName;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public String getPublishDateInputValue() {
        return toDateTimeLocalValue(publishDate);
    }

    public String getExpiryDateInputValue() {
        return toDateTimeLocalValue(expiryDate);
    }

    public String getEffectiveStatus() {
        LocalDateTime now = LocalDateTime.now();
        if (publishDate != null && publishDate.isAfter(now)) {
            return "Scheduled";
        }
        if (expiryDate != null && !expiryDate.isAfter(now)) {
            return "Expired";
        }
        return "Active";
    }

    public boolean isSpecificRecipient() {
        return "Specific".equalsIgnoreCase(targetRole);
    }

    public String getRecipientLabel() {
        if (!isSpecificRecipient()) {
            return targetRole;
        }
        if (recipientDisplayName != null && !recipientDisplayName.isBlank()) {
            return recipientDisplayName;
        }
        if (recipientEmail != null && !recipientEmail.isBlank()) {
            return recipientEmail;
        }
        return recipientUserId != null ? "User #" + recipientUserId : "Tài khoản cụ thể";
    }

    private String toDateTimeLocalValue(LocalDateTime value) {
        if (value == null) {
            return "";
        }
        return value.toString().length() >= 16 ? value.toString().substring(0, 16) : value.toString();
    }
}
