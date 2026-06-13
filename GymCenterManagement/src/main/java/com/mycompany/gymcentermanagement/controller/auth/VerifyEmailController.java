/**
 * =========================================================================
 * @file          : VerifyEmailController.java
 * @description   : Controller tiếp nhận link kích hoạt từ email của người dùng, kiểm tra tính hợp lệ và thời hạn
 *                  của Token trong bảng User_Tokens để kích hoạt trạng thái tài khoản từ Inactive sang Active.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VerifyEmailController", urlPatterns = {"/verify"})
public class VerifyEmailController extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Trích xuất chuỗi tham số mã định danh Token từ đường dẫn URL người dùng click vào (Bước 9 & 10)
        String token = request.getParameter("token");

        // Kiểm tra xử lý nếu tham số truyền vào trống rác
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Mã xác thực tài khoản không hợp lệ hoặc không tồn tại!");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
            return;
        }

        try {
            // Gọi hàm kiểm duyệt CSDL, thực thi Transaction chuyển trạng thái dữ liệu sang Active (Bước 11)
            String verifiedEmail = userDAO.verifyAccountAndGetEmail(token.trim());
            if (verifiedEmail != null) {
                // KÍCH HOẠT THÀNH CÔNG: Sử dụng Redirect kết hợp thông báo flash trong Session để tránh F5 gửi lại request (PRG)
                jakarta.servlet.http.HttpSession session = request.getSession(true);
                session.setAttribute("successMessage", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
                session.setAttribute("prepopulatedEmail", verifiedEmail);
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                // Luồng ngoại lệ E3: Token không tồn tại, hết hạn (quá 24 giờ), hoặc đã kích hoạt từ trước
                request.setAttribute("error", "Mã liên kết xác minh đã hết hiệu lực kích hoạt (quá 24 giờ), không đúng hoặc đã được sử dụng trước đó.");
                request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-email.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cho phép nhập token thủ công và xử lý chung thông qua doGet
        doGet(request, response);
    }
}

