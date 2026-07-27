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

    // Tạo token xác thực; RegisterController dùng cho VERIFICATION, còn LoginController dùng cho REMEMBER_ME.
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

    // Trả về user sở hữu token để ghi liên kết User_Tokens trong cơ sở dữ liệu.
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    // Trả về giá trị token để lưu DB hoặc dùng đối chiếu với cookie Remember Me.
    public String getTokenValue() {
        return tokenValue;
    }

    public void setTokenValue(String tokenValue) {
        this.tokenValue = tokenValue;
    }

    // Trả về loại token, ví dụ REMEMBER_ME, để tránh dùng nhầm token xác minh hoặc reset mật khẩu.
    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    // Trả về thời điểm hết hạn để DB chỉ chấp nhận token Remember Me còn hiệu lực.
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
