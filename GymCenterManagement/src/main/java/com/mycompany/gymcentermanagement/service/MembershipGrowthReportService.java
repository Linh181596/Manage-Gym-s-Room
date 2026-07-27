/**
 * =========================================================================
 * @file          : MembershipGrowthReportService.java
 * @description   : Service interface for Membership Growth Report business logic
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import java.sql.SQLException;
import java.util.List;

public interface MembershipGrowthReportService {
    /**
     * Lấy danh sách năm có dữ liệu hội viên để tạo bộ lọc năm.
     */
    List<Integer> getAvailableYears() throws SQLException;

    /**
     * Lấy số liệu tổng quan về hội viên mới, active, hết hạn và tỷ lệ tăng
     * trưởng theo kỳ được chọn.
     */
    MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException;

    /**
     * Lấy dữ liệu biểu đồ tăng trưởng theo tháng trong năm hoặc theo ngày trong
     * tháng.
     */
    List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException;

    /**
     * Lấy danh sách hội viên theo kỳ, trạng thái, từ khóa và phân trang.
     */
    List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException;

    /**
     * Đếm số hội viên theo kỳ, trạng thái và từ khóa để tính phân trang.
     */
    int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException;

    /**
     * Lấy danh sách hội viên mới theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    /**
     * Lấy danh sách hội viên đang còn gói tập hiệu lực theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    /**
     * Lấy danh sách hội viên đã hết hạn gói tập theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;
}
