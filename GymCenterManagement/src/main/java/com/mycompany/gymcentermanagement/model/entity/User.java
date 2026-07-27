package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDateTime;

/**
 * Entity representing the 'users' table in the database.
 */
public class User {

    public enum Role {
        Admin, Staff, Member, PT
    }

    public enum AccountStatus {
        Active, Inactive, Pending, Rejected, Locked
    }

    private int userId;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phoneNumber;
    private String avatarPath; // Thêm trường avatarPath để hiển thị ảnh đại diện
    private Role role;
    private AccountStatus accountStatus;
    private boolean mustChangePassword; //add new attribute for change pass

    // Cho biết user vừa xác thực có bị buộc chuyển sang luồng đổi mật khẩu trước khi vào dashboard hay không.
    public boolean isMustChangePassword() { //new getter
        return mustChangePassword;
    }

    public void setMustChangePassword(boolean mustChangePassword) { //new setter
        this.mustChangePassword = mustChangePassword;
    }

    // Audit Metadata
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean isDeleted;

    public User() {
    }

    public User(int userId, String email, String passwordHash, String fullName, String phoneNumber, Role role, AccountStatus accountStatus) {
        this.userId = userId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.accountStatus = accountStatus;
    }

    public User(AccountStatus accountStatus, String createdBy, int userId, LocalDateTime updatedDate, String updatedBy, Role role, String passwordHash, boolean mustChangePassword, String email, LocalDateTime createdDate, String fullName, boolean isDeleted, String phoneNumber) {
        this.accountStatus = accountStatus;
        this.createdBy = createdBy;
        this.userId = userId;
        this.updatedDate = updatedDate;
        this.updatedBy = updatedBy;
        this.role = role;
        this.passwordHash = passwordHash;
        this.mustChangePassword = mustChangePassword;
        this.email = email;
        this.createdDate = createdDate;
        this.fullName = fullName;
        this.isDeleted = isDeleted;
        this.phoneNumber = phoneNumber;
    }

    // Getters and Setters
    // Trả về ID dùng để tạo token, kiểm tra trạng thái và gắn session với user.
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    // Gán email đã được RegisterController validate để lưu vào bản ghi Users mới.
    public void setEmail(String email) {
        this.email = email;
    }

    // Trả về hash mật khẩu lưu trong DB để LoginController so sánh với hash của mật khẩu nhập vào.
    public String getPasswordHash() {
        return passwordHash;
    }

    // Gán mật khẩu đã băm SHA-256; RegisterController không lưu mật khẩu thô xuống cơ sở dữ liệu.
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    // Gán họ tên từ form đăng ký vào cột DisplayName của Users.
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    // Gán số điện thoại đã kiểm tra trùng lặp để lưu vào Users.
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    // Trả về role để LoginController và AuthenticationFilter điều hướng, phân quyền sau đăng nhập.
    public Role getRole() {
        return role;
    }

    // Gán role Member mặc định cho tài khoản được tạo từ form đăng ký công khai.
    public void setRole(Role role) {
        this.role = role;
    }

    // Trả về trạng thái tài khoản để chặn user Inactive hoặc Locked trong luồng xác thực.
    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

    // Gán trạng thái Inactive khi đăng ký; trạng thái sẽ đổi thành Active sau khi xác minh email.
    public void setAccountStatus(AccountStatus accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role=" + role +
                ", accountStatus=" + accountStatus +
                '}';
    }
}
