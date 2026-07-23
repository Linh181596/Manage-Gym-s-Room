/**
 * =========================================================================
 * @file          : MembershipGrowthMember.java
 * @description   : DTO for member data in growth report
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * DTO lưu trữ thông tin chi tiết của một hội viên trong báo cáo tăng trưởng.
 * Dùng để hiển thị danh sách hội viên mới đăng ký trong một khoảng thời gian được lọc.
 */
public class MembershipGrowthMember {
    // Định dạng ngày hiển thị trên View
    private static final DateTimeFormatter DISPLAY_FORMAT = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private int memberId;
    private String fullName;
    private String gender;
    private String phone;
    private String packageName;
    private LocalDate registrationDate;
    private LocalDate membershipEndDate;
    private String membershipStatus;

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public LocalDate getRegistrationDate() {
        return registrationDate;
    }

    public String getRegistrationDateText() {
        return registrationDate != null ? registrationDate.format(DISPLAY_FORMAT) : "";
    }

    public void setRegistrationDate(LocalDate registrationDate) {
        this.registrationDate = registrationDate;
    }

    public LocalDate getMembershipEndDate() {
        return membershipEndDate;
    }

    public String getMembershipEndDateText() {
        return membershipEndDate != null ? membershipEndDate.format(DISPLAY_FORMAT) : "";
    }

    public void setMembershipEndDate(LocalDate membershipEndDate) {
        this.membershipEndDate = membershipEndDate;
    }

    public String getMembershipStatus() {
        return membershipStatus;
    }

    public void setMembershipStatus(String membershipStatus) {
        this.membershipStatus = membershipStatus;
    }
}
