/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author phuga
 */
public class ValidationUtils {

    private ValidationUtils() {
    }

    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /* Valid:
    abc@gmail.com
    nguyenvana123@gmail.com
    test.user-01@gmail.com
    
    Invalid:
    abcgmail.com       // thiếu @
    @gmail.com         // thiếu phần trước @
    abc@               // thiếu domain
    abc gmail.com      // có dấu cách
    
     */
    public static boolean isValidEmail(String email) {
        if (isBlank(email)) {
            return false;
        }
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isValidPhone(String phone) {
        if (isBlank(phone)) {
            return false;
        }
        return phone.matches("^\\d{10}$");
    }

    public static Integer parseIntegerOrNull(String value) {
        if (isBlank(value)) {
            return null;
        }

        String trimmedValue = value.trim();
        try {
            return Integer.valueOf(trimmedValue);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public static boolean isValidOptionalCertificateType(String fileType) {
        if (isBlank(fileType)) {
            return true;
        }

        String type = fileType.trim().toUpperCase();

        return type.equals("PDF")
                || type.equals("JPG")
                || type.equals("JPEG")
                || type.equals("PNG");
    }
}
