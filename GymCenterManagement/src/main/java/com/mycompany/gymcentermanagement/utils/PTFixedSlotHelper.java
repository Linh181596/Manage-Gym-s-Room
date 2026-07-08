package com.mycompany.gymcentermanagement.utils;

import java.sql.Time;
import java.util.List;

public final class PTFixedSlotHelper {

    public record FixedSlot(String label, Time startTime, Time endTime) {}

    public static final List<String> VALID_SLOT_LABELS = List.of(
            "08:15-09:45",
            "10:00-11:30",
            "13:30-15:00",
            "15:15-16:45",
            "17:00-18:30",
            "18:45-20:15"
    );

    private PTFixedSlotHelper() {
    }

    public static boolean isValidSlot(String slotLabel) {
        return slotLabel != null && VALID_SLOT_LABELS.contains(slotLabel.trim());
    }

    public static FixedSlot parseSlot(String slotLabel) {
        if (!isValidSlot(slotLabel)) {
            return null;
        }
        String[] parts = slotLabel.trim().split("-");
        return new FixedSlot(
                slotLabel.trim(),
                Time.valueOf(parts[0] + ":00"),
                Time.valueOf(parts[1] + ":00")
        );
    }
}
