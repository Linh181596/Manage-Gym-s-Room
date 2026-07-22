/**
 * =========================================================================
 * @file          : MembershipGrowthSummary.java
 * @description   : DTO for summary statistics
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.dto;

import java.util.Locale;

public class MembershipGrowthSummary {
    private int newMembers;
    private int activeMembers;
    private int expiredMembers;
    private int previousPeriodNewMembers;
    private Double growthRate;

    public MembershipGrowthSummary() {
    }

    public int getNewMembers() {
        return newMembers;
    }

    public void setNewMembers(int newMembers) {
        this.newMembers = newMembers;
    }

    public int getActiveMembers() {
        return activeMembers;
    }

    public void setActiveMembers(int activeMembers) {
        this.activeMembers = activeMembers;
    }

    public int getExpiredMembers() {
        return expiredMembers;
    }

    public void setExpiredMembers(int expiredMembers) {
        this.expiredMembers = expiredMembers;
    }

    public int getPreviousPeriodNewMembers() {
        return previousPeriodNewMembers;
    }

    public void setPreviousPeriodNewMembers(int previousPeriodNewMembers) {
        this.previousPeriodNewMembers = previousPeriodNewMembers;
    }

    public Double getGrowthRate() {
        return growthRate;
    }

    public void setGrowthRate(Double growthRate) {
        this.growthRate = growthRate;
    }

    public boolean isGrowthRateAvailable() {
        return growthRate != null;
    }

    public String getGrowthRateText() {
        if (growthRate == null) {
            return "N/A";
        }
        return String.format(Locale.US, "%.1f%%", growthRate);
    }
}
