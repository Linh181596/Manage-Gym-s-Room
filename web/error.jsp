<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GMCS - Lỗi truy cập</title>
    <style>
        body { margin: 0; font-family: Arial, Helvetica, sans-serif; background: #f6f8fb; color: #1f2937; }
        main { max-width: 760px; margin: 48px auto; background: #fff; border: 1px solid #d8dee9; border-radius: 8px; padding: 24px; }
        .error { border: 1px solid #fecaca; background: #fef2f2; color: #991b1b; padding: 12px; border-radius: 6px; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<main>
    <h1>Lỗi truy cập</h1>
    <div class="error">
        <b>Thông báo:</b>
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Bạn không có quyền thực hiện hành động này." %>
    </div>
    <p>Hãy quay lại Dashboard và dùng các nút đổi role để thử đúng luồng nghiệp vụ.</p>
    <p><a href="<%= request.getContextPath() %>/gym-system?action=dashboard">Quay lại Dashboard</a></p>
</main>
</body>
</html>
