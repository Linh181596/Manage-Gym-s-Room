<%-- 
    Document   : application-result-lookup
    Created on : May 31, 2026, 10:44:30 PM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.PTApplication" %>

<%
    String error = (String) request.getAttribute("error");

    String applicationCode = request.getAttribute("applicationCode") != null
            ? (String) request.getAttribute("applicationCode")
            : "";

    String phone = request.getAttribute("phone") != null
            ? (String) request.getAttribute("phone")
            : "";

    PTApplication ptApplication = (PTApplication) request.getAttribute("application");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tra cứu kết quả ứng tuyển PT</title>
    </head>
    <body>
        <h2>Tra cứu kết quả ứng tuyển PT</h2>

        <p>Vui lòng nhập mã đơn ứng tuyển và số điện thoại đã đăng ký để kiểm tra kết quả.</p>

        <% if (error != null && !error.trim().isEmpty()) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/pt-application-result" method="post">
            <div>
                <label>Mã đơn ứng tuyển *</label><br>
                <input type="text" name="applicationCode" value="<%= applicationCode %>" required>
            </div>

            <br>

            <div>
                <label>Số điện thoại *</label><br>
                <input type="text" name="phone" value="<%= phone %>" required maxlength="10" pattern="[0-9]{10}">
            </div>

            <br>

            <button type="submit">Tra cứu</button>
            <a href="${pageContext.request.contextPath}/apply-pt">Quay lại đăng ký ứng tuyển</a>
        </form>

        <% if (ptApplication != null) { %>
        <hr>

        <h3>Kết quả tra cứu</h3>

        <p>
            <strong>Mã đơn:</strong>
            <%= ptApplication.getApplicationCode() %>
        </p>

        <p>
            <strong>Họ và tên:</strong>
            <%= ptApplication.getFullName() %>
        </p>

        <p>
            <strong>Email:</strong>
            <%= ptApplication.getEmail() %>
        </p>

        <p>
            <strong>Số điện thoại:</strong>
            <%= ptApplication.getPhone() %>
        </p>

        <p>
            <strong>Chuyên môn:</strong>
            <%= ptApplication.getSpecialization() %>
        </p>

        <p>
            <strong>Trạng thái đơn:</strong>
            <%= ptApplication.getStatus() %>
        </p>

        <% if (ptApplication.getReviewNote() != null && !ptApplication.getReviewNote().trim().isEmpty()) { %>
        <p>
            <strong>Ghi chú xét duyệt:</strong>
            <%= ptApplication.getReviewNote() %>
        </p>
        <% } %>

        <% if ("Approved".equalsIgnoreCase(ptApplication.getStatus())) { %>
        <div style="border: 1px solid green; padding: 10px;">
            <h4>Thông tin tài khoản PT</h4>
            <p>
                Đơn ứng tuyển của bạn đã được duyệt. Tài khoản PT sẽ được Staff/Admin kích hoạt
                và cung cấp theo quy trình của phòng gym.
            </p>
            <p>
                Vui lòng sử dụng email đã đăng ký:
                <strong><%= ptApplication.getEmail() %></strong>
                để nhận hoặc đăng nhập tài khoản khi được thông báo.
            </p>
        </div>
        <% } else if ("Rejected".equalsIgnoreCase(ptApplication.getStatus())) { %>
        <div style="border: 1px solid red; padding: 10px;">
            <p>Đơn ứng tuyển của bạn chưa được duyệt. Vui lòng xem ghi chú xét duyệt nếu có.</p>
        </div>
        <% } else { %>
        <div style="border: 1px solid orange; padding: 10px;">
            <p>Đơn ứng tuyển của bạn đang chờ Admin xét duyệt.</p>
        </div>
        <% } %>
        <% } %>

        <br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
    </body>
</html>
