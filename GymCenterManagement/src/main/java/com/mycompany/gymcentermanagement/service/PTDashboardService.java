package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.PTDashboardData;
import java.sql.SQLException;

public interface PTDashboardService {
    PTDashboardData getPTDashboardData(int ptId) throws SQLException;
}
