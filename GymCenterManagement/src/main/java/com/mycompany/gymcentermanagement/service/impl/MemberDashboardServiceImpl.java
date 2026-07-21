/**
 * =========================================================================
 * @file          : MemberDashboardServiceImpl.java
 * @description   : Lớp triển khai dịch vụ xử lý dữ liệu cho dashboard hội viên.
 *                  Hỗ trợ tính toán ngày và format JSON cho biểu đồ chi tiêu.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.MemberDashboardDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDashboardDAOImpl;
import com.mycompany.gymcentermanagement.dto.MemberDashboardData;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.service.MemberDashboardService;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class MemberDashboardServiceImpl implements MemberDashboardService {

    private static final int TREND_MONTHS = 6;
    private static final DateTimeFormatter CHART_MONTH_FORMAT = DateTimeFormatter.ofPattern("MM/yyyy");

    private final MemberDashboardDAO dashboardDAO = new MemberDashboardDAOImpl();

    /**
     * Lấy dữ liệu tổng hợp cho Member Dashboard.
     * Luồng nghiệp vụ:
     * 1. Đếm số lịch hẹn sắp tới của hội viên.
     * 2. Lấy thông tin gói tập hiện tại và tính toán số ngày còn lại.
     * 3. Tính tổng chi tiêu trong tháng hiện tại.
     * 4. Đếm số lượng thông báo chưa đọc của tài khoản.
     * 5. Lấy danh sách buổi tập sắp tới và hóa đơn gần đây.
     * 6. Lấy xu hướng chi tiêu trong 6 tháng gần nhất, điền dữ liệu cho các tháng thiếu và chuẩn hóa JSON.
     * 
     * @param memberId ID của hội viên
     * @param userId ID của người dùng (tài khoản)
     * @return Dữ liệu dashboard cho Member
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public MemberDashboardData getMemberDashboardData(int memberId, int userId) throws SQLException {
        MemberDashboardData data = new MemberDashboardData();
        
        // 1. KPI đếm số lịch hẹn sắp tới
        data.setUpcomingAppointmentsCount(dashboardDAO.countUpcomingAppointments(memberId));
        
        // 2. KPI thông tin gói tập hiện tại và số ngày còn lại
        Map<String, Object> pkgInfo = dashboardDAO.getActivePackageInfo(memberId);
        if (pkgInfo != null && !pkgInfo.isEmpty()) {
            String pkgName = (String) pkgInfo.get("packageName");
            if (pkgName != null) {
                data.setActivePackageName(pkgName);
            }
            LocalDate endDate = (LocalDate) pkgInfo.get("endDate");
            if (endDate != null) {
                long remaining = ChronoUnit.DAYS.between(LocalDate.now(), endDate);
                data.setActivePackageRemainingDays((int) Math.max(0, remaining));
            }
        }
        
        // 3. KPI tổng chi tiêu tháng này
        data.setSpendThisMonth(dashboardDAO.getSpendThisMonth(memberId));
        
        // 4. KPI số lượng thông báo
        data.setUnreadNotificationsCount(dashboardDAO.countNotifications(userId));
        
        // 5. Nạp danh sách buổi tập sắp tới và hóa đơn gần đây
        data.setUpcomingSessions(dashboardDAO.getUpcomingSessions(memberId, 5));
        data.setRecentInvoices(dashboardDAO.getRecentInvoices(memberId, 5));
        
        // 6. Xử lý biểu đồ chi tiêu hàng tháng (6 tháng gần nhất)
        List<RevenuePoint> trendPoints = dashboardDAO.getMonthlySpendTrend(memberId, TREND_MONTHS);
        List<RevenuePoint> filledPoints = fillMissingSpendMonths(trendPoints);
        data.setSpendChartLabelsJson(buildLabelsJson(filledPoints));
        data.setSpendChartValuesJson(buildValuesJson(filledPoints));
        
        return data;
    }

    private List<RevenuePoint> fillMissingSpendMonths(List<RevenuePoint> rawPoints) {
        Map<LocalDate, BigDecimal> spendByMonth = rawPoints.stream()
                .filter(point -> point.getRevenueDate() != null)
                .collect(Collectors.toMap(
                        point -> point.getRevenueDate().withDayOfMonth(1),
                        RevenuePoint::getAmount,
                        BigDecimal::add
                ));

        Map<LocalDate, BigDecimal> ordered = new LinkedHashMap<>();
        LocalDate startMonth = LocalDate.now().minusMonths(TREND_MONTHS - 1L).withDayOfMonth(1);
        for (int i = 0; i < TREND_MONTHS; i++) {
            LocalDate month = startMonth.plusMonths(i);
            ordered.put(month, spendByMonth.getOrDefault(month, BigDecimal.ZERO));
        }

        return ordered.entrySet().stream()
                .map(entry -> new RevenuePoint(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }

    private String buildLabelsJson(List<RevenuePoint> points) {
        return points.stream()
                .map(point -> "\"" + point.getRevenueDate().format(CHART_MONTH_FORMAT) + "\"")
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String buildValuesJson(List<RevenuePoint> points) {
        return points.stream()
                .map(point -> point.getAmount().toPlainString())
                .collect(Collectors.joining(",", "[", "]"));
    }
}
