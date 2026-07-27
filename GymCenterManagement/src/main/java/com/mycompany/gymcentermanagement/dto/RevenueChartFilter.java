/**
 * =========================================================================
 * @file          : RevenueChartFilter.java
 * @description   : DTO lưu điều kiện lọc biểu đồ doanh thu trên bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-07-06
 * @last_modified : 2026-07-06 bởi Codex
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * DTO chứa cấu hình các tiêu chí lọc cho biểu đồ doanh thu (Theo loại doanh thu và khoảng thời gian).
 * Chứa logic chuyển đổi tự động các mốc tương đối (ví dụ: "last7", "this_month", "this_quarter") 
 * thành ngày cụ thể (fromDate, toDate) để gọi truy vấn SQL dễ dàng.
 */
public class RevenueChartFilter {
    public static final String RANGE_LAST_7_DAYS = "last7";
    public static final String RANGE_LAST_30_DAYS = "last30";
    public static final String RANGE_THIS_MONTH = "this_month";
    public static final String RANGE_THIS_QUARTER = "this_quarter";
    public static final String RANGE_THIS_YEAR = "this_year";
    public static final String RANGE_CUSTOM = "custom";

    public static final String TYPE_ALL = "all";
    public static final String TYPE_GYM_PACKAGE = "gym";
    public static final String TYPE_PT_SERVICE = "pt";

    public static final String GROUP_DAY = "DAY";
    public static final String GROUP_WEEK = "WEEK";
    public static final String GROUP_MONTH = "MONTH";

    private String range = RANGE_THIS_MONTH;
    private String revenueType = TYPE_ALL;
    private LocalDate fromDate;
    private LocalDate toDate;
    private String groupBy = GROUP_DAY;

    /**
     * Tạo bộ lọc doanh thu từ tham số request, sau đó chuẩn hóa khoảng ngày và cách nhóm dữ liệu biểu đồ.
     */
    public static RevenueChartFilter fromRequest(String range, String fromDateValue, String toDateValue, String revenueType) {
        RevenueChartFilter filter = new RevenueChartFilter();
        filter.range = isValidRange(range) ? range : RANGE_THIS_MONTH;
        filter.revenueType = isValidRevenueType(revenueType) ? revenueType : TYPE_ALL;
        filter.fromDate = parseDate(fromDateValue);
        filter.toDate = parseDate(toDateValue);
        filter.normalize(LocalDate.now());
        return filter;
    }

    /**
     * Chuyển khoảng thời gian tương đối hoặc tùy chọn thành ngày bắt đầu/kết thúc hợp lệ.
     */
    private void normalize(LocalDate today) {
        if (RANGE_CUSTOM.equals(range)) {
            if (fromDate == null || toDate == null) {
                range = RANGE_THIS_MONTH;
            } else if (fromDate.isAfter(toDate)) {
                LocalDate temp = fromDate;
                fromDate = toDate;
                toDate = temp;
            }
        }

        if (RANGE_LAST_7_DAYS.equals(range)) {
            fromDate = today.minusDays(6);
            toDate = today;
        } else if (RANGE_LAST_30_DAYS.equals(range)) {
            fromDate = today.minusDays(29);
            toDate = today;
        } else if (RANGE_THIS_MONTH.equals(range)) {
            fromDate = today.withDayOfMonth(1);
            toDate = today;
        } else if (RANGE_THIS_QUARTER.equals(range)) {
            int firstMonthOfQuarter = ((today.getMonthValue() - 1) / 3) * 3 + 1;
            fromDate = LocalDate.of(today.getYear(), firstMonthOfQuarter, 1);
            toDate = today;
        } else if (RANGE_THIS_YEAR.equals(range)) {
            fromDate = LocalDate.of(today.getYear(), 1, 1);
            toDate = today;
        }

        groupBy = resolveGroupBy(fromDate, toDate);
    }

    /**
     * Chọn nhóm biểu đồ theo ngày, tuần hoặc tháng dựa trên độ dài của khoảng thời gian.
     */
    private static String resolveGroupBy(LocalDate fromDate, LocalDate toDate) {
        long days = ChronoUnit.DAYS.between(fromDate, toDate) + 1;
        if (days <= 31) {
            return GROUP_DAY;
        }
        if (days <= 120) {
            return GROUP_WEEK;
        }
        return GROUP_MONTH;
    }

    /**
     * Kiểm tra giá trị khoảng thời gian có thuộc các lựa chọn Dashboard hỗ trợ hay không.
     */
    private static boolean isValidRange(String value) {
        return RANGE_LAST_7_DAYS.equals(value)
                || RANGE_LAST_30_DAYS.equals(value)
                || RANGE_THIS_MONTH.equals(value)
                || RANGE_THIS_QUARTER.equals(value)
                || RANGE_THIS_YEAR.equals(value)
                || RANGE_CUSTOM.equals(value);
    }

    /**
     * Kiểm tra loại doanh thu có phải là tất cả, gói Gym hoặc dịch vụ PT hay không.
     */
    private static boolean isValidRevenueType(String value) {
        return TYPE_ALL.equals(value)
                || TYPE_GYM_PACKAGE.equals(value)
                || TYPE_PT_SERVICE.equals(value);
    }

    /**
     * Chuyển chuỗi ngày từ request sang LocalDate; trả về null khi dữ liệu rỗng hoặc sai định dạng.
     */
    private static LocalDate parseDate(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return LocalDate.parse(value.trim());
        } catch (RuntimeException ex) {
            return null;
        }
    }

    /**
     * Trả về loại khoảng thời gian đang được áp dụng cho biểu đồ doanh thu.
     */
    public String getRange() {
        return range;
    }

    /**
     * Trả về loại doanh thu đang được lọc trên Dashboard.
     */
    public String getRevenueType() {
        return revenueType;
    }

    /**
     * Trả về ngày bắt đầu đã được chuẩn hóa cho truy vấn doanh thu.
     */
    public LocalDate getFromDate() {
        return fromDate;
    }

    /**
     * Trả về ngày kết thúc đã được chuẩn hóa cho truy vấn doanh thu.
     */
    public LocalDate getToDate() {
        return toDate;
    }

    /**
     * Trả về ngày bắt đầu dưới dạng chuỗi để điền lại vào ô lọc trên giao diện.
     */
    public String getFromDateValue() {
        return fromDate != null ? fromDate.toString() : "";
    }

    /**
     * Trả về ngày kết thúc dưới dạng chuỗi để điền lại vào ô lọc trên giao diện.
     */
    public String getToDateValue() {
        return toDate != null ? toDate.toString() : "";
    }

    /**
     * Trả về đơn vị nhóm dữ liệu doanh thu của biểu đồ: ngày, tuần hoặc tháng.
     */
    public String getGroupBy() {
        return groupBy;
    }
}
