<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GMCS — Cổng thông tin Hội viên</title>
    <style>
        body { margin: 0; font-family: Arial, Helvetica, sans-serif; background: #f6f8fb; color: #1f2937; }
        header { padding: 16px 24px; background: #fff; border-bottom: 1px solid #d8dee9; display: flex; justify-content: space-between; align-items: center;}
        main { max-width: 1040px; margin: 0 auto; padding: 20px 24px 32px; }
        .nav { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 16px; }
        .nav a {
            border: 1px solid #d8dee9; background: #fff; color: #1f2937; padding: 8px 12px; border-radius: 6px; font-weight: 600; text-decoration: none;
        }
        .nav a.active { background: #2563eb; color: #fff; border-color: #2563eb; }
        .card { background: #fff; border: 1px solid #d8dee9; border-radius: 8px; padding: 20px; margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .profile-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px; }
        .profile-item { background: #f8fafc; padding: 12px 16px; border-radius: 6px; border: 1px solid #edf2f7; }
        .label { color: #6b7280; font-size: 13px; margin-bottom: 4px; font-weight: 600; text-transform: uppercase; }
        .value { font-size: 16px; font-weight: bold; color: #0f172a; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        th { background: #f1f5f9; color: #475569; font-size: 13px; font-weight: bold; }
        .badge { padding: 4px 8px; border-radius: 999px; font-size: 12px; font-weight: bold; }
        .badge-active { background: #dcfce7; color: #15803d; }
        .badge-expired { background: #fee2e2; color: #dc2626; }
        .empty { padding: 28px; text-align: center; color: #6b7280; font-style: italic; }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    Map<String, String> profile = (Map<String, String>) request.getAttribute("memberProfile");
    List<Map<String, String>> services = (List<Map<String, String>>) request.getAttribute("memberServices");
    String appUrl = request.getContextPath() + "/gym-system";
%>
<header>
    <div>
        <h1 style="margin:0; font-size: 20px; color: #2563eb;">Hồ sơ Cá nhân Hội viên (Member Portal)</h1>
        <p style="margin:4px 0 0; color: #6b7280; font-size: 14px;">Xem và theo dõi thời hạn các gói tập đang đăng ký tại trung tâm</p>
    </div>
    <div style="text-align: right; font-size: 14px;">
        Chào, <b><%= currentUser != null ? currentUser.getFullName() : "Hội viên" %></b> ! 
        (<a href="<%= appUrl %>?action=dashboard">Về Dashboard</a>)
    </div>
</header>

<main class="container">
    <nav class="nav">
        <% if(currentUser != null && !"Member".equalsIgnoreCase(currentUser.getRole())) { %>
            <a href="<%= appUrl %>?action=memberManagement">📋 Quản lý hội viên</a>
        <% } %>
        <a class="active" href="<%= appUrl %>?action=uc10_portal">👤 Hồ sơ cá nhân của tôi</a>
        <a href="<%= appUrl %>?action=viewMemberNotifications">🔔 Hộp thư thông báo riêng</a>
    </nav>

    <section class="card">
        <h2 style="margin-top: 0; font-size: 18px; color: #1e293b; margin-bottom: 16px;">📌 Thông tin tài khoản chính</h2>
        <% if (profile != null && !profile.isEmpty()) { %>
        <div class="profile-grid">
            <div class="profile-item">
                <div class="label">Mã thành viên</div>
                <div class="value">#<%= profile.get("memberId") %> (User ID: <%= profile.get("userId") %>)</div>
            </div>
            <div class="profile-item">
                <div class="label">Họ và Tên</div>
                <div class="value" style="color: #2563eb;"><%= profile.get("fullName") %></div>
            </div>
            <div class="profile-item">
                <div class="label">Hạng thẻ / Gói hiện tại</div>
                <div class="value"><%= profile.get("type") %></div>
            </div>
            <div class="profile-item">
                <div class="label">Địa chỉ Email</div>
                <div class="value"><%= profile.get("email") %></div>
            </div>
            <div class="profile-item">
                <div class="label">Số điện thoại</div>
                <div class="value"><%= profile.get("phone") %></div>
            </div>
            <div class="profile-item">
                <div class="label">Ngày gia nhập hệ thống</div>
                <div class="value"><%= profile.get("date").split("\\.")[0] %></div>
            </div>
            <div class="profile-item">
                <div class="label">Trạng thái hệ thống</div>
                <div class="value">
                    <% boolean act = "Active".equalsIgnoreCase(profile.get("status")); %>
                    <span class="badge <%= act?"badge-active":"badge-expired" %>">
                        <%= act ? "✓ Đang kích hoạt" : "✕ Đang tạm khóa" %>
                    </span>
                </div>
            </div>
        </div>
        <% } else { %>
            <div class="empty">⚠️ Không tìm thấy hồ sơ dữ liệu của hội viên này. Vui lòng kiểm tra lại quyền hạn.</div>
        <% } %>
    </section>

    <section class="card">
        <h2 style="margin-top: 0; font-size: 18px; color: #1e293b;">🏋️ Lịch sử đăng ký dịch vụ & Gói tập</h2>
        <% if (services != null && !services.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>Tên Gói Dịch Vụ Gym</th>
                <th>Ngày Kích Hoạt</th>
                <th>Ngày Hết Hạn</th>
                <th>Trạng Thái Gói</th>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, String> service : services) { 
                String sStatus = service.get("status");
                boolean isActiveS = "Active".equalsIgnoreCase(sStatus);
            %>
            <tr>
                <td><b><%= service.get("serviceName") %></b></td>
                <td><%= service.get("startDate") %></td>
                <td style="font-weight: 600;"><%= service.get("endDate") %></td>
                <td>
                    <span class="badge <%= isActiveS ? "badge-active" : "badge-expired" %>">
                        <%= isActiveS ? "● Còn hạn dùng" : "○ Hết hạn / Hủy" %>
                    </span>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
            <div class="empty">📭 Bạn chưa đăng ký hoặc chưa được gán bất kỳ gói dịch vụ tập luyện nào.</div>
        <% } %>
    </section>
</main>
</body>
</html>