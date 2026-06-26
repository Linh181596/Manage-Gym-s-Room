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
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.service.DashboardService;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DashboardServiceImpl implements DashboardService {
    private static final int REVENUE_DAYS = 7;
    private static final DateTimeFormatter CHART_DATE_FORMAT = DateTimeFormatter.ofPattern("dd/MM");

    private final DashboardDAO dashboardDAO = new DashboardDAOImpl();

    @Override
    public AdminDashboardData getAdminDashboardData() throws SQLException {
        AdminDashboardData data = new AdminDashboardData();
        data.setMetric(dashboardDAO.getMetrics());
        data.setRevenueTrend(fillMissingRevenueDays(dashboardDAO.getRevenueTrend(REVENUE_DAYS)));
        data.setRecentInvoices(dashboardDAO.getRecentInvoices(8));
        data.setAlerts(dashboardDAO.getOperationalAlerts());
        data.setRevenueChartLabelsJson(buildLabelsJson(data.getRevenueTrend()));
        data.setRevenueChartValuesJson(buildValuesJson(data.getRevenueTrend()));
        return data;
    }

    private List<RevenuePoint> fillMissingRevenueDays(List<RevenuePoint> rawPoints) {
        Map<LocalDate, BigDecimal> revenueByDate = rawPoints.stream()
                .filter(point -> point.getRevenueDate() != null)
                .collect(Collectors.toMap(RevenuePoint::getRevenueDate, RevenuePoint::getAmount, BigDecimal::add));

        Map<LocalDate, BigDecimal> ordered = new LinkedHashMap<>();
        LocalDate startDate = LocalDate.now().minusDays(REVENUE_DAYS - 1L);
        for (int i = 0; i < REVENUE_DAYS; i++) {
            LocalDate date = startDate.plusDays(i);
            ordered.put(date, revenueByDate.getOrDefault(date, BigDecimal.ZERO));
        }

        return ordered.entrySet().stream()
                .map(entry -> new RevenuePoint(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }

    private String buildLabelsJson(List<RevenuePoint> points) {
        return points.stream()
                .map(point -> "\"" + point.getRevenueDate().format(CHART_DATE_FORMAT) + "\"")
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String buildValuesJson(List<RevenuePoint> points) {
        return points.stream()
                .map(point -> point.getAmount().toPlainString())
                .collect(Collectors.joining(",", "[", "]"));
    }
}
