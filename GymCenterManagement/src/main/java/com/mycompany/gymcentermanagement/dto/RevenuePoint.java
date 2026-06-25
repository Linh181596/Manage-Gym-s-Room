/**
 * =========================================================================
 * @file          : RevenuePoint.java
 * @description   : DTO lưu một điểm dữ liệu doanh thu theo ngày cho biểu đồ doanh thu.
 * @author        : Codex
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class RevenuePoint {
    private LocalDate revenueDate;
    private BigDecimal amount = BigDecimal.ZERO;

    public RevenuePoint() {
    }

    public RevenuePoint(LocalDate revenueDate, BigDecimal amount) {
        this.revenueDate = revenueDate;
        this.amount = amount != null ? amount : BigDecimal.ZERO;
    }

    public LocalDate getRevenueDate() {
        return revenueDate;
    }

    public void setRevenueDate(LocalDate revenueDate) {
        this.revenueDate = revenueDate;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount != null ? amount : BigDecimal.ZERO;
    }
}
