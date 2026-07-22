/**
 * =========================================================================
 * @file          : UserServiceImpl.java
 * @description   : Lớp triển khai nghiệp vụ người dùng và các quy tắc quản lý tài khoản theo UC-05 cho Admin.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.dto.AccountOperationResult;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service implementation for User business operations.
 */
public class UserServiceImpl implements UserService {
    private static final Logger LOGGER = Logger.getLogger(UserServiceImpl.class.getName());
    private static final String PT_BLOCKING_SCHEDULE_MESSAGE = "PT đang có lịch dạy, vui lòng xử lý lịch trước.";
    
    // In a clean JEE environment, this can be injected via CDI.
    // Here we instantiate manually for simplicity.
    private final UserDAO userDAO = new UserDAOImpl();

    /**
     * Xác thực thông tin đăng nhập của người dùng.
     * Luồng nghiệp vụ: Tìm kiếm người dùng theo email. Nếu tìm thấy, kiểm tra mật khẩu.
     * Nếu mật khẩu đúng, kiểm tra trạng thái tài khoản.
     * [BR-CONS-01]: Only active users can log in to the system.
     * 
     * @param email Email đăng nhập
     * @param rawPassword Mật khẩu thô
     * @return Đối tượng User nếu đăng nhập thành công và tài khoản Active, ngược lại trả về null
     */
    @Override
    public User login(String email, String rawPassword) {
        try {
            User user = userDAO.findByEmail(email);
            if (user != null && PasswordUtils.checkPassword(rawPassword, user.getPasswordHash())) {
                // Ensure account is Active before allowing login
                // [BR-CONS-01]: Only active users can log in to the system.
                if (user.getAccountStatus() == User.AccountStatus.Active) {
                    return user;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error performing authentication for: " + email, ex);
        }
        return null;
    }

    /**
     * Đăng ký tài khoản Member mới.
     * Luồng nghiệp vụ: Kiểm tra email đã tồn tại hay chưa ([BR-CONS-02]).
     * Nếu chưa, mã hóa mật khẩu, gán vai trò Member, trạng thái Active và lưu vào DB.
     * 
     * @param user Thông tin người dùng cần đăng ký
     * @param rawPassword Mật khẩu thô
     * @return true nếu đăng ký thành công, ngược lại false
     */
    @Override
    public boolean registerMember(User user, String rawPassword) {
        try {
            // Check if email already registered
            // [BR-CONS-02]: Each email address must be unique in the system.
            if (userDAO.findByEmail(user.getEmail()) != null) {
                LOGGER.warning("Registration failed: Email already exists: " + user.getEmail());
                return false;
            }

            // Set user identifiers and system attributes
            user.setPasswordHash(PasswordUtils.hashPassword(rawPassword));
            user.setRole(User.Role.Member);
            user.setAccountStatus(User.AccountStatus.Active);
            user.setCreatedBy("System/Registration");
            user.setCreatedDate(LocalDateTime.now());

            return userDAO.insert(user);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error performing registration for: " + user.getEmail(), ex);
        }
        return false;
    }

    @Override
    public User getProfile(int userId) {
        try {
            return userDAO.findById(userId);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading profile for user ID: " + userId, ex);
        }
        return null;
    }

    @Override
    public boolean updateProfile(User user) {
        try {
            User existing = userDAO.findById(user.getUserId());
            if (existing == null) {
                return false;
            }

            // Update basic editable details
            existing.setFullName(user.getFullName());
            existing.setPhoneNumber(user.getPhoneNumber());
            existing.setEmail(user.getEmail());
            existing.setUpdatedBy(String.valueOf(user.getUserId()));
            existing.setUpdatedDate(LocalDateTime.now());

            return userDAO.update(existing);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating profile for user ID: " + user.getUserId(), ex);
        }
        return false;
    }

    @Override
    public List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status) {
        try {
            return userDAO.searchAccounts(keyword, role, status);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error searching accounts", ex);
            return List.of();
        }
    }

    @Override
    public int countAccounts(String keyword, User.Role role, User.AccountStatus status) {
        try {
            return userDAO.countAccounts(keyword, role, status);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error counting accounts", ex);
            return 0;
        }
    }

    @Override
    public List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit) {
        try {
            return userDAO.searchAccounts(keyword, role, status, offset, limit);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error searching accounts paginated", ex);
            return List.of();
        }
    }

    @Override
    public User getAccountById(int userId) {
        try {
            return userDAO.findById(userId);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading account for user ID: " + userId, ex);
            return null;
        }
    }

    /**
     * Tạo tài khoản quản lý (Staff hoặc Member) bởi Admin/Staff.
     * Luồng nghiệp vụ: Kiểm tra phân quyền role hợp lệ, validate dữ liệu đầu vào.
     * Tạo mật khẩu tạm thời ngẫu nhiên ([BR-ACT-22]), yêu cầu đổi mật khẩu ở lần đăng nhập đầu tiên.
     * Lưu tài khoản vào DB và trả về kết quả kèm mật khẩu tạm thời.
     * 
     * @param user Thông tin tài khoản cần tạo
     * @param createdBy Người tạo tài khoản
     * @return AccountOperationResult chứa kết quả và thông điệp xử lý
     */
    @Override
    public AccountOperationResult createManagedAccount(User user, String createdBy) {
        try {
            if (!isStaffOrMember(user.getRole())) {
                return AccountOperationResult.failure("Chỉ được tạo tài khoản Staff hoặc Member trong chức năng này.");
            }

            AccountOperationResult validation = validateAccountData(user, 0);
            if (!validation.isSuccess()) {
                return validation;
            }

            // [BR-ACT-22]: Generate a temporary password, store only hashed password, require change at first login.
            String temporaryPassword = PasswordUtils.generateTemporaryPassword(10);
            user.setPasswordHash(PasswordUtils.hashPassword(temporaryPassword));
            user.setMustChangePassword(true);
            user.setCreatedBy(normalizeActor(createdBy));
            user.setCreatedDate(LocalDateTime.now());
            if (user.getAccountStatus() == null) {
                user.setAccountStatus(User.AccountStatus.Active);
            }

            boolean created = userDAO.insertManagedAccount(user);
            if (!created) {
                return AccountOperationResult.failure("Không thể tạo tài khoản. Vui lòng thử lại.");
            }

            return AccountOperationResult.successWithTemporaryPassword("Tạo tài khoản thành công.", temporaryPassword);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error creating managed account", ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi tạo tài khoản.");
        }
    }

    @Override
    public AccountOperationResult updateManagedAccount(User user, User.Role requestedRole, int currentAdminId, String updatedBy) {
        try {
            User existing = userDAO.findById(user.getUserId());
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            User.Role targetRole = requestedRole != null ? requestedRole : existing.getRole();
            boolean roleChanged = existing.getRole() != targetRole;
            if (roleChanged && (targetRole == User.Role.Admin || targetRole == User.Role.PT)) {
                return AccountOperationResult.failure("Không được gán vai trò Admin hoặc Personal Trainer trong chức năng Account Management.");
            }

            if (roleChanged && (!isStaffOrMember(existing.getRole()) || !isStaffOrMember(targetRole))) {
                return AccountOperationResult.failure("Chỉ được đổi vai trò giữa Staff và Member.");
            }

            if (roleChanged && existing.getUserId() == currentAdminId) {
                return AccountOperationResult.failure("Không thể đổi vai trò của chính tài khoản đang đăng nhập.");
            }

            if (user.getAccountStatus() == null) {
                return AccountOperationResult.failure("Vui lòng chọn trạng thái tài khoản.");
            }

            if (!isSupportedAccountStatus(user.getAccountStatus())) {
                return AccountOperationResult.failure("Trạng thái tài khoản không hợp lệ.");
            }

            if (existing.getAccountStatus() == User.AccountStatus.Inactive
                    && user.getAccountStatus() == User.AccountStatus.Locked) {
                return AccountOperationResult.failure("Tài khoản đã vô hiệu hóa không thể chuyển sang trạng thái khóa.");
            }

            if (existing.getUserId() == currentAdminId && existing.getAccountStatus() != user.getAccountStatus()) {
                return AccountOperationResult.failure("Không thể đổi trạng thái của chính tài khoản đang đăng nhập.");
            }

            AccountOperationResult ptScheduleCheck = validatePTScheduleBeforeRestrictedStatus(existing, user.getAccountStatus());
            if (!ptScheduleCheck.isSuccess()) {
                return ptScheduleCheck;
            }

            user.setRole(targetRole);
            AccountOperationResult validation = validateAccountData(user, user.getUserId());
            if (!validation.isSuccess()) {
                return validation;
            }

            existing.setEmail(user.getEmail());
            existing.setFullName(user.getFullName());
            existing.setPhoneNumber(user.getPhoneNumber());
            existing.setAccountStatus(user.getAccountStatus());
            existing.setRole(targetRole);
            existing.setUpdatedBy(normalizeActor(updatedBy));
            existing.setUpdatedDate(LocalDateTime.now());

            boolean updated = userDAO.updateManagedAccount(existing);
            if (!updated) {
                return AccountOperationResult.failure("Không thể lưu thay đổi tài khoản.");
            }

            return AccountOperationResult.success("Cập nhật tài khoản thành công.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating managed account ID: " + user.getUserId(), ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi cập nhật tài khoản.");
        }
    }

    @Override
    public AccountOperationResult changeManagedAccountRole(int targetUserId, User.Role newRole, int currentAdminId, String updatedBy) {
        try {
            if (targetUserId == currentAdminId) {
                return AccountOperationResult.failure("Không thể đổi vai trò của chính tài khoản đang đăng nhập.");
            }

            if (!isStaffOrMember(newRole)) {
                return AccountOperationResult.failure("Chỉ được đổi vai trò giữa Staff và Member.");
            }

            User existing = userDAO.findById(targetUserId);
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            if (!isStaffOrMember(existing.getRole())) {
                return AccountOperationResult.failure("Chỉ tài khoản Staff và Member được đổi vai trò bằng thao tác này.");
            }

            boolean changed = userDAO.changeManagedAccountRole(targetUserId, newRole, normalizeActor(updatedBy));
            if (!changed) {
                return AccountOperationResult.failure("Không thể đổi vai trò tài khoản.");
            }

            return AccountOperationResult.success("Đổi vai trò tài khoản thành công.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error changing account role ID: " + targetUserId, ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi đổi vai trò tài khoản.");
        }
    }

    @Override
    public AccountOperationResult updateAccountStatus(int targetUserId, User.AccountStatus status, int currentAdminId, String updatedBy) {
        try {
            if (status == null) {
                return AccountOperationResult.failure("Vui lòng chọn trạng thái tài khoản.");
            }

            if (!isSupportedAccountStatus(status)) {
                return AccountOperationResult.failure("Trạng thái tài khoản không hợp lệ.");
            }

            User existing = userDAO.findById(targetUserId);
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            if (existing.getAccountStatus() == User.AccountStatus.Inactive
                    && status == User.AccountStatus.Locked) {
                return AccountOperationResult.failure("Tài khoản đã vô hiệu hóa không thể chuyển sang trạng thái khóa.");
            }

            if (targetUserId == currentAdminId && existing.getAccountStatus() != status) {
                return AccountOperationResult.failure("Không thể đổi trạng thái của chính tài khoản đang đăng nhập.");
            }

            AccountOperationResult ptScheduleCheck = validatePTScheduleBeforeRestrictedStatus(existing, status);
            if (!ptScheduleCheck.isSuccess()) {
                return ptScheduleCheck;
            }

            boolean updated = userDAO.updateAccountStatus(targetUserId, status, normalizeActor(updatedBy));
            if (!updated) {
                return AccountOperationResult.failure("Không thể cập nhật trạng thái tài khoản.");
            }

            return AccountOperationResult.success("Cập nhật trạng thái tài khoản thành công.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating account status ID: " + targetUserId, ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi cập nhật trạng thái tài khoản.");
        }
    }

    @Override
    public AccountOperationResult lockAccount(int targetUserId, int currentAdminId, String updatedBy) {
        if (targetUserId == currentAdminId) {
            return AccountOperationResult.failure("Không thể khóa chính tài khoản đang đăng nhập.");
        }

        User existing = getAccountById(targetUserId);
        if (existing == null) {
            return AccountOperationResult.failure("Không tìm thấy tài khoản.");
        }

        if (existing.getAccountStatus() == User.AccountStatus.Inactive) {
            return AccountOperationResult.failure("Tài khoản đã vô hiệu hóa không thể khóa. Trạng thái Inactive cần được giữ nguyên.");
        }

        return updateAccountStatus(targetUserId, User.AccountStatus.Locked, currentAdminId, updatedBy);
    }

    @Override
    public AccountOperationResult unlockAccount(int targetUserId, String updatedBy) {
        try {
            User existing = userDAO.findById(targetUserId);
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            if (existing.getAccountStatus() != User.AccountStatus.Locked) {
                return AccountOperationResult.failure("Chỉ tài khoản đang bị khóa mới có thể mở khóa.");
            }

            boolean updated = userDAO.updateAccountStatus(targetUserId, User.AccountStatus.Active, normalizeActor(updatedBy));
            if (!updated) {
                return AccountOperationResult.failure("Không thể mở khóa tài khoản.");
            }

            return AccountOperationResult.success("Mở khóa tài khoản thành công.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error unlocking account ID: " + targetUserId, ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi mở khóa tài khoản.");
        }
    }

    @Override
    public AccountOperationResult deactivateAccount(int targetUserId, int currentAdminId, String updatedBy) {
        try {
            if (targetUserId == currentAdminId) {
                return AccountOperationResult.failure("Không thể vô hiệu hóa chính tài khoản đang đăng nhập.");
            }

            User existing = userDAO.findById(targetUserId);
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            AccountOperationResult ptScheduleCheck = validatePTScheduleBeforeRestrictedStatus(existing, User.AccountStatus.Inactive);
            if (!ptScheduleCheck.isSuccess()) {
                return ptScheduleCheck;
            }

            boolean deactivated = userDAO.deactivateAccount(targetUserId, normalizeActor(updatedBy));
            if (!deactivated) {
                return AccountOperationResult.failure("Không thể vô hiệu hóa tài khoản.");
            }

            return AccountOperationResult.success("Vô hiệu hóa tài khoản thành công.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deactivating account ID: " + targetUserId, ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi vô hiệu hóa tài khoản.");
        }
    }

    @Override
    public AccountOperationResult resetManagedPassword(int targetUserId, String updatedBy) {
        try {
            User existing = userDAO.findById(targetUserId);
            if (existing == null) {
                return AccountOperationResult.failure("Không tìm thấy tài khoản.");
            }

            String temporaryPassword = PasswordUtils.generateTemporaryPassword(10);
            String hashedPassword = PasswordUtils.hashPassword(temporaryPassword);
            boolean reset = userDAO.resetPassword(targetUserId, hashedPassword, normalizeActor(updatedBy));

            if (!reset) {
                return AccountOperationResult.failure("Không thể đặt lại mật khẩu tài khoản.");
            }

            return AccountOperationResult.successWithTemporaryPassword("Đặt lại mật khẩu thành công.", temporaryPassword);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error resetting password for account ID: " + targetUserId, ex);
            return AccountOperationResult.failure("Lỗi cơ sở dữ liệu khi đặt lại mật khẩu tài khoản.");
        }
    }

    /**
     * Xác thực tính hợp lệ của dữ liệu tài khoản (email, số điện thoại, trạng thái).
     * Luồng nghiệp vụ: Chuẩn hóa dữ liệu. Kiểm tra các trường bắt buộc, định dạng email, số điện thoại.
     * Kiểm tra tính duy nhất của email ([BR-CONS-02]) và số điện thoại ([BR-CONS-40]).
     * 
     * @param user Thông tin người dùng
     * @param excludedUserId ID người dùng ngoại trừ (dùng khi cập nhật)
     * @return AccountOperationResult
     * @throws SQLException nếu có lỗi truy vấn CSDL
     */
    private AccountOperationResult validateAccountData(User user, int excludedUserId) throws SQLException {
        user.setFullName(normalizeBlank(user.getFullName()));
        user.setEmail(normalizeBlank(user.getEmail()));
        user.setPhoneNumber(normalizeBlank(user.getPhoneNumber()));

        if (user.getFullName() == null) {
            return AccountOperationResult.failure("Vui lòng nhập họ và tên.");
        }

        if (user.getEmail() == null || !user.getEmail().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return AccountOperationResult.failure("Email không hợp lệ.");
        }

        if (user.getPhoneNumber() == null || !user.getPhoneNumber().matches("^0[0-9]{9}$")) {
            return AccountOperationResult.failure("Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số.");
        }

        if (user.getRole() == null) {
            return AccountOperationResult.failure("Vui lòng chọn vai trò tài khoản.");
        }

        if (user.getAccountStatus() == null) {
            return AccountOperationResult.failure("Vui lòng chọn trạng thái tài khoản.");
        }

        if (!isSupportedAccountStatus(user.getAccountStatus())) {
            return AccountOperationResult.failure("Trạng thái tài khoản không hợp lệ.");
        }

        // [BR-CONS-02]: Each email address must be unique in the system.
        if (userDAO.checkEmailExistsForOtherUser(user.getEmail(), excludedUserId)) {
            return AccountOperationResult.failure("Email đã được sử dụng bởi tài khoản khác.");
        }

        // [BR-CONS-40]: Each phone number must be unique in the system for User accounts.
        if (userDAO.checkPhoneExistsForOtherUser(user.getPhoneNumber(), excludedUserId)) {
            return AccountOperationResult.failure("Số điện thoại đã được sử dụng bởi tài khoản khác.");
        }

        return AccountOperationResult.success("Dữ liệu tài khoản hợp lệ.");
    }

    private boolean isStaffOrMember(User.Role role) {
        return role == User.Role.Staff || role == User.Role.Member;
    }

    private boolean isSupportedAccountStatus(User.AccountStatus status) {
        return status == User.AccountStatus.Active
                || status == User.AccountStatus.Inactive
                || status == User.AccountStatus.Locked;
    }

    private AccountOperationResult validatePTScheduleBeforeRestrictedStatus(User account, User.AccountStatus targetStatus)
            throws SQLException {
        if (account.getRole() != User.Role.PT) {
            return AccountOperationResult.success("OK");
        }

        if (targetStatus != User.AccountStatus.Locked && targetStatus != User.AccountStatus.Inactive) {
            return AccountOperationResult.success("OK");
        }

        if (userDAO.hasBlockingPTSchedule(account.getUserId())) {
            return AccountOperationResult.failure(PT_BLOCKING_SCHEDULE_MESSAGE);
        }

        return AccountOperationResult.success("OK");
    }

    private String normalizeBlank(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String normalizeActor(String actor) {
        String normalizedActor = normalizeBlank(actor);
        return normalizedActor != null ? normalizedActor : "Admin";
    }

    @Override
    public boolean updateBasicUserInfo(User user) {
        return userDAO.updateBasicUserInfo(user);
    }

    /**
     * Kiểm tra sự tồn tại của email.
     * [BR-CONS-02]: Each email address must be unique in the system.
     * @param email Email cần kiểm tra
     * @return true nếu tồn tại
     */
    @Override
    public boolean checkEmailExists(String email) {
        try {
            return userDAO.checkEmailExists(email);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking email existence: " + email, ex);
        }
        return false;
    }

    /**
     * Kiểm tra sự tồn tại của số điện thoại.
     * [BR-CONS-40]: Each phone number must be unique in the system for User accounts.
     * @param phone Số điện thoại cần kiểm tra
     * @return true nếu tồn tại
     */
    @Override
    public boolean checkPhoneExists(String phone) {
        try {
            return userDAO.checkPhoneExists(phone);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking phone existence: " + phone, ex);
        }
        return false;
    }

    @Override
    public boolean createUser(User user) {
        try {
            user.setCreatedDate(java.time.LocalDateTime.now());
            return userDAO.insert(user);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error creating user: " + user.getEmail(), ex);
        }
        return false;
    }

    @Override
    public User getUserByEmail(String email) {
        try {
            return userDAO.findByEmail(email);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error retrieving user by email: " + email, ex);
        }
        return null;
    }
}
