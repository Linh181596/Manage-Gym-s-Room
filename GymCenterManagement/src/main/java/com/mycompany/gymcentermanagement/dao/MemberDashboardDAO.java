/**
 * =========================================================================
 * @file          : MemberDashboardDAO.java
 * @description   : Interface định nghĩa các truy vấn dữ liệu cho dashboard hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MemberDashboardDAO {
    /**
     * Đếm số lượng lịch hẹn tập sắp tới (trạng thái 'Upcoming') của hội viên.
     */
    int countUpcomingAppointments(int memberId) throws SQLException;

    /**
     * Lấy thông tin gói tập đang hoạt động cuối cùng của hội viên.
     * Trả về map gồm: "packageName" và "endDate".
     */
    Map<String, Object> getActivePackageInfo(int memberId) throws SQLException;

    /**
     * Tính tổng chi tiêu đã thanh toán trong tháng hiện tại của hội viên.
     */
    BigDecimal getSpendThisMonth(int memberId) throws SQLException;

    /**
     * Đếm số lượng thông báo chưa đọc (tổng số thông báo gửi cho Member hoặc All).
     */
    int countNotifications(int userId) throws SQLException;

    /**
     * Lấy xu hướng chi tiêu hàng tháng của hội viên trong số tháng được chỉ định.
     */
    List<RevenuePoint> getMonthlySpendTrend(int memberId, int months) throws SQLException;

    /**
     * Lấy danh sách các buổi tập sắp tới của hội viên.
     */
    List<Map<String, Object>> getUpcomingSessions(int memberId, int limit) throws SQLException;

    /**
     * Lấy danh sách hóa đơn gần đây của hội viên.
     */
    List<DashboardInvoice> getRecentInvoices(int memberId, int limit) throws SQLException;
}
