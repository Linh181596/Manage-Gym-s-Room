/**
 * =========================================================================
 * @file          : LoginController.java
 * @description   : Controller xử lý luồng đăng nhập hệ thống (UC-01). 
 *                  Hỗ trợ xác thực tài khoản, mã hóa SHA-256, kiểm tra trạng thái (Active/Inactive),
 *                  xử lý tính năng "Remember Me" qua Token và điều hướng về các Dashboard theo Role.
 * @author        : duongnd
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.service.impl.UserServiceImpl;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    private final UserService userService = new UserServiceImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nếu đã đăng nhập trước đó, chuyển thẳng tới Dashboard tương ứng
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (user != null) {
            redirectToDashboard(user, request, response);
            return;
        }

        // Tự động đăng nhập qua Cookie "Remember Me"
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    try {
                        User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                        if (autoUser != null && autoUser.getAccountStatus() == User.AccountStatus.Active) {
                            HttpSession newSession = request.getSession(true);
                            newSession.setAttribute("currentUser", autoUser);
                            if (autoUser.isMustChangePassword()) {
                                response.sendRedirect(request.getContextPath() + "/change-password");
                            } else {
                                redirectToDashboard(autoUser, request, response);
                            }
                            return;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        
        // Chuyển tiếp các thông báo Toast/Flash từ Session sang Request nếu có
        if (session != null) {
            String successMsg = (String) session.getAttribute("successMessage");
            if (successMsg != null) {
                request.setAttribute("successMessage", successMsg);
                session.removeAttribute("successMessage");
            }
            String prepopulatedEmailVal = (String) session.getAttribute("prepopulatedEmail");
            if (prepopulatedEmailVal != null) {
                request.setAttribute("prepopulatedEmail", prepopulatedEmailVal);
                session.removeAttribute("prepopulatedEmail");
            }
        }

        // Hiển thị giao diện Đăng nhập ban đầu
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        request.setAttribute("prepopulatedEmail", email);
        
        // 1. Kiểm tra trống các trường thông tin bắt buộc
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email và mật khẩu không được để trống!");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        // Luồng bỏ qua tạm thời cho tài khoản demo của hệ thống
        User authenticatedUser = null;
        if ("admin@gym.com".equalsIgnoreCase(email.trim()) && "admin123".equals(password)) {
            authenticatedUser = new User(1, "admin@gym.com", "", "Demo Admin", "0987654321", User.Role.Admin, User.AccountStatus.Active);
        } else if ("staff@gym.com".equalsIgnoreCase(email.trim()) && "staff123".equals(password)) {
            authenticatedUser = new User(2, "staff@gym.com", "", "Demo Staff", "0987654321", User.Role.Staff, User.AccountStatus.Active);
        } else if ("member@gym.com".equalsIgnoreCase(email.trim()) && "member123".equals(password)) {
            authenticatedUser = new User(4, "member@gym.com", "", "Demo Member", "0987654321", User.Role.Member, User.AccountStatus.Active);
        } else {
            try {
                // Xác thực tài khoản dựa trên truy vấn CSDL
                User user = userDAO.findByEmail(email.trim());
                String hashedInputPassword = PasswordUtils.hashPassword(password);
                
                if (user == null || !user.getPasswordHash().equals(hashedInputPassword)) {
                    request.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác!");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                    return;
                }
                
                // Kiểm tra trạng thái kích hoạt hoặc khóa tài khoản của người dùng
                if (user.getAccountStatus() == User.AccountStatus.Inactive) {
                    request.setAttribute("errorMessage", "Tài khoản của bạn chưa được kích hoạt! Vui lòng kiểm tra email kích hoạt.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                    return;
                } else if (user.getAccountStatus() == User.AccountStatus.Rejected) {
                    request.setAttribute("errorMessage", "Tài khoản này đã bị khóa hoặc từ chối truy cập.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                    return;
                }
                
                authenticatedUser = user;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi kết nối hệ thống: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }
        }
        
        if (authenticatedUser != null) {
            // Thành công: Tạo Session mới và lưu giữ thực thể User
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", authenticatedUser);

            // Xử lý lưu Token "Remember Me"
            if (rememberMe != null && "true".equals(rememberMe)) {
                String randomToken = UUID.randomUUID().toString();
                LocalDateTime expiresAt = LocalDateTime.now().plusDays(7);
                UserToken tokenEntity = new UserToken(authenticatedUser.getUserId(), randomToken, "REMEMBER_ME", expiresAt);
                try {
                    userDAO.saveRememberMeToken(tokenEntity);
                    Cookie rememberCookie = new Cookie("remember_me_token", randomToken);
                    rememberCookie.setMaxAge(7 * 24 * 60 * 60);
                    rememberCookie.setHttpOnly(true);
                    rememberCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
                    response.addCookie(rememberCookie);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
            // Điều hướng dựa vào yêu cầu thay đổi mật khẩu ban đầu
            if (authenticatedUser.isMustChangePassword()) {
                response.sendRedirect(request.getContextPath() + "/change-password");
            } else {
                redirectToDashboard(authenticatedUser, request, response);
            }
        }
    }
    
    private void redirectToDashboard(User user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String context = request.getContextPath();
        switch (user.getRole()) {
            case Admin:
                response.sendRedirect(context + "/admin/dashboard");
                break;
            case Staff:
                response.sendRedirect(context + "/staff/dashboard");
                break;
            case Member:
                response.sendRedirect(context + "/member/dashboard");
                break;
            case PT:
                response.sendRedirect(context + "/pt/dashboard");
                break;
            default:
                response.sendRedirect(context + "/index.html");
        }
    }
}
