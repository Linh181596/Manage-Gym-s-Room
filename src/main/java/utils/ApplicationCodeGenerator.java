/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

/**
 *
 * @author phuga
 */
public class ApplicationCodeGenerator {

    private static final Random RANDOM = new Random();

    private ApplicationCodeGenerator() {
    }

    public static String generatePTApplicationCode() {
        String timePart = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

        int randomPart = 100 + RANDOM.nextInt(900);

        return "PTAPP" + timePart + randomPart;
    }
}
