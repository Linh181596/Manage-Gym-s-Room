<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đăng Ký Tài Khoản</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="img/favicon.ico" rel="icon">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">
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
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <a href="index.jsp" class="text-decoration-none">
                                <h3 class="text-primary m-0"><i class="fa fa-hashtag me-2"></i>GCMS</h3>
                            </a>
                            <h3 class="m-0">Đăng Ký</h3>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa fa-check-circle me-2"></i>${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form id="registerForm" action="register" method="POST">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingFullName" name="displayName" value="${oldDisplayName}" placeholder="Nguyễn Văn A" maxlength="100" required>
                                <label for="floatingFullName">Họ và tên <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="floatingEmail" name="email" value="${oldEmail}" placeholder="name@example.com" maxlength="100" required>
                                <label for="floatingEmail">Địa chỉ Email <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="tel" class="form-control" id="floatingPhone" name="phone" value="${oldPhone}" placeholder="0912345678" pattern="[0-9]{10,15}" title="Vui lòng nhập từ 10 đến 15 chữ số" required>
                                <label for="floatingPhone">Số điện thoại <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <select class="form-select" id="floatingGender" name="gender" aria-label="Giới tính">
                                    <option value="" ${empty oldGender ? 'selected' : ''}>Chọn giới tính (Không bắt buộc)</option>
                                    <option value="Nam" ${oldGender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${oldGender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                    <option value="Khác" ${oldGender == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                                <label for="floatingGender">Giới tính</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="date" class="form-control" id="floatingDoB" name="dateOfBirth" value="${oldDob}" placeholder="Ngày sinh">
                                <label for="floatingDoB">Ngày sinh</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingAddress" name="address" value="${oldAddress}" placeholder="Địa chỉ cụ thể">
                                <label for="floatingAddress">Địa chỉ (Không bắt buộc)</label>
                            </div>

                            <div class="form-floating mb-3" style="position: relative;">
                                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Mật khẩu" minlength="8" style="padding-right: 45px;" required>
                                <label for="floatingPassword">Mật khẩu (Tối thiểu 8 ký tự) <span class="text-danger">*</span></label>
                                <span id="togglePassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 100; color: #6c757d;">
                                    <i class="fa fa-eye-slash fa-lg"></i>
                                </span>
                            </div>

                            <div class="form-floating mb-4" style="position: relative;">
                                <input type="password" class="form-control" id="floatingConfirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" style="padding-right: 45px;" required>
                                <label for="floatingConfirmPassword">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <span id="toggleConfirmPassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 100; color: #6c757d;">
                                    <i class="fa fa-eye-slash fa-lg"></i>
                                </span>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-6">
                                    <button type="submit" class="btn btn-primary py-3 w-100 fw-bold">Đăng ký</button>
                                </div>
                                <div class="col-6">
                                    <a href="login.jsp" class="btn btn-outline-secondary py-3 w-100 fw-bold">Hủy</a>
                                </div>
                            </div>
                        </form>
                        
                        <p class="text-center mb-0">Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/chart/chart.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <script src="js/main.js"></script>

    <script>
        $(document).ready(function() {
            // Chặn không cho chọn ngày sinh ở tương lai
            const today = new Date().toISOString().split("T")[0];
            $('#floatingDoB').attr('max', today);

            // Xử lý bật/tắt ẩn hiện mật khẩu cốt lõi
            $('#togglePassword').click(function() {
                const input = $('#floatingPassword');
                const icon = $(this).find('i');
                if (input.attr('type') === 'password') {
                    input.attr('type', 'text');
                    icon.removeClass('fa-eye-slash').addClass('fa-eye text-primary');
                } else {
                    input.attr('type', 'password');
                    icon.removeClass('fa-eye text-primary').addClass('fa-eye-slash');
                }
            });

            // Xử lý bật/tắt ẩn hiện mật khẩu xác nhận
            $('#toggleConfirmPassword').click(function() {
                const input = $('#floatingConfirmPassword');
                const icon = $(this).find('i');
                if (input.attr('type') === 'password') {
                    input.attr('type', 'text');
                    icon.removeClass('fa-eye-slash').addClass('fa-eye text-primary');
                } else {
                    input.attr('type', 'password');
                    icon.removeClass('fa-eye text-primary').addClass('fa-eye-slash');
                }
            });

            // Kiểm tra khớp mật khẩu nhanh bằng Javascript ở phía Client trước khi gửi tới Servlet
            $('#registerForm').on('submit', function(e) {
                const password = $('#floatingPassword').val();
                const confirmPassword = $('#floatingConfirmPassword').val();

                if (password !== confirmPassword) {
                    e.preventDefault(); // Chặn hành động gửi form nếu mật khẩu lệch nhau
                    alert("Mật khẩu và Xác nhận mật khẩu không trùng khớp. Vui lòng kiểm tra lại!");
                    $('#floatingConfirmPassword').focus();
                }
            });
        });
    </script>
</body>
</html>