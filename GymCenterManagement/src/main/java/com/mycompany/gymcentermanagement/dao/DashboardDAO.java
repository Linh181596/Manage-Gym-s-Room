/**
 * =========================================================================
 * @file          : DashboardDAO.java
 * @description   : Interface định nghĩa các truy vấn đọc dữ liệu phục vụ bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.DashboardAlert;
import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.DashboardMetric;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import java.sql.SQLException;
import java.util.List;

public interface DashboardDAO {
    DashboardMetric getMetrics() throws SQLException;
    List<RevenuePoint> getRevenueTrend(RevenueChartFilter filter) throws SQLException;
    List<DashboardInvoice> getRecentInvoices(int limit) throws SQLException;
    List<DashboardAlert> getOperationalAlerts() throws SQLException;
}
