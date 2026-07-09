<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Quên mật khẩu</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Đang tải...</span>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3 shadow">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <h3 class="text-primary m-0"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            </a>
                            <h3 class="m-0">Quên mật khẩu</h3>
                        </div>

                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${requestScope.error}
                            </div>
                        </c:if>

                        <c:if test="${not empty requestScope.success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fa fa-check-circle me-2"></i>${requestScope.success}
                            </div>
                        </c:if>

                        <p class="text-muted mb-4">
                            Nhập email tài khoản để nhận liên kết đặt lại mật khẩu.
                        </p>

                        <form action="${pageContext.request.contextPath}/forgot-password" method="POST">
                            <div class="form-floating mb-4">
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${requestScope.submittedEmail}" placeholder="name@example.com" required>
                                <label for="email">Địa chỉ Email <span class="text-danger">*</span></label>
                            </div>

                            <button type="submit" class="btn btn-primary py-3 w-100 mb-3 fw-bold">
                                Gửi liên kết đặt lại mật khẩu
                            </button>
                        </form>

                        <p class="text-center mb-0">
                            <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
