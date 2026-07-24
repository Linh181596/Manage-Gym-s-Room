<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đặt lại mật khẩu</title>
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
                <div class="col-12 col-sm-9 col-md-7 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3 shadow">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <h3 class="text-primary m-0"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            </a>
                            <h3 class="m-0">Đặt lại mật khẩu</h3>
                        </div>

                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${requestScope.error}
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${requestScope.invalidToken eq true}">
                                <p class="text-muted mb-4">
                                    Vui lòng yêu cầu liên kết đặt lại mật khẩu mới.
                                </p>
                                <a href="${pageContext.request.contextPath}/forgot-password" class="btn btn-primary py-3 w-100 mb-3 fw-bold">
                                    Gửi lại liên kết
                                </a>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary py-3 w-100">
                                    Quay lại đăng nhập
                                </a>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty requestScope.email}">
                                    <p class="text-muted mb-4">
                                        Đặt mật khẩu mới cho tài khoản <strong>${requestScope.email}</strong>.
                                    </p>
                                </c:if>

                                <%-- Form submit cập nhật mật khẩu mới, gửi phương thức POST kèm token xác minh --%>
                                <form id="resetPasswordForm" action="${pageContext.request.contextPath}/reset-password" method="POST" novalidate>
                                    <input type="hidden" name="token" value="${requestScope.token}">

                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="newPassword" name="newPassword"
                                               placeholder="Mật khẩu mới" minlength="8" autocomplete="new-password" required>
                                        <label for="newPassword">Mật khẩu mới <span class="text-danger">*</span></label>
                                    </div>

                                    <div class="form-floating mb-2">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                               placeholder="Xác nhận mật khẩu mới" autocomplete="new-password" required>
                                        <label for="confirmPassword">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                    </div>

                                    <small class="text-muted d-block mb-4">
                                        Mật khẩu mới phải có ít nhất 8 ký tự và bao gồm cả chữ lẫn số.
                                    </small>

                                    <div id="clientError" class="alert alert-danger d-none" role="alert"></div>

                                    <button type="submit" class="btn btn-primary py-3 w-100 mb-3 fw-bold">
                                        Cập nhật mật khẩu
                                    </button>

                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary py-3 w-100">
                                        Hủy
                                    </a>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>

    <script>
        $(document).ready(function() {
            // Validate dữ liệu mật khẩu ở máy khách trước khi submit
            $('#resetPasswordForm').on('submit', function(e) {
                const newPassword = $('#newPassword').val();
                const confirmPassword = $('#confirmPassword').val();
                const hasLetter = /[A-Za-z]/.test(newPassword);
                const hasDigit = /\d/.test(newPassword);
                const $clientError = $('#clientError');

                // Reset thông báo lỗi
                $clientError.addClass('d-none').text('');

                // Kiểm tra người dùng đã điền đủ hay chưa
                if (!newPassword || !confirmPassword) {
                    e.preventDefault();
                    $clientError.removeClass('d-none').text('Vui lòng nhập đầy đủ mật khẩu mới.');
                    return;
                }

                // Kiểm tra định dạng mật khẩu mới (tối thiểu 8 ký tự, có chữ và số)
                if (newPassword.length < 8 || !hasLetter || !hasDigit) {
                    e.preventDefault();
                    $clientError.removeClass('d-none').text('Mật khẩu mới phải có ít nhất 8 ký tự và bao gồm cả chữ lẫn số.');
                    $('#newPassword').focus();
                    return;
                }

                // Kiểm tra mật khẩu mới và xác nhận mật khẩu có khớp nhau không
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    $clientError.removeClass('d-none').text('Mật khẩu xác nhận không khớp.');
                    $('#confirmPassword').focus();
                }
            });
        });
    </script>
</body>
</html>
