/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.sql.Date;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: MemberProfileDTO.java
 * Description: Lớp vận chuyển dữ liệu (DTO) mở rộng từ UserProfileBaseDTO, bổ sung các 
 * trường thông tin riêng biệt của khách hàng hội viên (Số điện thoại, Địa chỉ, Ngày sinh, 
 * Thông tin gói tập đang sử dụng) phục vụ hiển thị giao diện động cho Member (UC-03).
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Thiết kế lớp dữ liệu Profile cho vai trò Member.
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MemberProfileDTO extends UserProfileBaseDTO {
    private String gender;
    private Date dateOfBirth;
    private String address;
    private String membershipStatus; // Thuộc tính chỉ đọc (Read-only)
}
