<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đổi Mật Khẩu</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Đang tải...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3 shadow">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h3 class="text-primary m-0"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            <h3 class="m-0">Đổi mật khẩu</h3>
                        </div>

                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${requestScope.error}
                            </div>
                        </c:if>

                        <p class="text-muted text-center mb-4">Vui lòng thay đổi mật khẩu của bạn để hoàn tất đăng nhập và bảo vệ tài khoản.</p>

                        <form id="changePasswordForm" action="${pageContext.request.contextPath}/change-password" method="POST">
                            <div class="form-floating mb-3" style="position: relative;">
                                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Mật khẩu mới" minlength="8" required>
                                <label for="newPassword">Mật khẩu mới <span class="text-danger">*</span></label>
                            </div>
                            
                            <div class="form-floating mb-4" style="position: relative;">
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                                <label for="confirmPassword">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                            </div>
                            
                            <button type="submit" class="btn btn-primary py-3 w-100 mb-4 fw-bold">Cập nhật mật khẩu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>

    <script>
        $(document).ready(function() {
            $('#changePasswordForm').on('submit', function(e) {
                const password = $('#newPassword').val();
                const confirm = $('#confirmPassword').val();

                if (password !== confirm) {
                    e.preventDefault();
                    alert("Mật khẩu xác nhận không trùng khớp!");
                    $('#confirmPassword').focus();
                    return;
                }

                if (password.length < 8 || !password.matches(".*[A-Za-z].*") || !password.matches(".*\\d.*")) {
                    // Quick check using RegExp in JS
                    const hasLetter = /[a-zA-Z]/.test(password);
                    const hasDigit = /[0-9]/.test(password);
                    if (!hasLetter || !hasDigit) {
                        e.preventDefault();
                        alert("Mật khẩu tối thiểu phải từ 8 ký tự, bao gồm cả chữ và số.");
                        return;
                    }
                }
            });
        });
    </script>
</body>
</html>
