/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author daiduong
 */
public class AuthUtil {
    // Hỗ trợ kiểm tra Authentication (Đã đăng nhập chưa) cho các Servlet Filter
    public static boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("currentUser") != null;
    }

    // Hỗ trợ kiểm tra Authorization theo trường Role (Enum) lưu trong Session
    public static boolean hasRole(HttpServletRequest request, String expectedRole) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String role = (String) session.getAttribute("role");
            return expectedRole.equals(role);
        }
        return false;
    }
}
