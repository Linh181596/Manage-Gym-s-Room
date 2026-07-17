package com.mycompany.gymcentermanagement.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class FinancialRevenueReportData {
    private BigDecimal totalRevenue = BigDecimal.ZERO;
    private BigDecimal gymPackageRevenue = BigDecimal.ZERO;
    private BigDecimal ptRevenue = BigDecimal.ZERO;
    
    private int paidInvoicesCount = 0;
    private int unpaidInvoicesCount = 0;
    
    // Giả lập chi phí vận hành
    private BigDecimal operationalCost = BigDecimal.ZERO;
    private BigDecimal profit = BigDecimal.ZERO;

    private List<RevenuePoint> revenueTrend = new ArrayList<>();
    private List<DashboardInvoice> recentInvoices = new ArrayList<>();
    private RevenueChartFilter revenueFilter;
    
    private String revenueChartLabelsJson = "[]";
    private String revenueChartValuesJson = "[]";

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public BigDecimal getGymPackageRevenue() {
        return gymPackageRevenue;
    }

    public void setGymPackageRevenue(BigDecimal gymPackageRevenue) {
        this.gymPackageRevenue = gymPackageRevenue;
    }

    public BigDecimal getPtRevenue() {
        return ptRevenue;
    }

    public void setPtRevenue(BigDecimal ptRevenue) {
        this.ptRevenue = ptRevenue;
    }

    public int getPaidInvoicesCount() {
        return paidInvoicesCount;
    }

    public void setPaidInvoicesCount(int paidInvoicesCount) {
        this.paidInvoicesCount = paidInvoicesCount;
    }

    public int getUnpaidInvoicesCount() {
        return unpaidInvoicesCount;
    }

    public void setUnpaidInvoicesCount(int unpaidInvoicesCount) {
        this.unpaidInvoicesCount = unpaidInvoicesCount;
    }

    public BigDecimal getOperationalCost() {
        return operationalCost;
    }

    public void setOperationalCost(BigDecimal operationalCost) {
        this.operationalCost = operationalCost;
    }

    public BigDecimal getProfit() {
        return profit;
    }

    public void setProfit(BigDecimal profit) {
        this.profit = profit;
    }

    public List<RevenuePoint> getRevenueTrend() {
        return revenueTrend;
    }

    public void setRevenueTrend(List<RevenuePoint> revenueTrend) {
        this.revenueTrend = revenueTrend;
    }

    public List<DashboardInvoice> getRecentInvoices() {
        return recentInvoices;
    }

    public void setRecentInvoices(List<DashboardInvoice> recentInvoices) {
        this.recentInvoices = recentInvoices;
    }

    public RevenueChartFilter getRevenueFilter() {
        return revenueFilter;
    }

    public void setRevenueFilter(RevenueChartFilter revenueFilter) {
        this.revenueFilter = revenueFilter;
    }

    public String getRevenueChartLabelsJson() {
        return revenueChartLabelsJson;
    }

    public void setRevenueChartLabelsJson(String revenueChartLabelsJson) {
        this.revenueChartLabelsJson = revenueChartLabelsJson;
    }

    public String getRevenueChartValuesJson() {
        return revenueChartValuesJson;
    }

    public void setRevenueChartValuesJson(String revenueChartValuesJson) {
        this.revenueChartValuesJson = revenueChartValuesJson;
    }
}
