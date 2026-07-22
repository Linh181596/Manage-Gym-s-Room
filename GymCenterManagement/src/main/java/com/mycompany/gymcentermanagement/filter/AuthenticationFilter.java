/**
 * =========================================================================
 * @file          : AuthenticationFilter.java
 * @description   : Filter kiểm tra đăng nhập, phân quyền theo vai trò và chặn truy cập khi tài khoản bắt buộc đổi mật khẩu.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-11
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.filter;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter đóng vai trò như một "lớp bảo vệ" (Middleware) chặn trước khi Request đi tới Controller.
 * Chức năng: 
 * 1. Kiểm tra trạng thái đăng nhập (Authentication).
 * 2. Triển khai phân quyền truy cập dựa trên vai trò - RBAC (Authorization).
 * Filter này được áp dụng cho tất cả các đường dẫn nhạy cảm như /admin, /staff, /member, /pt, /profile.
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = { "/admin/*", "/staff/*", "/member/*", "/pt/*",
        "/profile" })
public class AuthenticationFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String relativePath = requestURI.substring(contextPath.length());
        
        // Ngoại lệ: Cho phép tất cả mọi người xem danh sách PT mà không cần đăng nhập
        if ("/pt/list".equals(relativePath)) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        // Xử lý tính năng "Remember Me"
        if (user == null) {
            jakarta.servlet.http.Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (jakarta.servlet.http.Cookie cookie : cookies) {
                    // Nếu tìm thấy Cookie ghi nhớ đăng nhập
                    if ("remember_me_token".equals(cookie.getName())) {
                        String tokenValue = cookie.getValue();
                        try {
                            UserDAO userDAO = new UserDAOImpl();
                            // Xác thực token trong database
                            User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                            // Nếu hợp lệ và tài khoản không bị khóa (Active)
                            if (autoUser != null && autoUser.getAccountStatus() == User.AccountStatus.Active) {
                                // Tự động tạo session mới và đăng nhập cho người dùng
                                HttpSession newSession = request.getSession(true);
                                newSession.setAttribute("currentUser", autoUser);
                                user = autoUser;
                                break;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        
        // Chặn người dùng chưa đăng nhập, chuyển hướng về trang Login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Luôn đọc lại trạng thái tài khoản từ CSDL để các phiên cũ không tiếp
        // tục hoạt động sau khi Admin khóa hoặc vô hiệu hóa tài khoản.
        try {
            User persistedUser = new UserDAOImpl().findById(user.getUserId());
            if (persistedUser == null || persistedUser.getAccountStatus() != User.AccountStatus.Active) {
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/login?sessionEnded=1");
                return;
            }
        } catch (Exception ex) {
            throw new ServletException("Không thể kiểm tra trạng thái tài khoản.", ex);
        }

        // Kiểm tra nghiệp vụ: Bắt buộc đổi mật khẩu ở lần đăng nhập đầu tiên (Tài khoản được cấp bởi Admin/Staff)
        if (user.isMustChangePassword()) {
            response.sendRedirect(request.getContextPath() + "/change-password");
            return;
        }
        
        // ---------------------------------------------------------
        // RBAC Check (Role-Based Access Control)
        // [BR-CONS-03]: Kiểm tra phân quyền truy cập theo vai trò (Admin, Staff, PT, Member).
        // [BR-CONS-04]: Admin có quyền truy cập rộng, nhưng không được phép thao tác các chức năng dành riêng cho PT hoặc Member (Trừ một số ngoại lệ).
        // [BR-CONS-05]: Admin được quyền truy cập vào các dashboard tài chính và quản lý.
        // ---------------------------------------------------------
        boolean authorized = false;
        User.Role role = user.getRole();
        
        if (relativePath.equals("/profile")) {
            // Ai cũng có thể vào trang cá nhân của mình
            authorized = true;
        } else if (relativePath.startsWith("/admin/")) {
            if (role == User.Role.Admin) {
                // Admin được toàn quyền truy cập phân hệ Admin
                authorized = true;
            } else if (role == User.Role.Staff && (
                // Staff được cấp quyền truy cập một số module trong admin (Quản lý lịch tập, sửa thông tin PT)
                relativePath.startsWith("/admin/pt/edit") ||
                relativePath.startsWith("/admin/schedule/") ||
                relativePath.startsWith("/admin/pt/schedule-setup") ||
                relativePath.startsWith("/admin/pt/cancel")
            )) {
                authorized = true;
            } else if (role == User.Role.PT && (
                // PT cũng có quyền thiết lập và hủy lịch tập của chính mình
                relativePath.startsWith("/admin/pt/schedule-setup") ||
                relativePath.startsWith("/admin/pt/cancel")
            )) {
                authorized = true;
            }
        } else if (relativePath.startsWith("/staff/") && (role == User.Role.Staff || role == User.Role.Admin)) {
            // Module Nhân viên: Staff và Admin được quyền vào
            authorized = true;
        } else if (relativePath.startsWith("/member/")) {
            if (role == User.Role.Member) {
                // Module Hội viên
                authorized = true;
            } else if (relativePath.startsWith("/member/portal") && (role == User.Role.Staff || role == User.Role.Admin)) {
                // Ngoại lệ: Staff và Admin có thể xem portal (tài khoản phụ) của hội viên để hỗ trợ thao tác thanh toán, checkin
                authorized = true;
            }
        } else if (relativePath.startsWith("/pt/")) {
            if (relativePath.startsWith("/pt/list") || relativePath.startsWith("/pt/detail")) {
                // Thông tin công khai của PT, ai cũng xem được
                authorized = true;
            } else if (role == User.Role.PT) {
                // Các chức năng nghiệp vụ của PT
                authorized = true;
            }
        }
        
        if (authorized) {
            // Nếu có quyền, cho phép đi tiếp vào Controller (Servlet)
            chain.doFilter(request, response);
        } else {
            // Nếu không có quyền, trả về trang lỗi 403 (Forbidden)
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
        }
    }
}
