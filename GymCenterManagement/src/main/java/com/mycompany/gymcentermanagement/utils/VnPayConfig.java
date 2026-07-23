package com.mycompany.gymcentermanagement.utils;

import jakarta.servlet.http.HttpServletRequest;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * Lớp cấu hình và tiện ích kết nối với cổng thanh toán VNPAY.
 * Bao gồm các hàm mã hóa (HMAC-SHA512) để tạo chữ ký điện tử an toàn cho giao dịch.
 */
public class VnPayConfig {

    // URL trang thanh toán của VNPAY (Môi trường Sandbox để test)
    public static final String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    // URL Callback trả kết quả về hệ thống sau khi thanh toán xong
    public static final String vnp_ReturnUrl = "http://localhost:8080/GymCenterManagement/staff/vnpay-return";
    // Mã Website (Terminal Code) được VNPAY cấp
    public static final String vnp_TmnCode = "MGTBHP7Y";
    // Chuỗi bí mật để tạo chữ ký điện tử, giúp đảm bảo tính toàn vẹn của dữ liệu gửi đi và nhận về
    public static final String secretKey = "8XG030QUM880FOZGYNFLXAB2R163A16Z";
    // URL API dùng để truy vấn trạng thái giao dịch từ hệ thống VNPAY
    public static final String vnp_ApiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

    /**
     * Mã hóa băm chuỗi sử dụng thuật toán MD5 (hiện tại VNPAY khuyến cáo dùng SHA-512)
     */
    public static String md5(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    /**
     * Mã hóa băm chuỗi sử dụng thuật toán SHA-256
     */
    public static String Sha256(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    /**
     * Tạo chuỗi băm dựa trên các trường (fields) yêu cầu thanh toán được gửi tới VNPAY.
     * Thuật toán sẽ nối tất cả các Key-Value theo thứ tự Alphabet của Key thành dạng QueryString 
     * trước khi mã hóa bằng HMAC SHA-512 với secretKey.
     * 
     * @param fields Map chứa các tham số VNPAY (VD: vnp_Amount, vnp_Command, vnp_TxnRef,...)
     * @return Chữ ký điện tử bảo mật (vnp_SecureHash)
     */
    public static String hashAllFields(Map<String, String> fields) {
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        // Sắp xếp các tham số theo thứ tự tăng dần để đảm bảo tính nhất quán của chuỗi băm
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            // Chỉ thêm vào chuỗi băm nếu tham số có giá trị
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                sb.append(fieldName);
                sb.append("=");
                sb.append(fieldValue);
            }
            // Thêm ký hiệu '&' để nối tiếp tham số
            if (itr.hasNext()) {
                sb.append("&");
            }
        }
        return hmacSHA512(secretKey, sb.toString());
    }

    /**
     * Thuật toán mã hóa HMAC SHA-512. Sử dụng Secret Key cung cấp bởi VNPAY 
     * để tạo chữ ký điện tử cho chuỗi Data.
     */
    public static String hmacSHA512(final String key, final String data) {
        try {
            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKeySpec = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKeySpec);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception ex) {
            return "";
        }
    }

    /**
     * Tiện ích lấy địa chỉ IP của Client (người dùng) đang thực hiện giao dịch.
     * VNPAY yêu cầu truyền `vnp_IpAddr` để chống gian lận.
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            // Ưu tiên đọc từ X-FORWARDED-FOR nếu request đi qua Proxy hoặc Load Balancer
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

    /**
     * Tiện ích tạo chuỗi số ngẫu nhiên theo độ dài, dùng để tạo mã giao dịch (TxnRef).
     */
    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
