/**
 * =========================================================================
 * @file          : MemberProfileDTO.java
 * @description   : Data Transfer Object (DTO) for user profile details.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.sql.Date;

/**
 * Lớp vận chuyển dữ liệu (DTO) mở rộng từ UserProfileBaseDTO, bổ sung các 
 * trường thông tin riêng biệt của khách hàng hội viên (Số điện thoại, Địa chỉ, Ngày sinh, 
 * Thông tin gói tập đang sử dụng) phục vụ hiển thị giao diện động cho Member (UC-03).
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MemberProfileDTO extends UserProfileBaseDTO {
    private String gender;
    private Date dateOfBirth;
    private String address;
    private String membershipStatus; // Thuộc tính chỉ đọc (Read-only)
}

