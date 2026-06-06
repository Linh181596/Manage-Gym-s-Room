/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: EmailUtil.java
 * Description: Lớp hỗ trợ gửi email tự động thông qua giao thức SMTP (JavaMail API).
 * Chuyên trách tạo dựng phom thư và gửi liên kết chứa mã Token bảo mật kích hoạt
 * tài khoản cho Hội viên mới đăng ký hệ thống (UC-02).
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Cấu hình giao thức SMTP và viết hàm gửi email kích hoạt.
 */
public class EmailUtil {
    private static final String SMTP_USER = "ee978934f03c4f"; 
    private static final String SMTP_PASSWORD = "0da162ae9533cb";

    public static boolean sendVerificationEmail(String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "sandbox.smtp.mailtrap.io");
        props.put("mail.smtp.port", "2525"); // hoặc 587

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("noreply@gymcenter.com", "GCMS System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Vui long xac thuc tai khoan GCMS cua ban");

            // Đổi URL localhost nếu port server của bạn khác 8080
            String verifyLink = "http://localhost:8080/gcms/verify?token=" + token;
            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px;'>"
                    + "<h2 style='color: #007bff;'>Chào mừng bạn đến với Gym Center Management System</h2>"
                    + "<p>Vui lòng click vào nút bên dưới để kích hoạt tài khoản của bạn:</p>"
                    + "<a href='" + verifyLink + "' style='background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 10px;'>Kích hoạt tài khoản</a>"
                    + "<p style='margin-top: 20px; font-size: 12px; color: #777;'>*Link này sẽ hết hạn trong vòng 15 phút.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
