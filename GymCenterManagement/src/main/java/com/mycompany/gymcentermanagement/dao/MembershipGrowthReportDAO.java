/**
 * =========================================================================
 * @file          : MembershipGrowthReportDAO.java
 * @description   : DAO interface for Membership Growth Report
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import java.sql.SQLException;
import java.util.List;

public interface MembershipGrowthReportDAO {
    /**
     * Lấy các năm có dữ liệu hội viên từ database.
     */
    List<Integer> getAvailableYears() throws SQLException;

    /**
     * Lấy dữ liệu tổng quan hội viên theo năm hoặc tháng được chọn.
     */
    MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException;

    /**
     * Lấy dữ liệu biểu đồ tăng trưởng hội viên theo năm hoặc tháng.
     */
    List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException;

    /**
     * Lấy danh sách hội viên theo kỳ, trạng thái, từ khóa và phân trang.
     */
    List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException;

    /**
     * Đếm số hội viên theo cùng bộ lọc danh sách để tính phân trang.
     */
    int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException;

    /**
     * Lấy danh sách hội viên mới theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    /**
     * Lấy danh sách hội viên đang active theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    /**
     * Lấy danh sách hội viên đã hết hạn theo kỳ và từ khóa.
     */
    List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;
}
