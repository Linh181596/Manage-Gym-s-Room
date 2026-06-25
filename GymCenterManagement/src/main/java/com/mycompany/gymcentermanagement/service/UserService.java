/**
 * =========================================================================
 * @file          : UserService.java
 * @description   : Interface định nghĩa các nghiệp vụ người dùng, xác thực, hồ sơ cá nhân và quản lý tài khoản cho Admin.
 * @author        : Codex
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dto.AccountOperationResult;
import com.mycompany.gymcentermanagement.model.entity.User;
import java.util.List;

/**
 * Service interface for User business operations (Auth, Account Management).
 */
public interface UserService {

    /**
     * Authenticates a user with email and password.
     * 
     * @param email       The email of the user.
     * @param rawPassword The plain text password.
     * @return User object if authentication is successful, null otherwise.
     */
    User login(String email, String rawPassword);

    /**
     * Registers a new Member user. Hashes the password and sets default status.
     * 
     * @param user        The User entity.
     * @param rawPassword The plain text password to hash.
     * @return true if registration is successful.
     */
    boolean registerMember(User user, String rawPassword);

    /**
     * Gets user profile details by ID.
     * 
     * @param userId The ID of the user.
     * @return User entity or null if not found.
     */
    User getProfile(int userId);

    /**
     * Updates profile details of a user.
     * 
     * @param user The User entity with updated fields.
     * @return true if update is successful.
     */
    boolean updateProfile(User user);

    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status);

    User getAccountById(int userId);

    AccountOperationResult createManagedAccount(User user, String createdBy);

    AccountOperationResult updateManagedAccount(User user, User.Role requestedRole, int currentAdminId, String updatedBy);

    AccountOperationResult changeManagedAccountRole(int targetUserId, User.Role newRole, int currentAdminId, String updatedBy);

    AccountOperationResult updateAccountStatus(int targetUserId, User.AccountStatus status, int currentAdminId, String updatedBy);

    AccountOperationResult lockAccount(int targetUserId, int currentAdminId, String updatedBy);

    AccountOperationResult unlockAccount(int targetUserId, String updatedBy);

    AccountOperationResult deactivateAccount(int targetUserId, int currentAdminId, String updatedBy);

    AccountOperationResult resetManagedPassword(int targetUserId, String updatedBy);

    boolean updateBasicUserInfo(User user);

    boolean checkEmailExists(String email);

    boolean checkPhoneExists(String phone);

    boolean createUser(User user);

    User getUserByEmail(String email);
}
