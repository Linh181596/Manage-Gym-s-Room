/**
 * =========================================================================
 * @file          : ChangePasswordController.java
 * @description   : Controller xử lý UC-04 đổi mật khẩu, xác thực mật khẩu hiện tại, cập nhật mật khẩu mới và thu hồi phiên/token cũ.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;
import com.mycompany.gymcentermanagement.utils.SessionRegistry;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * UC-04: Allows authenticated active users to change their password.
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {

    private static final String CHANGE_PASSWORD_VIEW = "/WEB-INF/views/auth/change-password.jsp";
    private static final String REMEMBER_ME_COOKIE = "remember_me_token";

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = getCurrentUser(session);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        prepareForm(request, user);
        request.getRequestDispatcher(CHANGE_PASSWORD_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User sessionUser = getCurrentUser(session);

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user;
        try {
            user = userDAO.findById(sessionUser.getUserId());
        } catch (SQLException e) {
            e.printStackTrace();
            forwardWithError(request, response, sessionUser, "Không thể đọc thông tin tài khoản. Vui lòng thử lại.");
            return;
        }

        if (user == null || user.getAccountStatus() != User.AccountStatus.Active) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            forwardWithError(request, response, user, "Vui lòng nhập đầy đủ các trường mật khẩu.");
            return;
        }

        if (!isValidPassword(newPassword)) {
            forwardWithError(request, response, user,
                    "Mật khẩu mới phải có ít nhất 8 ký tự và bao gồm cả chữ lẫn số.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            forwardWithError(request, response, user, "Mật khẩu xác nhận không khớp.");
            return;
        }

        if (!PasswordUtils.checkPassword(currentPassword, user.getPasswordHash())) {
            forwardWithError(request, response, user, "Current password is incorrect.");
            return;
        }

        if (PasswordUtils.checkPassword(newPassword, user.getPasswordHash())) {
            forwardWithError(request, response, user, "Vui lòng chọn mật khẩu mới khác mật khẩu hiện tại.");
            return;
        }

        String newPasswordHash = PasswordUtils.hashPassword(newPassword);

        try {
            boolean success = userDAO.changePasswordAndRevokeTokens(user.getUserId(), newPasswordHash, false);
            if (!success) {
                forwardWithError(request, response, user,
                        "Không thể cập nhật mật khẩu mới. Vui lòng thử lại.");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            forwardWithError(request, response, user,
                    "Không thể cập nhật mật khẩu mới. Vui lòng thử lại.");
            return;
        }

        user.setPasswordHash(newPasswordHash);
        user.setMustChangePassword(false);
        session.setAttribute("currentUser", user);

        expireRememberMeCookie(request, response);
        SessionRegistry.invalidateOtherSessions(user.getUserId(), session.getId());

        session.setAttribute("successMessage", "Password changed successfully");
        redirectAfterSuccessfulChange(user, request, response);
    }

    private User getCurrentUser(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object currentUser = session.getAttribute("currentUser");
        return currentUser instanceof User user ? user : null;
    }

    private void prepareForm(HttpServletRequest request, User user) {
        boolean mandatoryChange = user.isMustChangePassword();
        request.setAttribute("mandatoryChange", mandatoryChange);
        request.setAttribute("cancelUrl", resolveCancelUrl(user, request));

        if (mandatoryChange) {
            request.setAttribute("mandatoryNotice",
                    "Tài khoản của bạn đang dùng mật khẩu tạm thời. Vui lòng đổi mật khẩu trước khi tiếp tục.");
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, User user, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        prepareForm(request, user);
        request.getRequestDispatcher(CHANGE_PASSWORD_VIEW).forward(request, response);
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isValidPassword(String password) {
        return password != null
                && password.length() >= 8
                && password.matches(".*[A-Za-z].*")
                && password.matches(".*\\d.*");
    }

    private void expireRememberMeCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie cleanCookie = new Cookie(REMEMBER_ME_COOKIE, "");
        cleanCookie.setMaxAge(0);
        cleanCookie.setHttpOnly(true);
        cleanCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
        response.addCookie(cleanCookie);
    }

    private void redirectAfterSuccessfulChange(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(getDefaultDestination(user, request));
    }

    private String getDefaultDestination(User user, HttpServletRequest request) {
        String context = request.getContextPath();
        return switch (user.getRole()) {
            case Admin -> context + "/admin/dashboard";
            case Staff -> context + "/staff/dashboard";
            case Member -> context + "/member/dashboard";
            case PT -> context + "/pt/dashboard";
        };
    }

    private String resolveCancelUrl(User user, HttpServletRequest request) {
        if (user.isMustChangePassword()) {
            return getDefaultDestination(user, request);
        }

        String referer = request.getHeader("Referer");
        String serverName = request.getServerName();

        if (referer != null
                && referer.contains(serverName)
                && !referer.contains("/change-password")
                && !referer.contains("/login")) {
            return referer;
        }

        return getDefaultDestination(user, request);
    }
}
