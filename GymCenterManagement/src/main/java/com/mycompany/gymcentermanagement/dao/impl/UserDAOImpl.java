/**
 * =========================================================================
 * @file          : UserDAOImpl.java
 * @description   : Lớp triển khai các phương thức truy vấn và tương tác cơ sở dữ liệu cho Users và Profiles.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.utils.DBContext;
import com.mycompany.gymcentermanagement.dto.*;

import java.sql.*;
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
            try {
                user.setRole(User.Role.valueOf(roleStr));
            } catch (IllegalArgumentException e) {
                user.setRole(null);
            }
        }

        // Map String to AccountStatus Enum
        String statusStr = rs.getString("Status");
        if (statusStr != null) {
            try {
                user.setAccountStatus(User.AccountStatus.valueOf(statusStr));
            } catch (IllegalArgumentException e) {
                user.setAccountStatus(User.AccountStatus.Inactive);
            }
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
        user.setMustChangePassword(rs.getBoolean("MustChangePassword"));
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
            String sqlUser = "INSERT INTO Users "
                    + "(Email, PasswordHash, DisplayName, Phone, Status, MustChangePassword, CreatedBy, CreatedDate, IsDeleted) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";
            // set mustchangepass to setBoolean(last ver not have)
            stmtUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);

            stmtUser.setString(1, user.getEmail());
            stmtUser.setString(2, user.getPasswordHash());
            stmtUser.setString(3, user.getFullName());
            stmtUser.setString(4, user.getPhoneNumber());
            stmtUser.setString(5, user.getAccountStatus().name());
            stmtUser.setBoolean(6, user.isMustChangePassword());
            stmtUser.setString(7, user.getCreatedBy());
            stmtUser.setTimestamp(8, user.getCreatedDate() != null
                    ? Timestamp.valueOf(user.getCreatedDate())
                    : new Timestamp(System.currentTimeMillis()));

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
    public boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        UPDATE Users
                        SET PasswordHash = ?,
                            MustChangePassword = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPasswordHash);
            stmt.setBoolean(2, mustChangePassword);
            stmt.setInt(3, userId);

            return stmt.executeUpdate() > 0;

        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public boolean checkEmailExists(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        SELECT 1
                        FROM Users
                        WHERE Email = ?
                          AND IsDeleted = 0
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            rs = stmt.executeQuery();
            return rs.next();

        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    @Override
    public boolean registerMember(User user, Member member, UserToken token) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtUser = null;
        PreparedStatement stmtRole = null;
        PreparedStatement stmtUserRole = null;
        PreparedStatement stmtMember = null;
        PreparedStatement stmtToken = null;
        ResultSet generatedKeys = null;
        ResultSet roleRs = null;

        boolean success = false;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();

            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            /*
             * 1. Insert Users
             */
            String sqlUser = """
                        INSERT INTO Users (
                            Email,
                            PasswordHash,
                            DisplayName,
                            Phone,
                            Status,
                            MustChangePassword,
                            CreatedBy,
                            CreatedDate,
                            IsDeleted
                        )
                        VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)
                    """;

            stmtUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            stmtUser.setString(1, user.getEmail());
            stmtUser.setString(2, user.getPasswordHash());
            stmtUser.setString(3, user.getFullName());
            stmtUser.setString(4, user.getPhoneNumber());
            stmtUser.setString(5, user.getAccountStatus().name());
            stmtUser.setBoolean(6, user.isMustChangePassword());
            stmtUser.setString(7, user.getCreatedBy() != null ? user.getCreatedBy() : "System");

            int userRows = stmtUser.executeUpdate();

            if (userRows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            generatedKeys = stmtUser.getGeneratedKeys();

            if (generatedKeys.next()) {
                user.setUserId(generatedKeys.getInt(1));
            } else {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            /*
             * 2. Get Member RoleID
             */
            String sqlRole = """
                        SELECT RoleID
                        FROM Roles
                        WHERE RoleName = ?
                    """;

            stmtRole = conn.prepareStatement(sqlRole);
            stmtRole.setString(1, User.Role.Member.name());
            roleRs = stmtRole.executeQuery();

            int roleId = 0;

            if (roleRs.next()) {
                roleId = roleRs.getInt("RoleID");
            }

            if (roleId <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            /*
             * 3. Insert UserRoles
             */
            String sqlUserRole = """
                        INSERT INTO UserRoles (UserID, RoleID)
                        VALUES (?, ?)
                    """;

            stmtUserRole = conn.prepareStatement(sqlUserRole);
            stmtUserRole.setInt(1, user.getUserId());
            stmtUserRole.setInt(2, roleId);

            int userRoleRows = stmtUserRole.executeUpdate();

            if (userRoleRows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            /*
             * 4. Insert Members
             */
            String sqlMember = """
                        INSERT INTO Members (
                            UserID,
                            Gender,
                            DateOfBirth,
                            Address,
                            MembershipStatus,
                            CreatedBy,
                            CreatedDate,
                            IsDeleted
                        )
                        VALUES (?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)
                    """;

            stmtMember = conn.prepareStatement(sqlMember);
            stmtMember.setInt(1, user.getUserId());
            stmtMember.setString(2, member.getGender());

            if (member.getDateOfBirth() != null) {
                stmtMember.setDate(3, Date.valueOf(member.getDateOfBirth()));
            } else {
                stmtMember.setNull(3, Types.DATE);
            }

            stmtMember.setString(4, member.getAddress());
            stmtMember.setString(5, member.getMembershipStatus() != null ? member.getMembershipStatus() : "Active");
            stmtMember.setString(6, member.getCreatedBy() != null ? member.getCreatedBy() : "System");

            int memberRows = stmtMember.executeUpdate();

            if (memberRows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            /*
             * 5. Insert verification token if provided
             */
            if (token != null) {
                String sqlToken = """
                            INSERT INTO User_Tokens (
                                UserID,
                                TokenValue,
                                TokenType,
                                ExpiresAt,
                                IsUsed,
                                CreatedAt
                            )
                            VALUES (?, ?, ?, ?, 0, SYSDATETIME())
                        """;

                stmtToken = conn.prepareStatement(sqlToken);
                stmtToken.setInt(1, user.getUserId());
                stmtToken.setString(2, token.getTokenValue());
                stmtToken.setString(3, token.getTokenType());

                if (token.getExpiresAt() != null) {
                    stmtToken.setTimestamp(4, Timestamp.valueOf(token.getExpiresAt()));
                } else {
                    stmtToken.setNull(4, Types.TIMESTAMP);
                }

                int tokenRows = stmtToken.executeUpdate();

                if (tokenRows <= 0) {
                    if (isLocalTx) {
                        conn.rollback();
                    }
                    return false;
                }
            }

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
            if (generatedKeys != null) generatedKeys.close();
            if (roleRs != null) roleRs.close();
            if (stmtToken != null) stmtToken.close();
            if (stmtMember != null) stmtMember.close();
            if (stmtUserRole != null) stmtUserRole.close();
            if (stmtRole != null) stmtRole.close();
            closeResource(conn, stmtUser, null);
        }

        return success;
    }

    @Override
    public String verifyAccountAndGetEmail(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtFind = null;
        PreparedStatement stmtUpdateToken = null;
        PreparedStatement stmtUpdateUser = null;
        PreparedStatement stmtUpdateMember = null;
        ResultSet rs = null;

        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();

            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            String sqlFind = """
                        SELECT u.UserID, u.Email
                        FROM User_Tokens t
                        INNER JOIN Users u ON t.UserID = u.UserID
                        WHERE t.TokenValue = ?
                          AND t.TokenType = 'VERIFICATION'
                          AND t.IsUsed = 0
                          AND t.ExpiresAt > SYSDATETIME()
                          AND u.IsDeleted = 0
                    """;

            stmtFind = conn.prepareStatement(sqlFind);
            stmtFind.setString(1, tokenValue);
            rs = stmtFind.executeQuery();

            if (!rs.next()) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return null;
            }

            int userId = rs.getInt("UserID");
            String email = rs.getString("Email");

            String sqlUpdateToken = """
                        UPDATE User_Tokens
                        SET IsUsed = 1
                        WHERE TokenValue = ?
                          AND TokenType = 'VERIFICATION'
                     """;

            stmtUpdateToken = conn.prepareStatement(sqlUpdateToken);
            stmtUpdateToken.setString(1, tokenValue);
            stmtUpdateToken.executeUpdate();

            String sqlUpdateUser = """
                        UPDATE Users
                        SET Status = 'Active',
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;

            stmtUpdateUser = conn.prepareStatement(sqlUpdateUser);
            stmtUpdateUser.setInt(1, userId);
            stmtUpdateUser.executeUpdate();

            String sqlUpdateMember = """
                        UPDATE Members
                        SET MembershipStatus = 'Active',
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;

            stmtUpdateMember = conn.prepareStatement(sqlUpdateMember);
            stmtUpdateMember.setInt(1, userId);
            stmtUpdateMember.executeUpdate();

            if (isLocalTx) {
                conn.commit();
            }

            return email;

        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (stmtUpdateMember != null) stmtUpdateMember.close();
            if (stmtUpdateUser != null) stmtUpdateUser.close();
            if (stmtUpdateToken != null) stmtUpdateToken.close();
            closeResource(conn, stmtFind, rs);
        }
    }

    @Override
    public boolean saveRememberMeToken(UserToken token) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        INSERT INTO User_Tokens (
                            UserID,
                            TokenValue,
                            TokenType,
                            ExpiresAt,
                            IsUsed,
                            CreatedAt
                        )
                        VALUES (?, ?, ?, ?, 0, SYSDATETIME())
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, token.getUserID());
            stmt.setString(2, token.getTokenValue());
            stmt.setString(3, token.getTokenType());

            if (token.getExpiresAt() != null) {
                stmt.setTimestamp(4, Timestamp.valueOf(token.getExpiresAt()));
            } else {
                stmt.setNull(4, Types.TIMESTAMP);
            }

            return stmt.executeUpdate() > 0;

        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public User getUserByRememberMeToken(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        SELECT u.*, r.RoleName
                        FROM User_Tokens t
                        INNER JOIN Users u ON t.UserID = u.UserID
                        LEFT JOIN UserRoles ur ON u.UserID = ur.UserID
                        LEFT JOIN Roles r ON ur.RoleID = r.RoleID
                        WHERE t.TokenValue = ?
                          AND t.TokenType = 'REMEMBER_ME'
                          AND t.IsUsed = 0
                          AND t.ExpiresAt > SYSDATETIME()
                          AND u.IsDeleted = 0
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, tokenValue);

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
    public boolean deleteRememberMeToken(String tokenValue) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        DELETE FROM User_Tokens
                        WHERE TokenValue = ?
                          AND TokenType = 'REMEMBER_ME'
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, tokenValue);

            return stmt.executeUpdate() > 0;

        } finally {
            closeResource(conn, stmt, null);
        }
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

    // --- Profile Methods (UC-03) ---

    @Override
    public String getHighestPriorityRole(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String roleName = null;
        try {
            conn = getActiveConnection();
            String sql = "SELECT TOP 1 r.RoleName FROM UserRoles ur " +
                         "INNER JOIN Roles r ON ur.RoleID = r.RoleID " +
                         "WHERE ur.UserID = ? " +
                         "ORDER BY r.RoleLevel ASC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                roleName = rs.getString("RoleName");
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return roleName;
    }

    @Override
    public UserProfileBaseDTO getUserProfileById(int userId) throws SQLException {
        String roleName = getHighestPriorityRole(userId);
        if (roleName == null) return null;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            
            if ("Admin".equalsIgnoreCase(roleName)) {
                String sql = "SELECT UserID, Email, DisplayName, Phone FROM Users " +
                             "WHERE UserID = ? AND IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    UserProfileBaseDTO adminProfile = new UserProfileBaseDTO();
                    setBaseProfileData(adminProfile, rs, roleName);
                    return adminProfile;
                }
            }
            else if ("Member".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, m.Gender, m.DateOfBirth, m.Address, m.MembershipStatus " +
                             "FROM Users u INNER JOIN Members m ON u.UserID = m.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND m.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    MemberProfileDTO member = new MemberProfileDTO();
                    setBaseProfileData(member, rs, roleName);
                    member.setGender(rs.getString("Gender"));
                    member.setDateOfBirth(rs.getDate("DateOfBirth"));
                    member.setAddress(rs.getString("Address"));
                    member.setMembershipStatus(rs.getString("MembershipStatus"));
                    return member;
                }
            } 
            else if ("PT".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, pt.FullName, pt.Specialization, pt.Description, " +
                             "pt.CareerStartDate, pt.AvatarPath, pt.CertificateFileName, pt.CertificateFilePath " +
                             "FROM Users u INNER JOIN PersonalTrainers pt ON u.UserID = pt.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND pt.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    PTProfileDTO pt = new PTProfileDTO();
                    setBaseProfileData(pt, rs, roleName);
                    pt.setFullName(rs.getString("FullName")); 
                    pt.setSpecialization(rs.getString("Specialization"));
                    pt.setDescription(rs.getString("Description"));
                    pt.setAvatarPath(rs.getString("AvatarPath"));
                    pt.setCertificateFileName(rs.getString("CertificateFileName"));
                    pt.setCertificateFilePath(rs.getString("CertificateFilePath"));
                    
                    Date startDateSql = rs.getDate("CareerStartDate");
                    if (startDateSql != null) {
                        java.time.LocalDate startDate = startDateSql.toLocalDate();
                        java.time.LocalDate currentDate = java.time.LocalDate.now();
                        long years = java.time.temporal.ChronoUnit.YEARS.between(startDate, currentDate);
                        pt.setExperienceYears((int) years);
                    }
                    return pt;
                }
            } 
            else if ("Staff".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, s.Position " +
                             "FROM Users u INNER JOIN Staffs s ON u.UserID = s.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND s.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    StaffProfileDTO staff = new StaffProfileDTO();
                    setBaseProfileData(staff, rs, roleName);
                    staff.setPosition(rs.getString("Position"));
                    return staff;
                }
            }
        } finally {
            closeResource(conn, ps, rs);
        }
        return null;
    }

    private void setBaseProfileData(UserProfileBaseDTO dto, ResultSet rs, String roleName) throws SQLException {
        dto.setUserId(rs.getInt("UserID"));
        dto.setEmail(rs.getString("Email"));
        dto.setDisplayName(rs.getString("DisplayName"));
        dto.setPhone(rs.getString("Phone"));
        dto.setRoleName(roleName);
    }

    @Override
    public boolean updateUserProfile(UserProfileBaseDTO profileDto, String roleName) throws SQLException {
        String sqlUser = "UPDATE Users SET DisplayName = ?, Phone = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psSub = null;
        boolean success = false;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            // 1. Cập nhật dữ liệu cốt lõi vào bảng Users chính
            psUser = conn.prepareStatement(sqlUser);
            psUser.setString(1, profileDto.getDisplayName());
            psUser.setString(2, profileDto.getPhone());
            psUser.setInt(3, profileDto.getUserId());
            int userRows = psUser.executeUpdate();

            int subRows = 1; // Mặc định hợp lệ cho trường hợp Admin hoặc Staff (không có bảng phụ cần cập nhật qua trang profile của Dương)

            // 2. Rẽ nhánh cập nhật dữ liệu đặc thù phụ thuộc theo vai trò
            if ("Member".equalsIgnoreCase(roleName) && profileDto instanceof MemberProfileDTO) {
                MemberProfileDTO memberDto = (MemberProfileDTO) profileDto;
                String sqlMember = "UPDATE Members SET Gender = ?, DateOfBirth = ?, Address = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlMember);
                psSub.setString(1, memberDto.getGender());
                psSub.setDate(2, memberDto.getDateOfBirth());
                psSub.setString(3, memberDto.getAddress());
                psSub.setInt(4, memberDto.getUserId());
                subRows = psSub.executeUpdate();
            } 
            else if ("PT".equalsIgnoreCase(roleName) && profileDto instanceof PTProfileDTO) {
                PTProfileDTO ptDto = (PTProfileDTO) profileDto;
                String sqlPT = "UPDATE PersonalTrainers SET FullName = ?, Description = ?, AvatarPath = ?, " +
                               "CertificateFileName = ?, CertificateFilePath = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlPT);
                psSub.setString(1, ptDto.getFullName());
                psSub.setString(2, ptDto.getDescription());
                psSub.setString(3, ptDto.getAvatarPath());
                psSub.setString(4, ptDto.getCertificateFileName());
                psSub.setString(5, ptDto.getCertificateFilePath());
                psSub.setInt(6, ptDto.getUserId());
                subRows = psSub.executeUpdate();
            }

            // 3. Xác nhận lưu dữ liệu thành công nếu cả 2 khối lệnh thực thi trơn tru
            if (userRows > 0 && subRows > 0) {
                success = true;
            }

            if (isLocalTx) {
                if (success) {
                    conn.commit();
                } else {
                    conn.rollback();
                }
            }
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (psSub != null) psSub.close();
            closeResource(conn, psUser, null);
        }
        return success;
    }
}

