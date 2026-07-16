/**
 * =========================================================================
 * @file          : InvoiceServiceImpl.java
 * @description   : Lop trien khai cac dich vu thanh toan hoa don, giao dich tien mat va lay lich su thanh toan
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
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
    public int getInvoicesCount() throws SQLException {
        return invoiceDAO.countAll();
    }

    @Override
    public List<Invoice> getInvoicesPaginated(int offset, int limit) throws SQLException {
        return invoiceDAO.findAllPaginated(offset, limit);
    }

    @Override
    public boolean recordCashPayment(int invoiceId, int staffUserId) throws SQLException {
        Connection conn = null;
        boolean success = false;
        
        try {
            conn = DBContext.getConnection();
            // Bắt đầu Transaction thủ công để đảm bảo tính toàn vẹn dữ liệu (ACID).
            conn.setAutoCommit(false);
            
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);
            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            
            // Lấy thông tin hóa đơn và kiểm tra trạng thái phải là Pending
            Invoice inv = invDAO.findById(invoiceId);
            if (inv == null) {
                throw new SQLException("Invoice not found.");
            }
            if (!"Pending".equals(inv.getStatus())) {
                throw new SQLException("Invoice is already processed (Status: " + inv.getStatus() + ").");
            }
            
            // Cập nhật hóa đơn thành Đã thanh toán (Paid)
            inv.setStatus("Paid");
            inv.setPaymentDate(LocalDateTime.now());
            inv.setProcessBy(staffUserId);
            inv.setUpdatedBy("StaffUserID: " + staffUserId);
            inv.setUpdatedDate(LocalDateTime.now());
            
            boolean updateInvoiceSuccess = invDAO.update(inv);
            if (!updateInvoiceSuccess) {
                throw new SQLException("Failed to update invoice status.");
            }
            
            // Kích hoạt gói tập tương ứng của thành viên (chuyển sang Active)
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

                // Tự động đóng gói của người gửi nếu đây là giao dịch chuyển nhượng (Transfer)
                if (inv.getCreatedBy() != null && inv.getCreatedBy().startsWith("Transfer;SenderPackageID:")) {
                    try {
                        String[] parts = inv.getCreatedBy().split(";");
                        int senderPkgId = -1;
                        for (String part : parts) {
                            if (part.startsWith("SenderPackageID:")) {
                                senderPkgId = Integer.parseInt(part.split(":")[1]);
                                break;
                            }
                        }
                        if (senderPkgId != -1) {
                            MemberPackage senderPkg = mpDAO.findById(senderPkgId);
                            if (senderPkg != null) {
                                senderPkg.setStatus("Expired");
                                senderPkg.setEndDate(java.time.LocalDate.now()); // Đặt EndDate về Hôm nay
                                senderPkg.setUpdatedBy("Transferred by StaffUserID: " + staffUserId);
                                senderPkg.setUpdatedDate(LocalDateTime.now());
                                mpDAO.update(senderPkg);
                            }
                        }
                    } catch (Exception e) {
                        System.err.println("Lỗi đóng gói người gửi khi xử lý chuyển nhượng: " + e.getMessage());
                        // Ghi log lỗi nhưng không rollback để tránh treo tiền khách hàng đã thanh toán
                    }
                }
            }
            
            // Commit toàn bộ giao dịch nếu các bước trên đều thành công
            conn.commit();
            success = true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    // Rollback lại trạng thái ban đầu nếu có lỗi, ngăn rác dữ liệu
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

    @Override
    public boolean recordOnlinePayment(int invoiceId) throws SQLException {
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
            inv.setPaymentMethod("Chuyển khoản VNPAY");
            inv.setPaymentDate(LocalDateTime.now());
            // No processBy for online payment or set it to 0
            inv.setUpdatedBy("System: VNPAY");
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
                mp.setUpdatedBy("System: VNPAY");
                mp.setUpdatedDate(LocalDateTime.now());
                
                boolean updatePackageSuccess = mpDAO.update(mp);
                if (!updatePackageSuccess) {
                    throw new SQLException("Failed to activate Member Package.");
                }

                // Tự động đóng gói của người gửi nếu đây là giao dịch chuyển nhượng (Transfer)
                if (inv.getCreatedBy() != null && inv.getCreatedBy().startsWith("Transfer;SenderPackageID:")) {
                    try {
                        String[] parts = inv.getCreatedBy().split(";");
                        int senderPkgId = -1;
                        for (String part : parts) {
                            if (part.startsWith("SenderPackageID:")) {
                                senderPkgId = Integer.parseInt(part.split(":")[1]);
                                break;
                            }
                        }
                        if (senderPkgId != -1) {
                            MemberPackage senderPkg = mpDAO.findById(senderPkgId);
                            if (senderPkg != null) {
                                senderPkg.setStatus("Expired");
                                senderPkg.setEndDate(java.time.LocalDate.now()); // Đặt EndDate về Hôm nay
                                senderPkg.setUpdatedBy("Transferred by System: VNPAY");
                                senderPkg.setUpdatedDate(LocalDateTime.now());
                                mpDAO.update(senderPkg);
                            }
                        }
                    } catch (Exception e) {
                        System.err.println("Lỗi đóng gói người gửi khi xử lý chuyển nhượng: " + e.getMessage());
                    }
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

    @Override
    public boolean cancelInvoice(int invoiceId, int staffUserId) throws SQLException {
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
            
            // 2. Update Invoice Status to Cancelled
            inv.setStatus("Cancelled");
            inv.setProcessBy(staffUserId);
            inv.setUpdatedBy("StaffUserID: " + staffUserId);
            inv.setUpdatedDate(LocalDateTime.now());
            
            boolean updateInvoiceSuccess = invDAO.update(inv);
            if (!updateInvoiceSuccess) {
                throw new SQLException("Failed to update invoice status.");
            }
            
            // 3. Mark Associated Member Package as Deleted
            if (inv.getMemberPackageId() != null) {
                boolean deletePackageSuccess = mpDAO.delete(inv.getMemberPackageId());
                if (!deletePackageSuccess) {
                    throw new SQLException("Failed to delete associated Member Package.");
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
