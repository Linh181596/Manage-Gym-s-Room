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

    /**
     * Hiển thị biểu mẫu đổi mật khẩu cho người dùng đang đăng nhập.
     */
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

    /**
     * Kiểm tra mật khẩu hiện tại, xác thực mật khẩu mới, cập nhật mật khẩu và thu hồi các phiên đăng nhập cũ.
     */
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
            forwardWithError(request, response, user, "Mật khẩu hiện tại không chính xác.");
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

    /**
     * Lấy đối tượng User đang đăng nhập từ session; trả về null khi session không hợp lệ.
     */
    private User getCurrentUser(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object currentUser = session.getAttribute("currentUser");
        if (currentUser instanceof User) {
            return (User) currentUser;
        }
        return null;
    }

    /**
     * Chuẩn bị thông tin bắt buộc đổi mật khẩu và đường dẫn hủy để hiển thị trên biểu mẫu.
     */
    private void prepareForm(HttpServletRequest request, User user) {
        boolean mandatoryChange = user.isMustChangePassword();
        request.setAttribute("mandatoryChange", mandatoryChange);
        request.setAttribute("cancelUrl", resolveCancelUrl(user, request));

        if (mandatoryChange) {
            request.setAttribute("mandatoryNotice",
                    "Tài khoản của bạn đang dùng mật khẩu tạm thời. Vui lòng đổi mật khẩu trước khi tiếp tục.");
        }
    }

    /**
     * Gắn thông báo lỗi, chuẩn bị lại biểu mẫu và chuyển tiếp về trang đổi mật khẩu.
     */
    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, User user, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        prepareForm(request, user);
        request.getRequestDispatcher(CHANGE_PASSWORD_VIEW).forward(request, response);
    }

    /**
     * Kiểm tra chuỗi mật khẩu hoặc tham số có rỗng sau khi bỏ khoảng trắng hay không.
     */
    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Kiểm tra mật khẩu mới có ít nhất 8 ký tự, bao gồm chữ cái và chữ số.
     */
    private boolean isValidPassword(String password) {
        return password != null
                && password.length() >= 8
                && password.matches(".*[A-Za-z].*")
                && password.matches(".*\\d.*");
    }

    /**
     * Xóa cookie Remember Me trên trình duyệt sau khi người dùng đổi mật khẩu thành công.
     */
    private void expireRememberMeCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie cleanCookie = new Cookie(REMEMBER_ME_COOKIE, "");
        cleanCookie.setMaxAge(0);
        cleanCookie.setHttpOnly(true);
        cleanCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
        response.addCookie(cleanCookie);
    }

    /**
     * Chuyển người dùng về trang đích theo vai trò sau khi đổi mật khẩu thành công.
     */
    private void redirectAfterSuccessfulChange(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(getDefaultDestination(user, request));
    }

    /**
     * Xác định dashboard mặc định tương ứng với vai trò của người dùng.
     */
    private String getDefaultDestination(User user, HttpServletRequest request) {
        String context = request.getContextPath();
        return switch (user.getRole()) {
            case Admin -> context + "/admin/dashboard";
            case Staff -> context + "/staff/dashboard";
            case Member -> context + "/member/dashboard";
            case PT -> context + "/pt/dashboard";
        };
    }

    /**
     * Xác định URL quay lại an toàn; bắt buộc dùng dashboard khi người dùng đang phải đổi mật khẩu tạm.
     */
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
