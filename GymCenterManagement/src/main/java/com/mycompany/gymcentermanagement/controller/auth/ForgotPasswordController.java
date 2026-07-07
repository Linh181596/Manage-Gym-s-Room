/**
 * =========================================================================
 * @file          : ForgotPasswordController.java
 * @description   : Controller xử lý yêu cầu gửi email đặt lại mật khẩu cho tài khoản đang hoạt động.
 * @author        : Duongnd
 * @created       : 2026-07-06
 * @last_modified : 2026-07-06
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private static final String FORGOT_PASSWORD_VIEW = "/WEB-INF/views/auth/forgot-password.jsp";
    private static final int RESET_TOKEN_MINUTES = 30;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        if (isBlank(email)) {
            request.setAttribute("error", "Vui lòng nhập địa chỉ email.");
            request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
            return;
        }

        email = email.trim();
        request.setAttribute("submittedEmail", email);

        try {
            User user = userDAO.findByEmail(email);
            if (user != null && user.getAccountStatus() == User.AccountStatus.Active) {
                String tokenValue = UUID.randomUUID().toString();
                UserToken token = new UserToken(
                        user.getUserId(),
                        tokenValue,
                        "RESET_PASSWORD",
                        LocalDateTime.now().plusMinutes(RESET_TOKEN_MINUTES));

                if (!userDAO.savePasswordResetToken(token)) {
                    request.setAttribute("error", "Không thể tạo yêu cầu đặt lại mật khẩu. Vui lòng thử lại.");
                    request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
                    return;
                }

                boolean sent = EmailUtils.sendPasswordResetEmail(email, tokenValue, buildBaseUrl(request));
                if (!sent) {
                    request.setAttribute("error", "Không thể gửi email đặt lại mật khẩu. Vui lòng kiểm tra cấu hình Mailtrap và thử lại.");
                    request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
                    return;
                }
            }

            request.setAttribute("success",
                    "Nếu email tồn tại trong hệ thống, hướng dẫn đặt lại mật khẩu đã được gửi tới hộp thư của bạn.");
            request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu. Vui lòng thử lại.");
            request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String buildBaseUrl(HttpServletRequest request) {
        return request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort()
                + request.getContextPath();
    }
}
