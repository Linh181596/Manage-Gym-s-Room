/**
 * =========================================================================
 * @file          : MembershipGrowthChartPoint.java
 * @description   : DTO for chart data points
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

public class MembershipGrowthChartPoint {
    private int periodNumber;
    private String label;
    private int memberCount;

    public MembershipGrowthChartPoint() {
    }

    public MembershipGrowthChartPoint(int periodNumber, String label, int memberCount) {
        this.periodNumber = periodNumber;
        this.label = label;
        this.memberCount = memberCount;
    }

    public int getPeriodNumber() {
        return periodNumber;
    }

    public void setPeriodNumber(int periodNumber) {
        this.periodNumber = periodNumber;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getMemberCount() {
        return memberCount;
    }

    public void setMemberCount(int memberCount) {
        this.memberCount = memberCount;
    }
}
