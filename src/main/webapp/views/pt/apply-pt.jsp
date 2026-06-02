<%-- 
    Document   : apply-pt
    Created on : May 31, 2026, 9:52:02 PM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String error = (String) request.getAttribute("error");

    String fullName = request.getAttribute("fullName") != null ? (String) request.getAttribute("fullName") : "";
    String email = request.getAttribute("email") != null ? (String) request.getAttribute("email") : "";
    String phone = request.getAttribute("phone") != null ? (String) request.getAttribute("phone") : "";
    String gender = request.getAttribute("gender") != null ? (String) request.getAttribute("gender") : "";
    String dateOfBirth = request.getAttribute("dateOfBirth") != null ? (String) request.getAttribute("dateOfBirth") : "";
    String specialization = request.getAttribute("specialization") != null ? (String) request.getAttribute("specialization") : "";
    String experienceYears = request.getAttribute("experienceYears") != null ? (String) request.getAttribute("experienceYears") : "";
    String experienceDescription = request.getAttribute("experienceDescription") != null ? (String) request.getAttribute("experienceDescription") : "";
    String description = request.getAttribute("description") != null ? (String) request.getAttribute("description") : "";
    String introduction = request.getAttribute("introduction") != null ? (String) request.getAttribute("introduction") : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký ứng tuyển PT</title>
    </head>
    <body>
        <h2>Đăng ký ứng tuyển Personal Trainer</h2>

        <p>Vui lòng nhập thông tin bên dưới để gửi đơn ứng tuyển làm PT.</p>

        <% if (error != null && !error.trim().isEmpty()) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/apply-pt" method="post" enctype="multipart/form-data">

            <div>
                <label>Họ và tên *</label><br>
                <input type="text" name="fullName" value="<%= fullName %>" required>
            </div>

            <br>

            <div>
                <label>Email *</label><br>
                <input type="email" name="email" value="<%= email %>" required>
            </div>

            <br>

            <div>
                <label>Số điện thoại *</label><br>
                <input type="text" name="phone" value="<%= phone %>" 
                       required maxlength="10" pattern="[0-9]{10}">
            </div>

            <br>

            <div>
                <label>Giới tính</label><br>
                <select name="gender">
                    <option value="">-- Chọn giới tính --</option>
                    <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Nam</option>
                    <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Nữ</option>
                    <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Khác</option>
                </select>
            </div>

            <br>

            <div>
                <label>Ngày sinh</label><br>
                <input type="date" name="dateOfBirth" value="<%= dateOfBirth %>">
            </div>

            <br>

            <div>
                <label>Chuyên môn *</label><br>
                <select name="specialization" required>
                    <option value="">-- Chọn chuyên môn --</option>

                    <option value="Quản lý cân nặng"
                            <%= "Quản lý cân nặng".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Quản lý cân nặng
                    </option>

                    <option value="Tăng cơ"
                            <%= "Tăng cơ".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Tăng cơ
                    </option>

                    <option value="Cardio"
                            <%= "Cardio".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Cardio
                    </option>

                    <option value="Yoga"
                            <%= "Yoga".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Yoga
                    </option>

                    <option value="Boxing"
                            <%= "Boxing".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Boxing
                    </option>

                    <option value="Dinh dưỡng"
                            <%= "Dinh dưỡng".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Dinh dưỡng
                    </option>

                    <option value="Phục hồi thể lực"
                            <%= "Phục hồi thể lực".equals(request.getAttribute("specialization")) ? "selected" : "" %>>
                        Phục hồi thể lực
                    </option>
                </select>
            </div>

            <br>

            <div>
                <label>Số năm kinh nghiệm*</label><br>
                <input type="number" name="experienceYears" min="0" required value="<%= experienceYears %>">
            </div>

            <br>

            <div>
                <label>Mô tả kinh nghiệm</label><br>
                <textarea name="experienceDescription" rows="4" cols="50"><%= experienceDescription %></textarea>
            </div>

            <br>

            <div>
                <label>Mô tả chuyên môn</label><br>
                <textarea name="description" rows="4" cols="50"><%= description %></textarea>
            </div>

            <br>

            <div>
                <label>Giới thiệu bản thân</label><br>
                <textarea name="introduction" rows="4" cols="50"><%= introduction %></textarea>
            </div>

            <br>

            <div>
                <label>File chứng chỉ</label><br>
                <input type="file" name="certificate" accept=".pdf,.jpg,.jpeg,.png">
                <p>Không bắt buộc. Hỗ trợ file PDF, JPG, JPEG, PNG.</p>
            </div>

            <br>

            <button type="submit">Gửi đơn ứng tuyển</button>
            <a href="${pageContext.request.contextPath}/index.html">Hủy</a>
        </form>
    </body>
</html>