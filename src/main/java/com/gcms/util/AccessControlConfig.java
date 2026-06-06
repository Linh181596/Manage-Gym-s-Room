/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.util;

import com.gcms.model.Role;
import java.util.List;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: AccessControlConfig.java
 * Description: Trung tâm cấu hình ma trận phân quyền hệ thống. Lưu trữ danh sách quy hoạch
 * các tiền tố đường dẫn URL nhạy cảm (/admin/*, /staff/*, /pt/*, /member/*) tương ứng với 
 * các quyền được cho phép. Cung cấp hàm static cho AuthorizationFilter kiểm tra nhanh.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Thiết lập ma trận phân quyền tập trung dựa trên URL.
 */
public class AccessControlConfig {
    /**
     * Kiểm tra xem URL yêu cầu có phải là tài nguyên công cộng không cần đăng nhập hay không.
     * Bao gồm các trang login, register, verify và các tài nguyên tĩnh (.css, .js, hình ảnh).
     */
    public static boolean isPublicResource(String uri) {
        // Chuẩn hóa chuỗi URI
        if (uri == null) return false;
        
        // Các trang công cộng phục vụ Login, Register, và xác thực tài khoản
        if (uri.equals("/") 
                || uri.equalsIgnoreCase("/login") 
                || uri.equalsIgnoreCase("/register") 
                || uri.toLowerCase().contains("verify")) {
            return true;
        }

        // Tài nguyên tĩnh không được chặn
        return uri.endsWith(".css") 
                || uri.endsWith(".js") 
                || uri.toLowerCase().contains("/img/") 
                || uri.toLowerCase().contains("/assets/") 
                || uri.toLowerCase().contains("/images/");
    }

    /**
     * Kiểm tra danh sách quyền của người dùng có hợp lệ với URL đang truy cập không.
     * Áp dụng chiến lược kiểm tra phân vùng thư mục URL Mapping.
     */
    public static boolean hasPermission(List<Role> userRoles, String uri) {
        if (userRoles == null || userRoles.isEmpty()) {
            return false;
        }

        // 1. Vùng quản trị Admin
        if (uri.startsWith("/admin/")) {
            return hasRole(userRoles, "Admin");
        }

        // 2. Vùng dành cho Nhân viên (Staff) - Cho phép cả Admin vào hỗ trợ xử lý
        if (uri.startsWith("/staff/")) {
            return hasRole(userRoles, "Admin") || hasRole(userRoles, "Staff");
        }

        // 3. Vùng dành cho Huấn luyện viên (PT)
        if (uri.startsWith("/pt/")) {
            return hasRole(userRoles, "PT");
        }

        // 4. Vùng dành cho Hội viên (Member)
        if (uri.startsWith("/member/")) {
            return hasRole(userRoles, "Member");
        }

        // Các vùng dẫn dùng chung nội bộ (như xem/sửa profile cá nhân) -> Đã đăng nhập là cho phép vào
        return true;
    }

    /**
     * Hàm tiện ích kiểm tra xem trong danh sách các vai trò của User có chứa RoleName mục tiêu không.
     */
    private static boolean hasRole(List<Role> userRoles, String roleName) {
        for (Role r : userRoles) {
            if (r.getRoleName() != null && r.getRoleName().equalsIgnoreCase(roleName)) {
                return true;
            }
        }
        return false;
    }
}
