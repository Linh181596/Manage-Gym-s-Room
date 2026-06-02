/**
 * =========================================================================
 * @file          : InvoiceDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể Invoice
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.InvoiceDAO;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class InvoiceDAOImpl extends BaseDAO implements InvoiceDAO {

    public InvoiceDAOImpl() {
        super();
    }

    public InvoiceDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private Invoice mapResultSetToInvoice(ResultSet rs) throws SQLException {
        Invoice inv = new Invoice();
        inv.setInvoiceId(rs.getInt("InvoiceID"));
        inv.setMemberId(rs.getInt("MemberID"));
        inv.setProcessBy(rs.getInt("ProcessBy"));
        
        int mpId = rs.getInt("MemberPackageID");
        if (!rs.wasNull()) {
            inv.setMemberPackageId(mpId);
        }
        
        int ptRegId = rs.getInt("PTRegistrationID");
        if (!rs.wasNull()) {
            inv.setPtRegistrationId(ptRegId);
        }
        
        inv.setAmount(rs.getBigDecimal("Amount"));
        inv.setPaymentMethod(rs.getString("PaymentMethod"));
        
        Timestamp payTs = rs.getTimestamp("PaymentDate");
        if (payTs != null) {
            inv.setPaymentDate(payTs.toLocalDateTime());
        }
        
        inv.setStatus(rs.getString("Status"));
        inv.setCreatedBy(rs.getString("CreatedBy"));
        
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            inv.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        inv.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            inv.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        inv.setDeleted(rs.getBoolean("IsDeleted"));

        // Attempt mapping linked details if present in ResultSet
        try {
            Member m = new Member();
            m.setMemberId(rs.getInt("MemberID"));
            User uMem = new User();
            uMem.setFullName(rs.getString("MemberName"));
            uMem.setEmail(rs.getString("MemberEmail"));
            m.setUserDetails(uMem);
            inv.setMember(m);
            
            User uProc = new User();
            uProc.setUserId(rs.getInt("ProcessBy"));
            uProc.setFullName(rs.getString("ProcessorName"));
            inv.setProcessByUser(uProc);
            
            if (inv.getMemberPackageId() != null) {
                MemberPackage mp = new MemberPackage();
                mp.setMemberPackageId(inv.getMemberPackageId());
                GymPackage gp = new GymPackage();
                gp.setPackageName(rs.getString("PackageName"));
                mp.setGymPackage(gp);
                inv.setMemberPackage(mp);
            }
        } catch (SQLException ex) {
            // Ignore if columns not in query
        }

        return inv;
    }

    @Override
    public Invoice findById(int invoiceId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Invoice inv = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT i.*, u_mem.DisplayName AS MemberName, u_mem.Email AS MemberEmail, u_proc.DisplayName AS ProcessorName, gp.PackageName " +
                         "FROM Invoices i " +
                         "INNER JOIN Members m ON i.MemberID = m.MemberID " +
                         "INNER JOIN Users u_mem ON m.UserID = u_mem.UserID " +
                         "INNER JOIN Users u_proc ON i.ProcessBy = u_proc.UserID " +
                         "LEFT JOIN MemberPackages mp ON i.MemberPackageID = mp.MemberPackageID " +
                         "LEFT JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "WHERE i.InvoiceID = ? AND i.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, invoiceId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                inv = mapResultSetToInvoice(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return inv;
    }

    @Override
    public boolean insert(Invoice inv) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO Invoices (MemberID, ProcessBy, MemberPackageID, PTRegistrationID, Amount, PaymentMethod, PaymentDate, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, inv.getMemberId());
            stmt.setInt(2, inv.getProcessBy());
            
            if (inv.getMemberPackageId() != null) {
                stmt.setInt(3, inv.getMemberPackageId());
            } else {
                stmt.setNull(3, java.sql.Types.INTEGER);
            }
            
            if (inv.getPtRegistrationId() != null) {
                stmt.setInt(4, inv.getPtRegistrationId());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }
            
            stmt.setBigDecimal(5, inv.getAmount());
            stmt.setString(6, inv.getPaymentMethod());
            stmt.setTimestamp(7, inv.getPaymentDate() != null ? Timestamp.valueOf(inv.getPaymentDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setString(8, inv.getStatus());
            stmt.setString(9, inv.getCreatedBy());
            stmt.setTimestamp(10, inv.getCreatedDate() != null ? Timestamp.valueOf(inv.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    inv.setInvoiceId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    @Override
    public boolean update(Invoice inv) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE Invoices SET MemberID = ?, ProcessBy = ?, MemberPackageID = ?, PTRegistrationID = ?, Amount = ?, PaymentMethod = ?, PaymentDate = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE InvoiceID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, inv.getMemberId());
            stmt.setInt(2, inv.getProcessBy());
            
            if (inv.getMemberPackageId() != null) {
                stmt.setInt(3, inv.getMemberPackageId());
            } else {
                stmt.setNull(3, java.sql.Types.INTEGER);
            }
            
            if (inv.getPtRegistrationId() != null) {
                stmt.setInt(4, inv.getPtRegistrationId());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }
            
            stmt.setBigDecimal(5, inv.getAmount());
            stmt.setString(6, inv.getPaymentMethod());
            stmt.setTimestamp(7, inv.getPaymentDate() != null ? Timestamp.valueOf(inv.getPaymentDate()) : null);
            stmt.setString(8, inv.getStatus());
            stmt.setString(9, inv.getUpdatedBy());
            stmt.setTimestamp(10, inv.getUpdatedDate() != null ? Timestamp.valueOf(inv.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(11, inv.getInvoiceId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public List<Invoice> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Invoice> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT i.*, u_mem.DisplayName AS MemberName, u_mem.Email AS MemberEmail, u_proc.DisplayName AS ProcessorName, gp.PackageName " +
                         "FROM Invoices i " +
                         "INNER JOIN Members m ON i.MemberID = m.MemberID " +
                         "INNER JOIN Users u_mem ON m.UserID = u_mem.UserID " +
                         "INNER JOIN Users u_proc ON i.ProcessBy = u_proc.UserID " +
                         "LEFT JOIN MemberPackages mp ON i.MemberPackageID = mp.MemberPackageID " +
                         "LEFT JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "WHERE i.IsDeleted = 0 " +
                         "ORDER BY i.InvoiceID DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToInvoice(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
