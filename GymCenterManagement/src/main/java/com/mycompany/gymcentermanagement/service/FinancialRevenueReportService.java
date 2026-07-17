package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import java.sql.SQLException;

public interface FinancialRevenueReportService {
    FinancialRevenueReportData getReportData(RevenueChartFilter filter) throws SQLException;
}
