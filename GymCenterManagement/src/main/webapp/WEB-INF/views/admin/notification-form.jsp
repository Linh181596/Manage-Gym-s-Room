<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/notifications">Quản lý thông báo</a></li>
                <li class="breadcrumb-item active" aria-current="page">${formTitle}</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-bell me-2 text-primary"></i>${formTitle}</h4>
            <a href="${pageContext.request.contextPath}/admin/notifications" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="bg-light rounded p-5 shadow-sm border-0">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                        <i class="fa fa-exclamation-circle me-2"></i> <c:out value="${errorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/notifications" method="post"
                      enctype="multipart/form-data" id="notificationForm" class="needs-validation" novalidate>
                    <input type="hidden" name="notificationId" value="${notification.notificationId}" />
                    <input type="hidden" name="currentImageUrl" value="${notification.notificationImageUrl}" />

                    <div class="mb-4">
                        <label for="title" class="form-label fw-bold text-dark">
                            <i class="fa fa-heading me-1 text-muted"></i> Tiêu đề thông báo <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control form-control-lg border-2" id="title" name="title"
                               value="${notification.title}" maxlength="255"
                               placeholder="Ví dụ: Lịch bảo trì phòng tập cuối tuần" required>
                        <div class="invalid-feedback">Vui lòng nhập tiêu đề thông báo, tối đa 255 ký tự.</div>
                        <div class="form-text d-flex justify-content-end">
                            <span id="titleCount">0/255 ký tự</span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark">
                            <i class="fa fa-paper-plane me-1 text-muted"></i> Kiểu gửi thông báo <span class="text-danger">*</span>
                        </label>
                        <div class="d-flex flex-wrap gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="deliveryMode" id="modeRole"
                                       value="role" ${notification.targetRole != 'Specific' ? 'checked' : ''}>
                                <label class="form-check-label" for="modeRole">Gửi theo vai trò</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="deliveryMode" id="modeAccount"
                                       value="account" ${notification.targetRole == 'Specific' ? 'checked' : ''}>
                                <label class="form-check-label" for="modeAccount">Gửi đến một tài khoản cụ thể</label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4" id="targetRoleGroup">
                        <label for="targetRole" class="form-label fw-bold text-dark">
                            <i class="fa fa-users me-1 text-muted"></i> Vai trò nhận thông báo
                        </label>
                        <select class="form-select form-select-lg border-2" id="targetRole" name="targetRole">
                            <option value="" disabled ${empty notification.targetRole || notification.targetRole == 'Specific' ? 'selected' : ''}>-- Chọn vai trò nhận --</option>
                            <option value="All" ${notification.targetRole == 'All' ? 'selected' : ''}>Tất cả người dùng</option>
                            <option value="Staff" ${notification.targetRole == 'Staff' ? 'selected' : ''}>Nhân viên</option>
                            <option value="Member" ${notification.targetRole == 'Member' ? 'selected' : ''}>Hội viên</option>
                            <option value="PT" ${notification.targetRole == 'PT' ? 'selected' : ''}>Huấn luyện viên</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn vai trò nhận thông báo.</div>
                    </div>

                    <div class="mb-4" id="recipientUserGroup">
                        <label for="recipientUserId" class="form-label fw-bold text-dark">
                            <i class="fa fa-user me-1 text-muted"></i> Tài khoản nhận thông báo
                        </label>
                        <select class="form-select form-select-lg border-2" id="recipientUserId" name="recipientUserId">
                            <option value="">-- Chọn tài khoản nhận --</option>
                            <c:forEach var="recipientUser" items="${recipientUsers}">
                                <option value="${recipientUser.userId}" ${notification.recipientUserId == recipientUser.userId ? 'selected' : ''}>
                                    <c:out value="${recipientUser.fullName}" /> - <c:out value="${recipientUser.email}" /> (${recipientUser.role})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn tài khoản nhận thông báo.</div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <label for="publishDate" class="form-label fw-bold text-dark">
                                <i class="fa fa-clock me-1 text-muted"></i> Thời gian lên thông báo <span class="text-danger">*</span>
                            </label>
                            <input type="datetime-local" class="form-control form-control-lg border-2" id="publishDate"
                                   name="publishDate" value="${notification.publishDateInputValue}" required>
                            <div class="invalid-feedback">Vui lòng chọn thời gian lên thông báo.</div>
                        </div>
                        <div class="col-md-6">
                            <label for="expiryDate" class="form-label fw-bold text-dark">
                                <i class="fa fa-calendar-times me-1 text-muted"></i> Tự động ẩn lúc
                            </label>
                            <input type="datetime-local" class="form-control form-control-lg border-2" id="expiryDate"
                                   name="expiryDate" value="${notification.expiryDateInputValue}">
                            <div class="form-text">Để trống nếu thông báo không có ngày hết hạn.</div>
                        </div>
                    </div>

                    <div class="mb-5">
                        <label for="content" class="form-label fw-bold text-dark">
                            <i class="fa fa-align-left me-1 text-muted"></i> Nội dung thông báo <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control border-2" id="content" name="content" rows="7"
                                  placeholder="Nhập nội dung thông báo gửi tới người dùng..." required>${notification.content}</textarea>
                        <div class="invalid-feedback">Vui lòng nhập nội dung thông báo.</div>
                    </div>

                    <div class="mb-5">
                        <label for="notificationImage" class="form-label fw-bold text-dark">
                            <i class="fa fa-image me-1 text-muted"></i> Ảnh đính kèm
                        </label>
                        <input type="file" class="form-control border-2" id="notificationImage"
                               name="notificationImage" accept="image/png,image/jpeg,image/jpg,image/gif,image/webp">
                        <div class="form-text">Không bắt buộc. Hỗ trợ JPG, JPEG, PNG, GIF, WEBP, tối đa 5MB.</div>

                        <c:if test="${not empty notification.notificationImageUrl}">
                            <div class="mt-3 p-3 bg-white border rounded">
                                <div class="d-flex align-items-start gap-3">
                                    <img src="${pageContext.request.contextPath}/${notification.notificationImageUrl}"
                                         alt="Ảnh thông báo" class="rounded border"
                                         style="width: 140px; height: 90px; object-fit: cover;">
                                    <div>
                                        <div class="fw-bold text-dark mb-1">Ảnh hiện tại</div>
                                        <small class="text-muted d-block mb-2">${notification.notificationImageUrl}</small>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="removeImage" name="removeImage">
                                            <label class="form-check-label" for="removeImage">Xóa ảnh hiện tại</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/admin/notifications" class="btn btn-lg btn-outline-secondary px-5">Hủy bỏ</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            <i class="fa fa-save me-2"></i> Lưu thông báo
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("notificationForm");
        const titleInput = document.getElementById("title");
        const titleCount = document.getElementById("titleCount");
        const publishDate = document.getElementById("publishDate");
        const expiryDate = document.getElementById("expiryDate");
        const modeRole = document.getElementById("modeRole");
        const modeAccount = document.getElementById("modeAccount");
        const targetRole = document.getElementById("targetRole");
        const recipientUserId = document.getElementById("recipientUserId");
        const targetRoleGroup = document.getElementById("targetRoleGroup");
        const recipientUserGroup = document.getElementById("recipientUserGroup");

        function updateTitleCount() {
            titleCount.innerText = titleInput.value.length + "/255 ký tự";
        }

        function updateDeliveryMode() {
            const accountMode = modeAccount.checked;
            targetRoleGroup.style.display = accountMode ? "none" : "";
            recipientUserGroup.style.display = accountMode ? "" : "none";
            targetRole.required = !accountMode;
            recipientUserId.required = accountMode;
        }

        form.addEventListener("submit", function (event) {
            updateDeliveryMode();
            if (publishDate.value && expiryDate.value && expiryDate.value <= publishDate.value) {
                expiryDate.setCustomValidity("Thời gian tự động ẩn phải sau thời gian lên thông báo");
            } else {
                expiryDate.setCustomValidity("");
            }

            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        titleInput.addEventListener("input", updateTitleCount);
        modeRole.addEventListener("change", updateDeliveryMode);
        modeAccount.addEventListener("change", updateDeliveryMode);
        updateTitleCount();
        updateDeliveryMode();
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
