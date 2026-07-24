/**
 * =========================================================================
 * @file          : PTDashboardServiceImpl.java
 * @description   : Lớp triển khai dịch vụ cho Dashboard của Personal Trainer (PT).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTDashboardDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTDashboardDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTDashboardData;
import com.mycompany.gymcentermanagement.service.PTDashboardService;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;

public class PTDashboardServiceImpl implements PTDashboardService {

    private final PTDashboardDAO dashboardDAO = new PTDashboardDAOImpl();

    /**
     * Lấy dữ liệu tổng hợp cho Dashboard của PT.
     * Luồng nghiệp vụ:
     * 1. Xác định ngày đầu tuần (Thứ Hai) và cuối tuần (Chủ Nhật) của tuần hiện tại.
     * 2. Lấy số lượng học viên đang hoạt động của PT.
     * 3. Lấy số buổi tập trong tuần hiện tại.
     * 4. Lấy tổng số giờ dạy đã hoàn thành.
     * 5. Lấy tổng số buổi dạy và số buổi đã hoàn thành trong ngày hôm nay.
     * 6. Lấy chi tiết lịch trình dạy trong ngày hôm nay.
     * 
     * @param ptId ID của PT
     * @return Dữ liệu dashboard cho PT
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public PTDashboardData getPTDashboardData(int ptId) throws SQLException {
        PTDashboardData data = new PTDashboardData();
        
        // Calculate the current week Monday and Sunday
        LocalDate today = LocalDate.now();
        LocalDate monday = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate sunday = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
        
        data.setActiveMembersCount(dashboardDAO.countActiveMembers(ptId));
        data.setWeeklySessionsCount(dashboardDAO.countWeeklySessions(ptId, monday, sunday));
        data.setTrainingHours(dashboardDAO.sumCompletedTrainingHours(ptId));
        data.setTotalTodayCount(dashboardDAO.countTotalTodaySessions(ptId));
        data.setCompletedTodayCount(dashboardDAO.countCompletedTodaySessions(ptId));
        data.setTodaySchedule(dashboardDAO.getTodaySchedule(ptId));
        
        return data;
    }
}
