/**
 * =========================================================================
 * @file          : StaffPTAttendance.java
 * @description   : Thực thể đại diện cho bản ghi điểm danh của Staff và PT.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Entity representing the 'StaffPTAttendance' table in the database.
 * Ghi lại mỗi lần check-in (điểm danh) của Staff hoặc Personal Trainer.
 */
public class StaffPTAttendance {

    /** Ca làm việc */
    public enum ShiftBlock {
        Morning, Afternoon, Evening
    }

    /** Loại người dùng được điểm danh */
    public enum UserRole {
        Staff, PT
    }

    private int attendanceId;
    private int userId;
    private UserRole userRole;
    private LocalDateTime checkedInAt;
    private LocalDate attendanceDate;   // computed column từ DB
    private ShiftBlock shiftBlock;
    private int checkedBy;
    private String note;

    // Audit
    private String createdBy;
    private LocalDateTime createdDate;
    private boolean deleted;

    // Joined fields (từ query JOIN Users)
    private String targetFullName;      // tên người được điểm danh
    private String targetEmail;
    private String checkedByName;       // tên staff thực hiện điểm danh

    public StaffPTAttendance() {
    }

    // ------------------------------------------------------------------ //
    //  Getters & Setters
    // ------------------------------------------------------------------ //

    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = UserRole.valueOf(userRole);
    }

    public LocalDateTime getCheckedInAt() {
        return checkedInAt;
    }

    public void setCheckedInAt(LocalDateTime checkedInAt) {
        this.checkedInAt = checkedInAt;
    }

    public LocalDate getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(LocalDate attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public ShiftBlock getShiftBlock() {
        return shiftBlock;
    }

    public void setShiftBlock(ShiftBlock shiftBlock) {
        this.shiftBlock = shiftBlock;
    }

    public void setShiftBlock(String shiftBlock) {
        this.shiftBlock = ShiftBlock.valueOf(shiftBlock);
    }

    public int getCheckedBy() {
        return checkedBy;
    }

    public void setCheckedBy(int checkedBy) {
        this.checkedBy = checkedBy;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    // ---- Joined fields ------------------------------------------------ //

    public String getTargetFullName() {
        return targetFullName;
    }

    public void setTargetFullName(String targetFullName) {
        this.targetFullName = targetFullName;
    }

    public String getTargetEmail() {
        return targetEmail;
    }

    public void setTargetEmail(String targetEmail) {
        this.targetEmail = targetEmail;
    }

    public String getCheckedByName() {
        return checkedByName;
    }

    public void setCheckedByName(String checkedByName) {
        this.checkedByName = checkedByName;
    }

    /** Label hiển thị ca làm việc bằng tiếng Việt */
    public String getShiftLabel() {
        if (shiftBlock == null) return "";
        return switch (shiftBlock) {
            case Morning   -> "Sáng (Morning)";
            case Afternoon -> "Chiều (Afternoon)";
            case Evening   -> "Tối (Evening)";
        };
    }

    @Override
    public String toString() {
        return "StaffPTAttendance{"
                + "attendanceId=" + attendanceId
                + ", userId=" + userId
                + ", userRole=" + userRole
                + ", checkedInAt=" + checkedInAt
                + ", shiftBlock=" + shiftBlock
                + '}';
    }
}