/**
 * =========================================================================
 * @file          : PTProfileDTO.java
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
 * File: PTProfileDTO.java
 * Description: Lớp vận chuyển dữ liệu (DTO) mở rộng từ UserProfileBaseDTO, bổ sung các 
 * thuộc tính nghề nghiệp đặc trưng của Huấn luyện viên cá nhân (Chuyên môn, Mô tả bản thân, 
 * Chứng chỉ, Số năm kinh nghiệm dựa trên ngày bắt đầu sự nghiệp) cho giao diện PT Profile (UC-03).
 * Author: Nguyễn Đại Dương - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    Nguyễn Đại Dương         1.0            Thiết kế lớp dữ liệu Profile cho vai trò Personal Trainer.
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class PTProfileDTO extends UserProfileBaseDTO {
    private String fullName;             // Ưu tiên hiển thị thay cho DisplayName tài khoản gốc
    private String specialization;       // Thuộc tính chỉ đọc (Read-only)
    private String description;          // Tiểu sử/Mô tả bản thân
    private int experienceYears;         // Số năm kinh nghiệm nguyên (Tính từ CareerStartDate)
    private String avatarPath;           // Đường dẫn ảnh đại diện
    private String certificateFileName;  // Tên file chứng chỉ công nhận
    private String certificateFilePath;  // Đường dẫn tệp chứng chỉ lưu trên máy chủ
}

