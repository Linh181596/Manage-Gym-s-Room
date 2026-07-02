<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đăng nhập</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="GCMS Login" name="keywords">
    <meta content="Đăng nhập vào Hệ thống quản lý phòng tập Gym" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

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


        <!-- Sign In Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3 shadow">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="${pageContext.request.contextPath}/" class="">
                                <h3 class="text-primary"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            </a>
                            <h3>Đăng nhập</h3>
                        </div>
                        
                        <c:if test="${not empty requestScope.errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                ${requestScope.errorMessage}
                            </div>
                        </c:if>

                        <c:if test="${not empty requestScope.successMessage}">
                            <div class="alert alert-success" role="alert">
                                ${requestScope.successMessage}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="POST">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="email" name="email" required placeholder="name@example.com" value="${not empty requestScope.prepopulatedEmail ? requestScope.prepopulatedEmail : param.email}">
                                <label for="email">Địa chỉ Email</label>
                            </div>
                            <div class="form-floating mb-4">
                                <input type="password" class="form-control" id="password" name="password" required placeholder="Password">
                                <label for="password">Mật khẩu</label>
                            </div>
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="true">
                                    <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                                </div>
                                <a href="#">Quên mật khẩu?</a>
                            </div>
                            <button type="submit" class="btn btn-primary py-3 w-100 mb-4">Đăng nhập</button>
                        </form>
                        <div class="text-center mb-3">
                            <span class="text-muted">Chưa có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/register" class="fw-bold">Đăng ký tài khoản</a>
                        </div>
                        
                        <div class="border-top pt-3 mt-3">
                            <p class="mb-1 text-muted" style="font-size: 0.85rem;">Tài khoản dùng thử (Demo):</p>
                            <ul class="text-muted ps-3 mb-0" style="font-size: 0.8rem;">
                                <li>Quản trị (Admin): <code>admin@gym.com</code> / <code>admin123</code></li>
                                <li>Nhân viên (Staff): <code>staff@gym.com</code> / <code>staff123</code></li>
                                <li>Hội viên (Member): <code>member@gym.com</code> / <code>member123</code></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign In End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
