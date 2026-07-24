/**
 * =========================================================================
 * @file          : MemberDashboardData.java
 * @description   : DTO tổng hợp toàn bộ dữ liệu cần hiển thị trên bảng điều khiển của hội viên (Member).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * DTO chứa toàn bộ dữ liệu cần thiết để hiển thị trên Dashboard của Hội viên (Member).
 * Gói gọn thông tin số buổi tập sắp tới, trạng thái gói tập hiện tại, 
 * tổng chi tiêu trong tháng, và danh sách các hóa đơn/lịch tập gần nhất.
 */
public class MemberDashboardData {
    private int upcomingAppointmentsCount;
    private String activePackageName = "Chưa đăng ký gói";
    private int activePackageRemainingDays;
    private BigDecimal spendThisMonth = BigDecimal.ZERO;
    private int unreadNotificationsCount;
    private String spendChartLabelsJson = "[]";
    private String spendChartValuesJson = "[]";
    private List<Map<String, Object>> upcomingSessions = new ArrayList<>();
    private List<DashboardInvoice> recentInvoices = new ArrayList<>();

    public int getUpcomingAppointmentsCount() {
        return upcomingAppointmentsCount;
    }

    public void setUpcomingAppointmentsCount(int upcomingAppointmentsCount) {
        this.upcomingAppointmentsCount = upcomingAppointmentsCount;
    }

    public String getActivePackageName() {
        return activePackageName;
    }

    public void setActivePackageName(String activePackageName) {
        this.activePackageName = activePackageName;
    }

    public int getActivePackageRemainingDays() {
        return activePackageRemainingDays;
    }

    public void setActivePackageRemainingDays(int activePackageRemainingDays) {
        this.activePackageRemainingDays = activePackageRemainingDays;
    }

    public BigDecimal getSpendThisMonth() {
        return spendThisMonth;
    }

    public void setSpendThisMonth(BigDecimal spendThisMonth) {
        this.spendThisMonth = spendThisMonth != null ? spendThisMonth : BigDecimal.ZERO;
    }

    public int getUnreadNotificationsCount() {
        return unreadNotificationsCount;
    }

    public void setUnreadNotificationsCount(int unreadNotificationsCount) {
        this.unreadNotificationsCount = unreadNotificationsCount;
    }

    public String getSpendChartLabelsJson() {
        return spendChartLabelsJson;
    }

    public void setSpendChartLabelsJson(String spendChartLabelsJson) {
        this.spendChartLabelsJson = spendChartLabelsJson;
    }

    public String getSpendChartValuesJson() {
        return spendChartValuesJson;
    }

    public void setSpendChartValuesJson(String spendChartValuesJson) {
        this.spendChartValuesJson = spendChartValuesJson;
    }

    public List<Map<String, Object>> getUpcomingSessions() {
        return upcomingSessions;
    }

    public void setUpcomingSessions(List<Map<String, Object>> upcomingSessions) {
        this.upcomingSessions = upcomingSessions;
    }

    public List<DashboardInvoice> getRecentInvoices() {
        return recentInvoices;
    }

    public void setRecentInvoices(List<DashboardInvoice> recentInvoices) {
        this.recentInvoices = recentInvoices;
    }
}
