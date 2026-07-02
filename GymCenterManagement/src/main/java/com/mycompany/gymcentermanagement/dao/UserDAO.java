/**
 * =========================================================================
 * @file          : UserDAO.java
 * @description   : Interface định nghĩa các thao tác dữ liệu cho người dùng, xác thực, token và hồ sơ tài khoản.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.dto.UserProfileBaseDTO;
import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    
    User findByEmail(String email) throws SQLException;

    User findById(int userId) throws SQLException;

    boolean insert(User user) throws SQLException;

    boolean update(User user) throws SQLException;

    boolean delete(int userId) throws SQLException;

    List<User> findAllActive() throws SQLException;

    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException;

    int countAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException;

    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit) throws SQLException;

    boolean checkEmailExistsForOtherUser(String email, int excludedUserId) throws SQLException;

    boolean checkPhoneExistsForOtherUser(String phone, int excludedUserId) throws SQLException;

    boolean insertManagedAccount(User user) throws SQLException;

    boolean updateManagedAccount(User user) throws SQLException;

    boolean changeManagedAccountRole(int userId, User.Role newRole, String updatedBy) throws SQLException;

    boolean updateAccountStatus(int userId, User.AccountStatus status, String updatedBy) throws SQLException;

    boolean deactivateAccount(int userId, String updatedBy) throws SQLException;

    boolean resetPassword(int userId, String newPasswordHash, String updatedBy) throws SQLException;

    // --- New Auth & Verification Methods ---
    
    boolean checkEmailExists(String email) throws SQLException;

    boolean checkPhoneExists(String phone) throws SQLException;
    
    boolean registerMember(User user, Member member, UserToken token) throws SQLException;
    
    String verifyAccountAndGetEmail(String tokenValue) throws SQLException;
    
    boolean saveRememberMeToken(UserToken token) throws SQLException;
    
    User getUserByRememberMeToken(String tokenValue) throws SQLException;
    
    boolean deleteRememberMeToken(String tokenValue) throws SQLException;
    
    int revokeRememberMeTokensByUserId(int userId) throws SQLException;

    boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;

    boolean changePasswordAndRevokeTokens(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;

    // --- Profile Methods (UC-03) ---
    
    String getHighestPriorityRole(int userId) throws SQLException;
    
    UserProfileBaseDTO getUserProfileById(int userId) throws SQLException;
    
    boolean updateUserProfile(UserProfileBaseDTO profileDto, String roleName) throws SQLException;

    boolean updateBasicUserInfo(User user);
}

