/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.model;

/**
 *
 * @author daiduong
 */
import java.sql.Timestamp;
public class UserToken {
    private int tokenID;
    private int userID;
    private String tokenValue;
    private String tokenType;   // Phân loại: 'REMEMBER_ME', 'REGISTRATION', 'RESET_PASSWORD'
    private Timestamp expiresAt; // Sử dụng Timestamp để tương thích tốt với DATETIME2 trong DB
    private boolean isUsed;
    private Timestamp createdDate;

    // Hàm khởi tạo không tham số (Default Constructor)
    public UserToken() {}

    // Hàm khởi tạo đầy đủ tham số phục vụ việc tạo nhanh Token ở Controller
    public UserToken(int userID, String tokenValue, String tokenType, Timestamp expiresAt) {
        this.userID = userID;
        this.tokenValue = tokenValue;
        this.tokenType = tokenType;
        this.expiresAt = expiresAt;
    }

    // Toàn bộ các hàm Getter và Setter chuẩn hóa mã nguồn
    public int getTokenID() { return tokenID; }
    public void setTokenID(int tokenID) { this.tokenID = tokenID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getTokenValue() { return tokenValue; }
    public void setTokenValue(String tokenValue) { this.tokenValue = tokenValue; }

    public String getTokenType() { return tokenType; }
    public void setTokenType(String tokenType) { this.tokenType = tokenType; }

    public Timestamp getExpiresAt() { return expiresAt; }
    public void setExpiresAt(Timestamp expiresAt) { this.expiresAt = expiresAt; }

    public boolean isIsUsed() { return isUsed; }
    public void setIsUsed(boolean isUsed) { this.isUsed = isUsed; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
}
