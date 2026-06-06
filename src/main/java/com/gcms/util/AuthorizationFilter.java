package com.gcms.util;

import com.gcms.model.User;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: AuthorizationFilter.java
 * Description: Bộ lọc trung tâm (Servlet Filter) kiểm soát quyền truy cập toàn bộ hệ thống.
 * Đánh chặn mọi request (/*), kiểm tra trạng thái login trong Session, đối chiếu quyền 
 * của User với AccessControlConfig để cho phép đi tiếp hoặc đá văng về trang 403.jsp / login.jsp.
 * Author: [duongnd] - [he187234]
 * Created Date: [05/06/2026]
 * Version: 1.0
 */

@WebFilter("/*") // Đánh chặn tất cả request gửi lên server
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo bộ lọc (nếu cần cấu hình ban đầu)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Lấy đường dẫn URI hiện tại (bỏ qua tên Context Path của dự án)
        String contextPath = req.getContextPath();
        String uri = req.getRequestURI().substring(contextPath.length());

        // BƯỚC 1: Kiểm tra tài nguyên công cộng hoặc tài nguyên tĩnh (Bypass)
        if (AccessControlConfig.isPublicResource(uri)) {
            chain.doFilter(request, response); // Cho đi qua luôn không cần check đăng nhập
            return;
        }

        // BƯỚC 2: Kiểm tra trạng thái Đăng nhập (Tomcat Session)
        HttpSession session = req.getSession(false); // Lấy session hiện tại, không tự sinh mới
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Chưa đăng nhập -> Đẩy ngay người dùng về trang login kèm cảnh báo bằng tiếng Việt
            req.setAttribute("errorMessage", "Vui lòng đăng nhập để truy cập hệ thống!");
            req.getRequestDispatcher("/login").forward(req, res);
            return;
        }

        // BƯỚC 3: Kiểm tra Phân quyền truy cập (Authorization)
        // Gửi List<Role> của người dùng và URI hiện tại sang bộ não cấu hình để so khớp
        if (AccessControlConfig.hasPermission(user.getRoles(), uri)) {
            chain.doFilter(request, response); // Quyền hợp lệ -> Cho phép đi tiếp vào các Servlet chức năng
        } else {
            // Cố tình truy cập trái phép vùng không thuộc quyền hạn -> Đẩy sang trang báo lỗi 403
            res.sendRedirect(contextPath + "/403.jsp");
        }
    }

    @Override
    public void destroy() {
        // Hủy bộ lọc khi dừng server
    }
}