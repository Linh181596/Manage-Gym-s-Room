/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.security.SecureRandom;

/**
 *
 * @author phuga
 */
public class PasswordGenerator {

    private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIALS = "@#$%&*!";

    private static final String ALL = UPPER + LOWER + DIGITS + SPECIALS;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordGenerator() {
    }

    public static String generateTemporaryPassword() {
        int length = 10;

        StringBuilder password = new StringBuilder();

        // Đảm bảo có đủ các nhóm ký tự cơ bản
        password.append(randomChar(UPPER));
        password.append(randomChar(LOWER));
        password.append(randomChar(DIGITS));
        password.append(randomChar(SPECIALS));

        for (int i = password.length(); i < length; i++) {
            password.append(randomChar(ALL));
        }

        return shuffle(password.toString());
    }

    private static char randomChar(String source) {
        return source.charAt(RANDOM.nextInt(source.length()));
    }

    private static String shuffle(String input) {
        char[] chars = input.toCharArray();

        for (int i = chars.length - 1; i > 0; i--) {
            int j = RANDOM.nextInt(i + 1);

            char temp = chars[i];
            chars[i] = chars[j];
            chars[j] = temp;
        }

        return new String(chars);
    }
}
