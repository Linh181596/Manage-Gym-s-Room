/**
 * =========================================================================
 * @file          : InvoiceDAO.java
 * @description   : Interface định nghĩa các thao tác dữ liệu với thực thể Invoice
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.Invoice;
import java.sql.SQLException;
import java.util.List;

public interface InvoiceDAO {
    Invoice findById(int invoiceId) throws SQLException;
    boolean insert(Invoice inv) throws SQLException;
    boolean update(Invoice inv) throws SQLException;
    List<Invoice> findAll() throws SQLException;
    int countAll() throws SQLException;
    List<Invoice> findAllPaginated(int offset, int limit) throws SQLException;
}
