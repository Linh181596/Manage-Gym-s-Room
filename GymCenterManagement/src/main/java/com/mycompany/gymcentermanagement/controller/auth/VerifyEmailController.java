package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller to handle email verification and account activation.
 * Mapped to /verify.
 */
@WebServlet(name = "VerifyEmailController", urlPatterns = {"/verify"})
public class VerifyEmailController extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Mã xác thực không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
            return;
        }

        try {
            String verifiedEmail = userDAO.verifyAccountAndGetEmail(token.trim());
            if (verifiedEmail != null) {
                jakarta.servlet.http.HttpSession session = request.getSession(true);
                session.setAttribute("successMessage", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
                session.setAttribute("prepopulatedEmail", verifiedEmail);
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("error", "Liên kết xác nhận không hợp lệ, đã được sử dụng hoặc đã hết hạn (quá 24 giờ)!");
                request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Allow manual token entry
        String token = request.getParameter("token");
        doGet(request, response);
    }
}
