package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Invoice;
import java.sql.SQLException;
import java.util.List;

public interface InvoiceService {
    Invoice getInvoiceById(int id) throws SQLException;
    List<Invoice> getAllInvoices() throws SQLException;
    boolean recordCashPayment(int invoiceId, int staffUserId) throws SQLException;
}
