/**
 * =========================================================================
 * @file          : MemberPackage.java
 * @description   : Entity đại diện cho bảng MemberPackages đăng ký dịch vụ hội viên
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Entity representing the 'MemberPackages' table in the database.
 */
public class MemberPackage {
    private int memberPackageId;
    private int memberId;
    private int packageId;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status; // 'Active', 'Expired', 'Pending'
    
    // Mapped entities (obtained via JOIN)
    private Member member;
    private GymPackage gymPackage;
    
    // Audit Metadata
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean isDeleted;

    public MemberPackage() {
    }

    public MemberPackage(int memberPackageId, int memberId, int packageId, LocalDate startDate, LocalDate endDate, String status) {
        this.memberPackageId = memberPackageId;
        this.memberId = memberId;
        this.packageId = packageId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public int getMemberPackageId() {
        return memberPackageId;
    }

    public void setMemberPackageId(int memberPackageId) {
        this.memberPackageId = memberPackageId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public GymPackage getGymPackage() {
        return gymPackage;
    }

    public void setGymPackage(GymPackage gymPackage) {
        this.gymPackage = gymPackage;
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
        return "MemberPackage{" +
                "memberPackageId=" + memberPackageId +
                ", memberId=" + memberId +
                ", packageId=" + packageId +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", status='" + status + '\'' +
                '}';
    }
}
