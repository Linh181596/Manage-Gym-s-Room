package com.mycompany.gymcentermanagement.utils;

import java.sql.Time;
import java.util.List;

/**
 * Lớp tiện ích hỗ trợ xử lý các khung giờ tập cố định (Fixed Slot) cho Personal Trainer (PT).
 * Thay vì để thời gian tự do, hệ thống quy định các ca tập cố định theo định dạng "HH:mm-HH:mm".
 */
public final class PTFixedSlotHelper {

    // Ký lục (Record) lưu trữ thông tin về một ca tập đã được phân tách thành giờ bắt đầu và kết thúc
    public record FixedSlot(String label, Time startTime, Time endTime) {}

    // Danh sách các ca tập hợp lệ trong hệ thống (Quy định nghiệp vụ)
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

    /**
     * Kiểm tra xem một chuỗi ca tập đầu vào có hợp lệ theo danh sách quy định hay không.
     * 
     * @param slotLabel Chuỗi nhãn ca tập (VD: "08:15-09:45")
     * @return true nếu hợp lệ, false nếu không
     */
    public static boolean isValidSlot(String slotLabel) {
        return slotLabel != null && VALID_SLOT_LABELS.contains(slotLabel.trim());
    }

    /**
     * Chuyển đổi chuỗi nhãn ca tập thành đối tượng FixedSlot chứa Time SQL để lưu database.
     * 
     * @param slotLabel Chuỗi nhãn ca tập cần phân tách
     * @return Đối tượng FixedSlot hoặc null nếu chuỗi không hợp lệ
     */
    public static FixedSlot parseSlot(String slotLabel) {
        if (!isValidSlot(slotLabel)) {
            return null;
        }
        // Phân tách chuỗi dựa vào dấu gạch ngang '-'
        String[] parts = slotLabel.trim().split("-");
        
        // Thêm ":00" để đúng chuẩn định dạng java.sql.Time (HH:mm:ss)
        return new FixedSlot(
                slotLabel.trim(),
                Time.valueOf(parts[0] + ":00"),
                Time.valueOf(parts[1] + ":00")
        );
    }
}
