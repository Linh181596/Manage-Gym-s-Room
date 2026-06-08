package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller to handle changing password when mustChangePassword flag is true.
 * Mapped to /change-password.
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường mật khẩu.");
            request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 8 || !newPassword.matches(".*[A-Za-z].*") || !newPassword.matches(".*\\d.*")) {
            request.setAttribute("error", "Mật khẩu tối thiểu phải từ 8 ký tự, bao gồm cả chữ và số.");
            request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        try {
            String newPasswordHash = PasswordUtils.hashPassword(newPassword);
            boolean success = userDAO.updatePassword(user.getUserId(), newPasswordHash, false);
            
            if (success) {
                user.setPasswordHash(newPasswordHash);
                user.setMustChangePassword(false);
                
                // Redirect based on User Role
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
            } else {
                request.setAttribute("error", "Không thể cập nhật mật khẩu mới. Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối CSDL: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(request, response);
        }
    }
}
