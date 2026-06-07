package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDateTime;

/**
 * Entity representing the 'User_Tokens' table in the database.
 */
public class UserToken {
    private int tokenID;
    private int userID;
    private String tokenValue;
    private String tokenType;   // 'REMEMBER_ME', 'VERIFICATION', 'RESET_PASSWORD'
    private LocalDateTime expiresAt;
    private boolean isUsed;
    private LocalDateTime createdAt;

    public UserToken() {}

    public UserToken(int userID, String tokenValue, String tokenType, LocalDateTime expiresAt) {
        this.userID = userID;
        this.tokenValue = tokenValue;
        this.tokenType = tokenType;
        this.expiresAt = expiresAt;
    }

    public int getTokenID() {
        return tokenID;
    }

    public void setTokenID(int tokenID) {
        this.tokenID = tokenID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTokenValue() {
        return tokenValue;
    }

    public void setTokenValue(String tokenValue) {
        this.tokenValue = tokenValue;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDateTime expiresAt) {
        this.expiresAt = expiresAt;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        this.isUsed = used;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
