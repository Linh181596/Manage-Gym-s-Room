/**
 * =========================================================================
 * @file          : DashboardService.java
 * @description   : Interface định nghĩa dịch vụ tổng hợp dữ liệu cho bảng điều khiển quản trị.
 * @author        : Codex
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.AdminDashboardData;
import java.sql.SQLException;

public interface DashboardService {
    AdminDashboardData getAdminDashboardData() throws SQLException;
}
