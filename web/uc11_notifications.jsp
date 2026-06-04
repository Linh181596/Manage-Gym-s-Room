<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GMCS — Trung tâm Thông báo Hội viên</title>
    <style>
        body { margin: 0; font-family: Arial, Helvetica, sans-serif; background: #f6f8fb; color: #1f2937; }
        header { padding: 16px 24px; background: #fff; border-bottom: 1px solid #d8dee9; display: flex; justify-content: space-between; align-items: center; }
        main { max-width: 1120px; margin: 0 auto; padding: 20px 24px 32px; }
        .nav { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 16px; }
        .nav a {
            border: 1px solid #d8dee9; background: #fff; color: #1f2937; padding: 8px 12px; border-radius: 6px; font-weight: 600; text-decoration: none;
        }
        .nav a.active { background: #2563eb; color: #fff; border-color: #2563eb; }
        .layout { display: grid; grid-template-columns: 360px 1fr; gap: 16px; }
        .card { background: #fff; border: 1px solid #d8dee9; border-radius: 8px; padding: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .card h2 { margin-top: 0; font-size: 16px; color: #475569; border-bottom: 1px solid #f1f5f9; padding-bottom: 8px; margin-bottom: 12px; }
        .item { display: block; padding: 12px; border: 1px solid #e2e8f0; border-radius: 6px; margin-bottom: 8px; color: #1f2937; text-decoration: none; background: #f8fafc; transition: all 0.2s; }
        .item:hover { border-color: #cbd5e1; background: #f1f5f9; text-decoration: none; }
        .item.active { border-color: #2563eb; background: #eff6ff; box-shadow: 0 0 0 1px #2563eb; }
        .item b { font-size: 14px; color: #1e293b; display: block; margin-bottom: 4px; }
        .meta { font-size: 12px; color: #94a3b8; }
        .empty { padding: 32px; text-align: center; color: #6b7280; font-style: italic; font-size: 14px; }
        .noti-content { font-size: 15px; color: #334155; line-height: 1.6; background: #f8fafc; padding: 16px; border-radius: 6px; border-left: 4px solid #2563eb; }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    List<Map<String, String>> notis = (List<Map<String, String>>) request.getAttribute("notis");
    Map<String, String> selectedNoti = (Map<String, String>) request.getAttribute("selectedNoti");
    int selectedId = request.getAttribute("selectedNotiId") != null ? (Integer) request.getAttribute("selectedNotiId") : -1;
    String appUrl = request.getContextPath() + "/gym-system";
%>
<header>
    <div>
        <h1 style="margin:0; font-size: 20px; color: #2563eb;">🔔 Hộp thư thông báo cá nhân</h1>
        <p style="margin:4px 0 0; color: #6b7280; font-size: 14px;">Xem tin tức, nhắc nhở lịch tập, ưu đãi gia hạn từ trung tâm</p>
    </div>
    <div style="text-align: right; font-size: 14px;">
        Tài khoản: <b><%= currentUser != null ? currentUser.getFullName() : "Hội viên" %></b> 
        (<a href="<%= appUrl %>?action=dashboard">Về Dashboard</a>)
    </div>
</header>

<main class="container">
    <nav class="nav">
        <% if(currentUser != null && !"Member".equalsIgnoreCase(currentUser.getRole())) { %>
            <a href="<%= appUrl %>?action=memberManagement">📋 Quản lý hội viên</a>
        <% } %>
        <a href="<%= appUrl %>?action=uc10_portal">👤 Hồ sơ cá nhân của tôi</a>
        <a class="active" href="<%= appUrl %>?action=viewMemberNotifications">🔔 Hộp thư thông báo riêng</a>
    </nav>

    <div class="layout">
        <section class="card">
            <h2>📬 Danh sách tin nhắn</h2>
            <div style="max-height: 500px; overflow-y: auto; padding-right: 4px;">
            <% if (notis != null && !notis.isEmpty()) { %>
                <% 
                    for (Map<String, String> noti : notis) {
                        int notiId = Integer.parseInt(noti.get("id"));
                        boolean isActiveNoti = (notiId == selectedId);
                %>
                    <a class="item <%= isActiveNoti ? "active" : "" %>" href="<%= appUrl %>?action=uc11_detail&notiId=<%= notiId %>">
                        <b>✉️ <%= noti.get("title") %></b>
                        <div class="meta">⏱ Gửi lúc: <%= noti.get("createdAt").split("\\.")[0] %></div>
                    </a>
                <% } %>
            <% } else { %>
                <div class="empty">📭 Hộp thư trống. Bạn chưa có thông báo nào.</div>
            <% } %>
            </div>
        </section>

        <section class="card">
            <h2>📄 Nội dung chi tiết thông báo</h2>
            <% if (selectedNoti != null) { %>
                <h3 style="margin-top: 0; color: #0f172a; font-size: 20px;"><%= selectedNoti.get("title") %></h3>
                <div class="meta" style="margin-bottom: 14px; padding-bottom: 8px; border-bottom: 1px dashed #e2e8f0;">
                    📅 Ngày gửi: <%= selectedNoti.get("createdAt").split("\\.")[0] %>
                </div>
                <div class="noti-content">
                    <%= selectedNoti.get("content") %>
                </div>
                <p class="meta" style="margin-top: 20px; font-style: italic; color: #94a3b8;">
                    💡 Hệ thống đã tự động đánh dấu thông báo này là "Đã đọc".
                </p>
            <% } else { %>
                <div class="empty" style="padding-top: 80px;">
                    👈 Vui lòng chọn một tiêu đề thư ở danh sách bên trái để đọc nội dung chi tiết.
                </div>
            <% } %>
        </section>
    </div>
</main>
</body>
</html>