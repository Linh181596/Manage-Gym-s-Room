/**
 * =========================================================================
 * @file          : DashboardService.java
 * @description   : Interface định nghĩa dịch vụ tổng hợp dữ liệu cho bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.AdminDashboardData;
import java.sql.SQLException;

public interface DashboardService {
    AdminDashboardData getAdminDashboardData() throws SQLException;
}
