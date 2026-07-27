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
    
    // Tìm thông tin xác thực và role của user theo email trong luồng đăng nhập.
    User findByEmail(String email) throws SQLException;

    // Tải lại user theo ID để kiểm tra trạng thái tài khoản trong các request đã đăng nhập.
    User findById(int userId) throws SQLException;

    boolean insert(User user) throws SQLException;

    boolean update(User user) throws SQLException;

    boolean delete(int userId) throws SQLException;

    List<User> findAllActive() throws SQLException;

    /** Tìm toàn bộ tài khoản theo điều kiện lọc của màn hình Manage Accounts. */
    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException;

    /** Đếm số tài khoản phù hợp với điều kiện lọc để phân trang. */
    int countAccounts(String keyword, User.Role role, User.AccountStatus status) throws SQLException;

    /** Tìm tài khoản theo điều kiện lọc trong một khoảng phân trang. */
    List<User> searchAccounts(String keyword, User.Role role, User.AccountStatus status, int offset, int limit) throws SQLException;

    /** Kiểm tra email đã được một tài khoản khác sử dụng hay chưa. */
    boolean checkEmailExistsForOtherUser(String email, int excludedUserId) throws SQLException;

    /** Kiểm tra số điện thoại đã được một tài khoản khác sử dụng hay chưa. */
    boolean checkPhoneExistsForOtherUser(String phone, int excludedUserId) throws SQLException;

    /** Thêm Users, UserRoles và profile Member hoặc Staff trong cùng một transaction. */
    boolean insertManagedAccount(User user) throws SQLException;

    /** Cập nhật thông tin tài khoản và đồng bộ role/profile khi Admin thay đổi dữ liệu. */
    boolean updateManagedAccount(User user) throws SQLException;

    /** Đổi role Staff và Member, đồng thời đồng bộ các bảng profile liên quan. */
    boolean changeManagedAccountRole(int userId, User.Role newRole, String updatedBy) throws SQLException;

    /** Cập nhật trạng thái tài khoản và trạng thái profile Member hoặc Staff tương ứng. */
    boolean updateAccountStatus(int userId, User.AccountStatus status, String updatedBy) throws SQLException;

    /** Vô hiệu hóa mềm tài khoản bằng cách chuyển trạng thái sang Inactive. */
    boolean deactivateAccount(int userId, String updatedBy) throws SQLException;

    /** Kiểm tra PT còn lịch dạy chưa hoàn tất hoặc hủy, dùng trước khi khóa/vô hiệu hóa. */
    boolean hasBlockingPTSchedule(int userId) throws SQLException;

    /** Kiểm tra Member còn lịch PT ràng buộc, dùng trước khi vô hiệu hóa. */
    boolean hasBlockingMemberSchedule(int userId) throws SQLException;

    /** Kiểm tra Member còn gói Gym Pending hoặc Active, dùng trước khi hạn chế tài khoản. */
    boolean hasBlockingMemberGymPackage(int userId) throws SQLException;

    /** Đặt mật khẩu đã băm, yêu cầu đổi mật khẩu và thu hồi token Remember Me của tài khoản. */
    boolean resetPassword(int userId, String newPasswordHash, String updatedBy) throws SQLException;

    // --- New Auth & Verification Methods ---
    
    /**
     * Kiểm tra email đã tồn tại trong hệ thống hay chưa.
     */
    boolean checkEmailExists(String email) throws SQLException;

    /**
     * Kiểm tra số điện thoại đã tồn tại trong hệ thống hay chưa.
     */
    boolean checkPhoneExists(String phone) throws SQLException;
    
    boolean registerMember(User user, Member member, UserToken token) throws SQLException;
    
    String verifyAccountAndGetEmail(String tokenValue) throws SQLException;
    
    // Lưu token Remember Me được tạo sau khi đăng nhập thành công.
    boolean saveRememberMeToken(UserToken token) throws SQLException;
    
    // Lấy user từ token Remember Me hợp lệ để thực hiện tự động đăng nhập.
    User getUserByRememberMeToken(String tokenValue) throws SQLException;
    
    // Thu hồi token Remember Me khi người dùng đăng xuất.
    boolean deleteRememberMeToken(String tokenValue) throws SQLException;
    
    /** Thu hồi toàn bộ token Remember Me của tài khoản khi bị khóa hoặc vô hiệu hóa. */
    int revokeRememberMeTokensByUserId(int userId) throws SQLException;

    /** Cập nhật mật khẩu đã băm và cờ bắt buộc đổi mật khẩu của một tài khoản. */
    boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;

    /** Đổi mật khẩu của người dùng và thu hồi token Remember Me trong cùng một transaction. */
    boolean changePasswordAndRevokeTokens(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;

    /** Lưu token đặt lại mật khẩu mới sau khi thu hồi các token reset cũ chưa dùng của cùng người dùng. */
    boolean savePasswordResetToken(UserToken token) throws SQLException;

    /** Lấy người dùng còn hoạt động từ token đặt lại mật khẩu chưa dùng và chưa hết hạn. */
    User getUserByPasswordResetToken(String tokenValue) throws SQLException;

    /** Đặt mật khẩu theo token hợp lệ, đánh dấu token reset đã dùng và thu hồi token Remember Me. */
    boolean resetPasswordByToken(String tokenValue, String newPasswordHash) throws SQLException;

    // --- Profile Methods (UC-03) ---
    
    // Lấy role ưu tiên của user để chọn DTO, form và bảng hồ sơ tương ứng.
    String getHighestPriorityRole(int userId) throws SQLException;
    
    // Tải hồ sơ chung và dữ liệu riêng theo role của user từ cơ sở dữ liệu.
    UserProfileBaseDTO getUserProfileById(int userId) throws SQLException;
    
    // Cập nhật dữ liệu Users cùng bảng hồ sơ Member hoặc PersonalTrainers trong một transaction.
    boolean updateUserProfile(UserProfileBaseDTO profileDto, String roleName) throws SQLException;

    // Cập nhật thông tin cơ bản của user; đây là hàm hỗ trợ cũ, không phải luồng /profile chính hiện tại.
    boolean updateBasicUserInfo(User user);
}

