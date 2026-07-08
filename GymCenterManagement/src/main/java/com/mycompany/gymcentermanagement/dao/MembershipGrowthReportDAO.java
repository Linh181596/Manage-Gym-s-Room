package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import java.sql.SQLException;
import java.util.List;

public interface MembershipGrowthReportDAO {
    List<Integer> getAvailableYears() throws SQLException;

    MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException;

    List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException;

    List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException;

    int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException;

    List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;

    List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException;
}
