<%-- 
    Document   : pt-account-creation-result
    Created on : Jun 4, 2026, 7:22:16 PM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String fullName = (String) request.getAttribute("fullName");
    String displayName = (String) request.getAttribute("displayName");
    String email = (String) request.getAttribute("email");
    String phone = (String) request.getAttribute("phone");
    String temporaryPassword = (String) request.getAttribute("temporaryPassword");

    Boolean mustChangePassword = (Boolean) request.getAttribute("mustChangePassword");

    String publicName = displayName;
    if (publicName == null || publicName.trim().isEmpty()) {
        publicName = fullName;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tạo tài khoản PT thành công</title>
    </head>

    <body>
        <h2>Tạo tài khoản Personal Trainer thành công</h2>

        <p>
            Hồ sơ Personal Trainer và tài khoản đăng nhập đã được tạo thành công.
            Staff/Admin cần bàn giao thông tin đăng nhập tạm thời cho PT.
        </p>

        <h3>Thông tin PT</h3>

        <p>
            <strong>Họ tên đầy đủ:</strong>
            <%= fullName != null ? fullName : "Chưa cập nhật" %>
        </p>

        <p>
            <strong>Tên hiển thị:</strong>
            <%= publicName != null ? publicName : "Chưa cập nhật" %>
        </p>

        <p>
            <strong>Email đăng nhập:</strong>
            <%= email != null ? email : "Chưa cập nhật" %>
        </p>

        <p>
            <strong>Số điện thoại:</strong>
            <%= phone != null ? phone : "Chưa cập nhật" %>
        </p>

        <h3>Thông tin đăng nhập tạm thời</h3>

        <p>
            <strong>Email:</strong>
            <%= email != null ? email : "Chưa cập nhật" %>
        </p>

        <p>
            <strong>Mật khẩu tạm thời:</strong>
            <span style="font-weight: bold; color: red;">
                <%= temporaryPassword != null ? temporaryPassword : "Không có dữ liệu" %>
            </span>
        </p>

        <p>
            <strong>Yêu cầu đổi mật khẩu lần đầu:</strong>
            <%= Boolean.TRUE.equals(mustChangePassword) ? "Có" : "Không" %>
        </p>

        <p style="color: red;">
            Lưu ý: Mật khẩu tạm thời chỉ hiển thị tại màn hình này. 
            Hệ thống chỉ lưu mật khẩu đã được hash trong database.
        </p>

        <p>
            Sau khi đăng nhập lần đầu, Personal Trainer phải đổi mật khẩu trước khi sử dụng các chức năng trong hệ thống.
        </p>

        <br>

        <a href="${pageContext.request.contextPath}/staff/pt/add">Tạo tài khoản PT khác</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/pt/list">Xem danh sách PT</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
    </body>
</html>