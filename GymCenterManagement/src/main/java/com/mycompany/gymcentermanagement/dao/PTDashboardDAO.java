package com.mycompany.gymcentermanagement.dao;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface PTDashboardDAO {
    int countActiveMembers(int ptId) throws SQLException;
    int countWeeklySessions(int ptId, LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException;
    double sumCompletedTrainingHours(int ptId) throws SQLException;
    int countTotalTodaySessions(int ptId) throws SQLException;
    int countCompletedTodaySessions(int ptId) throws SQLException;
    List<Map<String, Object>> getTodaySchedule(int ptId) throws SQLException;
}
