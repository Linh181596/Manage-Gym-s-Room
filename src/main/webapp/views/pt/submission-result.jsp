<%-- 
    Document   : submission-result
    Created on : May 31, 2026, 10:33:36 PM
    Author     : phuga
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi đơn thành công</title>
</head>
<body>
    <h2>Gửi đơn ứng tuyển thành công</h2>

    <p>Đơn ứng tuyển làm PT của bạn đã được ghi nhận.</p>

    <p>
        <strong>Mã đơn ứng tuyển:</strong>
        ${applicationCode}
    </p>

    <p>
        Vui lòng lưu lại mã đơn này. Bạn có thể dùng mã đơn cùng với số điện thoại đã đăng ký
        để tra cứu kết quả xét duyệt sau.
    </p>

    <a href="${pageContext.request.contextPath}/pt-application-result">Tra cứu kết quả ứng tuyển</a>
    <br><br>
    <a href="${pageContext.request.contextPath}/index.html">Quay về trang chủ</a>
</body>
</html>