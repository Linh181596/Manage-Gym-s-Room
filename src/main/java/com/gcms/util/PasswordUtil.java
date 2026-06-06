/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: PasswordUtil.java
 * Description: Tiện ích mã hóa và xác thực mật khẩu người dùng sử dụng thuật toán SHA-256.
 * Hỗ trợ tạo chuỗi băm (Hash) an toàn khi đăng ký tài khoản (UC-02) và so khớp mật khẩu
 * khi đăng nhập hệ thống (UC-01), đảm bảo an toàn tuyệt đối cho Database.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Khởi tạo cấu trúc logic băm mật khẩu SHA-256.
 */
public class PasswordUtil {
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi mã hóa mật khẩu: " + e.getMessage());
        }
    }
}
