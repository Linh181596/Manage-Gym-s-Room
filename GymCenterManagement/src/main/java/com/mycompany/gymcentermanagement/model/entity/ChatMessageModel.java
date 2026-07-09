/**
 * =========================================================================
 * @file          : ChatMessageModel.java
 * @description   : Model representing chat messages exchanged between users and the chatbot
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.model.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ChatMessageModel implements Serializable {

    private static final long serialVersionUID = 1L;
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    private String role;
    private String content;
    private LocalDateTime createdAt;

    public ChatMessageModel() {
    }

    public ChatMessageModel(String role, String content, LocalDateTime createdAt) {
        this.role = role;
        this.content = content;
        this.createdAt = createdAt;
    }

    public static ChatMessageModel user(String content) {
        return new ChatMessageModel("user", content, LocalDateTime.now());
    }

    public static ChatMessageModel bot(String content) {
        return new ChatMessageModel("bot", content, LocalDateTime.now());
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getDisplayTime() {
        if (createdAt == null) {
            return "";
        }
        return createdAt.format(TIME_FORMATTER);
    }

    public boolean isUserMessage() {
        return "user".equals(role);
    }
}
