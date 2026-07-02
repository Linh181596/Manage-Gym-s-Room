/**
 * =========================================================================
 * @file          : AccountOperationResult.java
 * @description   : DTO đóng gói kết quả thao tác quản lý tài khoản, thông báo phản hồi và mật khẩu tạm thời nếu có.
 * @author        : Duongnd
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

public class AccountOperationResult {
    private final boolean success;
    private final String message;
    private final String temporaryPassword;

    private AccountOperationResult(boolean success, String message, String temporaryPassword) {
        this.success = success;
        this.message = message;
        this.temporaryPassword = temporaryPassword;
    }

    public static AccountOperationResult success(String message) {
        return new AccountOperationResult(true, message, null);
    }

    public static AccountOperationResult successWithTemporaryPassword(String message, String temporaryPassword) {
        return new AccountOperationResult(true, message, temporaryPassword);
    }

    public static AccountOperationResult failure(String message) {
        return new AccountOperationResult(false, message, null);
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public String getTemporaryPassword() {
        return temporaryPassword;
    }
}
