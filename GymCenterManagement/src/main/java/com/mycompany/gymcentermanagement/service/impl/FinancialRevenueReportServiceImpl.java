/**
 * =========================================================================
 * @file          : FinancialRevenueReportServiceImpl.java
 * @description   : Lớp triển khai dịch vụ xử lý báo cáo doanh thu
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-15
 * @last_modified : 2026-06-20
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.FinancialRevenueReportDAO;
import com.mycompany.gymcentermanagement.dao.impl.FinancialRevenueReportDAOImpl;
import com.mycompany.gymcentermanagement.dto.DashboardInvoice;
import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.dto.RevenuePoint;
import com.mycompany.gymcentermanagement.service.FinancialRevenueReportService;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FinancialRevenueReportServiceImpl implements FinancialRevenueReportService {
    private final FinancialRevenueReportDAO reportDAO = new FinancialRevenueReportDAOImpl();

    /**
     * Tổng hợp dữ liệu báo cáo doanh thu.
     * Luồng nghiệp vụ:
     * 1. Lấy dữ liệu tổng quan.
     * 2. Ước tính chi phí vận hành (giả lập 20%).
     * 3. Lấy xu hướng doanh thu và xử lý ngày thiếu (zero-filling).
     * 
     * @param filter Bộ lọc
     * @return Dữ liệu báo cáo tổng hợp
     * @throws SQLException 
     */
    @Override
    public FinancialRevenueReportData getReportData(RevenueChartFilter filter) throws SQLException {
        FinancialRevenueReportData data = new FinancialRevenueReportData();
        data.setRevenueFilter(filter);

        // 1. Lấy dữ liệu tổng quan
        reportDAO.populateRevenueSummary(data, filter.getFromDateValue(), filter.getToDateValue(), filter.getRevenueType());

        // 2. Tính toán chi phí & lợi nhuận
        // TODO: Hiện tại chưa có bảng Expenses, giả lập chi phí vận hành bằng 20% doanh thu
        BigDecimal cost = data.getTotalRevenue().multiply(new BigDecimal("0.20"));
        data.setOperationalCost(cost);
        data.setProfit(data.getTotalRevenue().subtract(cost));

        // 3. Lấy dữ liệu biểu đồ
        List<RevenuePoint> trend = reportDAO.getRevenueTrend(filter);
        data.setRevenueTrend(trend);
        
        // 4. Xử lý thiếu ngày (để biểu đồ không bị gãy đoạn)
        processMissingDays(data, filter.getFromDateValue(), filter.getToDateValue());

        // 5. Build JSON cho biểu đồ
        buildChartJson(data);

        // 6. Lấy hóa đơn gần đây
        List<DashboardInvoice> invoices = reportDAO.getFilteredInvoices(filter.getFromDateValue(), filter.getToDateValue(), filter.getRevenueType(), 100);
        data.setRecentInvoices(invoices);

        return data;
    }

    /**
     * Lấy danh sách hóa đơn theo bộ lọc.
     * Luồng nghiệp vụ: Lấy hóa đơn để hiển thị danh sách trong màn hình Dashboard.
     * 
     * @param filter Bộ lọc
     * @param limit Giới hạn số lượng
     * @return Danh sách hóa đơn
     * @throws SQLException 
     */
    @Override
    public List<DashboardInvoice> getFilteredInvoices(RevenueChartFilter filter, int limit) throws SQLException {
        return reportDAO.getFilteredInvoices(filter.getFromDateValue(), filter.getToDateValue(), filter.getRevenueType(), limit);
    }

    private void processMissingDays(FinancialRevenueReportData data, String fromDateStr, String toDateStr) {
        if (!RevenueChartFilter.GROUP_DAY.equals(data.getRevenueFilter().getGroupBy())) {
            return;
        }

        LocalDate fromDate = LocalDate.parse(fromDateStr);
        LocalDate toDate = LocalDate.parse(toDateStr);
        List<RevenuePoint> dbPoints = data.getRevenueTrend();
        List<RevenuePoint> fullPoints = new ArrayList<>();

        int dbIndex = 0;
        for (LocalDate date = fromDate; !date.isAfter(toDate); date = date.plusDays(1)) {
            if (dbIndex < dbPoints.size() && dbPoints.get(dbIndex).getRevenueDate().equals(date)) {
                fullPoints.add(dbPoints.get(dbIndex));
                dbIndex++;
            } else {
                fullPoints.add(new RevenuePoint(date, BigDecimal.ZERO));
            }
        }
        data.setRevenueTrend(fullPoints);
    }

    private void buildChartJson(FinancialRevenueReportData data) {
        List<String> labels = new ArrayList<>();
        List<BigDecimal> values = new ArrayList<>();
        DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("dd/MM");
        DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("MM/yyyy");

        String groupBy = data.getRevenueFilter().getGroupBy();

        for (RevenuePoint point : data.getRevenueTrend()) {
            if (point.getRevenueDate() != null) {
                if (RevenueChartFilter.GROUP_MONTH.equals(groupBy)) {
                    labels.add("\"" + escapeJson(point.getRevenueDate().format(monthFormatter)) + "\"");
                } else {
                    labels.add("\"" + escapeJson(point.getRevenueDate().format(dayFormatter)) + "\"");
                }
            } else {
                labels.add("\"Unknown\"");
            }
            values.add(point.getAmount());
        }

        String labelsJson = "[" + String.join(",", labels) + "]";
        
        List<String> valueStrings = new ArrayList<>();
        for (BigDecimal val : values) {
            valueStrings.add(String.valueOf(val));
        }
        String valuesJson = "[" + String.join(",", valueStrings) + "]";

        data.setRevenueChartLabelsJson(labelsJson);
        data.setRevenueChartValuesJson(valuesJson);
    }
    
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
