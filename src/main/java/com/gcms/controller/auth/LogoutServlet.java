/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gcms.controller.auth;

import com.gcms.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: LogoutServlet.java
 * Description: Controller xử lý luồng Đăng xuất khỏi hệ thống (thuộc phân hệ UC-01).
 * Chịu trách nhiệm hủy bỏ hoàn toàn phiên làm việc hiện tại của người dùng (session.invalidate()),
 * tiến hành xóa bỏ các Cookie "Remember Me" lưu trữ trên trình duyệt Client, đồng thời
 * xóa Token đăng nhập tương ứng trong cơ sở dữ liệu nhằm bảo mật tài khoản.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Khởi tạo logic giải phóng Session, hủy Cookie và Token Remember Me.
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    /**
     * Xử lý yêu cầu đăng xuất qua phương thức GET (Khi click vào thẻ <a> Đăng xuất)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // BƯỚC 1: Xử lý xóa Token dưới Database và Trình duyệt (Nếu người dùng từng tích chọn Remember Me)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    
                    // 1.1 Gọi DAO thực hiện xóa cứng bản ghi Token trong bảng User_Tokens
                    userDAO.deleteRememberMeToken(tokenValue);
                    
                    // 1.2 Phát lệnh ghi đè Cookie với thời gian sống Max-Age = 0 để trình duyệt tự tiêu hủy
                    Cookie deleteCookie = new Cookie("remember_me_token", "");
                    deleteCookie.setMaxAge(0); // Đặt thời gian sống bằng 0 giây
                    deleteCookie.setHttpOnly(true); // Đảm bảo tính bảo mật
                    deleteCookie.setPath(request.getContextPath()); // Chỉ định đúng phạm vi ứng dụng
                    response.addCookie(deleteCookie);
                    break;
                }
            }
        }

        // BƯỚC 2: Tiêu hủy Session hiện tại của người dùng trên RAM của Server Tomcat
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tự sinh mới nếu không có
        if (session != null) {
            session.invalidate(); // Xóa sổ hoàn toàn Session và giải phóng vùng nhớ chứa object User
        }

        // BƯỚC 3: Điều hướng (Redirect) người dùng về trang Đăng nhập qua Endpoint /login
        // Đính kèm tham số toast bằng tiếng Việt để giao diện Login hiển thị thông báo trực quan
        response.sendRedirect(request.getContextPath() + "/login?toast=logout_success");
    }

    /**
     * Phục vụ trường hợp nút đăng xuất được bọc trong một Form và submit bằng POST
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển tiếp luồng xử lý chung về doGet
    }
}
