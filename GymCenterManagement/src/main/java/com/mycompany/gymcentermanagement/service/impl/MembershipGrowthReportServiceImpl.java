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

    @Override
    public List<Integer> getAvailableYears() throws SQLException {
        return reportDAO.getAvailableYears();
    }

    @Override
    public MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException {
        return reportDAO.getSummary(year, month);
    }

    @Override
    public List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException {
        return reportDAO.getGrowthChart(year, month);
    }

    @Override
    public List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException {
        return reportDAO.getMemberGrowthList(year, month, status, searchKeyword, offset, limit);
    }

    @Override
    public int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException {
        return reportDAO.countMembers(year, month, status, searchKeyword);
    }

    @Override
    public List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getNewMembers(year, month, searchKeyword, offset, limit);
    }

    @Override
    public List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getActiveMembers(year, month, searchKeyword, offset, limit);
    }

    @Override
    public List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getExpiredMembers(year, month, searchKeyword, offset, limit);
    }
}
