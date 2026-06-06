/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gcms.controller.auth;

import com.gcms.dao.RegisterDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: VerifyEmailServlet.java
 * Description: Tiếp nhận link kích hoạt từ email của người dùng, kiểm tra tính hợp lệ và thời hạn
 * của Token trong bảng User_Tokens để kích hoạt trạng thái tài khoản từ Inactive sang Active.
 * Author: [duongnd] - [he187234]
 * Created Date: [05/06/2026]
 * Version: 1.0
 */
@WebServlet(name = "VerifyEmailServlet", urlPatterns = {"/verify"})
public class VerifyEmailServlet extends HttpServlet {
    private final RegisterDAO registerDAO = new RegisterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Trích xuất chuỗi tham số mã định danh Token từ đường dẫn URL người dùng click vào (Bước 9 & 10)
        String tokenValue = request.getParameter("token");

        // Kiểm tra xử lý nếu tham số truyền vào trống rác
        if (tokenValue == null || tokenValue.trim().isEmpty()) {
            request.setAttribute("error", "Mã xác thực tài khoản không hợp lệ hoặc không tồn tại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Gọi hàm kiểm duyệt CSDL, thực thi Transaction chuyển trạng thái dữ liệu sang Active (Bước 11)
        String activatedEmail = registerDAO.verifyAccountAndGetEmail(tokenValue);

        if (activatedEmail != null) {
            // KÍCH HOẠT THÀNH CÔNG: Đưa về trang Đăng nhập, thông báo và tự động điền sẵn email (Bước 12)
            request.setAttribute("message", "Tài khoản của bạn đã được kích hoạt thành công! Hãy thực hiện đăng nhập hệ thống.");
            request.setAttribute("savedEmail", activatedEmail); // Khớp luồng lưu vết của UC-01
            request.setAttribute("autoEmail", activatedEmail);  // Khớp luồng thiết kế của UC-02
            request.setAttribute("email", activatedEmail);      // Dự phòng trường hợp thẻ input gọi trực tiếp
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Luồng ngoại lệ E3: Token không tồn tại, hết hạn (quá 24 giờ), hoặc đã kích hoạt từ trước
            request.setAttribute("error", "Mã liên kết xác minh đã hết hiệu lực kích hoạt (quá 24 giờ), không đúng hoặc đã được sử dụng trước đó.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
