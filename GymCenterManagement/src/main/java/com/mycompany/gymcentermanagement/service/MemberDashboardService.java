/**
 * =========================================================================
 * @file          : MemberDashboardService.java
 * @description   : Interface định nghĩa các nghiệp vụ xử lý dữ liệu cho dashboard hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.MemberDashboardData;
import java.sql.SQLException;

public interface MemberDashboardService {
    /**
     * Tổng hợp toàn bộ dữ liệu cần thiết cho dashboard hội viên.
     * @param memberId Mã hội viên
     * @param userId Mã người dùng (dùng để đếm thông báo)
     * @return DTO chứa dữ liệu đã được xử lý và định dạng JSON
     */
    MemberDashboardData getMemberDashboardData(int memberId, int userId) throws SQLException;
}
