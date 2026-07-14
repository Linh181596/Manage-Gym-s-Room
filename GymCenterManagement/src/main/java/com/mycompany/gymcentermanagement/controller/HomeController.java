/**
 * =========================================================================
 * @file          : HomeController.java
 * @description   : Controller xử lý trang chủ công cộng, nạp danh sách gói tập động.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller;

import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Public Home Page Controller.
 * Mapped to /home and /index.
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home", "/index"})
public class HomeController extends HttpServlet {
    
    private static final String REMEMBER_ME_COOKIE = "remember_me_token";
    
    private final GymPackageDAO gymPackageDAO = new GymPackageDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = resolveCurrentUser(request);
        if (currentUser != null) {
            request.setAttribute("homeUser", currentUser);
            request.setAttribute("dashboardPath", getDashboardPath(currentUser));
            request.setAttribute("profilePath", getProfilePath(currentUser));
        }
        
        try {
            List<GymPackage> activePackages = gymPackageDAO.findAllActive();
            request.setAttribute("activePackages", activePackages);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("packagesLoadError", "Không thể tải danh sách gói tập.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
    
    private User resolveCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user != null) {
            return user;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }

        for (Cookie cookie : cookies) {
            if (!REMEMBER_ME_COOKIE.equals(cookie.getName())) {
                continue;
            }

            String tokenValue = cookie.getValue();
            if (tokenValue == null || tokenValue.isBlank()) {
                return null;
            }

            try {
                User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                if (autoUser != null && autoUser.getAccountStatus() == User.AccountStatus.Active) {
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("currentUser", autoUser);
                    return autoUser;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return null;
        }

        return null;
    }

    private String getDashboardPath(User user) {
        if (user.isMustChangePassword()) {
            return "/change-password";
        }

        return switch (user.getRole()) {
            case Admin -> "/admin/dashboard";
            case Staff -> "/staff/dashboard";
            case Member -> "/member/dashboard";
            case PT -> "/pt/dashboard";
        };
    }

    private String getProfilePath(User user) {
        return user.getRole() == User.Role.PT ? "/pt/profile" : "/profile";
    }
}

