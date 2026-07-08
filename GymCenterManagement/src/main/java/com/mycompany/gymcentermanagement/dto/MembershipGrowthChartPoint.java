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
