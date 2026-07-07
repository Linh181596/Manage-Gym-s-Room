/**
 * =========================================================================
 * @file          : RevenueChartFilter.java
 * @description   : DTO lưu điều kiện lọc biểu đồ doanh thu trên bảng điều khiển quản trị.
 * @author        : Duongnd
 * @created       : 2026-07-06
 * @last_modified : 2026-07-06 bởi Codex
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

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

    public static RevenueChartFilter fromRequest(String range, String fromDateValue, String toDateValue, String revenueType) {
        RevenueChartFilter filter = new RevenueChartFilter();
        filter.range = isValidRange(range) ? range : RANGE_THIS_MONTH;
        filter.revenueType = isValidRevenueType(revenueType) ? revenueType : TYPE_ALL;
        filter.fromDate = parseDate(fromDateValue);
        filter.toDate = parseDate(toDateValue);
        filter.normalize(LocalDate.now());
        return filter;
    }

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

    private static boolean isValidRange(String value) {
        return RANGE_LAST_7_DAYS.equals(value)
                || RANGE_LAST_30_DAYS.equals(value)
                || RANGE_THIS_MONTH.equals(value)
                || RANGE_THIS_QUARTER.equals(value)
                || RANGE_THIS_YEAR.equals(value)
                || RANGE_CUSTOM.equals(value);
    }

    private static boolean isValidRevenueType(String value) {
        return TYPE_ALL.equals(value)
                || TYPE_GYM_PACKAGE.equals(value)
                || TYPE_PT_SERVICE.equals(value);
    }

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

    public String getRange() {
        return range;
    }

    public String getRevenueType() {
        return revenueType;
    }

    public LocalDate getFromDate() {
        return fromDate;
    }

    public LocalDate getToDate() {
        return toDate;
    }

    public String getFromDateValue() {
        return fromDate != null ? fromDate.toString() : "";
    }

    public String getToDateValue() {
        return toDate != null ? toDate.toString() : "";
    }

    public String getGroupBy() {
        return groupBy;
    }
}
