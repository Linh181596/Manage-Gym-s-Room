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

    public static String escapeJson(String value) {
        if (value == null) {
            return "";
        }

        StringBuilder builder = new StringBuilder(value.length() + 16);
        for (int i = 0; i < value.length(); i++) {
            char character = value.charAt(i);
            switch (character) {
                case '"' -> builder.append("\\\"");
                case '\\' -> builder.append("\\\\");
                case '\b' -> builder.append("\\b");
                case '\f' -> builder.append("\\f");
                case '\n' -> builder.append("\\n");
                case '\r' -> builder.append("\\r");
                case '\t' -> builder.append("\\t");
                default -> {
                    if (character < 0x20) {
                        builder.append(String.format("\\u%04x", (int) character));
                    } else {
                        builder.append(character);
                    }
                }
            }
        }
        return builder.toString();
    }
}
