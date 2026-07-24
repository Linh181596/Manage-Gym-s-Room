package com.mycompany.gymcentermanagement.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Lớp tiện ích để mã hóa băm (hash) và xác thực mật khẩu một cách an toàn
 * sử dụng thuật toán SHA-256. Không bao giờ được phép lưu mật khẩu dạng plain text vào cơ sở dữ liệu.
 */
public class PasswordUtils {

    // Tập hợp các ký tự được phép sử dụng để sinh mật khẩu ngẫu nhiên
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
    private static final java.security.SecureRandom RANDOM = new java.security.SecureRandom();

    /**
     * Tạo ngẫu nhiên một mật khẩu tạm thời cho các tài khoản mới được tạo bởi Admin/Staff.
     * 
     * @param length Độ dài mật khẩu mong muốn
     * @return Mật khẩu tạm thời đã được tạo
     */
    public static String generateTemporaryPassword(int length) {
        // Đảm bảo mật khẩu dài tối thiểu 8 ký tự vì lý do bảo mật
        if (length < 8) {
            length = 8;
        }
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < length; i++) {
            // Lựa chọn ngẫu nhiên một ký tự từ hằng số CHARACTERS
            int index = RANDOM.nextInt(CHARACTERS.length());
            password.append(CHARACTERS.charAt(index));
        }
        return password.toString();
    }

    /**
     * Mã hóa (hash) một mật khẩu dạng plain-text sử dụng thuật toán băm SHA-256.
     * SHA-256 là thuật toán băm 1 chiều không thể dịch ngược.
     * 
     * @param password Mật khẩu gốc.
     * @return Chuỗi băm (hash) dạng Hex của mật khẩu.
     */
    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            
            // Chuyển mảng byte sau khi băm sang chuỗi hệ cơ số 16 (Hexadecimal) để lưu trữ trong Database
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0'); // Thêm số 0 phía trước nếu chuỗi hex chỉ có 1 ký tự
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Failed to hash password with SHA-256", e);
        }
    }

    /**
     * Xác thực tính hợp lệ của một mật khẩu dạng plain-text so với mật khẩu đã băm (hashed) trong CSDL.
     * 
     * @param password       Mật khẩu người dùng nhập vào lúc Login.
     * @param hashedPassword Mật khẩu đã được mã hóa lưu trữ ở Database.
     * @return true nếu mật khẩu khớp, false nếu sai.
     */
    public static boolean checkPassword(String password, String hashedPassword) {
        if (password == null || hashedPassword == null) {
            return false;
        }
        // Mã hóa lại mật khẩu người dùng nhập và so sánh chuỗi băm
        return hashPassword(password).equals(hashedPassword);
    }
}
