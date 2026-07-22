/**
 * =========================================================================
 * @file          : JsonUtils.java
 * @description   : Utility class for JSON serialization, deserialization, and JSON data processing
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.utils;

public final class JsonUtils {

    private JsonUtils() {
    }

    /**
     * Xử lý (escape) các ký tự đặc biệt trong chuỗi để đảm bảo chuỗi hợp lệ 
     * khi nhúng vào định dạng JSON. Điều này ngăn ngừa lỗi cú pháp JSON và 
     * tấn công XSS/Injection.
     * 
     * @param value Chuỗi đầu vào cần được escape.
     * @return Chuỗi đã được xử lý an toàn cho JSON.
     */
    public static String escapeJson(String value) {
        if (value == null) {
            return "";
        }

        // Khởi tạo StringBuilder với dung lượng dự phòng để tránh việc cấp phát lại bộ nhớ liên tục
        StringBuilder builder = new StringBuilder(value.length() + 16);
        for (int i = 0; i < value.length(); i++) {
            char character = value.charAt(i);
            // Xử lý các ký tự điều khiển và dấu ngoặc kép thường gây lỗi cú pháp JSON
            switch (character) {
                case '"' -> builder.append("\\\"");
                case '\\' -> builder.append("\\\\");
                case '\b' -> builder.append("\\b"); // Backspace
                case '\f' -> builder.append("\\f"); // Form feed
                case '\n' -> builder.append("\\n"); // Dòng mới
                case '\r' -> builder.append("\\r"); // Trở về đầu dòng
                case '\t' -> builder.append("\\t"); // Tab
                default -> {
                    // Xử lý các ký tự điều khiển ASCII khác (< 32, dạng hex U+00xx)
                    if (character < 0x20) {
                        builder.append(String.format("\\u%04x", (int) character));
                    } else {
                        // Ký tự thông thường
                        builder.append(character);
                    }
                }
            }
        }
        return builder.toString();
    }
}
