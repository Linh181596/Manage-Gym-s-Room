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
            
            // 1. Get Gym Package Details
            GymPackage gp = gpDAO.findById(packageId);
            if (gp == null || !"Active".equals(gp.getStatus())) {
                throw new SQLException("Gym package not found or is inactive.");
            }
            
            // 2. Check if member has an active package to concatenate dates
            LocalDate startDate = LocalDate.now();
            String checkActiveSql = "SELECT TOP 1 EndDate FROM MemberPackages WHERE MemberID = ? AND Status = 'Active' AND IsDeleted = 0 ORDER BY EndDate DESC";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkActiveSql)) {
                checkStmt.setInt(1, memberId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        java.sql.Date activeEndDate = rs.getDate("EndDate");
                        if (activeEndDate != null) {
                            LocalDate latestEndDate = activeEndDate.toLocalDate();
                            // If latest active package expires in the future, start the new one the day after
                            if (latestEndDate.isAfter(LocalDate.now()) || latestEndDate.isEqual(LocalDate.now())) {
                                startDate = latestEndDate.plusDays(1);
                            }
                        }
                    }
                }
            }
            
            LocalDate endDate = startDate.plusMonths(gp.getDurationMonths());
            
            // 3. Insert MemberPackage in 'Pending' status (awaiting payment)
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
            
            // 4. Create Pending Invoice
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
