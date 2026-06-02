package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
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
        user.setUserId(rs.getInt("UserID"));
        user.setEmail(rs.getString("Email"));
        user.setPasswordHash(rs.getString("PasswordHash"));
        user.setFullName(rs.getString("DisplayName"));
        user.setPhoneNumber(rs.getString("Phone"));
        
        // Map String to Role Enum
        String roleStr = rs.getString("RoleName");
        if (roleStr != null) {
            user.setRole(User.Role.valueOf(roleStr));
        }
        
        // Map String to AccountStatus Enum
        String statusStr = rs.getString("Status");
        if (statusStr != null) {
            user.setAccountStatus(User.AccountStatus.valueOf(statusStr));
        }
        
        user.setCreatedBy(rs.getString("CreatedBy"));
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            user.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        user.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            user.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        user.setDeleted(rs.getBoolean("IsDeleted"));
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
            String sql = "SELECT u.*, r.RoleName FROM Users u " +
                         "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID " +
                         "LEFT JOIN Roles r ON ur.RoleID = r.RoleID " +
                         "WHERE u.Email = ? AND u.IsDeleted = 0";
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
    public User findById(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT u.*, r.RoleName FROM Users u " +
                         "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID " +
                         "LEFT JOIN Roles r ON ur.RoleID = r.RoleID " +
                         "WHERE u.UserID = ? AND u.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
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
        PreparedStatement stmtUser = null;
        PreparedStatement stmtRole = null;
        PreparedStatement stmtUserRole = null;
        ResultSet generatedKeys = null;
        ResultSet roleRs = null;
        boolean success = false;
        
        // If we don't have a shared connection, we handle transaction here
        boolean isLocalTx = (this.connection == null);
        
        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }
            
            // 1. Insert User
            String sqlUser = "INSERT INTO Users (Email, PasswordHash, DisplayName, Phone, Status, MustChangePassword, CreatedBy, CreatedDate, IsDeleted) " +
                             "VALUES (?, ?, ?, ?, ?, 0, ?, ?, 0)";
            stmtUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            stmtUser.setString(1, user.getEmail());
            stmtUser.setString(2, user.getPasswordHash());
            stmtUser.setString(3, user.getFullName());
            stmtUser.setString(4, user.getPhoneNumber());
            stmtUser.setString(5, user.getAccountStatus().name());
            stmtUser.setString(6, user.getCreatedBy());
            stmtUser.setTimestamp(7, user.getCreatedDate() != null ? Timestamp.valueOf(user.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsUser = stmtUser.executeUpdate();
            if (rowsUser > 0) {
                generatedKeys = stmtUser.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
                
                // 2. Fetch RoleID
                String sqlRole = "SELECT RoleID FROM Roles WHERE RoleName = ?";
                stmtRole = conn.prepareStatement(sqlRole);
                stmtRole.setString(1, user.getRole().name());
                roleRs = stmtRole.executeQuery();
                
                int roleId = 0;
                if (roleRs.next()) {
                    roleId = roleRs.getInt("RoleID");
                }
                
                if (roleId > 0) {
                    // 3. Insert UserRole
                    String sqlUserRole = "INSERT INTO UserRoles (UserID, RoleID, CreatedBy, CreatedDate, IsDeleted) VALUES (?, ?, ?, ?, 0)";
                    stmtUserRole = conn.prepareStatement(sqlUserRole);
                    stmtUserRole.setInt(1, user.getUserId());
                    stmtUserRole.setInt(2, roleId);
                    stmtUserRole.setString(3, user.getCreatedBy());
                    stmtUserRole.setTimestamp(4, user.getCreatedDate() != null ? Timestamp.valueOf(user.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
                    
                    int rowsRole = stmtUserRole.executeUpdate();
                    success = (rowsRole > 0);
                }
            }
            
            if (isLocalTx && success) {
                conn.commit();
            } else if (isLocalTx) {
                conn.rollback();
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (roleRs != null) roleRs.close();
            if (stmtRole != null) stmtRole.close();
            if (stmtUserRole != null) stmtUserRole.close();
            closeResource(conn, stmtUser, null);
        }
        return success;
    }

    @Override
    public boolean update(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtUser = null;
        PreparedStatement stmtRole = null;
        PreparedStatement stmtUserRole = null;
        ResultSet roleRs = null;
        boolean success = false;
        
        boolean isLocalTx = (this.connection == null);
        
        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }
            
            // 1. Update User
            String sqlUser = "UPDATE Users SET Email = ?, PasswordHash = ?, DisplayName = ?, Phone = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                             "WHERE UserID = ? AND IsDeleted = 0";
            stmtUser = conn.prepareStatement(sqlUser);
            stmtUser.setString(1, user.getEmail());
            stmtUser.setString(2, user.getPasswordHash());
            stmtUser.setString(3, user.getFullName());
            stmtUser.setString(4, user.getPhoneNumber());
            stmtUser.setString(5, user.getAccountStatus().name());
            stmtUser.setString(6, user.getUpdatedBy());
            stmtUser.setTimestamp(7, user.getUpdatedDate() != null ? Timestamp.valueOf(user.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmtUser.setInt(8, user.getUserId());
            
            int rowsUser = stmtUser.executeUpdate();
            if (rowsUser > 0) {
                // 2. Fetch RoleID
                String sqlRole = "SELECT RoleID FROM Roles WHERE RoleName = ?";
                stmtRole = conn.prepareStatement(sqlRole);
                stmtRole.setString(1, user.getRole().name());
                roleRs = stmtRole.executeQuery();
                
                int roleId = 0;
                if (roleRs.next()) {
                    roleId = roleRs.getInt("RoleID");
                }
                
                if (roleId > 0) {
                    // 3. Update UserRole
                    String sqlUserRole = "UPDATE UserRoles SET RoleID = ?, UpdatedBy = ?, UpdatedDate = ? WHERE UserID = ?";
                    stmtUserRole = conn.prepareStatement(sqlUserRole);
                    stmtUserRole.setInt(1, roleId);
                    stmtUserRole.setString(2, user.getUpdatedBy());
                    stmtUserRole.setTimestamp(3, user.getUpdatedDate() != null ? Timestamp.valueOf(user.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
                    stmtUserRole.setInt(4, user.getUserId());
                    stmtUserRole.executeUpdate();
                }
                success = true;
            }
            
            if (isLocalTx && success) {
                conn.commit();
            } else if (isLocalTx) {
                conn.rollback();
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (roleRs != null) roleRs.close();
            if (stmtRole != null) stmtRole.close();
            if (stmtUserRole != null) stmtUserRole.close();
            closeResource(conn, stmtUser, null);
        }
        return success;
    }

    @Override
    public boolean delete(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtUser = null;
        PreparedStatement stmtUserRole = null;
        boolean success = false;
        
        boolean isLocalTx = (this.connection == null);
        
        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }
            
            String sqlUser = "UPDATE Users SET IsDeleted = 1 WHERE UserID = ?";
            stmtUser = conn.prepareStatement(sqlUser);
            stmtUser.setInt(1, userId);
            int rowsUser = stmtUser.executeUpdate();
            
            if (rowsUser > 0) {
                String sqlUserRole = "UPDATE UserRoles SET IsDeleted = 1 WHERE UserID = ?";
                stmtUserRole = conn.prepareStatement(sqlUserRole);
                stmtUserRole.setInt(1, userId);
                stmtUserRole.executeUpdate();
                success = true;
            }
            
            if (isLocalTx && success) {
                conn.commit();
            } else if (isLocalTx) {
                conn.rollback();
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (stmtUserRole != null) stmtUserRole.close();
            closeResource(conn, stmtUser, null);
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
            String sql = "SELECT u.*, r.RoleName FROM Users u " +
                         "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID " +
                         "LEFT JOIN Roles r ON ur.RoleID = r.RoleID " +
                         "WHERE u.IsDeleted = 0";
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
