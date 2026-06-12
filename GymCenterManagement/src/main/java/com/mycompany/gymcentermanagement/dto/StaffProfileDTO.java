/**
 * =========================================================================
 * @file          : StaffProfileDTO.java
 * @description   : Data Transfer Object (DTO) for user profile details.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: StaffProfileDTO.java
 * Description: Lớp vận chuyển dữ liệu (DTO) mở rộng từ UserProfileBaseDTO, đóng gói thêm các 
 * thông tin hành chính của Nhân viên trung tâm hoặc Admin (Vị trí công tác, Ca trực, Ngày ký hợp đồng) 
 * để xuất dữ liệu lên giao diện quản trị (UC-03).
 * Author: Nguyễn Đại Dương - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    Nguyễn Đại Dương         1.0            Thiết kế lớp dữ liệu Profile cho vai trò Staff/Admin.
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class StaffProfileDTO extends UserProfileBaseDTO{
    private String position; // Thuộc tính chỉ đọc (Read-only)
}

