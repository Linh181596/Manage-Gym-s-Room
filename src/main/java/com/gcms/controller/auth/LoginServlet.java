/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gcms.controller.auth;

import com.gcms.dao.UserDAO;
import com.gcms.model.Role;
import com.gcms.model.User;
import com.gcms.model.UserToken;
import com.gcms.util.PasswordUtil;
import java.time.LocalDateTime;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: LoginServlet.java
 * Description: Controller xử lý luồng đăng nhập hệ thống (UC-01). 
 * Hỗ trợ xác thực tài khoản, mã hóa SHA-256, kiểm tra trạng thái (Active/Locked),
 * xử lý tính năng "Remember Me" qua Token và điều hướng về các Dashboard theo Role.
 * Author: [Duongnd] - [HE187234]
 * Created Date: [Ngày tạo]
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    [duongnd]    1.0            Xử lý logic Session, Remember Me và Cookie.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            // Điều hướng dựa vào quyền ưu tiên cao nhất trong danh sách Nhiều - Nhiều
            redirectToDashboard(getPrimaryRoleName(user), request, response);
            return;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                    
                    if (autoUser != null && "Active".equals(autoUser.getStatus())) {
                        HttpSession newSession = request.getSession(true);
                        newSession.setAttribute("user", autoUser);
                        redirectToDashboard(getPrimaryRoleName(autoUser), request, response);
                        return;
                    }
                }
            }
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMeStr = request.getParameter("rememberMe");

        request.setAttribute("savedEmail", email);

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email và mật khẩu không được để trống!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.getUserByEmail(email.trim());
        String hashedInputPassword = PasswordUtil.hashPassword(password);
        
        if (user == null || !user.getPasswordHash().equals(hashedInputPassword)) {
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if ("Inactive".equals(user.getStatus())) {
            request.setAttribute("errorMessage", "Tài khoản của bạn chưa được kích hoạt");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        } else if ("Locked".equals(user.getStatus())) {
            request.setAttribute("errorMessage", "Tài khoản này đã bị khóa. Vui lòng liên hệ Admin");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (user.isMustChangePassword()) {
            HttpSession tempSession = request.getSession(true);
            tempSession.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/change-password.jsp");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);

        if (rememberMeStr != null && "true".equals(rememberMeStr)) {
            String randomToken = UUID.randomUUID().toString();
            Timestamp expiresTimestamp = Timestamp.valueOf(LocalDateTime.now().plusDays(7));
            
            UserToken tokenEntity = new UserToken(user.getUserID(), randomToken, "REMEMBER_ME", expiresTimestamp);
            
            boolean isSaved = userDAO.saveRememberMeToken(tokenEntity);
            if (isSaved) {
                Cookie rememberCookie = new Cookie("remember_me_token", randomToken);
                rememberCookie.setMaxAge(7 * 24 * 60 * 60);
                rememberCookie.setHttpOnly(true);
                rememberCookie.setPath(request.getContextPath());
                response.addCookie(rememberCookie);
            }
        }

        // ĐIỀU HƯỚNG THỰC CHIẾN: Tìm tên quyền ưu tiên hạ cánh của User
        String primaryRole = getPrimaryRoleName(user);
        redirectToDashboard(primaryRole, request, response);
    }

    /**
     * Hàm tiện ích thực chiến: Quét danh sách quyền Nhiều - Nhiều để chọn ra quyền chính phục vụ Login.
     * Ưu tiên phân hệ: Admin -> Staff -> PT -> Member (Hoặc so sánh thuộc tính RoleLevel từ cao xuống thấp)
     */
    private String getPrimaryRoleName(User user) {
        if (user.getRoles() == null || user.getRoles().isEmpty()) {
            return "";
        }
        
        // Cách tiếp cận bằng cách kiểm tra sự hiện diện theo mức độ ưu tiên của Phân hệ hạ cánh
        if (hasRole(user, "Admin")) return "Admin";
        if (hasRole(user, "Staff")) return "Staff";
        if (hasRole(user, "PT")) return "PT";
        if (hasRole(user, "Member")) return "Member";
        
        // Dự phòng: Trả về tên quyền đầu tiên trong danh sách CSDL nếu không khớp các chuỗi trên
        return user.getRoles().get(0).getRoleName();
    }

    /**
     * Hàm kiểm tra xem User có sở hữu một tên quyền cụ thể nào đó trong List Nhiều - Nhiều không
     */
    private boolean hasRole(User user, String roleName) {
        for (Role r : user.getRoles()) {
            if (r.getRoleName().equalsIgnoreCase(roleName)) {
                return true;
            }
        }
        return false;
    }

    private void redirectToDashboard(String roleName, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String contextPath = request.getContextPath();
        if ("Admin".equalsIgnoreCase(roleName)) {
            response.sendRedirect(contextPath + "/admin/dashboard.jsp");
        } else if ("Staff".equalsIgnoreCase(roleName)) {
            response.sendRedirect(contextPath + "/staff/dashboard.jsp");
        } else if ("PT".equalsIgnoreCase(roleName)) {
            response.sendRedirect(contextPath + "/pt/schedule.jsp");
        } else if ("Member".equalsIgnoreCase(roleName)) {
            response.sendRedirect(contextPath + "/member/home.jsp");
        } else {
            response.sendRedirect(contextPath + "/login.jsp");
        }
    }
}