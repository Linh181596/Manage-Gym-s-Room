/**
 * =========================================================================
 * @file          : UserDAOImpl.java
 * @description   : Lớp triển khai truy vấn JDBC cho Users, token xác thực, đổi mật khẩu và hồ sơ người dùng. Lớp triển khai các phương thức truy vấn và tương tác cơ sở dữ liệu cho Users và Profiles.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-25 (Cập nhật bởi Antigravity: 2026-06-11)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dto.MemberProfileDTO;
import com.mycompany.gymcentermanagement.dto.PTProfileDTO;
import com.mycompany.gymcentermanagement.dto.StaffProfileDTO;
import com.mycompany.gymcentermanagement.dto.UserProfileBaseDTO;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC Implementation of the UserDAO interface. Extends BaseDAO to handle
 * connection caching and resource clean up.
 */
public class UserDAOImpl extends BaseDAO implements UserDAO {

    public UserDAOImpl() {
        super();
    }

    /**
     * Instantiates the DAO with a shared Connection (for active transaction
     * support).
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

        // Map AvatarPath (if present in ResultSet)
        try {
            String avatarPath = rs.getString("AvatarPath");
            if (avatarPath != null) {
                user.setAvatarPath(avatarPath);
            }
        } catch (SQLException e) {
            // Column might not exist in some queries, ignore
        }

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
            String sql = "SELECT u.*, r.RoleName, pt.AvatarPath FROM Users u "
                    + "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID "
                    + "LEFT JOIN Roles r ON ur.RoleID = r.RoleID "
                    + "LEFT JOIN PersonalTrainers pt ON u.UserID = pt.UserID "
                    + "WHERE u.Email = ? AND u.IsDeleted = 0";
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
            String sql = "SELECT u.*, r.RoleName, pt.AvatarPath FROM Users u "
                    + "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID "
                    + "LEFT JOIN Roles r ON ur.RoleID = r.RoleID "
                    + "LEFT JOIN PersonalTrainers pt ON u.UserID = pt.UserID "
                    + "WHERE u.UserID = ? AND u.IsDeleted = 0";
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
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (roleRs != null) {
                roleRs.close();
            }
            if (stmtRole != null) {
                stmtRole.close();
            }
            if (stmtUserRole != null) {
                stmtUserRole.close();
            }
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
            String sqlUser = "UPDATE Users SET Email = ?, PasswordHash = ?, DisplayName = ?, Phone = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? "
                    + "WHERE UserID = ? AND IsDeleted = 0";
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
            if (roleRs != null) {
                roleRs.close();
            }
            if (stmtRole != null) {
                stmtRole.close();
            }
            if (stmtUserRole != null) {
                stmtUserRole.close();
            }
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
            if (stmtUserRole != null) {
                stmtUserRole.close();
            }
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
    public int revokeRememberMeTokensByUserId(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();

            String sql = """
                        UPDATE User_Tokens
                        SET IsUsed = 1
                        WHERE UserID = ?
                          AND TokenType = 'REMEMBER_ME'
                          AND IsUsed = 0
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            return stmt.executeUpdate();

        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public boolean changePasswordAndRevokeTokens(int userId, String newPasswordHash, boolean mustChangePassword)
            throws SQLException {
        Connection conn = null;
        PreparedStatement stmtPassword = null;
        PreparedStatement stmtTokens = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            String sqlPassword = """
                        UPDATE Users
                        SET PasswordHash = ?,
                            MustChangePassword = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;

            stmtPassword = conn.prepareStatement(sqlPassword);
            stmtPassword.setString(1, newPasswordHash);
            stmtPassword.setBoolean(2, mustChangePassword);
            stmtPassword.setInt(3, userId);

            int passwordRows = stmtPassword.executeUpdate();
            if (passwordRows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            String sqlTokens = """
                        UPDATE User_Tokens
                        SET IsUsed = 1
                        WHERE UserID = ?
                          AND TokenType = 'REMEMBER_ME'
                          AND IsUsed = 0
                    """;

            stmtTokens = conn.prepareStatement(sqlTokens);
            stmtTokens.setInt(1, userId);
            stmtTokens.executeUpdate();

            if (isLocalTx) {
                conn.commit();
            }

            return true;

        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (stmtTokens != null) stmtTokens.close();
            closeResource(conn, stmtPassword, null);
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
    public boolean checkPhoneExists(String phone) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();

            String sql = "SELECT 1 FROM Users WHERE Phone = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            rs = stmt.executeQuery();

            return rs.next(); // Trả về true nếu số điện thoại đã tồn tại

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Bắt buộc ném lỗi ra ngoài để Controller có thể hiển thị thông báo thay vì nuốt lỗi
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException e) {
            }
            if (stmt != null) try {
                stmt.close();
            } catch (SQLException e) {
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException e) {
            }
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
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (roleRs != null) {
                roleRs.close();
            }
            if (stmtToken != null) {
                stmtToken.close();
            }
            if (stmtMember != null) {
                stmtMember.close();
            }
            if (stmtUserRole != null) {
                stmtUserRole.close();
            }
            if (stmtRole != null) {
                stmtRole.close();
            }
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
            if (stmtUpdateMember != null) {
                stmtUpdateMember.close();
            }
            if (stmtUpdateUser != null) {
                stmtUpdateUser.close();
            }
            if (stmtUpdateToken != null) {
                stmtUpdateToken.close();
            }
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
                        SELECT u.*, r.RoleName, pt.AvatarPath
                        FROM User_Tokens t
                        INNER JOIN Users u ON t.UserID = u.UserID
                        LEFT JOIN UserRoles ur ON u.UserID = ur.UserID
                        LEFT JOIN Roles r ON ur.RoleID = r.RoleID
                        LEFT JOIN PersonalTrainers pt ON u.UserID = pt.UserID
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
            String sql = "SELECT u.*, r.RoleName FROM Users u "
                    + "LEFT JOIN UserRoles ur ON u.UserID = ur.UserID "
                    + "LEFT JOIN Roles r ON ur.RoleID = r.RoleID "
                    + "WHERE u.IsDeleted = 0";
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

    @Override
    public List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException {
        return searchAccounts(keyword, role, status, 0, Integer.MAX_VALUE);
    }

    @Override
    public List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        try {
            conn = getActiveConnection();
            StringBuilder sql = new StringBuilder("""
                        SELECT u.*, r.RoleName
                        FROM Users u
                        LEFT JOIN UserRoles ur ON u.UserID = ur.UserID
                        LEFT JOIN Roles r ON ur.RoleID = r.RoleID
                        WHERE u.IsDeleted = 0
                    """);

            String normalizedKeyword = normalizeBlank(keyword);
            if (normalizedKeyword != null) {
                sql.append("""
                            AND (
                                u.DisplayName LIKE ?
                                OR u.Email LIKE ?
                                OR u.Phone LIKE ?
                                OR r.RoleName LIKE ?
                                OR u.Status LIKE ?
                            )
                        """);
                String pattern = "%" + normalizedKeyword + "%";
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
            }

            if (role != null) {
                sql.append(" AND r.RoleName = ?");
                params.add(role.name());
            }

            if (status != null) {
                sql.append(" AND u.Status = ?");
                params.add(status.name());
            }

            sql.append(" ORDER BY u.UserID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add(Math.max(offset, 0));
            params.add(limit <= 0 ? 10 : limit);
            stmt = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public int countAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> params = new ArrayList<>();

        try {
            conn = getActiveConnection();
            StringBuilder sql = new StringBuilder("""
                        SELECT COUNT(*)
                        FROM Users u
                        LEFT JOIN UserRoles ur ON u.UserID = ur.UserID
                        LEFT JOIN Roles r ON ur.RoleID = r.RoleID
                        WHERE u.IsDeleted = 0
                    """);

            String normalizedKeyword = normalizeBlank(keyword);
            if (normalizedKeyword != null) {
                sql.append("""
                            AND (
                                u.DisplayName LIKE ?
                                OR u.Email LIKE ?
                                OR u.Phone LIKE ?
                                OR r.RoleName LIKE ?
                                OR u.Status LIKE ?
                            )
                        """);
                String pattern = "%" + normalizedKeyword + "%";
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
            }

            if (role != null) {
                sql.append(" AND r.RoleName = ?");
                params.add(role.name());
            }

            if (status != null) {
                sql.append(" AND u.Status = ?");
                params.add(status.name());
            }

            stmt = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

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
    public List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        try {
            conn = getActiveConnection();
            StringBuilder sql = new StringBuilder("""
                        SELECT u.*, r.RoleName
                        FROM Users u
                        LEFT JOIN UserRoles ur ON u.UserID = ur.UserID
                        LEFT JOIN Roles r ON ur.RoleID = r.RoleID
                        WHERE u.IsDeleted = 0
                    """);

            String normalizedKeyword = normalizeBlank(keyword);
            if (normalizedKeyword != null) {
                sql.append("""
                            AND (
                                u.DisplayName LIKE ?
                                OR u.Email LIKE ?
                                OR u.Phone LIKE ?
                                OR r.RoleName LIKE ?
                                OR u.Status LIKE ?
                            )
                        """);
                String pattern = "%" + normalizedKeyword + "%";
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
                params.add(pattern);
            }

            if (role != null) {
                sql.append(" AND r.RoleName = ?");
                params.add(role.name());
            }

            if (status != null) {
                sql.append(" AND u.Status = ?");
                params.add(status.name());
            }

            sql.append(" ORDER BY u.UserID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add(Math.max(0, offset));
            params.add(limit);

            stmt = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public boolean checkEmailExistsForOtherUser(String email, int excludedUserId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            String sql = "SELECT 1 FROM Users WHERE Email = ? AND UserID <> ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, excludedUserId);
            rs = stmt.executeQuery();
            return rs.next();
        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    @Override
    public boolean checkPhoneExistsForOtherUser(String phone, int excludedUserId) throws SQLException {
        if (normalizeBlank(phone) == null) {
            return false;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            String sql = "SELECT 1 FROM Users WHERE Phone = ? AND UserID <> ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            stmt.setInt(2, excludedUserId);
            rs = stmt.executeQuery();
            return rs.next();
        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    @Override
    public boolean insertManagedAccount(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtUser = null;
        ResultSet generatedKeys = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

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
            stmtUser.setString(7, user.getCreatedBy());

            int rows = stmtUser.executeUpdate();
            if (rows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            generatedKeys = stmtUser.getGeneratedKeys();
            if (!generatedKeys.next()) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            user.setUserId(generatedKeys.getInt(1));
            setUserRole(conn, user.getUserId(), user.getRole());
            ensureManagedProfile(conn, user.getUserId(), user.getRole(), user.getAccountStatus().name(), user.getCreatedBy());

            if (isLocalTx) {
                conn.commit();
            }
            return true;
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            closeResource(conn, stmtUser, null);
        }
    }

    @Override
    public boolean updateManagedAccount(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            String sql = """
                        UPDATE Users
                        SET Email = ?,
                            DisplayName = ?,
                            Phone = ?,
                            Status = ?,
                            UpdatedBy = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setString(4, user.getAccountStatus().name());
            stmt.setString(5, user.getUpdatedBy());
            stmt.setInt(6, user.getUserId());

            int rows = stmt.executeUpdate();
            if (rows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            User.Role currentRole = findCurrentRole(conn, user.getUserId());
            User.Role requestedRole = user.getRole() != null ? user.getRole() : currentRole;
            if (isStaffOrMember(currentRole) && isStaffOrMember(requestedRole) && currentRole != requestedRole) {
                setUserRole(conn, user.getUserId(), requestedRole);
                ensureManagedProfile(conn, user.getUserId(), requestedRole, user.getAccountStatus().name(), user.getUpdatedBy());
                disableManagedProfile(conn, user.getUserId(), currentRole, user.getUpdatedBy());
            } else if (isStaffOrMember(currentRole)) {
                ensureManagedProfile(conn, user.getUserId(), currentRole, user.getAccountStatus().name(), user.getUpdatedBy());
            }

            if (isLocalTx) {
                conn.commit();
            }
            return true;
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public boolean changeManagedAccountRole(int userId, User.Role newRole, String updatedBy) throws SQLException {
        if (!isStaffOrMember(newRole)) {
            return false;
        }

        Connection conn = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            User.Role currentRole = findCurrentRole(conn, userId);
            if (!isStaffOrMember(currentRole)) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            if (currentRole == newRole) {
                if (isLocalTx) {
                    conn.commit();
                }
                return true;
            }

            setUserRole(conn, userId, newRole);
            String currentStatus = findUserStatus(conn, userId);
            ensureManagedProfile(conn, userId, newRole, currentStatus, updatedBy);
            disableManagedProfile(conn, userId, currentRole, updatedBy);

            if (isLocalTx) {
                conn.commit();
            }
            return true;
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResource(conn, null, null);
        }
    }

    @Override
    public boolean updateAccountStatus(int userId, User.AccountStatus status, String updatedBy) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            String sql = """
                        UPDATE Users
                        SET Status = ?,
                            UpdatedBy = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status.name());
            stmt.setString(2, updatedBy);
            stmt.setInt(3, userId);

            int rows = stmt.executeUpdate();
            if (rows <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            User.Role role = findCurrentRole(conn, userId);
            if (role == User.Role.Member || role == User.Role.Staff) {
                ensureManagedProfile(conn, userId, role, status.name(), updatedBy);
            }

            if (isLocalTx) {
                conn.commit();
            }
            return true;
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public boolean deactivateAccount(int userId, String updatedBy) throws SQLException {
        return updateAccountStatus(userId, User.AccountStatus.Inactive, updatedBy);
    }

    @Override
    public boolean resetPassword(int userId, String newPasswordHash, String updatedBy) throws SQLException {
        Connection conn = null;
        PreparedStatement stmtPassword = null;
        PreparedStatement stmtTokens = null;
        boolean isLocalTx = (this.connection == null);

        try {
            conn = getActiveConnection();
            if (isLocalTx) {
                conn.setAutoCommit(false);
            }

            String sqlPassword = """
                        UPDATE Users
                        SET PasswordHash = ?,
                            MustChangePassword = 1,
                            UpdatedBy = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                          AND IsDeleted = 0
                    """;
            stmtPassword = conn.prepareStatement(sqlPassword);
            stmtPassword.setString(1, newPasswordHash);
            stmtPassword.setString(2, updatedBy);
            stmtPassword.setInt(3, userId);

            if (stmtPassword.executeUpdate() <= 0) {
                if (isLocalTx) {
                    conn.rollback();
                }
                return false;
            }

            String sqlTokens = """
                        UPDATE User_Tokens
                        SET IsUsed = 1
                        WHERE UserID = ?
                          AND TokenType = 'REMEMBER_ME'
                          AND IsUsed = 0
                    """;
            stmtTokens = conn.prepareStatement(sqlTokens);
            stmtTokens.setInt(1, userId);
            stmtTokens.executeUpdate();

            if (isLocalTx) {
                conn.commit();
            }
            return true;
        } catch (SQLException e) {
            if (isLocalTx && conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (stmtTokens != null) stmtTokens.close();
            closeResource(conn, stmtPassword, null);
        }
    }

    private User.Role findCurrentRole(Connection conn, int userId) throws SQLException {
        String sql = """
                    SELECT TOP 1 r.RoleName
                    FROM UserRoles ur
                    INNER JOIN Roles r ON ur.RoleID = r.RoleID
                    WHERE ur.UserID = ?
                      AND r.IsDeleted = 0
                    ORDER BY r.RoleLevel ASC
                """;
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    try {
                        return User.Role.valueOf(rs.getString("RoleName"));
                    } catch (IllegalArgumentException ex) {
                        return null;
                    }
                }
            }
        }
        return null;
    }

    private String findUserStatus(Connection conn, int userId) throws SQLException {
        String sql = "SELECT Status FROM Users WHERE UserID = ? AND IsDeleted = 0";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("Status");
                }
            }
        }
        return User.AccountStatus.Inactive.name();
    }

    private int findRoleId(Connection conn, User.Role role) throws SQLException {
        String sql = "SELECT RoleID FROM Roles WHERE RoleName = ? AND IsDeleted = 0";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, role.name());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("RoleID");
                }
            }
        }
        throw new SQLException("Role not found: " + role.name());
    }

    private void setUserRole(Connection conn, int userId, User.Role role) throws SQLException {
        int roleId = findRoleId(conn, role);
        String updateSql = "UPDATE UserRoles SET RoleID = ? WHERE UserID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
            stmt.setInt(1, roleId);
            stmt.setInt(2, userId);
            if (stmt.executeUpdate() > 0) {
                return;
            }
        }

        String insertSql = "INSERT INTO UserRoles (UserID, RoleID) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, roleId);
            stmt.executeUpdate();
        }
    }

    private void ensureManagedProfile(Connection conn, int userId, User.Role role, String status, String actor) throws SQLException {
        String profileStatus = profileStatusForRole(role, status);
        if (role == User.Role.Member) {
            if (profileExists(conn, "Members", userId)) {
                String sql = """
                            UPDATE Members
                            SET MembershipStatus = ?,
                                IsDeleted = 0,
                                UpdatedBy = ?,
                                UpdatedDate = SYSDATETIME()
                            WHERE UserID = ?
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, profileStatus);
                    stmt.setString(2, actor);
                    stmt.setInt(3, userId);
                    stmt.executeUpdate();
                }
            } else {
                String sql = """
                            INSERT INTO Members (UserID, MembershipStatus, CreatedBy, CreatedDate, IsDeleted)
                            VALUES (?, ?, ?, SYSDATETIME(), 0)
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    stmt.setString(2, profileStatus);
                    stmt.setString(3, actor);
                    stmt.executeUpdate();
                }
            }
        } else if (role == User.Role.Staff) {
            if (profileExists(conn, "Staffs", userId)) {
                String sql = """
                            UPDATE Staffs
                            SET Status = ?,
                                IsDeleted = 0,
                                UpdatedBy = ?,
                                UpdatedDate = SYSDATETIME()
                            WHERE UserID = ?
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, profileStatus);
                    stmt.setString(2, actor);
                    stmt.setInt(3, userId);
                    stmt.executeUpdate();
                }
            } else {
                String sql = """
                            INSERT INTO Staffs (UserID, Position, Status, CreatedBy, CreatedDate, IsDeleted)
                            VALUES (?, ?, ?, ?, SYSDATETIME(), 0)
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    stmt.setString(2, "Staff");
                    stmt.setString(3, profileStatus);
                    stmt.setString(4, actor);
                    stmt.executeUpdate();
                }
            }
        }
    }

    private String profileStatusForRole(User.Role role, String accountStatus) {
        if (role == User.Role.Member && User.AccountStatus.Pending.name().equals(accountStatus)) {
            return "Pending";
        }
        return User.AccountStatus.Active.name().equals(accountStatus) ? "Active" : "Inactive";
    }

    private void disableManagedProfile(Connection conn, int userId, User.Role role, String actor) throws SQLException {
        if (role == User.Role.Member) {
            String sql = """
                        UPDATE Members
                        SET MembershipStatus = 'Inactive',
                            IsDeleted = 1,
                            UpdatedBy = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                    """;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, actor);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }
        } else if (role == User.Role.Staff) {
            String sql = """
                        UPDATE Staffs
                        SET Status = 'Inactive',
                            IsDeleted = 1,
                            UpdatedBy = ?,
                            UpdatedDate = SYSDATETIME()
                        WHERE UserID = ?
                    """;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, actor);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }
        }
    }

    private boolean profileExists(Connection conn, String tableName, int userId) throws SQLException {
        String sql = "SELECT 1 FROM " + tableName + " WHERE UserID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private boolean isStaffOrMember(User.Role role) {
        return role == User.Role.Staff || role == User.Role.Member;
    }

    private String normalizeBlank(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
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
            String sql = "SELECT TOP 1 r.RoleName FROM UserRoles ur "
                    + "INNER JOIN Roles r ON ur.RoleID = r.RoleID "
                    + "WHERE ur.UserID = ? "
                    + "ORDER BY r.RoleLevel ASC";
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
        if (roleName == null) {
            return null;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();

            if ("Admin".equalsIgnoreCase(roleName)) {
                String sql = "SELECT UserID, Email, DisplayName, Phone FROM Users "
                        + "WHERE UserID = ? AND IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    UserProfileBaseDTO adminProfile = new UserProfileBaseDTO();
                    setBaseProfileData(adminProfile, rs, roleName);
                    return adminProfile;
                }
            } else if ("Member".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, m.Gender, m.DateOfBirth, m.Address, m.MembershipStatus "
                        + "FROM Users u INNER JOIN Members m ON u.UserID = m.UserID "
                        + "WHERE u.UserID = ? AND u.IsDeleted = 0 AND m.IsDeleted = 0";
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
            } else if ("PT".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, pt.FullName, pt.Specialization, pt.Description, "
                        + "pt.CareerStartDate, pt.AvatarPath, pt.CertificateFileName, pt.CertificateFilePath "
                        + "FROM Users u INNER JOIN PersonalTrainers pt ON u.UserID = pt.UserID "
                        + "WHERE u.UserID = ? AND u.IsDeleted = 0 AND pt.IsDeleted = 0";
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
            } else if ("Staff".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, s.Position "
                        + "FROM Users u INNER JOIN Staffs s ON u.UserID = s.UserID "
                        + "WHERE u.UserID = ? AND u.IsDeleted = 0 AND s.IsDeleted = 0";
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

            // 1. Cáº­p nháº­t dá»¯ liá»‡u cá»‘t lÃµi vÃ o báº£ng Users chÃ­nh
            psUser = conn.prepareStatement(sqlUser);
            psUser.setString(1, profileDto.getDisplayName());
            psUser.setString(2, profileDto.getPhone());
            psUser.setInt(3, profileDto.getUserId());
            int userRows = psUser.executeUpdate();

            int subRows = 1; // Máº·c Ä‘á»‹nh há»£p lá»‡ cho trÆ°á»ng há»£p Admin hoáº·c Staff (khÃ´ng cÃ³ báº£ng phá»¥ cáº§n cáº­p nháº­t qua trang profile cá»§a DÆ°Æ¡ng)

            // 2. Ráº½ nhÃ¡nh cáº­p nháº­t dá»¯ liá»‡u Ä‘áº·c thÃ¹ phá»¥ thuá»™c theo vai trÃ²
            if ("Member".equalsIgnoreCase(roleName) && profileDto instanceof MemberProfileDTO) {
                MemberProfileDTO memberDto = (MemberProfileDTO) profileDto;
                String sqlMember = "UPDATE Members SET Gender = ?, DateOfBirth = ?, Address = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlMember);
                psSub.setString(1, memberDto.getGender());
                psSub.setDate(2, memberDto.getDateOfBirth());
                psSub.setString(3, memberDto.getAddress());
                psSub.setInt(4, memberDto.getUserId());
                subRows = psSub.executeUpdate();
            } else if ("PT".equalsIgnoreCase(roleName) && profileDto instanceof PTProfileDTO) {
                PTProfileDTO ptDto = (PTProfileDTO) profileDto;
                String sqlPT = "UPDATE PersonalTrainers SET FullName = ?, Description = ?, AvatarPath = ?, "
                        + "CertificateFileName = ?, CertificateFilePath = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlPT);
                psSub.setString(1, ptDto.getFullName());
                psSub.setString(2, ptDto.getDescription());
                psSub.setString(3, ptDto.getAvatarPath());
                psSub.setString(4, ptDto.getCertificateFileName());
                psSub.setString(5, ptDto.getCertificateFilePath());
                psSub.setInt(6, ptDto.getUserId());
                subRows = psSub.executeUpdate();
            }

            // 3. XÃ¡c nháº­n lÆ°u dá»¯ liá»‡u thÃ nh cÃ´ng náº¿u cáº£ 2 khá»‘i lá»‡nh thá»±c thi trÆ¡n tru
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
            if (psSub != null) {
                psSub.close();
            }
            closeResource(conn, psUser, null);
        }
        return success;
    }

    /* Update phone method to update PT's info */
    @Override
    public boolean updateBasicUserInfo(User user) {
        String sql = """
                UPDATE Users 
                SET Phone = ? 
                WHERE UserID = ? 
                  AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, user.getPhoneNumber());
            stm.setInt(2, user.getUserId());

            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
