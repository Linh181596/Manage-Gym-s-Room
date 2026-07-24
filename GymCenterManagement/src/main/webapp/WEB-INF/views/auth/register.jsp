<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đăng Ký Tài Khoản</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

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
    <style>
        input[type="password"]::-ms-reveal,
        input[type="password"]::-ms-clear {
            display: none;
        }
    </style>
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
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3 shadow">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <h3 class="text-primary m-0"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            </a>
                            <h3 class="m-0">Đăng Ký</h3>
                        </div>

                        <c:if test="${not empty requestScope.message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa fa-check-circle me-2"></i>${requestScope.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${requestScope.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <%-- Form đăng ký tài khoản (POST) gửi tới server --%>
                        <form id="registerForm" action="${pageContext.request.contextPath}/register" method="POST">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingFullName" name="displayName" value="${requestScope.oldDisplayName}" placeholder="Nguyễn Văn A" maxlength="100" required oninvalid="this.setCustomValidity('Vui lòng nhập họ và tên')" oninput="this.setCustomValidity('')">
                                <label for="floatingFullName">Họ và tên <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="floatingEmail" name="email" value="${requestScope.oldEmail}" placeholder="name@example.com" maxlength="100" required oninvalid="if(this.validity.valueMissing){this.setCustomValidity('Vui lòng nhập địa chỉ email')}else{this.setCustomValidity('Vui lòng nhập đúng định dạng email (ví dụ: name@example.com)')}" oninput="this.setCustomValidity('')">
                                <label for="floatingEmail">Địa chỉ Email <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="tel" class="form-control" id="floatingPhone" name="phone" value="${requestScope.oldPhone}" placeholder="0912345678" pattern="[0-9]{10}" title="Vui lòng nhập đúng 10 số điện thoại" required oninvalid="if(this.validity.valueMissing){this.setCustomValidity('Vui lòng nhập số điện thoại')}else{this.setCustomValidity('Vui lòng nhập đúng 10 số điện thoại')}" oninput="this.setCustomValidity('')">
                                <label for="floatingPhone">Số điện thoại <span class="text-danger">*</span></label>
                            </div>

                            <div class="form-floating mb-3">
                                <select class="form-select" id="floatingGender" name="gender" aria-label="Giới tính">
                                    <option value="" ${empty requestScope.oldGender ? 'selected' : ''}>Chọn giới tính (Không bắt buộc)</option>
                                    <option value="Nam" ${requestScope.oldGender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${requestScope.oldGender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                    <option value="Khác" ${requestScope.oldGender == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                                <label for="floatingGender">Giới tính</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="date" class="form-control" id="floatingDoB" name="dateOfBirth" value="${requestScope.oldDob}" placeholder="Ngày sinh">
                                <label for="floatingDoB">Ngày sinh</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="floatingAddress" name="address" value="${requestScope.oldAddress}" placeholder="Địa chỉ cụ thể">
                                <label for="floatingAddress">Địa chỉ (Không bắt buộc)</label>
                            </div>

                            <div class="form-floating mb-3" style="position: relative;">
                                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Mật khẩu" minlength="8" style="padding-right: 45px;" required oninvalid="if(this.validity.valueMissing){this.setCustomValidity('Vui lòng nhập mật khẩu')}else{this.setCustomValidity('Mật khẩu phải chứa ít nhất 8 ký tự')}" oninput="this.setCustomValidity('')">
                                <label for="floatingPassword">Mật khẩu (Tối thiểu 8 ký tự) <span class="text-danger">*</span></label>
                                <span id="togglePassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 100; color: #6c757d;">
                                    <i class="fa fa-eye-slash fa-lg"></i>
                                </span>
                            </div>

                            <div class="form-floating mb-4" style="position: relative;">
                                <input type="password" class="form-control" id="floatingConfirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" style="padding-right: 45px;" required oninvalid="this.setCustomValidity('Vui lòng xác nhận lại mật khẩu')" oninput="this.setCustomValidity('')">
                                <label for="floatingConfirmPassword">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <span id="toggleConfirmPassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 100; color: #6c757d;">
                                    <i class="fa fa-eye-slash fa-lg"></i>
                                </span>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-6">
                                    <%-- Nút submit dữ liệu đăng ký thành viên mới --%>
                                    <button type="submit" class="btn btn-primary py-3 w-100 fw-bold">Đăng ký</button>
                                </div>
                                <div class="col-6">
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary py-3 w-100 fw-bold">Hủy</a>
                                </div>
                            </div>
                        </form>
                        
                        <p class="text-center mb-0">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
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

    <script>
        $(document).ready(function() {
<<<<<<< HEAD
            // Only allow dates of birth for people who are at least 14 years old.
            const today = new Date();
            const latestAllowedDob = new Date(today.getFullYear() - 14, today.getMonth(), today.getDate());
            const dobInput = $('#floatingDoB');
            const formatDate = function(date) {
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
            };
            const validateMinimumAge = function() {
                const dateOfBirth = dobInput.val();
                if (!dateOfBirth) {
                    dobInput[0].setCustomValidity('');
                    return true;
                }

                if (new Date(`${dateOfBirth}T00:00:00`) > latestAllowedDob) {
                    dobInput[0].setCustomValidity('Bạn chưa đủ tuổi để đăng kí tập gym.');
                    return false;
                }

                dobInput[0].setCustomValidity('');
                return true;
            };
            dobInput.attr('max', formatDate(latestAllowedDob));
            dobInput.on('input change', validateMinimumAge);
=======
            // Giới hạn ngày sinh tối đa là ngày hôm nay (không cho phép chọn ngày ở tương lai)
            const today = new Date().toISOString().split("T")[0];
            $('#floatingDoB').attr('max', today);
>>>>>>> 791c22bac344832abd2b6ae2e693370264c69786

            // Xử lý logic ẩn/hiện hiển thị mật khẩu
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

            // Xử lý logic ẩn/hiện hiển thị xác nhận mật khẩu
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

            // Validation phía client trước khi submit: Kiểm tra trùng khớp mật khẩu
            $('#registerForm').on('submit', function(e) {
                const password = $('#floatingPassword').val();
                const confirmPassword = $('#floatingConfirmPassword').val();

                if (!validateMinimumAge()) {
                    e.preventDefault();
                    dobInput[0].reportValidity();
                    dobInput.focus();
                    return;
                }

                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert("Mật khẩu và Xác nhận mật khẩu không trùng khớp. Vui lòng kiểm tra lại!");
                    $('#floatingConfirmPassword').focus();
                }
            });
        });
    </script>
</body>
</html>
