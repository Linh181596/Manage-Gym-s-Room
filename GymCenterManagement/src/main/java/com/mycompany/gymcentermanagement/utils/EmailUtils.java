package com.mycompany.gymcentermanagement.utils;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Utility class to send emails via SMTP using Jakarta Mail API.
 */
public class EmailUtils {
    private static final String SMTP_USER = "ee978934f03c4f"; 
    private static final String SMTP_PASSWORD = "0da162ae9533cb";

    /**
     * Sends a verification email containing the activation link/code to the user.
     * 
     * @param toEmail The recipient's email address.
     * @param token   The verification token value.
     * @return true if sent successfully, false otherwise.
     */
    public static boolean sendVerificationEmail(String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "sandbox.smtp.mailtrap.io");
        props.put("mail.smtp.port", "2525");

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

            // Build the verification link. Adjust base path dynamically if possible, or use standard relative mapping.
            String verifyLink = "http://localhost:8080/GymCenterManagement/verify?token=" + token;
            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px;'>"
                    + "<h2 style='color: #007bff;'>Chào mừng bạn đến với Gym Center Management System</h2>"
                    + "<p>Vui lòng click vào nút bên dưới để kích hoạt tài khoản của bạn:</p>"
                    + "<a href='" + verifyLink + "' style='background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 10px;'>Kích hoạt tài khoản</a>"
                    + "<p style='margin-top: 20px; font-size: 12px; color: #777;'>*Link này sẽ hết hạn trong vòng 24 giờ.</p>"
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
