<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GMCS - Hệ thống Quản lý Hội viên</title>
    <style>
        :root {
            --bg: #f4f6f9;
            --panel: #ffffff;
            --line: #e2e8f0;
            --text: #1e293b;
            --muted: #64748b;
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --success: #10b981;
            --success-hover: #059669;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --warning: #f59e0b;
        }
        * { box-shadow: none; box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: var(--bg);
            color: var(--text);
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            align-items: center;
            padding: 16px 24px;
            background: var(--panel);
            border-bottom: 1px solid var(--line);
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        }
        .brand h1 { margin: 0; font-size: 20px; color: var(--primary); font-weight: 700; }
        .brand p { margin: 4px 0 0; color: var(--muted); font-size: 13px; }
        .role-box { text-align: right; font-size: 13px; }
        .role-links { margin-top: 6px; }
        .role-links a {
            padding: 2px 6px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: var(--primary);
            text-decoration: none;
        }
        .role-links a.active {
            background: #dbeafe;
            color: #1e40af;
            border-color: #bfdbfe;
            font-weight: bold;
        }
        
        .container { padding: 24px; max-width: 1300px; margin: 0 auto; }
        
        .nav {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .nav a, .btn {
            border: 1px solid var(--line);
            background: var(--panel);
            color: var(--text);
            padding: 9px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .nav a.primary, .btn.primary {
            background: var(--primary);
            color: #fff;
            border-color: var(--primary);
        }
        .nav a.primary:hover, .btn.primary:hover {
            background: var(--primary-hover);
        }
        .btn-success {
            background: var(--success);
            color: white;
            border-color: var(--success);
        }
        .btn-success:hover {
            background: var(--success-hover);
        }
        
        .add-member-section {
            background: var(--panel);
            border: 1px solid var(--line);
            border-radius: 8px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            display: none; 
            animation: slideDown 0.25s ease-out;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .grid-layout {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 24px;
            align-items: start;
        }
        .card {
            background: var(--panel);
            border: 1px solid var(--line);
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .card h2 { margin-top: 0; font-size: 16px; border-bottom: 1px solid var(--line); padding-bottom: 10px; margin-bottom: 16px; color: #334155; }
        
        label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 14px; color: #475569; }
        input, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font: inherit;
            color: var(--text);
            background-color: #fff;
        }
        input:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--panel);
        }
        th, td {
            border-bottom: 1px solid var(--line);
            padding: 14px 12px;
            text-align: left;
            font-size: 14px;
        }
        th { background: #f8fafc; font-size: 13px; color: #64748b; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }
        .muted { color: var(--muted); font-size: 13px; margin-top: 2px; }
        
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }
        .badge.active { color: #065f46; background: #d1fae5; }
        .badge.locked { color: #991b1b; background: #fee2e2; }
        
        .row-actions { display: flex; gap: 6px; flex-wrap: wrap; }
        .row-actions a {
            font-size: 13px;
            padding: 6px 10px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            background: #fff;
            color: #475569;
            font-weight: 500;
            text-decoration: none;
        }
        .row-actions a:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
            color: var(--primary);
        }
        .row-actions a.btn-delete-action {
            color: var(--danger);
            border-color: #fecaca;
        }
        .row-actions a.btn-delete-action:hover {
            background: #fef2f2;
            border-color: var(--danger);
            color: var(--danger-hover);
        }
        .empty { padding: 40px; text-align: center; color: var(--muted); font-style: italic; }
        
        @media (max-width: 950px) {
            .topbar { flex-direction: column; align-items: flex-start; }
            .grid-layout { grid-template-columns: 1fr; }
            table { display: block; overflow-x: auto; }
        }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    List<Map<String, String>> memberList = (List<Map<String, String>>) request.getAttribute("memberList");
    String keyword = request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "";
    String memberType = request.getParameter("memberType") != null ? request.getParameter("memberType") : "";
    String appUrl = request.getContextPath() + "/gym-system";
    String currentRole = currentUser != null ? currentUser.getRole() : "Guest";
    boolean isStaff = "Staff".equals(currentRole);
%>
<header class="topbar">
    <div class="brand">
        <h1>GMCS — Trung tâm Quản lý Fitness & Gym</h1>
        <p>Bảng điều khiển nghiệp vụ dành riêng cho Nhân viên điều hành</p>
    </div>
    <div class="role-box">
        <div><b>Vai trò hiện tại:</b> <span style="color: var(--primary); font-weight: bold;"><%= currentRole %></span> — <%= currentUser != null ? currentUser.getFullName() : "Khách" %></div>
        <div class="role-links">
            Kiểm thử vai trò: 
            <a href="<%= appUrl %>?action=switchRole&role=Staff" class="<%= "Staff".equals(currentRole)?"active":"" %>">Nhân viên (Staff)</a> |
            <a href="<%= appUrl %>?action=switchRole&role=Admin" class="<%= "Admin".equals(currentRole)?"active":"" %>">Quản trị viên</a> |
            <a href="<%= appUrl %>?action=switchRole&role=Member" class="<%= "Member".equals(currentRole)?"active":"" %>">Hội viên</a>
        </div>
    </div>
</header>

<main class="container">
    <nav class="nav">
        <a class="primary" href="<%= appUrl %>?action=memberManagement">📋 Quản lý danh sách hội viên</a>
        <a href="<%= appUrl %>?action=uc10_portal">👤 Cổng thông tin hội viên (Portal)</a>
        <a href="<%= appUrl %>?action=viewMemberNotifications">🔔 Hộp thư thông báo</a>
    </nav>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; background: #fff; padding: 16px; border: 1px solid var(--line); border-radius: 8px;">
        <div style="font-weight: 700; font-size: 18px; color: #0f172a;">Danh sách hội viên đăng ký</div>
        <% if(isStaff) { %>
            <button class="btn btn-success" onclick="toggleAddMemberForm()" id="mainActionBtn">
                <span>➕ Thêm hội viên mới (UC9-1)</span>
            </button>
        <% } %>
    </div>

    <% if(isStaff) { %>
    <section id="addMemberSection" class="add-member-section">
        <h3 style="margin-top:0; margin-bottom: 18px; font-size: 16px; color: #0f172a; font-weight: 700; border-bottom: 1px solid var(--line); padding-bottom: 8px;">
            ✨ Điền thông tin tạo tài khoản hội viên mới
        </h3>
        <form action="<%= appUrl %>" method="POST">
            <input type="hidden" name="action" value="uc09_add">
            
            <div class="form-grid">
                <div>
                    <label for="name">Họ và tên hội viên <span style="color:var(--danger)">*</span></label>
                    <input id="name" type="text" name="name" placeholder="Ví dụ: Trần Văn A" required>
                </div>
                <div>
                    <label for="email">Địa chỉ Email <span style="color:var(--danger)">*</span></label>
                    <input id="email" type="email" name="email" placeholder="example@gmail.com" required>
                </div>
                <div>
                    <label for="phone">Số điện thoại liên hệ</label>
                    <input id="phone" type="text" name="phone" placeholder="Ví dụ: 0912345xxx">
                </div>
                <div>
                    <label for="type">Gói tập đăng ký ban đầu</label>
                    <select id="type" name="type">
                        <option value="Gym Basic 1 Month">Gói Cơ Bản (Gym Basic - 1 Tháng)</option>
                        <option value="Gym Premium 3 Months">Gói Cao Cấp (Gym Premium - 3 Tháng)</option>
                    </select>
                </div>
            </div>
            
            <div style="display: flex; gap: 12px; justify-content: flex-end; border-top: 1px solid var(--line); padding-top: 16px;">
                <button class="btn" type="button" onclick="toggleAddMemberForm()" style="background: #f1f5f9; border-color: #cbd5e1;">Hủy bỏ</button>
                <button class="btn primary" type="submit">Xác nhận thêm hội viên</button>
            </div>
        </form>
    </section>
    <% } %>

    <div class="grid-layout">
        <section class="card">
            <h2>🔍 Bộ lọc dữ liệu</h2>
            <form action="<%= appUrl %>" method="GET">
                <input type="hidden" name="action" value="memberManagement">
                
                <label for="searchKeyword">Từ khóa cần tìm</label>
                <input id="searchKeyword" type="text" name="searchKeyword" value="<%= keyword %>" placeholder="Tên, Email hoặc Số ĐT..." <%= !isStaff ? "disabled" : "" %>>
                
                <label for="memberType" style="margin-top: 14px;">Theo phân loại gói tập</label>
                <select id="memberType" name="memberType" <%= !isStaff ? "disabled" : "" %>>
                    <option value="" <%= memberType.isEmpty() ? "selected" : "" %>>— Tất cả các gói —</option>
                    <option value="Basic" <%="Basic".equals(memberType)?"selected":"" %>>Gói Cơ Bản (Basic)</option>
                    <option value="Premium" <%="Premium".equals(memberType)?"selected":"" %>>Gói Cao Cấp (Premium)</option>
                </select>
                
                <div style="margin-top: 20px;">
                    <button class="btn primary" type="submit" style="width: 100%; justify-content: center;" <%= !isStaff ? "disabled" : "" %>>Tìm kiếm</button>
                    <a href="<%= appUrl %>?action=memberManagement" class="btn" style="width: 100%; justify-content: center; margin-top: 8px; text-align: center; pointer-events: <%= isStaff ? "auto" : "none" %>; opacity: <%= isStaff ? "1" : "0.5" %>;">Xóa bộ lọc</a>
                </div>
            </form>
        </section>

        <section class="card" style="overflow-x: auto; padding: 0;">
            <% if (isStaff && memberList != null && !memberList.isEmpty()) { %>
            <table>
                <thead>
                <tr>
                    <th style="width: 80px; padding-left: 16px;">Mã số</th>
                    <th>Thông tin thành viên</th>
                    <th>Gói tập hiện tại</th>
                    <th>Ngày tham gia</th>
                    <th>Trạng thái tài khoản</th>
                    <th style="text-align: center; width: 280px;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <% 
                    for (Map<String, String> member : memberList) { 
                        String userId = member.get("userId");
                        String status = member.get("status");
                        boolean isActive = "Active".equalsIgnoreCase(status);
                %>
                <tr>
                    <td style="padding-left: 16px;"><b>#<%= userId %></b></td>
                    <td>
                        <div style="font-weight: 700; color: #0f172a;"><%= member.get("fullName") %></div>
                        <div class="muted">📧 <%= member.get("email") %></div>
                        <div class="muted">📱 <%= member.get("phone") %></div>
                    </td>
                    <td>
                        <span class="badge" style="background: #f1f5f9; color: #334155; border: 1px solid #cbd5e1; font-weight: 600;">
                            <%= member.get("membershipType") %>
                        </span>
                    </td>
                    <td class="muted"><%= member.get("date").split("\\.")[0] %></td>
                    <td>
                        <span class="badge <%= isActive ? "active" : "locked" %>">
                            <%= isActive ? "🟢 Hoạt động" : "🔴 Đang khóa" %>
                        </span>
                    </td>
                    <td>
                        <div class="row-actions" style="justify-content: center;">
                            <a href="<%= appUrl %>?action=viewMemberPortal&viewMemberId=<%= userId %>">👁️ Hồ sơ</a>
                            
                            <% if (isActive) { %>
                                <a href="<%= appUrl %>?action=toggleMemberStatus&userId=<%= userId %>&targetStatus=Locked"
                                   onclick="return confirm('Bạn có chắc chắn muốn KHÓA hội viên này?')">🔒 Khóa</a>
                            <% } else { %>
                                <a href="<%= appUrl %>?action=toggleMemberStatus&userId=<%= userId %>&targetStatus=Active"
                                   onclick="return confirm('Bạn có chắc chắn muốn MỞ KHÓA hội viên này?')" style="color: #059669;">🔓 Mở</a>
                            <% } %>
                            
                            <a href="<%= appUrl %>?action=sendQuickNotification&userId=<%= userId %>"
                               onclick="return confirm('Hệ thống sẽ gửi thông báo nhắc nợ tự động. Tiếp tục?')">🔔 Nhắc nhở gia hạn</a>

                            <a href="<%= appUrl %>?action=deleteMember&userId=<%= userId %>" class="btn-delete-action"
                               onclick="return confirm('CẢNH BÁO: Bạn có thực sự chắc chắn muốn XÓA HỘI VIÊN này khỏi hệ thống không?')">❌ Xóa</a>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
                <div class="empty">
                    <% if(!isStaff) { %>
                        🔒 <b>Quyền truy cập bị từ chối:</b> Chức năng Quản lý hội viên (Manage Members) chỉ dành riêng cho tài khoản thuộc nhóm quyền <b>Staff (Nhân viên)</b>. Vui lòng ấn chọn "Nhân viên (Staff)" ở góc trên bên phải để kiểm thử chức năng này.
                    <% } else { %>
                        📭 Hiện tại chưa có dữ liệu hội viên nào phù hợp với bộ lọc tìm kiếm của bạn.
                    <% } %>
                </div>
            <% } %>
        </section>
    </div>
</main>

<script>
    function toggleAddMemberForm() {
        var formSection = document.getElementById("addMemberSection");
        var btn = document.getElementById("mainActionBtn");
        if(!formSection) return;
        
        if (formSection.style.display === "none" || formSection.style.display === "") {
            formSection.style.display = "block";
            btn.innerHTML = "<span>❌ Đóng biểu mẫu thêm</span>";
            btn.style.backgroundColor = "var(--danger)";
            btn.style.borderColor = "var(--danger)";
            document.getElementById("name").focus();
        } else {
            formSection.style.display = "none";
            btn.innerHTML = "<span>➕ Thêm hội viên mới (UC9-1)</span>";
            btn.style.backgroundColor = "var(--success)";
            btn.style.borderColor = "var(--success)";
        }
    }
</script>
</body>
</html>