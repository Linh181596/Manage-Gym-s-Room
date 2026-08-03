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
import com.google.gson.JsonObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class MemberPackageServiceImpl implements MemberPackageService {

    private final MemberDAO memberDAO = new MemberDAOImpl();

    /**
     * Lấy danh sách hội viên đang hoạt động (Active).
     * Luồng nghiệp vụ: Truy vấn bảng Members qua MemberDAO, lọc hội viên Active.
     * Dùng để cho phép nhân viên chọn người đăng ký gói tập.
     * 
     * @return Danh sách hội viên
     * @throws SQLException
     */
    @Override
    public List<Member> getActiveMembers() throws SQLException {
        return memberDAO.findAllActive();
    }

    /**
     * Đăng ký một gói tập mới cho hội viên.
     * Luồng nghiệp vụ:
     * 1. Validate gói tập và tính hợp lệ (VD: [BR-COMP-12] - Không cho đăng ký nếu
     * đang có hóa đơn Pending trùng).
     * 2. [BR-COMP-07] - Nối ngày tự động nếu hội viên đang có gói Active, ngược lại
     * bắt đầu từ ngày hiện tại.
     * 3. Sử dụng transaction: Insert gói tập (Trạng thái Pending) -> Insert Hóa đơn
     * (Pending) -> Commit.
     * 
     * @param memberId    ID Hội viên
     * @param packageId   ID Gói tập
     * @param paymentMethod Phương thức thanh toán (VNPay / Cash)
     * @return Hóa đơn (Invoice) chờ thanh toán
     * @throws SQLException nếu có lỗi hoặc validate thất bại
     */
    @Override
    public Invoice registerMemberPackage(int memberId, int packageId, String paymentMethod) throws SQLException {
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

            // Validate: Không cho phép tạo nhiều hóa đơn chờ (Pending) cho cùng 1 loại gói
            // [BR-COMP-12]: The system shall not allow users to register a new package if
            // they have an unpaid pending invoice.
            String checkPendingSql = "SELECT TOP 1 1 FROM MemberPackages WHERE MemberID = ? AND PackageID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, memberId);
                checkPendingStmt.setInt(2, packageId);
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Khách hàng đang có một thủ tục đăng ký/gia hạn chờ thanh toán cho gói tập này. Vui lòng thanh toán hoặc hủy thủ tục cũ trước khi tạo mới.");
                    }
                }
            }

            // Validate: Nếu hội viên ĐÃ TỪNG có gói tập, kiểm tra xem có được phép đăng ký mới không
            MemberPackage latestPkg = mpDAO.findLatestByMemberId(memberId);
            if (latestPkg != null) {
                if ("Active".equalsIgnoreCase(latestPkg.getStatus()) || "Pending".equalsIgnoreCase(latestPkg.getStatus())) {
                    throw new SQLException("Khách hàng đang có gói tập. Vui lòng sử dụng chức năng Gia hạn thay vì Đăng ký mới.");
                } else if ("Expired".equalsIgnoreCase(latestPkg.getStatus())) {
                    java.time.LocalDate endDate = latestPkg.getEndDate();
                    java.time.LocalDate now = java.time.LocalDate.now();
                    long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(endDate, now);
                    if (daysBetween <= 3) {
                        throw new SQLException("Khách hàng có gói tập vừa hết hạn (<= 3 ngày). Vui lòng sử dụng chức năng Gia hạn thay vì Đăng ký mới.");
                    }
                }
            }

            // [BR-COMP-07] Bị vô hiệu cho đăng ký mới do rule 1 người 1 gói. Đăng ký mới
            // luôn bắt đầu từ hôm nay.
            LocalDate startDate = LocalDate.now();
            LocalDate endDate = startDate.plusMonths(gp.getDurationMonths());

            // Khởi tạo gói tập của hội viên ở trạng thái Pending (Chờ thanh toán)
            MemberPackage mp = new MemberPackage();
            mp.setMemberId(memberId);
            mp.setPackageId(packageId);
            mp.setStartDate(startDate);
            mp.setEndDate(endDate);
            mp.setStatus("Pending");
            mp.setCreatedBy("Member Self-Registration");
            mp.setCreatedDate(LocalDateTime.now());

            boolean insertPackageSuccess = mpDAO.insert(mp);
            if (!insertPackageSuccess) {
                throw new SQLException("Failed to create Member Package record.");
            }

            // Tạo hóa đơn thanh toán tương ứng cho gói tập này
            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(memberId);
            Member member = memberDAO.findById(memberId);
            pendingInvoice.setProcessBy(member != null ? member.getUserId() : 1);
            pendingInvoice.setMemberPackageId(mp.getMemberPackageId());
            pendingInvoice.setAmount(gp.getPrice());
            pendingInvoice.setPaymentMethod(paymentMethod);
            pendingInvoice.setStatus("Pending");
            pendingInvoice.setCreatedBy("Member Self-Registration");
            pendingInvoice.setPaymentDate(LocalDateTime.now());
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

            // Validate: Không cho phép tạo nhiều hóa đơn chờ (Pending) cho cùng 1 loại gói
            String checkPendingSql = "SELECT TOP 1 1 FROM MemberPackages WHERE MemberID = ? AND PackageID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, memberId);
                checkPendingStmt.setInt(2, packageId);
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Khách hàng đang có một thủ tục đăng ký/gia hạn chờ thanh toán cho gói tập này. Vui lòng thanh toán hoặc hủy thủ tục cũ trước khi tạo mới.");
                    }
                }
            }

            // Validate: Nếu hội viên ĐÃ TỪNG có gói tập, kiểm tra xem có được phép đăng ký mới không
            MemberPackage latestPkg = mpDAO.findLatestByMemberId(memberId);
            if (latestPkg != null) {
                if ("Active".equalsIgnoreCase(latestPkg.getStatus()) || "Pending".equalsIgnoreCase(latestPkg.getStatus())) {
                    throw new SQLException("Khách hàng đang có gói tập. Vui lòng sử dụng chức năng Gia hạn thay vì Đăng ký mới.");
                } else if ("Expired".equalsIgnoreCase(latestPkg.getStatus())) {
                    java.time.LocalDate endDate = latestPkg.getEndDate();
                    java.time.LocalDate now = java.time.LocalDate.now();
                    long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(endDate, now);
                    if (daysBetween <= 3) {
                        throw new SQLException("Khách hàng có gói tập vừa hết hạn (<= 3 ngày). Vui lòng sử dụng chức năng Gia hạn thay vì Đăng ký mới.");
                    }
                }
            }

            LocalDate startDate = LocalDate.now();
            LocalDate endDate = startDate.plusMonths(gp.getDurationMonths());

            // Khởi tạo gói tập của hội viên ở trạng thái Pending (Chờ thanh toán)
            MemberPackage mp = new MemberPackage();
            mp.setMemberId(memberId);
            mp.setPackageId(packageId);
            mp.setStartDate(startDate);
            mp.setEndDate(endDate);
            mp.setStatus("Pending");
            mp.setCreatedBy("Staff (ID: " + staffUserId + ")");
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
            pendingInvoice.setPaymentMethod(null);
            pendingInvoice.setStatus("Pending");
            pendingInvoice.setCreatedBy("Staff (ID: " + staffUserId + ")");
            pendingInvoice.setPaymentDate(LocalDateTime.now());
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


    /**
     * Lấy gói tập đang hoạt động của hội viên (có thời hạn dài nhất nếu có nhiều
     * gói).
     * Luồng nghiệp vụ: Truy vấn MemberPackageDAO.
     * 
     * @param memberId ID hội viên
     * @return MemberPackage nếu tìm thấy
     * @throws SQLException
     */
    @Override
    public MemberPackage getActivePackageByMemberId(int memberId) throws SQLException {
        MemberPackageDAO mpDAO = new MemberPackageDAOImpl();
        return mpDAO.findActiveByMemberId(memberId);
    }

    /**
     * Lấy gói tập mới nhất của hội viên (bất kể trạng thái).
     * Luồng nghiệp vụ: Truy vấn MemberPackageDAO.
     * Dùng để xác định gói tập được phép gia hạn.
     * 
     * @param memberId ID hội viên
     * @return MemberPackage nếu tìm thấy
     * @throws SQLException
     */
    @Override
    public MemberPackage getLatestPackageByMemberId(int memberId) throws SQLException {
        MemberPackageDAO mpDAO = new MemberPackageDAOImpl();
        return mpDAO.findLatestByMemberId(memberId);
    }

    /**
     * Lấy danh sách tất cả gói tập đang hoạt động của hội viên.
     * Luồng nghiệp vụ: Lấy các gói Status='Active' và EndDate >= hôm nay.
     * 
     * @param memberId ID hội viên
     * @return Danh sách MemberPackage
     * @throws SQLException
     */
    @Override
    public java.util.List<MemberPackage> findAllActivePackagesByMemberId(int memberId) throws SQLException {
        MemberPackageDAO mpDAO = new MemberPackageDAOImpl();
        return mpDAO.findAllActiveByMemberId(memberId);
    }

    /**
     * Gia hạn gói tập.
     * Luồng nghiệp vụ: Gọi lại quy trình đăng ký gói tập thông thường.
     * [BR-COMP-18]: Members can renew their membership package.
     * 
     * @param memberId    ID hội viên
     * @param packageId   ID gói tập
     * @param staffUserId ID nhân viên xử lý
     * @return Hóa đơn
     * @throws SQLException
     */
    @Override
    public Invoice renewMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException {
        Connection conn = null;
        Invoice pendingInvoice = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            GymPackageDAO gpDAO = new GymPackageDAOImpl(conn);
            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);

            // Kiểm tra gói tập có tồn tại và Active không
            GymPackage gp = gpDAO.findById(packageId);
            if (gp == null || !"Active".equals(gp.getStatus())) {
                throw new SQLException("Gói tập hệ thống không khả dụng.");
            }

            // Tìm gói tập hiện tại của member
            MemberPackage latestPkg = mpDAO.findLatestByMemberId(memberId);
            if (latestPkg == null) {
                throw new SQLException("Hội viên chưa có gói tập nào để gia hạn. Vui lòng Đăng ký mới.");
            }
            
            // Chỉ cho phép gia hạn khi gói tập còn dưới 1 tháng
            if (latestPkg.getEndDate() != null && LocalDate.now().plusMonths(1).isBefore(latestPkg.getEndDate())) {
                throw new SQLException("Bạn chỉ có thể gia hạn khi gói tập hiện tại còn thời hạn dưới 1 tháng.");
            }

            // Validate: Không cho phép tạo nhiều hóa đơn chờ cho gói này
            String checkPendingSql = "SELECT TOP 1 1 FROM Invoices WHERE MemberPackageID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, latestPkg.getMemberPackageId());
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Hội viên đang có một hóa đơn chờ thanh toán cho gói tập này. Vui lòng thanh toán hoặc hủy trước khi gia hạn.");
                    }
                }
            }

            // TẠO HÓA ĐƠN THAY VÌ TẠO GÓI TẬP MỚI
            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(memberId);
            pendingInvoice.setProcessBy(staffUserId);
            pendingInvoice.setMemberPackageId(latestPkg.getMemberPackageId());
            pendingInvoice.setAmount(gp.getPrice());
            pendingInvoice.setPaymentMethod("Cash");
            pendingInvoice.setStatus("Pending");
            
            // Sử dụng TransactionData để lưu Meta-data an toàn thay vì CreatedBy
            JsonObject tData = new JsonObject();
            tData.addProperty("action", "renew");
            tData.addProperty("packageId", packageId);
            tData.addProperty("staffUserId", staffUserId);
            pendingInvoice.setTransactionData(tData.toString());
            
            pendingInvoice.setCreatedBy("StaffUserID: " + staffUserId); 
            pendingInvoice.setPaymentDate(LocalDateTime.now());
            pendingInvoice.setCreatedDate(LocalDateTime.now());

            boolean insertInvoiceSuccess = invDAO.insert(pendingInvoice);
            if (!insertInvoiceSuccess) {
                throw new SQLException("Failed to create renewal invoice.");
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
            }
        }
        return pendingInvoice;
    }

    /**
     * Gia hạn gói tập (Dành cho Member tự gia hạn).
     */
    @Override
    public Invoice renewMemberPackage(int memberId, int packageId, String paymentMethod) throws SQLException {
        Connection conn = null;
        Invoice pendingInvoice = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            GymPackageDAO gpDAO = new GymPackageDAOImpl(conn);
            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);

            // Kiểm tra gói tập có tồn tại và Active không
            GymPackage gp = gpDAO.findById(packageId);
            if (gp == null || !"Active".equals(gp.getStatus())) {
                throw new SQLException("Gói tập hệ thống không khả dụng.");
            }

            // Tìm gói tập hiện tại của member
            MemberPackage latestPkg = mpDAO.findLatestByMemberId(memberId);
            if (latestPkg == null) {
                throw new SQLException("Hội viên chưa có gói tập nào để gia hạn. Vui lòng Đăng ký mới.");
            }
            
            // Chỉ cho phép gia hạn khi gói tập còn dưới 1 tháng
            if (latestPkg.getEndDate() != null && LocalDate.now().plusMonths(1).isBefore(latestPkg.getEndDate())) {
                throw new SQLException("Bạn chỉ có thể gia hạn khi gói tập hiện tại còn thời hạn dưới 1 tháng.");
            }

            // Không cho phép gia hạn nếu đã hết hạn quá 3 ngày
            if (latestPkg.getEndDate() != null && latestPkg.getEndDate().plusDays(3).isBefore(LocalDate.now())) {
                throw new SQLException("Gói tập của bạn đã hết hạn quá 3 ngày. Vui lòng đăng ký gói mới thay vì gia hạn.");
            }

            // Validate: Không cho phép tạo nhiều hóa đơn chờ cho gói này
            String checkPendingSql = "SELECT TOP 1 1 FROM Invoices WHERE MemberPackageID = ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, latestPkg.getMemberPackageId());
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Bạn đang có một hóa đơn chờ thanh toán cho gói tập này. Vui lòng thanh toán hoặc hủy trước khi gia hạn.");
                    }
                }
            }

            // TẠO HÓA ĐƠN THAY VÌ TẠO GÓI TẬP MỚI
            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(memberId);
            MemberDAO memberDAO = new com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl(conn);
            Member member = memberDAO.findById(memberId);
            pendingInvoice.setProcessBy(member != null ? member.getUserId() : 1);
            pendingInvoice.setMemberPackageId(latestPkg.getMemberPackageId());
            pendingInvoice.setAmount(gp.getPrice());
            pendingInvoice.setPaymentMethod(paymentMethod);
            pendingInvoice.setStatus("Pending");
            
            // Sử dụng TransactionData để lưu Meta-data an toàn
            JsonObject tData = new JsonObject();
            tData.addProperty("action", "renew");
            tData.addProperty("packageId", packageId);
            pendingInvoice.setTransactionData(tData.toString());
            
            pendingInvoice.setCreatedBy("Member Self-Renewal"); 
            pendingInvoice.setPaymentDate(LocalDateTime.now());
            pendingInvoice.setCreatedDate(LocalDateTime.now());

            boolean insertInvoiceSuccess = invDAO.insert(pendingInvoice);
            if (!insertInvoiceSuccess) {
                throw new SQLException("Failed to create renewal invoice.");
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
            }
        }

        return pendingInvoice;
    }

    /**
     * Chuyển nhượng gói tập cho hội viên khác.
     * Luồng nghiệp vụ:
     * 1. Kiểm tra gói tập có đủ điều kiện chuyển không (> 1 ngày) [BR-COMP-19].
     * 2. [BR-COMP-12] Kiểm tra không có hóa đơn Pending chuyển nhượng.
     * 3. [BR-COMP-07] Tính ngày bắt đầu cho người nhận (nối ngày).
     * 4. Dùng Transaction lưu Gói nhận (Pending) và Hóa đơn phí (Pending).
     * (Việc disable gói gốc được thực hiện lúc thanh toán hóa đơn này).
     * 
     * @param senderPkgId      ID gói của người gửi
     * @param receiverMemberId ID hội viên nhận
     * @param staffUserId      Nhân viên xử lý
     * @param note             Ghi chú
     * @return Hóa đơn
     * @throws SQLException
     */
    @Override
    public Invoice transferMemberPackage(int senderPkgId, int receiverMemberId, int staffUserId,
            String note) throws SQLException {
        Connection conn = null;
        Invoice pendingInvoice = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            MemberPackageDAO mpDAO = new MemberPackageDAOImpl(conn);
            InvoiceDAO invDAO = new InvoiceDAOImpl(conn);

            // 1. Kiểm tra gói tập của người gửi
            MemberPackage senderPackage = mpDAO.findById(senderPkgId);
            if (senderPackage == null) {
                throw new SQLException("Không tìm thấy gói tập được chọn để chuyển nhượng.");
            }
            if (!"Active".equals(senderPackage.getStatus())) {
                throw new SQLException("Gói tập được chọn không trong trạng thái hoạt động.");
            }

            LocalDate today = LocalDate.now();
            LocalDate effectiveStartDate = senderPackage.getStartDate().isAfter(today) ? senderPackage.getStartDate() : today;
            long remainingDays = java.time.temporal.ChronoUnit.DAYS.between(effectiveStartDate, senderPackage.getEndDate());

            if (remainingDays <= 0) {
                throw new SQLException("Gói tập đã hết hạn, không thể chuyển nhượng.");
            }

            // 3. Validate không có hóa đơn chờ
            String checkPendingTransferSql = "SELECT TOP 1 1 FROM Invoices WHERE CreatedBy LIKE ? AND Status = 'Pending' AND IsDeleted = 0";
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingTransferSql)) {
                checkPendingStmt.setString(1, "Transfer;SenderPackageID:" + senderPackage.getMemberPackageId() + ";%");
                try (ResultSet rs = checkPendingStmt.executeQuery()) {
                    if (rs.next()) {
                        throw new SQLException(
                                "Gói tập này đang có thủ tục chuyển nhượng chờ thanh toán. Vui lòng xử lý hóa đơn cũ trước.");
                    }
                }
            }

            // 4. Xử lý gói tập của người nhận (Receiver)
            MemberPackage receiverActive = mpDAO.findLatestByMemberId(receiverMemberId); // Lấy gói bất kỳ của người
                                                                                         // nhận
            int receiverPkgId;

            if (receiverActive != null) {
                // Kiểm tra xem người nhận có đang có hóa đơn Pending nào gắn với gói này không
                String checkReceiverPendingSql = "SELECT TOP 1 1 FROM Invoices WHERE MemberPackageID = ? AND Status = 'Pending' AND IsDeleted = 0";
                try (PreparedStatement checkReceiverPendingStmt = conn.prepareStatement(checkReceiverPendingSql)) {
                    checkReceiverPendingStmt.setInt(1, receiverActive.getMemberPackageId());
                    try (ResultSet rs = checkReceiverPendingStmt.executeQuery()) {
                        if (rs.next()) {
                            throw new SQLException(
                                    "Người nhận đang có thủ tục đăng ký hoặc gia hạn chờ thanh toán. Vui lòng yêu cầu người nhận thanh toán hoặc hủy thủ tục đó trước khi nhận chuyển nhượng.");
                        }
                    }
                }

                // Người nhận đã có gói => Gắn vào gói cũ để lát update cộng ngày
                receiverPkgId = receiverActive.getMemberPackageId();
            } else {
                // Người nhận chưa có gói => Tạo một record Pending
                MemberPackage receiverPackage = new MemberPackage();
                receiverPackage.setMemberId(receiverMemberId);
                receiverPackage.setPackageId(senderPackage.getPackageId());
                receiverPackage.setStartDate(today);
                receiverPackage.setEndDate(today.plusDays(remainingDays));
                receiverPackage.setStatus("Pending");
                receiverPackage.setCreatedBy(
                        "Transfer from Member ID: " + senderPackage.getMemberId() + ". Staff ID: " + staffUserId);
                receiverPackage.setCreatedDate(LocalDateTime.now());

                boolean insertPackageSuccess = mpDAO.insert(receiverPackage);
                if (!insertPackageSuccess) {
                    throw new SQLException("Không thể tạo bản ghi gói tập mới cho người nhận.");
                }
                receiverPkgId = receiverPackage.getMemberPackageId();
            }

            // 5. Tạo hóa đơn chuyển nhượng (Phí = 5,000 VND / ngày còn lại)
            double transferFee = remainingDays * 5000.0;

            pendingInvoice = new Invoice();
            pendingInvoice.setMemberId(receiverMemberId);
            pendingInvoice.setProcessBy(staffUserId);
            pendingInvoice.setMemberPackageId(receiverPkgId);
            pendingInvoice.setAmount(java.math.BigDecimal.valueOf(transferFee));
            pendingInvoice.setPaymentMethod("Cash");
            pendingInvoice.setStatus("Pending");

            // Lưu meta-data bằng JSON thay vì CreatedBy String Split
            JsonObject tData = new JsonObject();
            tData.addProperty("action", "transfer");
            tData.addProperty("senderPkgId", senderPackage.getMemberPackageId());
            tData.addProperty("remainingDays", remainingDays);
            tData.addProperty("staffUserId", staffUserId);
            pendingInvoice.setTransactionData(tData.toString());
            
            pendingInvoice.setCreatedBy("StaffUserID: " + staffUserId);
            pendingInvoice.setPaymentDate(LocalDateTime.now());
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
