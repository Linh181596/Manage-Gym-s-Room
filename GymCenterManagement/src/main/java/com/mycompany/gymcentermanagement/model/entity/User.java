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
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

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
