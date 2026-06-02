<%-- 
    Document   : pt-list
    Created on : Jun 1, 2026, 4:23:11 AM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.PersonalTrainer" %>
<%@ page import="model.PTServicePrice" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    List<PersonalTrainer> trainers = (List<PersonalTrainer>) request.getAttribute("trainers");
    List<String> specializationOptions = (List<String>) request.getAttribute("specializationOptions");
    List<String> selectedSpecializations = (List<String>) request.getAttribute("selectedSpecializations");

    if (specializationOptions == null) {
        specializationOptions = java.util.Collections.emptyList();
    }

    if (selectedSpecializations == null) {
        selectedSpecializations = java.util.Collections.emptyList();
    }
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Personal Trainer</title>
    </head>

    <form method="get" action="${pageContext.request.contextPath}/pt/list">
        <details>
            <summary>Lọc theo chuyên môn</summary>

            <div>
                <% for (String option : specializationOptions) { %>
                <label style="display: block; margin: 4px 0;">
                    <input type="checkbox"
                           name="specializations"
                           value="<%= option %>"
                           <%= selectedSpecializations.contains(option) ? "checked" : "" %>>
                    <%= option %>
                </label>
                <% } %>
            </div>
        </details>

        <br>

        <button type="submit">Lọc</button>
        <a href="${pageContext.request.contextPath}/pt/list">Xóa lọc</a>
    </form>

    <br>
    
    <body>
        <h2>Danh sách Personal Trainer</h2>

        <p>Danh sách các PT đang hoạt động tại phòng gym.</p>

        <% if (trainers == null || trainers.isEmpty()) { %>
        <p>Hiện chưa có PT nào đang hoạt động.</p>
        <% } else { %>
        <table border="1" cellpadding="8" cellspacing="0">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Họ tên</th>
                    <th>Chuyên môn</th>
                    <th>Kinh nghiệm</th>
                    <th>Gói dịch vụ</th>
                    <th>Thao tác</th>
                </tr>
            </thead>

            <tbody>
                <%
                    int index = 1;
                    for (PersonalTrainer trainer : trainers) {
                %>
                <tr>
                    <td><%= index++ %></td>

                    <td>
                        <strong><%= trainer.getDisplayName() %></strong><br>
                        <small><%= trainer.getEmail() %></small>
                    </td>

                    <td><%= trainer.getSpecialization() %></td>

                    <td>
                        <% if (trainer.getExperienceYears() != null) { %>
                        <%= trainer.getExperienceYears() %> năm
                        <% } else { %>
                        Chưa cập nhật
                        <% } %>
                    </td>

                    <td>
                        <% if (trainer.getServicePrices() == null || trainer.getServicePrices().isEmpty()) { %>
                        Chưa có gói dịch vụ
                        <% } else { %>
                        <ul>
                            <% for (PTServicePrice price : trainer.getServicePrices()) { %>
                            <li>
                                <%= price.getPackageName() %>
                                -
                                <%= currencyFormat.format(price.getPrice()) %> VNĐ
                            </li>
                            <% } %>
                        </ul>
                        <% } %>
                    </td>

                    <td>
                        <a href="${pageContext.request.contextPath}/pt/detail?id=<%= trainer.getPtId() %>">
                            Xem chi tiết
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

        <br>
        <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
    </body>
</html>
