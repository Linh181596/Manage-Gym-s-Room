package com.mycompany.gymcentermanagement.utils;

import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    private static final Logger LOGGER = Logger.getLogger(EmailUtils.class.getName());
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = EmailUtils.class.getClassLoader().getResourceAsStream("mail.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to find mail.properties in resources.");
            } else {
                properties.load(input);
                LOGGER.info("Mail configuration loaded successfully from mail.properties.");
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Failed to initialize mail configuration", ex);
        }
    }

    /**
     * Sends a verification email containing the activation link/code to the user.
     * 
     * @param toEmail The recipient's email address.
     * @param token   The verification token value.
     * @return true if sent successfully, false otherwise.
     */
    public static boolean sendVerificationEmail(String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", properties.getProperty("mail.smtp.auth", "true"));
        props.put("mail.smtp.starttls.enable", properties.getProperty("mail.smtp.starttls.enable", "true"));
        props.put("mail.smtp.host", properties.getProperty("mail.smtp.host", "sandbox.smtp.mailtrap.io"));
        props.put("mail.smtp.port", properties.getProperty("mail.smtp.port", "2525"));

        final String smtpUser = properties.getProperty("mail.smtp.username");
        final String smtpPassword = properties.getProperty("mail.smtp.password");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            String fromEmail = properties.getProperty("mail.from.email", "noreply@gymcenter.com");
            String fromName = properties.getProperty("mail.from.name", "GCMS System");
            message.setFrom(new InternetAddress(fromEmail, fromName));
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
            LOGGER.log(Level.SEVERE, "Failed to send verification email to " + toEmail, e);
            return false;
        }
    }
}
