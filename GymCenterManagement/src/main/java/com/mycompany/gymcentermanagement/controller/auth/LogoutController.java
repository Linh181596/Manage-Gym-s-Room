/**
 * =========================================================================
 * @file          : LogoutController.java
 * @description   : Controller xử lý luồng Đăng xuất khỏi hệ thống (thuộc phân hệ UC-01).
 *                  Chịu trách nhiệm hủy bỏ hoàn toàn phiên làm việc hiện tại của người dùng (session.invalidate()),
 *                  tiến hành xóa bỏ các Cookie "Remember Me" lưu trữ trên trình duyệt Client, đồng thời
 *                  xóa Token đăng nhập tương ứng trong cơ sở dữ liệu nhằm bảo mật tài khoản.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // BƯỚC 1: Xử lý xóa Token dưới Database và Trình duyệt (Nếu người dùng từng tích chọn Remember Me)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    try {
                        // 1.1 Gọi DAO thực hiện xóa bản ghi Token trong bảng User_Tokens
                        userDAO.deleteRememberMeToken(tokenValue);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    // 1.2 Phát lệnh ghi đè Cookie với thời gian sống Max-Age = 0 để trình duyệt tự tiêu hủy
                    Cookie cleanCookie = new Cookie("remember_me_token", "");
                    cleanCookie.setMaxAge(0);
                    cleanCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
                    response.addCookie(cleanCookie);
                    break;
                }
            }
        }

        // BƯỚC 2: Tiêu hủy Session hiện tại của người dùng trên RAM của Server
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Xóa sổ hoàn toàn Session và giải phóng vùng nhớ chứa object User
        }
        
        // BƯỚC 3: Điều hướng (Redirect) người dùng về trang Đăng nhập qua Endpoint /login
        // Đính kèm tham số toast bằng tiếng Việt để giao diện Login hiển thị thông báo trực quan
        response.sendRedirect(request.getContextPath() + "/login?toast=logout_success");
    }
}

