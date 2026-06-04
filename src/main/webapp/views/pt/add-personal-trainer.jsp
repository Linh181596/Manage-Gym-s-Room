<%-- 
    Document   : add-personal-trainer
    Created on : Jun 4, 2026, 7:20:18 PM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>

<%
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Personal Trainer / Tạo tài khoản PT</title>
    </head>

    <body>
        <h2>Thêm Personal Trainer / Tạo tài khoản PT</h2>

        <p>
            Màn hình này dùng cho Staff/Admin tạo hồ sơ PT và tài khoản đăng nhập
            sau khi PT đã hoàn tất quy trình tuyển dụng/phỏng vấn offline.
        </p>

        <% if (error != null && !error.trim().isEmpty()) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>

        <form method="post"
              action="${pageContext.request.contextPath}/staff/pt/add"
              enctype="multipart/form-data">

            <h3>Thông tin tài khoản</h3>

            <div>
                <label>Email đăng nhập <span style="color: red;">*</span></label><br>
                <input type="email" name="email" required>
            </div>

            <br>

            <div>
                <label>Số điện thoại <span style="color: red;">*</span></label><br>
                <input type="text"
                       name="phone"
                       pattern="[0-9]{10}"
                       maxlength="10"
                       placeholder="Ví dụ: 0912345678"
                       required>
                <br>
                <small>Số điện thoại phải có đúng 10 chữ số.</small>
            </div>

            <hr>

            <h3>Thông tin Personal Trainer</h3>

            <div>
                <label>Họ tên đầy đủ <span style="color: red;">*</span></label><br>
                <input type="text" name="fullName" required>
            </div>

            <br>

            <div>
                <label>Tên hiển thị</label><br>
                <input type="text" name="displayName" placeholder="Ví dụ: Coach Nam">
                <br>
                <small>Nếu bỏ trống, hệ thống sẽ hiển thị họ tên đầy đủ của PT.</small>
            </div>

            <br>

            <div>
                <label>Chuyên môn <span style="color: red;">*</span></label><br>
                <select name="specialization" required>
                    <option value="">-- Chọn chuyên môn --</option>
                    <option value="Quản lý cân nặng">Quản lý cân nặng</option>
                    <option value="Tăng cơ">Tăng cơ</option>
                    <option value="Cardio">Cardio</option>
                    <option value="Yoga">Yoga</option>
                    <option value="Boxing">Boxing</option>
                    <option value="Dinh dưỡng">Dinh dưỡng</option>
                    <option value="Phục hồi thể lực">Phục hồi thể lực</option>
                </select>
            </div>

            <br>

            <div>
                <label>Ngày bắt đầu sự nghiệp <span style="color: red;">*</span></label><br>
                <input type="date"
                       name="careerStartDate"
                       max="<%= LocalDate.now() %>"
                       required>
                <br>
                <small>Dùng để tính số năm kinh nghiệm của PT.</small>
            </div>

            <br>

            <div>
                <label>Mô tả / Giới thiệu PT</label><br>
                <textarea name="description"
                          rows="5"
                          cols="60"
                          maxlength="500"
                          placeholder="Nhập mô tả ngắn về kinh nghiệm, phong cách huấn luyện, điểm mạnh của PT..."></textarea>
            </div>

            <br>

            <div>
                <label>Chứng chỉ PT</label><br>
                <input type="file"
                       name="certificateFile"
                       accept=".pdf,.jpg,.jpeg,.png">
                <br>
                <small>Không bắt buộc. Chỉ hỗ trợ PDF, JPG, JPEG, PNG.</small>
            </div>

            <br>

            <div>
                <label>Ảnh đại diện PT</label><br>
                <input type="file"
                       name="avatarFile"
                       accept=".jpg,.jpeg,.png">
                <br>
                <small>Không bắt buộc. Chỉ hỗ trợ JPG, JPEG, PNG.</small>
            </div>

            <hr>

            <button type="submit">Tạo tài khoản PT</button>
            <a href="${pageContext.request.contextPath}/pt/list">Hủy</a>
        </form>
    </body>
</html>
