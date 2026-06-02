<%-- 
    Document   : pt-detail
    Created on : Jun 1, 2026, 4:23:44 AM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.PersonalTrainer" %>
<%@ page import="model.PTServicePrice" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    String error = (String) request.getAttribute("error");
    PersonalTrainer trainer = (PersonalTrainer) request.getAttribute("trainer");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Personal Trainer</title>
    </head>
    <body>
        <h2>Chi tiết Personal Trainer</h2>

        <% if (error != null && !error.trim().isEmpty()) { %>
        <p style="color: red;"><%= error %></p>
        <a href="${pageContext.request.contextPath}/pt/list">Quay lại danh sách PT</a>
        <% } else if (trainer != null) { %>

        <h3><%= trainer.getDisplayName() %></h3>

        <p>
            <strong>Email:</strong>
            <%= trainer.getEmail() %>
        </p>

        <p>
            <strong>Số điện thoại:</strong>
            <%= trainer.getPhone() != null ? trainer.getPhone() : "Chưa cập nhật" %>
        </p>

        <p>
            <strong>Chuyên môn:</strong>
            <%= trainer.getSpecialization() %>
        </p>

        <p>
            <strong>Số năm kinh nghiệm:</strong>
            <% if (trainer.getExperienceYears() != null) { %>
            <%= trainer.getExperienceYears() %> năm
            <% } else { %>
            Chưa cập nhật
            <% } %>
        </p>

        <p>
            <strong>Mô tả:</strong><br>
            <%= trainer.getDescription() != null ? trainer.getDescription() : "Chưa có mô tả." %>
        </p>

        <hr>

        <h3>Gói dịch vụ PT</h3>

        <% if (trainer.getServicePrices() == null || trainer.getServicePrices().isEmpty()) { %>
        <p>PT này hiện chưa có gói dịch vụ nào.</p>
        <% } else { %>
        <table border="1" cellpadding="8" cellspacing="0">
            <thead>
                <tr>
                    <th>Tên gói</th>
                    <th>Thời hạn</th>
                    <th>Số buổi</th>
                    <th>Giá</th>
                    <th>Thao tác</th>
                </tr>
            </thead>

            <tbody>
                <% for (PTServicePrice price : trainer.getServicePrices()) { %>
                <tr>
                    <td><%= price.getPackageName() %></td>

                    <td>
                        <% if (price.getDurationMonths() != null) { %>
                        <%= price.getDurationMonths() %> tháng
                        <% } else { %>
                        Chưa cập nhật
                        <% } %>
                    </td>

                    <td>
                        <% if (price.getNumberOfSessions() != null) { %>
                        <%= price.getNumberOfSessions() %> buổi
                        <% } else { %>
                        Chưa cập nhật
                        <% } %>
                    </td>

                    <td>
                        <%= currencyFormat.format(price.getPrice()) %> VNĐ
                    </td>

                    <td>
                        <a href="${pageContext.request.contextPath}/member/pt/register?priceId=<%= price.getPtServicePriceId() %>">
                            Đăng ký gói này
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

        <br>

        <a href="${pageContext.request.contextPath}/pt/list">Quay lại danh sách PT</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>

        <% } %>
    </body>
</html>
