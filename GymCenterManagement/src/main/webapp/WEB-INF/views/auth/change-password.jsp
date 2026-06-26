<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--
  =========================================================================
  Document    : change-password.jsp
  Created on  : 2026-06-25
  Author      : Nguyễn Đại Dương (duongnd)
  Description : Giao diện thay đổi mật khẩu người dùng.
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Đổi mật khẩu</title>
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
                            <h3 class="text-primary m-0"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                            <h3 class="m-0">Đổi mật khẩu</h3>
                        </div>

                        <c:if test="${not empty requestScope.mandatoryNotice}">
                            <div class="alert alert-warning" role="alert">
                                <i class="fa fa-lock me-2"></i>${requestScope.mandatoryNotice}
                            </div>
                        </c:if>

                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i>${requestScope.error}
                            </div>
                        </c:if>

                        <form id="changePasswordForm" action="${pageContext.request.contextPath}/change-password" method="POST" novalidate>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword"
                                       placeholder="Mật khẩu hiện tại" autocomplete="current-password" required>
                                <label for="currentPassword">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                            </div>

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

                            <c:if test="${requestScope.mandatoryChange ne true}">
                                <a href="${requestScope.cancelUrl}" class="btn btn-outline-secondary py-3 w-100">
                                    Hủy
                                </a>
                            </c:if>
                        </form>
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
            $('#changePasswordForm').on('submit', function(e) {
                const currentPassword = $('#currentPassword').val();
                const newPassword = $('#newPassword').val();
                const confirmPassword = $('#confirmPassword').val();
                const hasLetter = /[A-Za-z]/.test(newPassword);
                const hasDigit = /\d/.test(newPassword);
                const $clientError = $('#clientError');

                $clientError.addClass('d-none').text('');

                if (!currentPassword || !newPassword || !confirmPassword) {
                    e.preventDefault();
                    $clientError.removeClass('d-none').text('Vui lòng nhập đầy đủ các trường mật khẩu.');
                    return;
                }

                if (newPassword.length < 8 || !hasLetter || !hasDigit) {
                    e.preventDefault();
                    $clientError.removeClass('d-none').text('Mật khẩu mới phải có ít nhất 8 ký tự và bao gồm cả chữ lẫn số.');
                    $('#newPassword').focus();
                    return;
                }

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
