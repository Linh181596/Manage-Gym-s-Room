package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
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
        user.setMustChangePassword(rs.getBoolean("MustChangePassword"));
        
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
                    String sqlUserRole = "INSERT INTO UserRoles (UserID, RoleID) VALUES (?, ?)";
                    stmtUserRole = conn.prepareStatement(sqlUserRole);
                    stmtUserRole.setInt(1, user.getUserId());
                    stmtUserRole.setInt(2, roleId);
                    
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
                    String sqlUserRole = "UPDATE UserRoles SET RoleID = ? WHERE UserID = ?";
                    stmtUserRole = conn.prepareStatement(sqlUserRole);
                    stmtUserRole.setInt(1, roleId);
                    stmtUserRole.setInt(2, user.getUserId());
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
                String sqlUserRole = "DELETE FROM UserRoles WHERE UserID = ?";
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

    // --- Implementation of New Auth & Verification Methods ---

    @Override
    public boolean checkEmailExists(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            String sql = "SELECT 1 FROM dbo.Users WHERE Email = ? AND IsDeleted = 0";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next();
        } finally {
            closeResource(conn, ps, rs);
        }
    }

    @Override
    public boolean registerMember(User user, Member member, UserToken token) throws SQLException {
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psRole = null;
        PreparedStatement psMember = null;
        PreparedStatement psToken = null;
        ResultSet rsKeys = null;
        boolean success = false;
        
        boolean isLocalTx = (this.connection == null);
        
        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }
            
            // 1. Insert User
            String sqlUser = "INSERT INTO dbo.Users (Email, PasswordHash, DisplayName, Phone, Status, "
                           + "MustChangePassword, CreatedBy, CreatedDate, IsDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)";
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getEmail());
            psUser.setString(2, user.getPasswordHash());
            psUser.setString(3, user.getFullName());
            psUser.setString(4, user.getPhoneNumber());
            psUser.setString(5, user.getAccountStatus().name());
            psUser.setBoolean(6, false); // mustChangePassword
            psUser.setString(7, "Public Registration");
            
            int affectedRows = psUser.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Quá trình thêm thông tin User thất bại.");
            }
            
            rsKeys = psUser.getGeneratedKeys();
            int userId = 0;
            if (rsKeys.next()) {
                userId = rsKeys.getInt(1);
                user.setUserId(userId);
            } else {
                throw new SQLException("Không thể lấy ID tự sinh của User.");
            }
            
            // 2. Insert UserRole (RoleID = 4 for Member)
            String sqlRole = "INSERT INTO dbo.UserRoles (UserID, RoleID) VALUES (?, 4)";
            psRole = conn.prepareStatement(sqlRole);
            psRole.setInt(1, userId);
            psRole.executeUpdate();
            
            // 3. Insert Member profile
            String sqlMember = "INSERT INTO dbo.Members (UserID, Gender, DateOfBirth, Address, "
                             + "MembershipStatus, CreatedDate, IsDeleted) VALUES (?, ?, ?, ?, ?, SYSDATETIME(), 0)";
            psMember = conn.prepareStatement(sqlMember);
            psMember.setInt(1, userId);
            psMember.setString(2, member.getGender());
            psMember.setDate(3, member.getDateOfBirth() != null ? java.sql.Date.valueOf(member.getDateOfBirth()) : null);
            psMember.setString(4, member.getAddress());
            psMember.setString(5, member.getMembershipStatus());
            psMember.executeUpdate();
            
            // 4. Insert UserToken
            String sqlToken = "INSERT INTO dbo.User_Tokens (UserID, TokenValue, TokenType, ExpiresAt, IsUsed) VALUES (?, ?, ?, ?, 0)";
            psToken = conn.prepareStatement(sqlToken);
            psToken.setInt(1, userId);
            psToken.setString(2, token.getTokenValue());
            psToken.setString(3, token.getTokenType());
            psToken.setTimestamp(4, Timestamp.valueOf(token.getExpiresAt()));
            psToken.executeUpdate();
            
            success = true;
            if (isLocalTx) {
                conn.commit();
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (rsKeys != null) rsKeys.close();
            if (psRole != null) psRole.close();
            if (psMember != null) psMember.close();
            if (psToken != null) psToken.close();
            closeResource(conn, psUser, null);
        }
        return success;
    }

    @Override
    public String verifyAccountAndGetEmail(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpUser = null;
        PreparedStatement psUpMember = null;
        PreparedStatement psUpToken = null;
        ResultSet rs = null;
        String email = null;
        
        boolean isLocalTx = (this.connection == null);
        
        try {
            conn = getActiveConnection();
            String sqlCheck = "SELECT t.UserID, t.TokenID, u.Email FROM dbo.User_Tokens t "
                            + "JOIN dbo.Users u ON t.UserID = u.UserID "
                            + "WHERE t.TokenValue = ? AND t.TokenType = 'VERIFICATION' AND t.IsUsed = 0 AND t.ExpiresAt > SYSDATETIME()";
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, tokenValue);
            rs = psCheck.executeQuery();
            
            if (rs.next()) {
                int userId = rs.getInt("UserID");
                int tokenId = rs.getInt("TokenID");
                email = rs.getString("Email");
                
                if (isLocalTx) {
                    conn.setAutoCommit(false);
                }
                
                String sqlUpUser = "UPDATE dbo.Users SET Status = 'Active' WHERE UserID = ?";
                psUpUser = conn.prepareStatement(sqlUpUser);
                psUpUser.setInt(1, userId);
                psUpUser.executeUpdate();
                
                String sqlUpMember = "UPDATE dbo.Members SET MembershipStatus = 'Active' WHERE UserID = ?";
                psUpMember = conn.prepareStatement(sqlUpMember);
                psUpMember.setInt(1, userId);
                psUpMember.executeUpdate();
                
                String sqlUpToken = "UPDATE dbo.User_Tokens SET IsUsed = 1 WHERE TokenID = ?";
                psUpToken = conn.prepareStatement(sqlUpToken);
                psUpToken.setInt(1, tokenId);
                psUpToken.executeUpdate();
                
                if (isLocalTx) {
                    conn.commit();
                }
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (psCheck != null) psCheck.close();
            if (psUpUser != null) psUpUser.close();
            if (psUpMember != null) psUpMember.close();
            if (psUpToken != null) psUpToken.close();
            if (isLocalTx && conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
        return email;
    }

    @Override
    public boolean saveRememberMeToken(UserToken token) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO dbo.User_Tokens (UserID, TokenValue, TokenType, ExpiresAt, IsUsed) " +
                         "VALUES (?, ?, ?, ?, 0)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, token.getUserID());
            ps.setString(2, token.getTokenValue());
            ps.setString(3, token.getTokenType());
            ps.setTimestamp(4, Timestamp.valueOf(token.getExpiresAt()));
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    @Override
    public User getUserByRememberMeToken(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;
        try {
            conn = getActiveConnection();
            String sql = "SELECT u.*, r.RoleName FROM dbo.User_Tokens t " +
                         "INNER JOIN dbo.Users u ON t.UserID = u.UserID " +
                         "INNER JOIN dbo.UserRoles ur ON u.UserID = ur.UserID " +
                         "INNER JOIN dbo.Roles r ON ur.RoleID = r.RoleID " +
                         "WHERE t.TokenValue = ? AND t.TokenType = 'REMEMBER_ME' " +
                         "AND t.IsUsed = 0 AND t.ExpiresAt > SYSDATETIME() AND u.IsDeleted = 0";
            ps = conn.prepareStatement(sql);
            ps.setString(1, tokenValue);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return user;
    }

    @Override
    public boolean deleteRememberMeToken(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            String sql = "DELETE FROM dbo.User_Tokens WHERE TokenValue = ? AND TokenType = 'REMEMBER_ME'";
            ps = conn.prepareStatement(sql);
            ps.setString(1, tokenValue);
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    @Override
    public boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getActiveConnection();
            String sql = "UPDATE dbo.Users SET PasswordHash = ?, MustChangePassword = ? WHERE UserID = ? AND IsDeleted = 0";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newPasswordHash);
            ps.setBoolean(2, mustChangePassword);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } finally {
            closeResource(conn, ps, null);
        }
    }
}
