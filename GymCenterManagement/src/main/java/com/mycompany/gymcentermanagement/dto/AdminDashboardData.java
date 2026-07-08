/**
 * =========================================================================
 * @file          : AdminDashboardData.java
 * @description   : DTO tổng hợp toàn bộ dữ liệu cần hiển thị trên bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.util.ArrayList;
import java.util.List;

public class AdminDashboardData {
    private DashboardMetric metric = new DashboardMetric();
    private List<RevenuePoint> revenueTrend = new ArrayList<>();
    private List<DashboardInvoice> recentInvoices = new ArrayList<>();
    private List<DashboardAlert> alerts = new ArrayList<>();
    private RevenueChartFilter revenueFilter;
    private String revenueChartLabelsJson = "[]";
    private String revenueChartValuesJson = "[]";

    public DashboardMetric getMetric() {
        return metric;
    }

    public void setMetric(DashboardMetric metric) {
        this.metric = metric;
    }

    public List<RevenuePoint> getRevenueTrend() {
        return revenueTrend;
    }

    public void setRevenueTrend(List<RevenuePoint> revenueTrend) {
        this.revenueTrend = revenueTrend;
    }

    public List<DashboardInvoice> getRecentInvoices() {
        return recentInvoices;
    }

    public void setRecentInvoices(List<DashboardInvoice> recentInvoices) {
        this.recentInvoices = recentInvoices;
    }

    public List<DashboardAlert> getAlerts() {
        return alerts;
    }

    public void setAlerts(List<DashboardAlert> alerts) {
        this.alerts = alerts;
    }

    public RevenueChartFilter getRevenueFilter() {
        return revenueFilter;
    }

    public void setRevenueFilter(RevenueChartFilter revenueFilter) {
        this.revenueFilter = revenueFilter;
    }

    public String getRevenueChartLabelsJson() {
        return revenueChartLabelsJson;
    }

    public void setRevenueChartLabelsJson(String revenueChartLabelsJson) {
        this.revenueChartLabelsJson = revenueChartLabelsJson;
    }

    public String getRevenueChartValuesJson() {
        return revenueChartValuesJson;
    }

    public void setRevenueChartValuesJson(String revenueChartValuesJson) {
        this.revenueChartValuesJson = revenueChartValuesJson;
    }
}
