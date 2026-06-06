/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: UserProfileBaseDTO.java
 * Description: Lớp cơ sở (Base DTO) chứa các trường dữ liệu tài khoản cốt lõi dùng chung 
 * của người dùng (Email, Họ tên, Trạng thái, Vai trò). Làm nền tảng kế thừa cho các lớp 
 * thông tin profile đặc thù của từng vai trò tại UC-03.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Tạo Base DTO định hình cấu trúc Profile chung.
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
