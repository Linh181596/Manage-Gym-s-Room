<%-- 
    Project: Gym Center Management System (GCMS)
    Course: SWP391 - Software Development Project
    File: login.jsp
    Description: Giao diện form đăng nhập dành cho tất cả các Actors (Admin, Staff, Member, PT).
                 Tích hợp in thông báo lỗi (errorMessage), tự động điền email (savedEmail/autoEmail)
                 và thông báo kích hoạt thành công .
    Author: [duongnd] - [he187234]
    Created Date: [05/06/2026]
    Version: 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GCMS - Đăng Nhập Hệ Thống</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f4f7f6; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-container { max-width: 450px; width: 100%; padding: 30px; background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .btn-custom { background: #3498db; color: white; transition: all 0.3s; }
        .btn-custom:hover { background: #2980b9; color: white; }
    </style>
</head>
<body>

<div class="login-container">
    <div class="text-center mb-4">
        <h2>Gym Center Management</h2>
        <p class="text-muted">Vui lòng đăng nhập vào tài khoản của bạn</p>
    </div>

    <% 
        /* * BƯỚC THÊM MỚI: Bắt sự kiện thông báo Đăng xuất (Logout) từ LogoutServlet gửi về
         */
        String toast = request.getParameter("toast");
        if ("logout_success".equals(toast)) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i> Đăng xuất tài khoản thành công!
<!--            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>-->
        </div>
    <% 
        } 
    %>

    <% 
        /* * ĐỒNG BỘ HÓA UC-02: Khối hiển thị thông báo KÍCH HOẠT THÀNH CÔNG màu xanh 
         * Lấy từ VerifyEmailServlet thông qua thuộc tính "message"
         */
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i> <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% 
        } 
    %>

    <% 
        /* * ĐỒNG BỘ HÓA: In thông điệp báo lỗi từ Controller (Sai mật khẩu, tài khoản chưa kích hoạt, hoặc link hết hạn)
         */
        String errorMessage = (String) request.getAttribute("errorMessage");
        // Hỗ trợ thêm trường "error" truyền từ khối xử lý ngoại lệ E3 của Servlet xác thực
        if (errorMessage == null) {
            errorMessage = (String) request.getAttribute("error");
        }
        if (errorMessage != null) {
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i> <%= errorMessage %>
<!--            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>-->
        </div>
    <% 
        } 
    %>

    <form action="login" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Địa chỉ Email</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <%
                    // ĐỒNG BỘ HÓA ĐIỀN EMAIL: Kiểm tra lưu vết của cả luồng Login lỗi và luồng Xác thực Email thành công gửi sang
                    String savedEmail = (String) request.getAttribute("savedEmail");
                    if (savedEmail == null) {
                        savedEmail = (String) request.getAttribute("autoEmail");
                    }
                    if (savedEmail == null) {
                        savedEmail = (String) request.getAttribute("email");
                    }
                    if (savedEmail == null) {
                        savedEmail = "";
                    }
                %>
                <input type="email" class="form-control" id="email" name="email" 
                       placeholder="example@gym.com" required 
                       value="<%= savedEmail %>">
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" class="form-control" id="password" name="password" 
                       placeholder="••••••••" required>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
                <input type="checkbox" class="checkbox" id="rememberMe" name="rememberMe" value="true">
                <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
            </div>
            <a href="forgot-password.jsp" class="text-decoration-none">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn btn-custom w-100 py-2">
            <i class="fas fa-sign-in-alt me-2"></i> Đăng Nhập
        </button>
    </form>
</div>

<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>