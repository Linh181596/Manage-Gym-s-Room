/**
 * =========================================================================
 * @file          : DashboardServiceImpl.java
 * @description   : Lớp tổng hợp dữ liệu dashboard, chuẩn hóa chuỗi JSON cho biểu đồ doanh thu và xử lý ngày thiếu dữ liệu.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.DashboardDAO;
import com.mycompany.gymcentermanagement.dao.impl.DashboardDAOImpl;
import com.mycompany.gymcentermanagement.dto.AdminDashboardData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.service.DashboardService;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DashboardServiceImpl implements DashboardService {
    private static final DateTimeFormatter DAY_CHART_DATE_FORMAT = DateTimeFormatter.ofPattern("dd/MM");
    private static final DateTimeFormatter MONTH_CHART_DATE_FORMAT = DateTimeFormatter.ofPattern("MM/yyyy");

    private final DashboardDAO dashboardDAO = new DashboardDAOImpl();

    @Override
    public AdminDashboardData getAdminDashboardData(RevenueChartFilter revenueFilter) throws SQLException {
        RevenueChartFilter filter = revenueFilter != null
                ? revenueFilter
                : RevenueChartFilter.fromRequest(null, null, null, null);
        AdminDashboardData data = new AdminDashboardData();
        data.setMetric(dashboardDAO.getMetrics());
        data.setRevenueFilter(filter);
        data.setRevenueTrend(fillMissingRevenuePeriods(dashboardDAO.getRevenueTrend(filter), filter));
        data.setRecentInvoices(dashboardDAO.getRecentInvoices(8));
        data.setAlerts(dashboardDAO.getOperationalAlerts());
        data.setRevenueChartLabelsJson(buildLabelsJson(data.getRevenueTrend(), filter));
        data.setRevenueChartValuesJson(buildValuesJson(data.getRevenueTrend()));
        return data;
    }

    private List<RevenuePoint> fillMissingRevenuePeriods(List<RevenuePoint> rawPoints, RevenueChartFilter filter) {
        Map<LocalDate, BigDecimal> revenueByDate = rawPoints.stream()
                .filter(point -> point.getRevenueDate() != null)
                .collect(Collectors.toMap(RevenuePoint::getRevenueDate, RevenuePoint::getAmount, BigDecimal::add));

        Map<LocalDate, BigDecimal> ordered = new LinkedHashMap<>();
        LocalDate cursor = getFirstChartPeriod(filter);
        LocalDate endDate = filter.getToDate();

        while (!cursor.isAfter(endDate)) {
            ordered.put(cursor, revenueByDate.getOrDefault(cursor, BigDecimal.ZERO));
            cursor = getNextChartPeriod(cursor, filter);
        }

        return ordered.entrySet().stream()
                .map(entry -> new RevenuePoint(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }

    private LocalDate getFirstChartPeriod(RevenueChartFilter filter) {
        if (RevenueChartFilter.GROUP_WEEK.equals(filter.getGroupBy())) {
            return filter.getFromDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        }
        if (RevenueChartFilter.GROUP_MONTH.equals(filter.getGroupBy())) {
            return filter.getFromDate().withDayOfMonth(1);
        }
        return filter.getFromDate();
    }

    private LocalDate getNextChartPeriod(LocalDate current, RevenueChartFilter filter) {
        if (RevenueChartFilter.GROUP_WEEK.equals(filter.getGroupBy())) {
            return current.plusWeeks(1);
        }
        if (RevenueChartFilter.GROUP_MONTH.equals(filter.getGroupBy())) {
            return current.plusMonths(1);
        }
        return current.plusDays(1);
    }

    private String buildLabelsJson(List<RevenuePoint> points, RevenueChartFilter filter) {
        return points.stream()
                .map(point -> "\"" + buildLabel(point.getRevenueDate(), filter) + "\"")
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String buildLabel(LocalDate date, RevenueChartFilter filter) {
        if (RevenueChartFilter.GROUP_WEEK.equals(filter.getGroupBy())) {
            return "Tuần " + date.format(DAY_CHART_DATE_FORMAT);
        }
        if (RevenueChartFilter.GROUP_MONTH.equals(filter.getGroupBy())) {
            return date.format(MONTH_CHART_DATE_FORMAT);
        }
        return date.format(DAY_CHART_DATE_FORMAT);
    }

    private String buildValuesJson(List<RevenuePoint> points) {
        return points.stream()
                .map(point -> point.getAmount().toPlainString())
                .collect(Collectors.joining(",", "[", "]"));
    }
}
