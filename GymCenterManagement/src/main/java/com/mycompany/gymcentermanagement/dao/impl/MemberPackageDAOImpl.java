/**
 * =========================================================================
 * @file          : MemberPackageDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể MemberPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.MemberPackageDAO;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.sql.Timestamp;

public class MemberPackageDAOImpl extends BaseDAO implements MemberPackageDAO {

    public MemberPackageDAOImpl() {
        super();
    }

    public MemberPackageDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private MemberPackage mapResultSetToMemberPackage(ResultSet rs) throws SQLException {
        MemberPackage mp = new MemberPackage();
        mp.setMemberPackageId(rs.getInt("MemberPackageID"));
        mp.setMemberId(rs.getInt("MemberID"));
        mp.setPackageId(rs.getInt("PackageID"));
        
        Date start = rs.getDate("StartDate");
        if (start != null) {
            mp.setStartDate(start.toLocalDate());
        }
        
        Date end = rs.getDate("EndDate");
        if (end != null) {
            mp.setEndDate(end.toLocalDate());
        }
        
        mp.setStatus(rs.getString("Status"));
        mp.setCreatedBy(rs.getString("CreatedBy"));
        
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            mp.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        mp.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            mp.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        mp.setDeleted(rs.getBoolean("IsDeleted"));

        // Attempt mapping linked details if present in ResultSet
        try {
            GymPackage gp = new GymPackage();
            gp.setPackageId(rs.getInt("PackageID"));
            gp.setPackageName(rs.getString("PackageName"));
            gp.setPrice(rs.getBigDecimal("Price"));
            gp.setDurationMonths(rs.getInt("DurationMonths"));
            mp.setGymPackage(gp);
            
            Member m = new Member();
            m.setMemberId(rs.getInt("MemberID"));
            User u = new User();
            u.setFullName(rs.getString("DisplayName"));
            u.setEmail(rs.getString("Email"));
            m.setUserDetails(u);
            mp.setMember(m);
        } catch (SQLException ex) {
            // Ignore if columns not in query
        }

        return mp;
    }

    @Override
    public MemberPackage findById(int memberPackageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MemberPackage mp = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberPackageID = ? AND mp.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberPackageId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mp = mapResultSetToMemberPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return mp;
    }

    @Override
    public boolean insert(MemberPackage mp) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO MemberPackages (MemberID, PackageID, StartDate, EndDate, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, mp.getMemberId());
            stmt.setInt(2, mp.getPackageId());
            stmt.setDate(3, Date.valueOf(mp.getStartDate()));
            stmt.setDate(4, Date.valueOf(mp.getEndDate()));
            stmt.setString(5, mp.getStatus());
            stmt.setString(6, mp.getCreatedBy());
            stmt.setTimestamp(7, mp.getCreatedDate() != null ? Timestamp.valueOf(mp.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    mp.setMemberPackageId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    @Override
    public boolean update(MemberPackage mp) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE MemberPackages SET MemberID = ?, PackageID = ?, StartDate = ?, EndDate = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE MemberPackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, mp.getMemberId());
            stmt.setInt(2, mp.getPackageId());
            stmt.setDate(3, Date.valueOf(mp.getStartDate()));
            stmt.setDate(4, Date.valueOf(mp.getEndDate()));
            stmt.setString(5, mp.getStatus());
            stmt.setString(6, mp.getUpdatedBy());
            stmt.setTimestamp(7, mp.getUpdatedDate() != null ? Timestamp.valueOf(mp.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, mp.getMemberPackageId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public boolean delete(int memberPackageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE MemberPackages SET IsDeleted = 1 WHERE MemberPackageID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberPackageId);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public MemberPackage findActiveByMemberId(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MemberPackage mp = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT TOP 1 mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberID = ? AND mp.Status = 'Active' AND mp.IsDeleted = 0 " +
                         "AND mp.EndDate >= CAST(GETDATE() AS date) " +
                         "ORDER BY mp.EndDate DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mp = mapResultSetToMemberPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return mp;
    }

    @Override
    public java.util.List<MemberPackage> findAllActiveByMemberId(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        java.util.List<MemberPackage> list = new java.util.ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberID = ? AND mp.Status = 'Active' AND mp.IsDeleted = 0 " +
                         "AND mp.EndDate >= CAST(GETDATE() AS date) " +
                         "ORDER BY mp.EndDate ASC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMemberPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
