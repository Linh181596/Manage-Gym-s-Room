package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC Implementation of the UserDAO interface.
 * Extends BaseDAO to handle connection caching and resource clean up.
 */
public class UserDAOImpl extends BaseDAO implements UserDAO {

    public UserDAOImpl() {
        super();
    }

    /**
     * Instantiates the DAO with a shared Connection (for active transaction support).
     * 
     * @param connection The shared database Connection.
     */
    public UserDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        // Use the shared connection if it exists, otherwise get a new connection.
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getString("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setPhoneNumber(rs.getString("phone_number"));
        
        // Map String to Role Enum
        String roleStr = rs.getString("role");
        if (roleStr != null) {
            user.setRole(User.Role.valueOf(roleStr));
        }
        
        // Map String to AccountStatus Enum
        String statusStr = rs.getString("account_status");
        if (statusStr != null) {
            user.setAccountStatus(User.AccountStatus.valueOf(statusStr));
        }
        
        user.setCreatedBy(rs.getString("created_by"));
        Timestamp createdTs = rs.getTimestamp("created_date");
        if (createdTs != null) {
            user.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        user.setUpdatedBy(rs.getString("updated_by"));
        Timestamp updatedTs = rs.getTimestamp("updated_date");
        if (updatedTs != null) {
            user.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        user.setDeleted(rs.getBoolean("is_deleted"));
        return user;
    }

    @Override
    public User findByEmail(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND is_deleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return user;
    }

    @Override
    public User findById(String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM users WHERE user_id = ? AND is_deleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return user;
    }

    @Override
    public boolean insert(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO users (user_id, email, password_hash, full_name, phone_number, role, account_status, created_by, created_date, is_deleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUserId());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setString(6, user.getRole().name());
            stmt.setString(7, user.getAccountStatus().name());
            stmt.setString(8, user.getCreatedBy());
            stmt.setTimestamp(9, user.getCreatedDate() != null ? Timestamp.valueOf(user.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public boolean update(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            String sql = "UPDATE users SET email = ?, password_hash = ?, full_name = ?, phone_number = ?, role = ?, account_status = ?, updated_by = ?, updated_date = ? " +
                         "WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPasswordHash());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getRole().name());
            stmt.setString(6, user.getAccountStatus().name());
            stmt.setString(7, user.getUpdatedBy());
            stmt.setTimestamp(8, user.getUpdatedDate() != null ? Timestamp.valueOf(user.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setString(9, user.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public boolean delete(String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // Soft delete user
            String sql = "UPDATE users SET is_deleted = 1 WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    @Override
    public List<User> findAllActive() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM users WHERE is_deleted = 0";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
