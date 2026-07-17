package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import java.sql.SQLException;
import java.util.List;

public interface FinancialRevenueReportDAO {
    void populateRevenueSummary(FinancialRevenueReportData data, String fromDate, String toDate, String revenueType) throws SQLException;
    List<RevenuePoint> getRevenueTrend(RevenueChartFilter filter) throws SQLException;
    List<DashboardInvoice> getFilteredInvoices(String fromDate, String toDate, String revenueType, int limit) throws SQLException;
}
