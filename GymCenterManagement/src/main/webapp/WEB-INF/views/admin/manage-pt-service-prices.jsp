<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : manage-pt-service-prices.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện cấu hình giá dịch vụ tập luyện với HLV cá nhân (Động theo gói PT).
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
                    <p class="text-muted small">Cấu hình bảng giá dịch vụ cho các gói tập của huấn luyện viên này.</p>
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

                    <!-- Danh sách các gói PT cấu hình động -->
                    <c:choose>
                        <c:when test="${empty activePackages}">
                            <div class="alert alert-warning mb-4" role="alert">
                                <i class="fa fa-exclamation-triangle me-2"></i> Hệ thống chưa có gói tập PT nào được kích hoạt hoạt động. Vui lòng tạo gói PT mới trước khi thiết lập giá.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="pkg" items="${activePackages}">
                                <div class="mb-4">
                                    <label for="price_${pkg.ptPackageTypeId}" class="form-label fw-bold text-dark">
                                        <i class="fa fa-box me-1 text-muted"></i> ${pkg.packageName} (${pkg.numberOfSessions} buổi) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <c:set var="pkgPrice" value="${priceMap[pkg.ptPackageTypeId]}" />
                                        <input type="number" class="form-control form-control-lg border-2" id="price_${pkg.ptPackageTypeId}" name="price_${pkg.ptPackageTypeId}" 
                                               value="${pkgPrice != null ? pkgPrice.toBigInteger() : '0'}" 
                                               placeholder="Nhập giá tiền cho gói ${pkg.packageName}" min="1000" step="1000" required>
                                        <span class="input-group-text bg-white border-2 border-start-0 fw-semibold text-secondary">₫</span>
                                        <div class="invalid-feedback">Vui lòng nhập giá tiền hợp lệ (lớn hơn 0 và không bỏ trống).</div>
                                    </div>
                                    <div class="form-text text-muted">Thời hạn sử dụng: ${pkg.durationMonths} Tháng. <c:if test="${not empty pkg.description}">(${pkg.description})</c:if></div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}" class="btn btn-lg btn-outline-secondary px-5">Hủy bỏ</a>
                        <c:if test="${not empty activePackages}">
                            <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                                <i class="fa fa-save me-2"></i> Lưu cấu hình giá
                            </button>
                        </c:if>
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
