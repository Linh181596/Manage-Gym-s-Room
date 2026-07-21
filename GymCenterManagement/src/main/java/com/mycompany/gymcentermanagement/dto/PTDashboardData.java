package com.mycompany.gymcentermanagement.dto;

import java.util.List;
import java.util.Map;

/**
 * DTO chứa toàn bộ dữ liệu cần thiết để hiển thị trên Dashboard của Huấn luyện viên (PT).
 * Gói gọn thông tin số hội viên đang quản lý, số ca tập trong tuần, giờ đào tạo và lịch tập hôm nay.
 */
public class PTDashboardData {
    private int activeMembersCount;
    private int weeklySessionsCount;
    private double trainingHours;
    private int completedTodayCount;
    private int totalTodayCount;
    private List<Map<String, Object>> todaySchedule;

    public PTDashboardData() {
    }

    public int getActiveMembersCount() {
        return activeMembersCount;
    }

    public void setActiveMembersCount(int activeMembersCount) {
        this.activeMembersCount = activeMembersCount;
    }

    public int getWeeklySessionsCount() {
        return weeklySessionsCount;
    }

    public void setWeeklySessionsCount(int weeklySessionsCount) {
        this.weeklySessionsCount = weeklySessionsCount;
    }

    public double getTrainingHours() {
        return trainingHours;
    }

    public void setTrainingHours(double trainingHours) {
        this.trainingHours = trainingHours;
    }

    public int getCompletedTodayCount() {
        return completedTodayCount;
    }

    public void setCompletedTodayCount(int completedTodayCount) {
        this.completedTodayCount = completedTodayCount;
    }

    public int getTotalTodayCount() {
        return totalTodayCount;
    }

    public void setTotalTodayCount(int totalTodayCount) {
        this.totalTodayCount = totalTodayCount;
    }

    public List<Map<String, Object>> getTodaySchedule() {
        return todaySchedule;
    }

    public void setTodaySchedule(List<Map<String, Object>> todaySchedule) {
        this.todaySchedule = todaySchedule;
    }
}
