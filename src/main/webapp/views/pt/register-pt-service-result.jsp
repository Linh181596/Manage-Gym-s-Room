<%-- 
    Document   : register-pt-service-result
    Created on : Jun 1, 2026, 5:54:36 AM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.PTServicePrice" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    PTServicePrice servicePrice = (PTServicePrice) request.getAttribute("servicePrice");
    LocalDate startDate = (LocalDate) request.getAttribute("startDate");
    LocalDate endDate = (LocalDate) request.getAttribute("endDate");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký gói PT thành công</title>
    </head>
    <body>
        <h2>Đăng ký gói PT thành công</h2>

        <p>Yêu cầu đăng ký gói PT của bạn đã được ghi nhận.</p>

        <% if (servicePrice != null) { %>
        <p>
            <strong>Tên gói:</strong>
            <%= servicePrice.getPackageName() %>
        </p>

        <p>
            <strong>Số buổi tập:</strong>
            <%= servicePrice.getNumberOfSessions() %> buổi
        </p>

        <p>
            <strong>Giá:</strong>
            <%= currencyFormat.format(servicePrice.getPrice()) %> VNĐ
        </p>

        <p>
            <strong>Ngày bắt đầu:</strong>
            <%= startDate %>
        </p>

        <p>
            <strong>Ngày kết thúc:</strong>
            <%= endDate %>
        </p>
        <% } %>

        <p>Staff/Admin sẽ sắp xếp lịch tập PT sau khi đăng ký được xử lý.</p>

        <a href="${pageContext.request.contextPath}/pt/list">Quay lại danh sách PT</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
    </body>
</html>
