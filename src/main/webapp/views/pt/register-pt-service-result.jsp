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
<%@ page import="java.math.BigDecimal" %>

<%
    PTServicePrice servicePrice = (PTServicePrice) request.getAttribute("servicePrice");
    LocalDate startDate = (LocalDate) request.getAttribute("startDate");
    LocalDate endDate = (LocalDate) request.getAttribute("endDate");  
    Object totalAmountAttr = request.getAttribute("totalAmount");
    BigDecimal totalAmount = null;
    
    if (totalAmountAttr instanceof BigDecimal) {
        totalAmount = (BigDecimal) totalAmountAttr;
    } else if (servicePrice != null) {
        totalAmount = servicePrice.getPrice();
    }

    String registrationStatus = (String) request.getAttribute("registrationStatus");
    if (registrationStatus == null || registrationStatus.trim().isEmpty()) {
        registrationStatus = "Pending";
    }

    String paymentStatus = (String) request.getAttribute("paymentStatus");
    if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
        paymentStatus = "Unpaid";
    }
    
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gửi yêu cầu đăng ký PT thành công</title>
    </head>
    <body>
        <h2>Gửi yêu cầu đăng ký PT thành công</h2>

        <p>Yêu cầu đăng ký dịch vụ PT của bạn đã được ghi nhận.</p>
        <p>Trạng thái đăng ký hiện tại là <strong><%= registrationStatus %></strong>. Staff/Admin sẽ xử lý thanh toán và sắp xếp lịch tập sau.</p>

        <% if (servicePrice != null) { %>
        <p>
            <strong>Tên PT:</strong>
            <%= servicePrice.getTrainerName() %>
        </p>

        <p>
            <strong>Tên gói:</strong>
            <%= servicePrice.getPackageName() %>
        </p>

        <p>
            <strong>Số buổi tập:</strong>
            <%= servicePrice.getNumberOfSessions() %> buổi
        </p>

        <p>
            <strong>Ngày bắt đầu:</strong>
            <%= startDate %>
        </p>

        <p>
            <strong>Ngày kết thúc:</strong>
            <%= endDate %>
        </p>

        <p>
            <strong>Tổng tiền:</strong>
            <%= totalAmount != null ? currencyFormat.format(totalAmount) : "0" %> VNĐ
        </p>

        <p>
            <strong>Trạng thái thanh toán:</strong>
            <%= paymentStatus %>
        </p>
        <% } %>

        <p>Staff/Admin sẽ sắp xếp lịch tập PT sau khi đăng ký được xử lý.</p>

        <a href="${pageContext.request.contextPath}/pt/list">Quay lại danh sách PT</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
    </body>
</html>
