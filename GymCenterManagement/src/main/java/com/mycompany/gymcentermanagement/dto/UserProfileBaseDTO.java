/**
 * =========================================================================
 * @file          : UserProfileBaseDTO.java
 * @description   : Data Transfer Object (DTO) for user profile details.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Lớp cơ sở (Base DTO) chứa các trường dữ liệu tài khoản cốt lõi dùng chung 
 * của người dùng (Email, Họ tên, Trạng thái, Vai trò). Làm nền tảng kế thừa cho các lớp 
 * thông tin profile đặc thù của từng vai trò tại UC-03.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserProfileBaseDTO {
    private int userId;
    private String email;
    private String displayName;
    private String phone;
    private String roleName;
}

