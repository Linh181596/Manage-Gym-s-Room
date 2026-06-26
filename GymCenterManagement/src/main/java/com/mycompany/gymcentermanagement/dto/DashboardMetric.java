/**
 * =========================================================================
 * @file          : DashboardMetric.java
 * @description   : DTO lưu các chỉ số tổng quan như hội viên hoạt động, doanh thu, huấn luyện viên và cảnh báo vận hành.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.math.BigDecimal;

public class DashboardMetric {
    private int activeMembers;
    private int newMembershipsToday;
    private BigDecimal todayRevenue = BigDecimal.ZERO;
    private BigDecimal monthRevenue = BigDecimal.ZERO;
    private int activeTrainers;
    private int todayPtSessions;
    private int pendingAlerts;

    public int getActiveMembers() {
        return activeMembers;
    }

    public void setActiveMembers(int activeMembers) {
        this.activeMembers = activeMembers;
    }

    public int getNewMembershipsToday() {
        return newMembershipsToday;
    }

    public void setNewMembershipsToday(int newMembershipsToday) {
        this.newMembershipsToday = newMembershipsToday;
    }

    public BigDecimal getTodayRevenue() {
        return todayRevenue;
    }

    public void setTodayRevenue(BigDecimal todayRevenue) {
        this.todayRevenue = todayRevenue != null ? todayRevenue : BigDecimal.ZERO;
    }

    public BigDecimal getMonthRevenue() {
        return monthRevenue;
    }

    public void setMonthRevenue(BigDecimal monthRevenue) {
        this.monthRevenue = monthRevenue != null ? monthRevenue : BigDecimal.ZERO;
    }

    public int getActiveTrainers() {
        return activeTrainers;
    }

    public void setActiveTrainers(int activeTrainers) {
        this.activeTrainers = activeTrainers;
    }

    public int getTodayPtSessions() {
        return todayPtSessions;
    }

    public void setTodayPtSessions(int todayPtSessions) {
        this.todayPtSessions = todayPtSessions;
    }

    public int getPendingAlerts() {
        return pendingAlerts;
    }

    public void setPendingAlerts(int pendingAlerts) {
        this.pendingAlerts = pendingAlerts;
    }
}
