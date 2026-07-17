/**
 * =========================================================================
 * @file          : GymPackageDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể GymPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class GymPackageDAOImpl extends BaseDAO implements GymPackageDAO {

    public GymPackageDAOImpl() {
        super();
    }

    public GymPackageDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private GymPackage mapResultSetToGymPackage(ResultSet rs) throws SQLException {
        GymPackage pkg = new GymPackage();
        pkg.setPackageId(rs.getInt("PackageID"));
        pkg.setPackageName(rs.getString("PackageName"));
        pkg.setDurationMonths(rs.getInt("DurationMonths"));
        pkg.setPrice(rs.getBigDecimal("Price"));
        pkg.setDescription(rs.getString("Description"));
        pkg.setStatus(rs.getString("Status"));
        pkg.setCreatedBy(rs.getString("CreatedBy"));
        
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            pkg.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        pkg.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            pkg.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        pkg.setDeleted(rs.getBoolean("IsDeleted"));
        return pkg;
    }

    @Override
    public List<GymPackage> findAllActive() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM GymPackages WHERE Status = 'Active' AND IsDeleted = 0 ORDER BY Price ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public List<GymPackage> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            // Chỉ lấy những gói tập chưa bị xóa (IsDeleted = 0)
            String sql = "SELECT * FROM GymPackages WHERE IsDeleted = 0 ORDER BY PackageID DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public GymPackage findById(int packageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        GymPackage pkg = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM GymPackages WHERE PackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, packageId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToGymPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    @Override
    public boolean insert(GymPackage pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO GymPackages (PackageName, DurationMonths, Price, Description, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, pkg.getPackageName());
            stmt.setInt(2, pkg.getDurationMonths());
            stmt.setBigDecimal(3, pkg.getPrice());
            stmt.setString(4, pkg.getDescription());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getCreatedBy());
            stmt.setTimestamp(7, pkg.getCreatedDate() != null ? Timestamp.valueOf(pkg.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    pkg.setPackageId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    @Override
    public boolean update(GymPackage pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE GymPackages SET PackageName = ?, DurationMonths = ?, Price = ?, Description = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE PackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, pkg.getPackageName());
            stmt.setInt(2, pkg.getDurationMonths());
            stmt.setBigDecimal(3, pkg.getPrice());
            stmt.setString(4, pkg.getDescription());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getUpdatedBy());
            stmt.setTimestamp(7, pkg.getUpdatedDate() != null ? Timestamp.valueOf(pkg.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, pkg.getPackageId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public GymPackage findByName(String packageName) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        GymPackage pkg = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM GymPackages WHERE PackageName = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, packageName);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToGymPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    @Override
    public boolean delete(int packageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // Soft Delete - Thay vì dùng lệnh DELETE FROM, ta set cờ IsDeleted = 1 
            // Điều này giúp giữ lại dữ liệu lịch sử để tham chiếu (vd: Báo cáo, Lịch sử thanh toán)
            String sql = "UPDATE GymPackages SET IsDeleted = 1 WHERE PackageID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, packageId);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public int countAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            String sql = "SELECT COUNT(*) FROM GymPackages WHERE IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return 0;
    }

    @Override
    public List<GymPackage> findAllPaginated(int offset, int limit) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM GymPackages WHERE IsDeleted = 0 ORDER BY PackageID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Math.max(0, offset));
            stmt.setInt(2, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
