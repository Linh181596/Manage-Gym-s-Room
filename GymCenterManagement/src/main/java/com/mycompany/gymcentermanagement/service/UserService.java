/**
 * =========================================================================
 * @file          : UserService.java
 * @description   : Interface định nghĩa các nghiệp vụ người dùng, xác thực, hồ sơ cá nhân và quản lý tài khoản cho Admin.
 * @author        : Nguyễn Đại Dương
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

    /** Tìm toàn bộ tài khoản theo từ khóa, vai trò và trạng thái cho chức năng quản lý tài khoản. */
    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status);

    /** Đếm số tài khoản thỏa điều kiện lọc để tính phân trang. */
    int countAccounts(String keyword, User.Role role, User.AccountStatus status);

    /** Tìm tài khoản theo điều kiện lọc trong một trang dữ liệu xác định. */
    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit);

    /** Lấy thông tin chi tiết một tài khoản theo mã người dùng. */
    User getAccountById(int userId);

    /** Tạo tài khoản Staff hoặc Member do Admin quản lý và trả về kết quả cùng mật khẩu tạm khi thành công. */
    AccountOperationResult createManagedAccount(User user, String createdBy);

    /** Cập nhật thông tin, trạng thái và vai trò hợp lệ của một tài khoản được quản lý. */
    AccountOperationResult updateManagedAccount(User user, User.Role requestedRole, int currentAdminId, String updatedBy);

    /** Đổi vai trò giữa Staff và Member cho tài khoản đủ điều kiện. */
    AccountOperationResult changeManagedAccountRole(int targetUserId, User.Role newRole, int currentAdminId, String updatedBy);

    /** Cập nhật trạng thái Active, Locked hoặc Inactive sau khi kiểm tra các ràng buộc nghiệp vụ. */
    AccountOperationResult updateAccountStatus(int targetUserId, User.AccountStatus status, int currentAdminId, String updatedBy);

    /** Khóa tài khoản và ngăn Admin khóa chính tài khoản đang đăng nhập. */
    AccountOperationResult lockAccount(int targetUserId, int currentAdminId, String updatedBy);

    /** Mở khóa một tài khoản hiện đang có trạng thái Locked. */
    AccountOperationResult unlockAccount(int targetUserId, String updatedBy);

    /** Vô hiệu hóa mềm tài khoản sau khi kiểm tra các lịch và gói dịch vụ còn ràng buộc. */
    AccountOperationResult deactivateAccount(int targetUserId, int currentAdminId, String updatedBy);

    /** Sinh mật khẩu tạm mới, bắt buộc đổi mật khẩu ở lần đăng nhập sau và trả mật khẩu tạm cho controller. */
    AccountOperationResult resetManagedPassword(int targetUserId, String updatedBy);

    boolean updateBasicUserInfo(User user);

    boolean checkEmailExists(String email);

    boolean checkPhoneExists(String phone);

    boolean createUser(User user);

    User getUserByEmail(String email);
}
