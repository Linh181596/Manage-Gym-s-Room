/**
 * =========================================================================
 * @file          : RevenuePoint.java
 * @description   : DTO lưu một điểm dữ liệu doanh thu theo ngày cho biểu đồ doanh thu.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * DTO biểu diễn một điểm dữ liệu (tọa độ) duy nhất trên biểu đồ doanh thu.
 * Trục X là ngày (revenueDate), trục Y là tổng tiền thu được trong ngày đó (amount).
 */
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
