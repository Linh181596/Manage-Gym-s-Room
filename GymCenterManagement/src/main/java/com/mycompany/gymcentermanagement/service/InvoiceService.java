/**
 * =========================================================================
 * @file          : InvoiceService.java
 * @description   : Interface dinh nghia cac dich vu thanh toan hoa don va xem lich su giao dich
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Invoice;
import java.sql.SQLException;
import java.util.List;

public interface InvoiceService {
    Invoice getInvoiceById(int id) throws SQLException;
    List<Invoice> getAllInvoices() throws SQLException;
    boolean recordCashPayment(int invoiceId, int staffUserId) throws SQLException;
}
