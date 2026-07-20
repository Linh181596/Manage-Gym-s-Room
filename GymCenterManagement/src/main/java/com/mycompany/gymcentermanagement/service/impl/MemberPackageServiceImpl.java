/**
 * =========================================================================
 * @file          : MemberPackageServiceImpl.java
 * @description   : Lop trien khai cac dich vu nghiep vu cho MemberPackage (dang ky package moi & luu transaction)
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.MemberPackageDAO;
import com.mycompany.gymcentermanagement.dao.InvoiceDAO;
import com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.MemberPackageDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.InvoiceDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.service.MemberPackageService;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class MemberPackageServiceImpl implements MemberPackageService {

    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    public List<Member> getActiveMembers() throws SQLException {
        return memberDAO.findAllActive();
    }

    @Override
    public Invoice registerMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException {
        Connection conn = null;
        Invoice pendingInvoice = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Instantiates DAOs with the shared transaction connection
            GymPackageDAO gpDAO = new GymPackageDAOImpl(conn);
            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);

            // Lấy thông tin Gói tập và kiểm tra xem có đang Active không
            GymPackage gp = gpDAO.findById(packageId);
            if (gp == null || !"Active".equals(gp.getStatus())) {
                throw new SQLException("Gym package not found or is inactive.");
            }

            // Validate: Không cho phép tạo nhiều hóa đơn chờ (Pending) cho bất kỳ loại gói
            // nào
            String checkPendingSql = "SELECT TOP 1 1 FROM MemberPackages WHERE MemberID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, memberId);
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Khách hàng đang có một thủ tục chờ thanh toán. Vui lòng thanh toán hoặc hủy thủ tục cũ trước khi tạo giao dịch mới.");
                    }
                }
            }

            // Kỹ thuật nối ngày (Concatenate Dates).
            // Tự động cộng dồn thời hạn nếu hội viên đang có gói Active
            LocalDate startDate = LocalDate.now();
            String checkActiveSql = "SELECT TOP 1 EndDate FROM MemberPackages WHERE MemberID = ? AND Status = 'Active' AND IsDeleted = 0 ORDER BY EndDate DESC";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkActiveSql)) {
                checkStmt.setInt(1, memberId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        java.sql.Date activeEndDate = rs.getDate("EndDate");
                        if (activeEndDate != null) {
                            LocalDate latestEndDate = activeEndDate.toLocalDate();
                            // If latest active package expires in the future, start the new one the day
                            // after
                            if (latestEndDate.isAfter(LocalDate.now()) || latestEndDate.isEqual(LocalDate.now())) {
                                startDate = latestEndDate.plusDays(1);
                            }
                        }
                    }
                }
            }

            LocalDate endDate = startDate.plusMonths(gp.getDurationMonths());

            // Khởi tạo gói tập của hội viên ở trạng thái Pending (Chờ thanh toán)
            MemberPackage mp = new MemberPackage();
            mp.setMemberId(memberId);
            mp.setPackageId(packageId);
            mp.setStartDate(startDate);
            mp.setEndDate(endDate);
            mp.setStatus("Pending");
            mp.setCreatedBy("StaffUserID: " + staffUserId);
            mp.setCreatedDate(LocalDateTime.now());

            boolean insertPackageSuccess = mpDAO.insert(mp);
            if (!insertPackageSuccess) {
                throw new SQLException("Failed to create Member Package record.");
            }

            // Tạo hóa đơn thanh toán tương ứng cho gói tập này
            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(memberId);
            pendingInvoice.setProcessBy(staffUserId);
            pendingInvoice.setMemberPackageId(mp.getMemberPackageId());
            pendingInvoice.setAmount(gp.getPrice());
            pendingInvoice.setPaymentMethod("Cash");
            pendingInvoice.setStatus("Pending");
            pendingInvoice.setCreatedBy("StaffUserID: " + staffUserId);
            pendingInvoice.setCreatedDate(LocalDateTime.now());

            boolean insertInvoiceSuccess = invDAO.insert(pendingInvoice);
            if (!insertInvoiceSuccess) {
                throw new SQLException("Failed to create invoice.");
            }

            // Giao dịch thành công, lưu toàn bộ dữ liệu (Commit)
            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    // Hoàn tác toàn bộ nếu có bất kỳ lỗi nào, tránh sinh rác dữ liệu
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

        return pendingInvoice;
    }

    @Override
    public MemberPackage getActivePackageByMemberId(int memberId) throws SQLException {
        MemberPackageDAO mpDAO = new MemberPackageDAOImpl();
        return mpDAO.findActiveByMemberId(memberId);
    }

    @Override
    public java.util.List<MemberPackage> findAllActivePackagesByMemberId(int memberId) throws SQLException {
        MemberPackageDAO mpDAO = new MemberPackageDAOImpl();
        return mpDAO.findAllActiveByMemberId(memberId);
    }

    @Override
    public Invoice renewMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException {
        return registerMemberPackage(memberId, packageId, staffUserId);
    }

    @Override
    public Invoice transferMemberPackage(int senderPkgId, int receiverMemberId, double transferFee, int staffUserId,
            String note) throws SQLException {
        Connection conn = null;
        Invoice pendingInvoice = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);

            // Lấy cụ thể gói tập Active được chọn của người gửi
            MemberPackage senderPackage = mpDAO.findById(senderPkgId);
            if (senderPackage == null) {
                throw new SQLException("Không tìm thấy gói tập được chọn để chuyển nhượng.");
            }
            if (!"Active".equals(senderPackage.getStatus())) {
                throw new SQLException("Gói tập được chọn không trong trạng thái hoạt động.");
            }

            // Tính số ngày tập còn lại của người gửi cho gói tập này

            LocalDate today = LocalDate.now();
            LocalDate effectiveStartDate = senderPackage.getStartDate().isAfter(today) ? senderPackage.getStartDate()
                    : today;
            long remainingDays = java.time.temporal.ChronoUnit.DAYS.between(effectiveStartDate,
                    senderPackage.getEndDate());
            if (remainingDays < 1) {
                throw new SQLException(
                        "Gói tập không đủ điều kiện chuyển nhượng (Thời hạn sử dụng còn lại phải tối thiểu 1 ngày).");
            }

            // Validate: Không cho phép tạo nhiều hóa đơn chuyển nhượng (Pending) chồng chéo
            // cho cùng 1 gói tập
            String checkPendingTransferSql = "SELECT TOP 1 1 FROM Invoices WHERE CreatedBy LIKE ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingTransferSql)) {
                checkPendingStmt.setString(1, "Transfer;SenderPackageID:" + senderPackage.getMemberPackageId() + ";%");
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Gói tập này đang có một thủ tục chuyển nhượng chờ thanh toán. Vui lòng thanh toán hoặc hủy thủ tục cũ trước khi tạo mới.");
                    }
                }
            }

            // Validate: Không cho phép người nhận nhận chuyển nhượng nếu đang có gói chờ
            // thanh toán
            String checkReceiverPendingSql = "SELECT TOP 1 1 FROM MemberPackages WHERE MemberID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkReceiverStmt = conn.prepareStatement(checkReceiverPendingSql)) {
                checkReceiverStmt.setInt(1, receiverMemberId);
                try (ResultSet rs = checkReceiverStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Người nhận đang có một thủ tục gói tập chờ thanh toán. Vui lòng yêu cầu họ thanh toán hoặc hủy thủ tục cũ trước khi nhận chuyển nhượng.");
                    }
                }
            }

            // Tính ngày bắt đầu cho người nhận (nối tiếp nếu người nhận đã có gói đang hoạt
            // động)
            MemberPackage receiverActive = mpDAO.findActiveByMemberId(receiverMemberId);
            LocalDate receiverStartDate = today;
            if (receiverActive != null) {
                if (receiverActive.getEndDate().isAfter(today) || receiverActive.getEndDate().isEqual(today)) {
                    receiverStartDate = receiverActive.getEndDate().plusDays(1);
                }
            }
            LocalDate receiverEndDate = receiverStartDate.plusDays(remainingDays);

            // Tạo gói tập mới ở trạng thái 'Pending' cho người nhận
            MemberPackage receiverPackage = new MemberPackage();
            receiverPackage.setMemberId(receiverMemberId);
            receiverPackage.setPackageId(senderPackage.getPackageId());
            receiverPackage.setStartDate(receiverStartDate);
            receiverPackage.setEndDate(receiverEndDate);
            receiverPackage.setStatus("Pending");
            receiverPackage.setCreatedBy(
                    "Transfer from Member ID: " + senderPackage.getMemberId() + ". Staff ID: " + staffUserId);
            receiverPackage.setCreatedDate(LocalDateTime.now());

            boolean insertPackageSuccess = mpDAO.insert(receiverPackage);
            if (!insertPackageSuccess) {
                throw new SQLException("Không thể tạo bản ghi gói tập mới cho người nhận.");
            }

            // Tạo hóa đơn phí dịch vụ chuyển nhượng ở trạng thái 'Pending'
            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(receiverMemberId);
            pendingInvoice.setProcessBy(staffUserId);
            pendingInvoice.setMemberPackageId(receiverPackage.getMemberPackageId());
            pendingInvoice.setAmount(java.math.BigDecimal.valueOf(transferFee));
            pendingInvoice.setPaymentMethod("Cash");
            pendingInvoice.setStatus("Pending");
            pendingInvoice.setCreatedBy("Transfer;SenderPackageID:" + senderPackage.getMemberPackageId() + ";StaffId:"
                    + staffUserId + ";Note:" + note);
            pendingInvoice.setCreatedDate(LocalDateTime.now());

            boolean insertInvoiceSuccess = invDAO.insert(pendingInvoice);
            if (!insertInvoiceSuccess) {
                throw new SQLException("Không thể khởi tạo hóa đơn phí dịch vụ chuyển nhượng.");
            }

            conn.commit();
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

        return pendingInvoice;
    }
}
