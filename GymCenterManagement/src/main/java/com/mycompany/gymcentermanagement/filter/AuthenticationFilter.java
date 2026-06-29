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
 * Filter to verify authentication status and enforce role-based access control (RBAC).
 * Mapped to protected dashboard/profile paths.
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
        
        if ("/pt/list".equals(relativePath)) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (user == null) {
            // Check remember me cookie
            jakarta.servlet.http.Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (jakarta.servlet.http.Cookie cookie : cookies) {
                    if ("remember_me_token".equals(cookie.getName())) {
                        String tokenValue = cookie.getValue();
                        try {
                            com.mycompany.gymcentermanagement.dao.UserDAO userDAO = new com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl();
                            User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                            if (autoUser != null && autoUser.getAccountStatus() == User.AccountStatus.Active) {
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
        
        if (user == null) {
            // Not authenticated, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // If user must change password, enforce redirection to /change-password
        if (user.isMustChangePassword()) {
            response.sendRedirect(request.getContextPath() + "/change-password");
            return;
        }
        
        // RBAC Check based on request path
        boolean authorized = false;
        User.Role role = user.getRole();
        
        if (relativePath.equals("/profile")) {
            authorized = true;
        } else if (relativePath.startsWith("/admin/")) {
            if (role == User.Role.Admin) {
                authorized = true;
            } else if (role == User.Role.Staff && (
                relativePath.startsWith("/admin/pt/edit") ||
                relativePath.startsWith("/admin/pt/service-prices") ||
                relativePath.startsWith("/admin/schedule/") ||
                relativePath.startsWith("/admin/pt/schedule-setup") ||
                relativePath.startsWith("/admin/pt/cancel")
            )) {
                authorized = true;
            }
        } else if (relativePath.startsWith("/staff/") && (role == User.Role.Staff || role == User.Role.Admin)) {
            authorized = true;
        } else if (relativePath.startsWith("/member/")) {
            if (role == User.Role.Member) {
                authorized = true;
            } else if (relativePath.startsWith("/member/portal") && (role == User.Role.Staff || role == User.Role.Admin)) {
                authorized = true;
            }
        } else if (relativePath.startsWith("/pt/")) {
            if (relativePath.startsWith("/pt/list") || relativePath.startsWith("/pt/detail")) {
                authorized = true;
            } else if (role == User.Role.PT) {
                authorized = true;
            }
        }
        
        if (authorized) {
            chain.doFilter(request, response);
        } else {
            // Authenticated but unauthorized for this specific role context (403 Forbidden)
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
        }
    }
}
