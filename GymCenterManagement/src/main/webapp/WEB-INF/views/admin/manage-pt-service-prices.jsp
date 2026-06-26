<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : manage-pt-service-prices.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện cấu hình giá dịch vụ tập luyện với HLV cá nhân.
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Breadcrumb & Back Action -->
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/pt/list">Đội ngũ HLV (PT)</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}">${trainer.displayName != null ? trainer.displayName : trainer.fullName}</a></li>
                <li class="breadcrumb-item active" aria-current="page">Quản lý giá dịch vụ</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-hand-holding-usd me-2 text-primary"></i>Quản lý giá dịch vụ của PT</h4>
            <a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Quay lại chi tiết PT
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <!-- Form Card -->
            <div class="bg-light rounded p-5 shadow-sm border-0">
                <div class="text-center mb-4">
                    <h5 class="fw-bold text-primary mb-1">${trainer.fullName}</h5>
                    <span class="badge bg-light-primary text-primary px-3 py-1.5 rounded-pill fw-semibold mb-2">
                        <i class="fa fa-dumbbell me-1"></i>${trainer.specialization}
                    </span>
                    <p class="text-muted small">Cấu hình bảng giá dịch vụ cho 2 gói tập cơ bản của huấn luyện viên này.</p>
                </div>

                <!-- Feedback Message Display -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                        <i class="fa fa-exclamation-circle me-2"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/pt/service-prices" method="post" id="pricesForm" class="needs-validation" novalidate>
                    <!-- Hidden field for PT ID -->
                    <input type="hidden" name="id" value="${trainer.ptId}" />

                    <!-- Package 12 Sessions -->
                    <div class="mb-4">
                        <label for="price12" class="form-label fw-bold text-dark">
                            <i class="fa fa-box me-1 text-muted"></i> Gói PT Cơ bản 1 Tháng (12 buổi) <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <input type="number" class="form-control form-control-lg border-2" id="price12" name="price12" 
                                   value="${price12.price != null ? price12.price.toBigInteger() : '0'}" 
                                   placeholder="Nhập giá tiền cho gói 12 buổi" min="0" step="1000" required>
                            <span class="input-group-text bg-white border-2 border-start-0 fw-semibold text-secondary">₫</span>
                            <div class="invalid-feedback">Vui lòng nhập giá tiền hợp lệ cho gói 12 buổi (số không âm).</div>
                        </div>
                        <div class="form-text">Đây là giá tiền áp dụng cho gói PT 12 buổi trong 1 tháng.</div>
                    </div>

                    <!-- Package 36 Sessions -->
                    <div class="mb-5">
                        <label for="price36" class="form-label fw-bold text-dark">
                            <i class="fa fa-boxes me-1 text-muted"></i> Gói PT Cao cấp 3 Tháng (36 buổi) <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <input type="number" class="form-control form-control-lg border-2" id="price36" name="price36" 
                                   value="${price36.price != null ? price36.price.toBigInteger() : '0'}" 
                                   placeholder="Nhập giá tiền cho gói 36 buổi" min="0" step="1000" required>
                            <span class="input-group-text bg-white border-2 border-start-0 fw-semibold text-secondary">₫</span>
                            <div class="invalid-feedback">Vui lòng nhập giá tiền hợp lệ cho gói 36 buổi (số không âm).</div>
                        </div>
                        <div class="form-text">Đây là giá tiền áp dụng cho gói PT 36 buổi trong 3 tháng.</div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}" class="btn btn-lg btn-outline-secondary px-5">Hủy bỏ</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            <i class="fa fa-save me-2"></i> Lưu cấu hình giá
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
        const form = document.getElementById("pricesForm");
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
