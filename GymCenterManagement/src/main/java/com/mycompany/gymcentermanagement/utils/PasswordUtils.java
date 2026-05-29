package com.mycompany.gymcentermanagement.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility class to securely hash and verify passwords using SHA-256.
 */
public class PasswordUtils {

    /**
     * Hashes a plain-text password using SHA-256.
     * 
     * @param password The plain text password.
     * @return The hex-encoded hashed password.
     */
    public static String hashPassword(String password) {
        if (password == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Failed to hash password with SHA-256", e);
        }
    }

    /**
     * Verifies a plain-text password against a hashed password.
     * 
     * @param password       The plain text password.
     * @param hashedPassword The expected hashed password.
     * @return true if the passwords match, false otherwise.
     */
    public static boolean checkPassword(String password, String hashedPassword) {
        if (password == null || hashedPassword == null) {
            return false;
        }
        return hashPassword(password).equals(hashedPassword);
    }
}
