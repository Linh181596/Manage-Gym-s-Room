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
