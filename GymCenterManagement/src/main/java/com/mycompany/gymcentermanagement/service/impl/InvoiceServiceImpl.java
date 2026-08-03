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
import com.google.gson.JsonObject;

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

    /**
     * Xác nhận thanh toán hóa đơn bằng tiền mặt (Cash).
     * Luồng nghiệp vụ:
     * 1. Lấy thông tin hóa đơn, kiểm tra trạng thái Pending.
     * 2. [BR-CONS-35]: Chỉ Admin/Staff được quyền duyệt hóa đơn thanh toán tiền mặt. (Validate quyền ở Controller).
     * 3. Update trạng thái Invoice thành 'Paid', cập nhật PaymentMethod và Processor.
     * 4. Kích hoạt gói tập (MemberPackage) thành 'Active'.
     * 5. [Transaction]: Dùng Manual Transaction để đảm bảo tính toàn vẹn (Invoice và MemberPackage phải cùng được cập nhật hoặc cùng bị hủy).
     * 
     * @param invoiceId ID hóa đơn
     * @param staffUserId ID người duyệt
     * @return true nếu thành công
     * @throws SQLException 
     */
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
            
            // Kích hoạt/Cập nhật gói tập tương ứng của thành viên
            if (inv.getMemberPackageId() != null) {
                MemberPackage mp = mpDAO.findById(inv.getMemberPackageId());
                if (mp == null) {
                    throw new SQLException("Associated Member Package not found.");
                }
                
                JsonObject tData = null;
                if (inv.getTransactionData() != null && !inv.getTransactionData().trim().isEmpty()) {
                    try {
                        tData = com.google.gson.JsonParser.parseString(inv.getTransactionData()).getAsJsonObject();
                    } catch (Exception e) {
                        // Bỏ qua lỗi parse JSON, dùng fallback
                    }
                }
                
                String createdBy = inv.getCreatedBy() != null ? inv.getCreatedBy() : "";
                
                if ((tData != null && tData.has("action") && "transfer".equals(tData.get("action").getAsString())) || createdBy.startsWith("Transfer;")) {
                    // Xử lý Transfer
                    int senderPkgId = -1;
                    long transferDays = 0;
                    
                    if (tData != null && tData.has("action") && "transfer".equals(tData.get("action").getAsString())) {
                        senderPkgId = tData.get("senderPkgId").getAsInt();
                        if (tData.has("remainingDays")) {
                            transferDays = tData.get("remainingDays").getAsLong();
                        } else if (tData.has("transferMonths")) {
                            transferDays = tData.get("transferMonths").getAsInt() * 30L;
                        }
                    } else {
                        String[] parts = createdBy.split(";");
                        for (String part : parts) {
                            if (part.startsWith("SPkg:")) {
                                senderPkgId = Integer.parseInt(part.split(":")[1]);
                            } else if (part.startsWith("TMths:")) {
                                transferDays = Integer.parseInt(part.split(":")[1]) * 30L;
                            }
                        }
                    }
                    
                    if (senderPkgId != -1 && transferDays > 0) {
                        // 1. Trừ ngày của Sender (Chuyển thành Expired)
                        MemberPackage senderPkg = mpDAO.findById(senderPkgId);
                        if (senderPkg != null) {
                            senderPkg.setEndDate(java.time.LocalDate.now()); // Kết thúc ngay lập tức
                            senderPkg.setStatus("Expired");
                            senderPkg.setUpdatedBy("Transferred by StaffUserID: " + staffUserId);
                            senderPkg.setUpdatedDate(LocalDateTime.now());
                            mpDAO.update(senderPkg);
                        }
                        
                        // 2. Cộng ngày cho Receiver
                        java.time.LocalDate baseDate = mp.getEndDate();
                        if ("Pending".equals(mp.getStatus())) {
                            // Người nhận chưa có gói, gói Pending đã set EndDate sẵn lúc Transfer rồi.
                            mp.setStatus("Active");
                        } else {
                            // Người nhận đã có gói, cộng dồn
                            if ("Expired".equals(mp.getStatus()) || baseDate == null || baseDate.isBefore(java.time.LocalDate.now())) {
                                baseDate = java.time.LocalDate.now();
                            }
                            mp.setEndDate(baseDate.plusDays(transferDays));
                            mp.setStatus("Active");
                        }
                    }
                } else if ((tData != null && tData.has("action") && "renew".equals(tData.get("action").getAsString())) || createdBy.startsWith("Renew;")) {
                    // Xử lý Renew
                    int renewPackageId = mp.getPackageId(); // Fallback
                    
                    if (tData != null && tData.has("action") && "renew".equals(tData.get("action").getAsString())) {
                        renewPackageId = tData.get("packageId").getAsInt();
                    } else {
                        String[] parts = createdBy.split(";");
                        for (String part : parts) {
                            if (part.startsWith("PackageID:")) {
                                renewPackageId = Integer.parseInt(part.split(":")[1]);
                            }
                        }
                    }

                    com.mycompany.gymcentermanagement.dao.GymPackageDAO gpDAO = new com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl(conn);
                    com.mycompany.gymcentermanagement.model.entity.GymPackage gp = gpDAO.findById(renewPackageId);
                    if (gp != null) {
                        java.time.LocalDate baseDate = mp.getEndDate();
                        if ("Expired".equals(mp.getStatus()) || baseDate == null || baseDate.isBefore(java.time.LocalDate.now())) {
                            baseDate = java.time.LocalDate.now();
                        }
                        mp.setEndDate(baseDate.plusMonths(gp.getDurationMonths()));
                        mp.setPackageId(renewPackageId); // Cập nhật gói mới
                        mp.setStatus("Active");
                    }
                } else {
                    // Xử lý Register (New)
                    mp.setStatus("Active");
                }
                
                mp.setUpdatedBy("StaffUserID: " + staffUserId);
                mp.setUpdatedDate(LocalDateTime.now());
                
                boolean updatePackageSuccess = mpDAO.update(mp);
                if (!updatePackageSuccess) {
                    throw new SQLException("Failed to activate/update Member Package.");
                }
            }
            
            if (inv.getPtRegistrationId() != null) {
                String sql = "UPDATE PTRegistrations SET Status = 'Active', PaymentStatus = 'Paid', UpdatedBy = ?, UpdatedDate = GETDATE() WHERE PTRegistrationID = ?";
                try (java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, "StaffUserID: " + staffUserId);
                    ps.setInt(2, inv.getPtRegistrationId());
                    ps.executeUpdate();
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

    /**
     * Ghi nhận thanh toán hóa đơn trực tuyến (VNPay).
     * Luồng nghiệp vụ:
     * 1. Lấy hóa đơn, check trạng thái Pending.
     * 2. Update trạng thái Invoice thành 'Paid', cập nhật PaymentMethod là 'Chuyển khoản VNPAY'.
     * 3. Kích hoạt MemberPackage thành 'Active'.
     * 4. [Transaction]: Dùng Manual Transaction đảm bảo dữ liệu.
     * 
     * @param invoiceId ID hóa đơn
     * @return true nếu thành công
     * @throws SQLException 
     */
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
            
            inv.setStatus("Paid");
            inv.setPaymentMethod("VNPay");
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
                
                JsonObject tData = null;
                if (inv.getTransactionData() != null && !inv.getTransactionData().trim().isEmpty()) {
                    try {
                        tData = com.google.gson.JsonParser.parseString(inv.getTransactionData()).getAsJsonObject();
                    } catch (Exception e) {
                        // Bỏ qua lỗi parse JSON, dùng fallback
                    }
                }
                
                String createdBy = inv.getCreatedBy() != null ? inv.getCreatedBy() : "";
                
                if ((tData != null && tData.has("action") && "transfer".equals(tData.get("action").getAsString())) || createdBy.startsWith("Transfer;")) {
                    // Xử lý Transfer
                    int senderPkgId = -1;
                    long transferDays = 0;
                    
                    if (tData != null && tData.has("action") && "transfer".equals(tData.get("action").getAsString())) {
                        senderPkgId = tData.get("senderPkgId").getAsInt();
                        if (tData.has("remainingDays")) {
                            transferDays = tData.get("remainingDays").getAsLong();
                        } else if (tData.has("transferMonths")) {
                            transferDays = tData.get("transferMonths").getAsInt() * 30L;
                        }
                    } else {
                        String[] parts = createdBy.split(";");
                        for (String part : parts) {
                            if (part.startsWith("SPkg:")) {
                                senderPkgId = Integer.parseInt(part.split(":")[1]);
                            } else if (part.startsWith("TMths:")) {
                                transferDays = Integer.parseInt(part.split(":")[1]) * 30L;
                            }
                        }
                    }
                    
                    if (senderPkgId != -1 && transferDays > 0) {
                        // 1. Trừ ngày của Sender
                        MemberPackage senderPkg = mpDAO.findById(senderPkgId);
                        if (senderPkg != null) {
                            senderPkg.setEndDate(java.time.LocalDate.now());
                            senderPkg.setStatus("Expired");
                            senderPkg.setUpdatedBy("Transferred by System: VNPAY");
                            senderPkg.setUpdatedDate(LocalDateTime.now());
                            mpDAO.update(senderPkg);
                        }
                        
                        // 2. Cộng ngày cho Receiver
                        java.time.LocalDate baseDate = mp.getEndDate();
                        if ("Pending".equals(mp.getStatus())) {
                            mp.setStatus("Active");
                        } else {
                            if ("Expired".equals(mp.getStatus()) || baseDate == null || baseDate.isBefore(java.time.LocalDate.now())) {
                                baseDate = java.time.LocalDate.now();
                            }
                            mp.setEndDate(baseDate.plusDays(transferDays));
                            mp.setStatus("Active");
                        }
                    }
                } else if ((tData != null && tData.has("action") && "renew".equals(tData.get("action").getAsString())) || createdBy.startsWith("Renew;")) {
                    // Xử lý Renew
                    int renewPackageId = mp.getPackageId(); // Fallback
                    
                    if (tData != null && tData.has("action") && "renew".equals(tData.get("action").getAsString())) {
                        renewPackageId = tData.get("packageId").getAsInt();
                    } else {
                        String[] parts = createdBy.split(";");
                        for (String part : parts) {
                            if (part.startsWith("PackageID:")) {
                                renewPackageId = Integer.parseInt(part.split(":")[1]);
                            }
                        }
                    }

                    com.mycompany.gymcentermanagement.dao.GymPackageDAO gpDAO = new com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl(conn);
                    com.mycompany.gymcentermanagement.model.entity.GymPackage gp = gpDAO.findById(renewPackageId);
                    if (gp != null) {
                        java.time.LocalDate baseDate = mp.getEndDate();
                        if ("Expired".equals(mp.getStatus()) || baseDate == null || baseDate.isBefore(java.time.LocalDate.now())) {
                            baseDate = java.time.LocalDate.now();
                        }
                        mp.setEndDate(baseDate.plusMonths(gp.getDurationMonths()));
                        mp.setPackageId(renewPackageId); // Cập nhật gói mới
                        mp.setStatus("Active");
                    }
                } else {
                    // Xử lý Register (New)
                    mp.setStatus("Active");
                }
                
                mp.setUpdatedBy("System: VNPAY");
                mp.setUpdatedDate(LocalDateTime.now());
                
                boolean updatePackageSuccess = mpDAO.update(mp);
                if (!updatePackageSuccess) {
                    throw new SQLException("Failed to activate/update Member Package.");
                }
            }
            
            if (inv.getPtRegistrationId() != null) {
                String sql = "UPDATE PTRegistrations SET Status = 'Active', PaymentStatus = 'Paid', UpdatedBy = ?, UpdatedDate = GETDATE() WHERE PTRegistrationID = ?";
                try (java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, "System: VNPAY");
                    ps.setInt(2, inv.getPtRegistrationId());
                    ps.executeUpdate();
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
            
            // 4. Cancel PT Registration if associated
            if (inv.getPtRegistrationId() != null) {
                String sql = "UPDATE PTRegistrations SET Status = 'Cancelled', UpdatedBy = ?, UpdatedDate = GETDATE() WHERE PTRegistrationID = ?";
                try (java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, "StaffUserID: " + staffUserId);
                    ps.setInt(2, inv.getPtRegistrationId());
                    ps.executeUpdate();
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
    public Invoice getOrCreateInvoiceForPTRegistration(int ptRegId, int staffUserId) throws SQLException {
        InvoiceDAO invDAO = new InvoiceDAOImpl();
        Invoice existingInvoice = invDAO.findByPtRegistrationId(ptRegId);
        if (existingInvoice != null) {
            return existingInvoice;
        }

        // We need to fetch PTRegistration to get details
        com.mycompany.gymcentermanagement.dao.PTRegistrationDAO ptDAO = new com.mycompany.gymcentermanagement.dao.impl.PTRegistrationDAOImpl();
        com.mycompany.gymcentermanagement.dto.PTRegistrationDTO regDTO = ptDAO.getRegistrationById(ptRegId);
        
        if (regDTO == null) {
            throw new SQLException("PT Registration not found.");
        }

        Invoice newInvoice = new Invoice();
        newInvoice.setMemberId(regDTO.getMemberId());
        newInvoice.setPtRegistrationId(ptRegId);
        newInvoice.setAmount(java.math.BigDecimal.valueOf(regDTO.getTotalAmount()));
        newInvoice.setPaymentMethod("Cash");
        newInvoice.setStatus("Pending");
        newInvoice.setProcessBy(staffUserId);
        newInvoice.setCreatedBy("StaffUserID: " + staffUserId);
        
        boolean inserted = invDAO.insert(newInvoice);
        if (inserted) {
            return invDAO.findByPtRegistrationId(ptRegId);
        }
        
        throw new SQLException("Failed to create Invoice for PT Registration.");
    }
}
