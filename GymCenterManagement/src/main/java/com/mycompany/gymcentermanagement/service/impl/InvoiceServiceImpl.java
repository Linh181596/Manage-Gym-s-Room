package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.InvoiceDAO;
import com.mycompany.gymcentermanagement.dao.MemberPackageDAO;
import com.mycompany.gymcentermanagement.dao.impl.InvoiceDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.MemberPackageDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.service.InvoiceService;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class InvoiceServiceImpl implements InvoiceService {

    private final InvoiceDAO invoiceDAO = new InvoiceDAOImpl();

    @Override
    public Invoice getInvoiceById(int id) throws SQLException {
        return invoiceDAO.findById(id);
    }

    @Override
    public List<Invoice> getAllInvoices() throws SQLException {
        return invoiceDAO.findAll();
    }

    @Override
    public boolean recordCashPayment(int invoiceId, int staffUserId) throws SQLException {
        Connection conn = null;
        boolean success = false;
        
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);
            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            
            // 1. Fetch Invoice
            Invoice inv = invDAO.findById(invoiceId);
            if (inv == null) {
                throw new SQLException("Invoice not found.");
            }
            if (!"Pending".equals(inv.getStatus())) {
                throw new SQLException("Invoice is already processed (Status: " + inv.getStatus() + ").");
            }
            
            // 2. Update Invoice Status to Paid
            inv.setStatus("Paid");
            inv.setPaymentDate(LocalDateTime.now());
            inv.setProcessBy(staffUserId);
            inv.setUpdatedBy("StaffUserID: " + staffUserId);
            inv.setUpdatedDate(LocalDateTime.now());
            
            boolean updateInvoiceSuccess = invDAO.update(inv);
            if (!updateInvoiceSuccess) {
                throw new SQLException("Failed to update invoice status.");
            }
            
            // 3. Activate Member Package if associated
            if (inv.getMemberPackageId() != null) {
                MemberPackage mp = mpDAO.findById(inv.getMemberPackageId());
                if (mp == null) {
                    throw new SQLException("Associated Member Package not found.");
                }
                mp.setStatus("Active");
                mp.setUpdatedBy("StaffUserID: " + staffUserId);
                mp.setUpdatedDate(LocalDateTime.now());
                
                boolean updatePackageSuccess = mpDAO.update(mp);
                if (!updatePackageSuccess) {
                    throw new SQLException("Failed to activate Member Package.");
                }
            }
            
            conn.commit();
            success = true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    // Ignore
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    // Ignore
                }
            }
        }
        
        return success;
    }
}
