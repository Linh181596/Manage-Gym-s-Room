/**
 * =========================================================================
 * @file          : ResetPasswordController.java
 * @description   : Controller xác thực token email và cập nhật mật khẩu mới cho luồng quên mật khẩu.
 * @author        : Duongnd
 * @created       : 2026-07-06
 * @last_modified : 2026-07-06
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;
import com.mycompany.gymcentermanagement.utils.SessionRegistry;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private static final String RESET_PASSWORD_VIEW = "/WEB-INF/views/auth/reset-password.jsp";

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        prepareResetForm(request, token);
        request.getRequestDispatcher(RESET_PASSWORD_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String token = request.getParameter("token");
        User user = findUserByToken(token);
        if (user == null) {
            forwardInvalidToken(request, response);
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        request.setAttribute("token", token);

        if (isBlank(newPassword) || isBlank(confirmPassword)) {
            forwardWithError(request, response, "Vui lòng nhập đầy đủ mật khẩu mới.");
            return;
        }

        if (!isValidPassword(newPassword)) {
            forwardWithError(request, response, "Mật khẩu mới phải có ít nhất 8 ký tự và bao gồm cả chữ lẫn số.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            forwardWithError(request, response, "Mật khẩu xác nhận không khớp.");
            return;
        }

        if (PasswordUtils.checkPassword(newPassword, user.getPasswordHash())) {
            forwardWithError(request, response, "Vui lòng chọn mật khẩu mới khác mật khẩu hiện tại.");
            return;
        }

        try {
            boolean success = userDAO.resetPasswordByToken(token, PasswordUtils.hashPassword(newPassword));
            if (!success) {
                forwardInvalidToken(request, response);
                return;
            }

            SessionRegistry.invalidateOtherSessions(user.getUserId(), "");
            HttpSession session = request.getSession(true);
            session.setAttribute("successMessage", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập bằng mật khẩu mới.");
            session.setAttribute("prepopulatedEmail", user.getEmail());
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (SQLException e) {
            e.printStackTrace();
            forwardWithError(request, response, "Không thể đặt lại mật khẩu. Vui lòng thử lại.");
        }
    }

    private void prepareResetForm(HttpServletRequest request, String token) {
        User user = findUserByToken(token);
        if (user == null) {
            request.setAttribute("invalidToken", true);
            request.setAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            return;
        }

        request.setAttribute("token", token);
        request.setAttribute("email", user.getEmail());
    }

    private User findUserByToken(String token) {
        if (isBlank(token)) {
            return null;
        }

        try {
            return userDAO.getUserByPasswordResetToken(token.trim());
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private void forwardInvalidToken(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("invalidToken", true);
        request.setAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
        request.getRequestDispatcher(RESET_PASSWORD_VIEW).forward(request, response);
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher(RESET_PASSWORD_VIEW).forward(request, response);
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
}
