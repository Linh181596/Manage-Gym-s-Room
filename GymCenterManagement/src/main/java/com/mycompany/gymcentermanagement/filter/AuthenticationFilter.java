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
 * Mapped to /admin/*, /staff/*, /member/*, and /pt/* paths.
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/admin/*", "/staff/*", "/member/*", "/pt/*"})
public class AuthenticationFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (user == null) {
            // Not authenticated, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // RBAC Check based on request path
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String relativePath = requestURI.substring(contextPath.length());
        
        boolean authorized = false;
        User.Role role = user.getRole();
        
        if (relativePath.startsWith("/admin/") && role == User.Role.Admin) {
            authorized = true;
        } else if (relativePath.startsWith("/staff/") && role == User.Role.Staff) {
            authorized = true;
        } else if (relativePath.startsWith("/member/") && role == User.Role.Member) {
            authorized = true;
        } else if (relativePath.startsWith("/pt/") && role == User.Role.PT) {
            authorized = true;
        }
        
        if (authorized) {
            chain.doFilter(request, response);
        } else {
            // Authenticated but unauthorized for this specific role context (403 Forbidden)
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
        }
    }
}
