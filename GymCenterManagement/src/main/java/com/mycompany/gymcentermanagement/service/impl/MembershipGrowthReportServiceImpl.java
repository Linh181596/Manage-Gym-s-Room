/**
 * =========================================================================
 * @file          : MembershipGrowthReportServiceImpl.java
 * @description   : Implementation of MembershipGrowthReportService
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.MembershipGrowthReportDAO;
import com.mycompany.gymcentermanagement.dao.impl.MembershipGrowthReportDAOImpl;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import com.mycompany.gymcentermanagement.service.MembershipGrowthReportService;
import java.sql.SQLException;
import java.util.List;

public class MembershipGrowthReportServiceImpl implements MembershipGrowthReportService {

    private final MembershipGrowthReportDAO reportDAO = new MembershipGrowthReportDAOImpl();

    /**
     * Lấy danh sách năm có dữ liệu hội viên để tạo bộ lọc năm.
     */
    @Override
    public List<Integer> getAvailableYears() throws SQLException {
        return reportDAO.getAvailableYears();
    }

    /**
     * Lấy số liệu tổng quan hội viên theo năm hoặc tháng được chọn.
     */
    @Override
    public MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException {
        return reportDAO.getSummary(year, month);
    }

    /**
     * Lấy dữ liệu biểu đồ tăng trưởng theo tháng trong năm hoặc theo ngày trong
     * tháng.
     */
    @Override
    public List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException {
        return reportDAO.getGrowthChart(year, month);
    }

    /**
     * Lấy danh sách hội viên theo kỳ, trạng thái, từ khóa và phân trang.
     */
    @Override
    public List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException {
        return reportDAO.getMemberGrowthList(year, month, status, searchKeyword, offset, limit);
    }

    /**
     * Đếm số hội viên theo kỳ, trạng thái và từ khóa để tính phân trang.
     */
    @Override
    public int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException {
        return reportDAO.countMembers(year, month, status, searchKeyword);
    }

    /**
     * Lấy danh sách hội viên mới theo kỳ và từ khóa.
     */
    @Override
    public List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getNewMembers(year, month, searchKeyword, offset, limit);
    }

    /**
     * Lấy danh sách hội viên đang còn gói tập hiệu lực theo kỳ và từ khóa.
     */
    @Override
    public List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getActiveMembers(year, month, searchKeyword, offset, limit);
    }

    /**
     * Lấy danh sách hội viên đã hết hạn gói tập theo kỳ và từ khóa.
     */
    @Override
    public List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getExpiredMembers(year, month, searchKeyword, offset, limit);
    }
}
