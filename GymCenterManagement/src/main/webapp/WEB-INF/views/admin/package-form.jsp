<%--
  =========================================================================
  Document    : package-form.jsp
  Created on  : 2026-06-01
  Author      : Nguyễn Hoàng Thắng
  Description : Form tạo mới hoặc chỉnh sửa gói tập của phòng gym dành cho Admin
  =========================================================================
--%>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/packages">Gym Packages</a></li>
                <li class="breadcrumb-item active" aria-current="page">${formTitle}</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-box-open me-2 text-primary"></i>${formTitle}</h4>
            <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Back to List
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

                <form action="${pageContext.request.contextPath}/admin/packages" method="post" id="packageForm" class="needs-validation" novalidate>
                    <!-- Hidden fields for Edit operation -->
                    <input type="hidden" name="packageId" value="${pkg.packageId}" />

                    <!-- Package Name Input -->
                    <div class="mb-4 position-relative">
                        <label for="packageName" class="form-label fw-bold text-dark"><i class="fa fa-tag me-1 text-muted"></i> Package Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg border-2 shadow-sm-inset" id="packageName" name="packageName" value="${pkg.packageName}" placeholder="e.g. Premium 3-Month Membership" required maxlength="100">
                        <div class="invalid-feedback">Please enter a valid package name (1-100 characters).</div>
                        <div class="valid-feedback">Looks good!</div>
                    </div>

                    <div class="row g-4 mb-4">
                        <!-- Duration in Months -->
                        <div class="col-md-6">
                            <label for="durationMonths" class="form-label fw-bold text-dark"><i class="fa fa-calendar-alt me-1 text-muted"></i> Duration (Months) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-lg border-2" id="durationMonths" name="durationMonths" value="${pkg.durationMonths > 0 ? pkg.durationMonths : ''}" placeholder="e.g. 3" min="1" max="120" required>
                            <div class="invalid-feedback">Please enter a valid duration (1 to 120 months).</div>
                        </div>

                        <!-- Price (VND) -->
                        <div class="col-md-6">
                            <label for="price" class="form-label fw-bold text-dark"><i class="fa fa-dollar-sign me-1 text-muted"></i> Price (VND) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" class="form-control form-control-lg border-2" id="price" name="price" value="${not empty pkg.price ? pkg.price : ''}" placeholder="e.g. 1500000" min="0" step="1000" required>
                                <span class="input-group-text bg-white border-2 border-start-0 fw-semibold text-secondary">₫</span>
                                <div class="invalid-feedback">Please enter a valid price (non-negative number).</div>
                            </div>
                        </div>
                    </div>

                    <!-- Status Selection -->
                    <div class="mb-4">
                        <label for="status" class="form-label fw-bold text-dark"><i class="fa fa-toggle-on me-1 text-muted"></i> Status <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg border-2" id="status" name="status" required>
                            <option value="" disabled selected>-- Select Status --</option>
                            <option value="Active" ${pkg.status == 'Active' ? 'selected' : ''}>Active</option>
                            <option value="Inactive" ${pkg.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <div class="invalid-feedback">Please select a package status.</div>
                    </div>

                    <!-- Description -->
                    <div class="mb-5">
                        <label for="description" class="form-label fw-bold text-dark"><i class="fa fa-align-left me-1 text-muted"></i> Description</label>
                        <textarea class="form-control border-2" id="description" name="description" rows="4" placeholder="Describe the package benefits, features, PT support etc..." maxlength="500">${pkg.description}</textarea>
                        <div class="form-text d-flex justify-content-between">
                            <span>Markdown-style text or list items.</span>
                            <span id="charCount">0/500 characters</span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-lg btn-outline-secondary px-5">Cancel</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            <i class="fa fa-save me-2"></i> Save Package
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Inline Validation & Micro-interactions Script -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Bootstrap standard styling validation rules
        const form = document.getElementById("packageForm");
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        // Character counter for textarea description
        const descTextarea = document.getElementById("description");
        const charCount = document.getElementById("charCount");
        
        function updateCharCount() {
            const count = descTextarea.value.length;
            charCount.innerText = count + "/500 characters";
        }
        
        descTextarea.addEventListener("input", updateCharCount);
        updateCharCount(); // Initialize
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
