package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.PTPackageTypeDAO;
import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PTPackageTypeDAOImpl extends BaseDAO implements PTPackageTypeDAO {

    public PTPackageTypeDAOImpl() {
        super();
    }

    public PTPackageTypeDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private PTPackageType mapResultSetToPTPackageType(ResultSet rs) throws SQLException {
        PTPackageType pkg = new PTPackageType();
        pkg.setPtPackageTypeId(rs.getInt("PTPackageTypeID"));
        pkg.setPackageName(rs.getString("PackageName"));
        pkg.setDescription(rs.getString("Description"));
        pkg.setDurationMonths(rs.getInt("DurationMonths"));
        pkg.setNumberOfSessions(rs.getInt("NumberOfSessions"));
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
    public List<PTPackageType> findAllActive() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PTPackageType> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM PTPackageTypes WHERE Status = 'Active' AND IsDeleted = 0 ORDER BY NumberOfSessions ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToPTPackageType(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public List<PTPackageType> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PTPackageType> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM PTPackageTypes WHERE IsDeleted = 0 ORDER BY PTPackageTypeID DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToPTPackageType(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public List<PTPackageType> findByStatus(String status) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PTPackageType> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql;
            if (status == null || status.trim().isEmpty() || "All".equalsIgnoreCase(status.trim())) {
                sql = "SELECT * FROM PTPackageTypes WHERE IsDeleted = 0 ORDER BY PTPackageTypeID DESC";
                stmt = conn.prepareStatement(sql);
            } else {
                sql = "SELECT * FROM PTPackageTypes WHERE Status = ? AND IsDeleted = 0 ORDER BY PTPackageTypeID DESC";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, status.trim());
            }
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToPTPackageType(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public PTPackageType findById(int ptPackageTypeId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PTPackageType pkg = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM PTPackageTypes WHERE PTPackageTypeID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ptPackageTypeId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToPTPackageType(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    @Override
    public PTPackageType findByName(String packageName) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PTPackageType pkg = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM PTPackageTypes WHERE PackageName = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, packageName);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToPTPackageType(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    @Override
    public boolean insert(PTPackageType pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO PTPackageTypes (PackageName, Description, DurationMonths, NumberOfSessions, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, pkg.getPackageName());
            stmt.setString(2, pkg.getDescription());
            stmt.setInt(3, pkg.getDurationMonths());
            stmt.setInt(4, pkg.getNumberOfSessions());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getCreatedBy());
            stmt.setTimestamp(7, pkg.getCreatedDate() != null ? Timestamp.valueOf(pkg.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    pkg.setPtPackageTypeId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    @Override
    public boolean update(PTPackageType pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE PTPackageTypes SET PackageName = ?, Description = ?, DurationMonths = ?, NumberOfSessions = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE PTPackageTypeID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, pkg.getPackageName());
            stmt.setString(2, pkg.getDescription());
            stmt.setInt(3, pkg.getDurationMonths());
            stmt.setInt(4, pkg.getNumberOfSessions());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getUpdatedBy());
            stmt.setTimestamp(7, pkg.getUpdatedDate() != null ? Timestamp.valueOf(pkg.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, pkg.getPtPackageTypeId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public boolean delete(int ptPackageTypeId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE PTPackageTypes SET IsDeleted = 1 WHERE PTPackageTypeID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ptPackageTypeId);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }
}
