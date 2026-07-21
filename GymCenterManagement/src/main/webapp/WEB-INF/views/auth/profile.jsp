<%--
 =========================================================================
 @file          : profile.jsp
 @description   : Giao diện hiển thị và cập nhật thông tin hồ sơ cá nhân (Member & PT)
 @author        : Nguyễn Đại Dương
 @created       : 2026-06-05
 @last_modified : 2026-06-11 bởi Antigravity
 =========================================================================
--%>
<%-- 
    Project: Gym Center Management System (GCMS)
    Course: SWP391 - Software Development Project
    File: profile.jsp
    Description: Giao diện hiển thị thông tin cá nhân động (Dynamic UI) dựa trên vai trò của User hiện tại.
                 Sử dụng JSTL để render các trường thông tin riêng biệt cho Member, PT, Staff, Admin.
    Author: [Nguyễn Đại Dương] - [he187234]
    Created Date: [05/06/2026]
    Version: 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>GCMS - Thông Tin Cá Nhân</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body class="bg-white">
    <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-3 shadow-sm">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand d-flex align-items-center">
            <h3 class="text-primary m-0"><i class="fa fa-hashtag me-2"></i>GCMS</h3>
        </a>
    </nav>

    <div class="container py-5">
        <div class="mb-4">
            <c:choose>
                <c:when test="${profile.roleName eq 'Member'}">
                    <a href="${pageContext.request.contextPath}/member/portal" class="btn btn-outline-secondary px-3 shadow-sm">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:when test="${profile.roleName eq 'Staff'}">
                    <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-outline-secondary px-3 shadow-sm">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:when test="${profile.roleName eq 'PT'}">
                    <a href="${pageContext.request.contextPath}/pt/dashboard" class="btn btn-outline-secondary px-3 shadow-sm">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:when test="${profile.roleName eq 'Admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary px-3 shadow-sm">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:window.history.back();" class="btn btn-outline-secondary px-3 shadow-sm">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
                <i class="fa fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <%-- Form cập nhật thông tin hồ sơ (POST). Hỗ trợ upload file ảnh/chứng chỉ nhờ enctype="multipart/form-data" --%>
        <form action="${pageContext.request.contextPath}/profile" method="POST" enctype="multipart/form-data" id="profileForm">
            <div class="row g-4 justify-content-center">
                
                <div class="col-12 col-lg-4 text-center">
                    <div class="bg-light rounded p-4 shadow-sm border border-white mb-4">
                        <h5 class="mb-4 text-dark text-start border-bottom pb-2">
                            <i class="fa fa-camera me-2 text-primary"></i>Ảnh đại diện
                        </h5>
                        
                        <div class="mb-3 position-relative d-inline-block">
                            <img id="avatarPreview" 
                                 src="${(profile.roleName eq 'PT' and not empty profile.avatarPath) ? pageContext.request.contextPath.concat('/').concat(profile.avatarPath) : 'https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.2.0/img/user2-160x160.jpg'}" 
                                 alt="Avatar" class="rounded-circle img-thumbnail shadow-sm" 
                                 style="width: 150px; height: 150px; object-fit: cover;">
                        </div>
                        
                        <c:choose>
                            <c:when test="${profile.roleName eq 'PT'}">
                                <p class="text-muted small mb-4">Hỗ trợ định dạng tệp: .jpg, .png (Tối đa 5MB)</p>
                                <label for="avatarFile" id="btnChangeAvatar" class="btn btn-outline-primary btn-sm px-4 d-none">
                                    <i class="fa fa-upload me-2"></i>Chọn ảnh mới
                                </label>
                                <input type="file" name="avatarFile" id="avatarFile" class="d-none" accept=".jpg, .jpeg, .png">
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted small mb-0">Tính năng đổi ảnh chỉ áp dụng cho tài khoản Huấn luyện viên.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${profile.roleName eq 'PT' or profile.roleName eq 'Staff' or profile.roleName eq 'Member'}">
                        <div class="bg-light rounded p-4 shadow-sm border border-white text-start">
                            <h5 class="mb-3 text-dark border-bottom pb-2"><i class="fa fa-id-card me-2 text-primary"></i>Thông tin vị trí</h5>
                            
                            <c:if test="${profile.roleName eq 'Member'}">
                                <div class="mb-2"><strong>Trạng thái hội viên:</strong> 
                                    <span class="badge bg-success">${profile.membershipStatus}</span>
                                </div>
                            </c:if>
                            
                            <c:if test="${profile.roleName eq 'Staff'}">
                                <div class="mb-2"><strong>Chức vụ nhân sự:</strong> 
                                    <input type="text" class="form-control bg-body-secondary text-muted mt-1" value="${profile.position}" readonly>
                                </div>
                            </c:if>

                            <c:if test="${profile.roleName eq 'PT'}">
                                <div class="mb-3"><strong>Chuyên môn đào tạo:</strong> 
                                    <input type="text" class="form-control bg-body-secondary text-muted mt-1" value="${profile.specialization}" readonly>
                                </div>
                                <div class="mb-2"><strong>Kinh nghiệm thực tế:</strong> 
                                    <span class="badge bg-primary px-3 py-2 fs-6">${profile.experienceYears} Năm</span>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>

                <div class="col-12 col-lg-8">
                    <div class="bg-light rounded p-4 p-sm-5 shadow-sm border border-white h-100">
                        <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-2">
                            <h4 class="m-0 text-dark">
                                <i class="fa fa-user-edit me-2 text-primary"></i>Hồ sơ tài khoản - Vai trò: ${profile.roleName}
                            </h4>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" name="displayName" class="form-control editable-field" id="floatingFullName" 
                                           maxlength="100" 
                                           value="${profile.roleName eq 'PT' ? profile.fullName : profile.displayName}" required disabled>
                                    <label for="floatingFullName">
                                        <c:choose>
                                            <c:when test="${profile.roleName eq 'PT'}">Họ và tên chính thức (BR-03) <span class="text-danger">*</span></c:when>
                                            <c:otherwise>Tên hiển thị tài khoản <span class="text-danger">*</span></c:otherwise>
                                        </c:choose>
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="email" class="form-control bg-body-secondary text-muted" id="floatingEmail" value="${profile.email}" readonly>
                                    <label for="floatingEmail">Địa chỉ Email hệ thống (Cố định)</label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="tel" name="phone" class="form-control editable-field" id="floatingPhone" placeholder="0912345678" 
                                           value="${profile.phone}" pattern="[0-9]{10,15}" title="Vui lòng nhập định dạng số từ 10-15 ký tự" required disabled>
                                    <label for="floatingPhone">Số điện thoại liên lạc <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <c:if test="${profile.roleName eq 'Member'}">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select name="gender" class="form-select editable-field" id="floatingGender" disabled>
                                            <option value="" ${empty profile.gender ? 'selected' : ''}>Chưa thiết lập</option>
                                            <option value="Nam" ${profile.gender eq 'Nam' ? 'selected' : ''}>Nam</option>
                                            <option value="Nữ" ${profile.gender eq 'Nữ' ? 'selected' : ''}>Nữ</option>
                                            <option value="Khác" ${profile.gender eq 'Khác' ? 'selected' : ''}>Khác</option>
                                        </select>
                                        <label for="floatingGender">Giới tính hội viên</label>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="form-floating">
                                        <input type="date" name="dateOfBirth" class="form-control editable-field" id="floatingDOB" value="${profile.dateOfBirth}" disabled>
                                        <label for="floatingDOB">Ngày tháng năm sinh</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea name="address" class="form-control editable-field" id="floatingAddress" maxlength="255" style="height: 100px;" disabled>${profile.address}</textarea>
                                        <label for="floatingAddress">Địa chỉ cư trú (Tối đa 255 ký tự)</label>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${profile.roleName eq 'PT'}">
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea name="description" class="form-control editable-field" id="floatingBio" placeholder="Giới thiệu bản thân" style="height: 120px;" disabled>${profile.description}</textarea>
                                        <label for="floatingBio">Tiểu sử & Giới thiệu bản thân nghề nghiệp</label>
                                    </div>
                                </div>
                                
                                <div class="col-12 mt-3">
                                    <label class="form-label text-dark fw-bold"><i class="fa fa-certificate me-2 text-primary"></i>Chứng chỉ nghề nghiệp hiện tại</label>
                                    <div class="p-3 bg-white border rounded d-flex align-items-center justify-content-between">
                                        <div>
                                            <c:choose>
                                                <c:when test="${not empty profile.certificateFileName}">
                                                    <i class="fa fa-file-pdf text-danger me-2 fs-5"></i>
                                                    <a href="${pageContext.request.contextPath}/${profile.certificateFilePath}" target="_blank" class="text-decoration-none fw-bold text-primary">${profile.certificateFileName}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small"><i class="fa fa-info-circle me-1"></i>Chưa cập nhật tệp chứng chỉ hành nghề chính thức.</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <input type="file" name="certificateFile" id="certificateFile" class="form-control form-control-sm editable-field" accept=".pdf,.jpg,.jpeg,.png" disabled>
                                        </div>
                                    </div>
                                    <div class="form-text text-muted small">Hệ thống chấp nhận các định dạng tệp: .pdf, .jpg, .png (Kích thước tệp tối đa: 5MB)</div>
                                </div>
                            </c:if>

                            <div class="col-12 text-end mt-4 border-top pt-3">
                                <!-- Nút chỉnh sửa ban đầu -->
                                <button type="button" id="btnEditMode" class="btn btn-outline-primary py-3 px-5 fw-bold shadow-sm">
                                    <i class="fa fa-edit me-2"></i>Chỉnh sửa hồ sơ
                                </button>
                                
                                <!-- Cặp nút Lưu và Hủy ở chế độ Edit (mặc định ẩn) -->
                                <button type="button" id="btnCancelEdit" class="btn btn-outline-secondary py-3 px-4 fw-bold shadow-sm me-2 d-none">
                                    Hủy bỏ
                                </button>
                                <button type="submit" id="btnSaveProfile" class="btn btn-primary py-3 px-5 fw-bold shadow-sm d-none">
                                    <i class="fa fa-save me-2"></i>Lưu thay đổi
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        $(document).ready(function() {
            // Lưu lại giá trị ban đầu của các trường để khôi phục khi nhấn Hủy
            const initialValues = {};
            
            function captureInitialValues() {
                $('.editable-field').each(function() {
                    const id = $(this).attr('id');
                    if (id) {
                        initialValues[id] = $(this).val();
                    }
                });
                initialValues['avatarSrc'] = $('#avatarPreview').attr('src');
            }
            
            captureInitialValues();

            // Nhấn nút Chỉnh sửa
            $('#btnEditMode').click(function() {
                $('.editable-field').prop('disabled', false);
                $('#btnChangeAvatar').removeClass('d-none');
                $(this).addClass('d-none');
                $('#btnCancelEdit').removeClass('d-none');
                $('#btnSaveProfile').removeClass('d-none');
            });

            // Nhấn nút Hủy
            $('#btnCancelEdit').click(function() {
                $('.editable-field').each(function() {
                    const id = $(this).attr('id');
                    if (id && initialValues[id] !== undefined) {
                        $(this).val(initialValues[id]);
                    }
                });
                
                $('#avatarPreview').attr('src', initialValues['avatarSrc']);
                $('#avatarFile').val('');
                $('#certificateFile').val('');

                $('.editable-field').prop('disabled', true);
                $('#btnChangeAvatar').addClass('d-none');
                $('#btnEditMode').removeClass('d-none');
                $(this).addClass('d-none');
                $('#btnSaveProfile').addClass('d-none');
            });
            
            // Xử lý bắt sự kiện hiển thị ảnh xem trước (Preview) lập tức khi PT chọn ảnh mới
            $('#avatarFile').change(function(e) {
                const file = e.target.files[0];
                if (file) {
                    const fileType = file["type"];
                    const validImageTypes = ["image/jpeg", "image/png", "image/jpg"];
                    
                    if ($.inArray(fileType, validImageTypes) < 0) {
                        alert("Hệ thống chỉ chấp nhận tệp hình ảnh định dạng .jpg hoặc .png!");
                        $(this).val(''); 
                        return false;
                    }

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#avatarPreview').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(file);
                }
            });

            // Validation khi submit form: Kiểm tra độ dài phần mô tả (Bio) của PT
            $('form').submit(function(e) {
                const bioField = $('#floatingBio');
                if (bioField.length && !bioField.prop('disabled')) {
                    const bioText = bioField.val().trim();
                    const words = bioText ? bioText.split(/\s+/) : [];
                    if (words.length > 500) {
                        alert("Tiểu sử (Bio) không được vượt quá 500 từ. Hiện tại bạn đang nhập: " + words.length + " từ.");
                        e.preventDefault();
                        return false;
                    }
                }
            });
        });
    </script>
</body>

</html>
