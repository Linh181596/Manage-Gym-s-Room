<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Breadcrumb & Back Action -->
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/pt/packages">Gói tập PT</a></li>
                <li class="breadcrumb-item active" aria-current="page">${formTitle}</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-box-open me-2 text-primary"></i>${formTitle}</h4>
            <a href="${pageContext.request.contextPath}/admin/pt/packages" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <!-- Form Card -->
            <div class="bg-light rounded p-5 shadow-sm border-0">
                <!-- Feedback Message Display -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                        <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/pt/packages" method="post" id="ptPackageForm" class="needs-validation" novalidate>
                    <!-- Hidden field for Edit operation -->
                    <input type="hidden" name="packageId" value="${pkg.ptPackageTypeId}" />

                    <!-- Package Name Input -->
                    <div class="mb-4">
                        <label for="packageName" class="form-label fw-bold text-dark"><i class="fa fa-tag me-1 text-muted"></i> Tên gói tập PT <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg border-2 shadow-sm-inset" id="packageName" name="packageName" value="${pkg.packageName}" placeholder="Ví dụ: Gói PT 12 Buổi Cơ Bản" required maxlength="100">
                        <div class="invalid-feedback">Vui lòng nhập tên gói tập PT hợp lệ (1-100 ký tự).</div>
                    </div>

                    <div class="row g-4 mb-4">
                        <!-- Duration in Months -->
                        <div class="col-md-6">
                            <label for="durationMonths" class="form-label fw-bold text-dark"><i class="fa fa-calendar-alt me-1 text-muted"></i> Thời hạn sử dụng (Tháng) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-lg border-2" id="durationMonths" name="durationMonths" value="${pkg.durationMonths > 0 ? pkg.durationMonths : ''}" placeholder="Ví dụ: 1" min="1" max="120" required>
                            <div class="invalid-feedback">Hạn tập phải lớn hơn 0 tháng (Tối đa 120 tháng).</div>
                        </div>

                        <!-- Number of Sessions -->
                        <div class="col-md-6">
                            <label for="numberOfSessions" class="form-label fw-bold text-dark"><i class="fa fa-dumbbell me-1 text-muted"></i> Số buổi tập (Sessions) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-lg border-2" id="numberOfSessions" name="numberOfSessions" value="${pkg.numberOfSessions > 0 ? pkg.numberOfSessions : ''}" placeholder="Ví dụ: 12" min="1" max="500" required>
                            <div class="invalid-feedback">Số buổi tập phải từ 1 đến 500 buổi.</div>
                        </div>
                    </div>

                    <!-- Status Selection -->
                    <div class="mb-4">
                        <label for="status" class="form-label fw-bold text-dark"><i class="fa fa-toggle-on me-1 text-muted"></i> Trạng thái hoạt động <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg border-2" id="status" name="status" required>
                            <option value="" disabled ${empty pkg.status ? 'selected' : ''}>-- Chọn trạng thái --</option>
                            <option value="Active" ${pkg.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="Inactive" ${pkg.status == 'Inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn trạng thái của gói tập.</div>
                    </div>

                    <!-- Description -->
                    <div class="mb-5">
                        <label for="description" class="form-label fw-bold text-dark"><i class="fa fa-align-left me-1 text-muted"></i> Mô tả chi tiết</label>
                        <textarea class="form-control border-2" id="description" name="description" rows="4" placeholder="Mô tả quyền lợi, tần suất tập luyện khuyên dùng, mục tiêu gói tập..." maxlength="500">${pkg.description}</textarea>
                        <div class="form-text d-flex justify-content-between">
                            <span id="charCount">0/500 ký tự</span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/admin/pt/packages" class="btn btn-lg btn-outline-secondary px-5">Hủy bỏ</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            <i class="fa fa-save me-2"></i> Lưu gói PT
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Inline Validation Script -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Bootstrap standard styling validation rules
        const form = document.getElementById("ptPackageForm");
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        // Character counter for description
        const descTextarea = document.getElementById("description");
        const charCount = document.getElementById("charCount");
        
        function updateCharCount() {
            const count = descTextarea.value.length;
            charCount.innerText = count + "/500 ký tự";
        }
        
        descTextarea.addEventListener("input", updateCharCount);
        updateCharCount(); // Initialize
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
