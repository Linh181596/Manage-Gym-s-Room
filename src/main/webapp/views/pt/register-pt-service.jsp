<%-- 
    Document   : register-pt-service
    Created on : Jun 1, 2026, 5:54:07 AM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.PTServicePrice" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.LocalDate" %>

<%
    String error = (String) request.getAttribute("error");
    PTServicePrice servicePrice = (PTServicePrice) request.getAttribute("servicePrice");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký gói PT</title>
    </head>
    <body>
        <h2>Đăng ký gói Personal Trainer</h2>

        <% if (error != null && !error.trim().isEmpty()) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>

        <% if (servicePrice == null) { %>
        <p>Không tìm thấy thông tin gói PT.</p>
        <a href="${pageContext.request.contextPath}/pt/list">Quay lại danh sách PT</a>
        <% } else { %>

        <h3>Thông tin gói PT</h3>
        <p>
            <strong>Tên PT:</strong>
            <%= servicePrice.getTrainerName() %>
        </p>
        
        <p>
            <strong>Tên gói:</strong>
            <%= servicePrice.getPackageName() %>
        </p>

        <p>
            <strong>Thời hạn:</strong>
            <%= servicePrice.getDurationMonths() %> tháng
        </p>

        <p>
            <strong>Số buổi tập:</strong>
            <%= servicePrice.getNumberOfSessions() %> buổi
        </p>

        <p>
            <strong>Giá:</strong>
            <%= currencyFormat.format(servicePrice.getPrice()) %> VNĐ
        </p>

        <form action="${pageContext.request.contextPath}/member/pt/register" method="post">
            <input type="hidden" name="priceId" value="<%= servicePrice.getPtServicePriceId() %>">

            <div>
                <label>Ngày bắt đầu mong muốn *</label><br>
                <input type="date" name="preferredStartDate" min="<%= LocalDate.now() %>"required>
            </div>

            <br>

            <div>
                <label>Ghi chú</label><br>
                <textarea name="note" rows="4" cols="50"></textarea>
            </div>

            <br>

            <button type="submit">Xác nhận đăng ký</button>
            <a href="${pageContext.request.contextPath}/pt/detail?id=<%= servicePrice.getPtId() %>">Hủy</a>
        </form>

        <% } %>
    </body>
</html>