package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import java.sql.SQLException;
import java.util.List;

public interface FinancialRevenueReportService {
    FinancialRevenueReportData getReportData(RevenueChartFilter filter) throws SQLException;
    
    List<DashboardInvoice> getFilteredInvoices(RevenueChartFilter filter, int limit) throws SQLException;
}
