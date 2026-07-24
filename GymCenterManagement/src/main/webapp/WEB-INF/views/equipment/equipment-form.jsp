<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : equipment-form.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện form thêm mới/chỉnh sửa thông tin thiết bị phòng tập.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Breadcrumb -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <c:choose>
                    <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/dashboard">Bảng điều khiển</a></li>
                    </c:otherwise>
                </c:choose>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/equipment">Quản lý thiết bị</a></li>
                <li class="breadcrumb-item active" aria-current="page">${edit ? 'Cập nhật thông tin' : 'Thêm thiết bị mới'}</li>
            </ol>
        </nav>
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment?action=list">
            <i class="fa fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Form Container -->
    <div class="bg-light rounded p-4 shadow-sm max-width-800 mx-auto">
        <div class="border-bottom pb-3 mb-4">
            <h5 class="fw-bold text-primary mb-0">
                <i class="fa ${edit ? 'fa-edit' : 'fa-plus-circle'} me-2"></i>${edit ? 'Cập nhật thông tin thiết bị' : 'Khai báo thiết bị mới'}
            </h5>
        </div>

        <%-- Form thêm mới/cập nhật thông tin thiết bị (POST) có kèm file ảnh --%>
        <form id="equipmentForm" method="post" action="${pageContext.request.contextPath}/staff/equipment" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${equipment.equipmentId}">
            <input type="hidden" name="imageUrl" value="${equipment.imageUrl}">
            
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Mã thiết bị <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="equipmentCode" value="${equipment.equipmentCode}" required maxlength="50" placeholder="Ví dụ: eq-treadmill-01">
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Tên thiết bị <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="equipmentName" value="${equipment.equipmentName}" required maxlength="100" placeholder="Ví dụ: Máy chạy bộ Matrix T50">
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Loại thiết bị <span class="text-danger">*</span></label>
                    <select class="form-select" name="equipmentType" required>
                        <option value="">Chọn loại</option>
                        <option value="Cardio" ${equipment.equipmentType == 'Cardio' ? 'selected' : ''}>Cardio</option>
                        <option value="Ta" ${equipment.equipmentType == 'Ta' ? 'selected' : ''}>Tạ</option>
                        <option value="May keo" ${equipment.equipmentType == 'May keo' ? 'selected' : ''}>Máy kéo</option>
                        <option value="Phu kien" ${equipment.equipmentType == 'Phu kien' ? 'selected' : ''}>Phụ kiện</option>
                        <option value="Khac" ${equipment.equipmentType == 'Khac' || empty equipment.equipmentType ? 'selected' : ''}>Khác</option>
                    </select>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Vị trí đặt <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="location" value="${equipment.location}" required maxlength="100" placeholder="Ví dụ: Khu Cardio, Tầng 1">
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Ngày mua <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="purchaseDate" value="${equipment.purchaseDate}" required>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Ngày hết hạn bảo hành <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="warrantyDate" value="${equipment.warrantyDate}" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Trạng thái thiết lập <span class="text-danger">*</span></label>
                    <select class="form-select" name="status" required>
                        <option value="">Chọn trạng thái</option>
                        <option value="Available" ${equipment.status == 'Available' || empty equipment.status ? 'selected' : ''}>Hoạt động bình thường</option>
                        <option value="Maintenance" ${equipment.status == 'Maintenance' ? 'selected' : ''}>Đang bảo trì</option>
                        <option value="Broken" ${equipment.status == 'Broken' ? 'selected' : ''}>Hỏng hóc</option>
                    </select>
                </div>
                
                <div class="col-12">
                    <label class="form-label fw-semibold">Ảnh thiết bị <c:if test="${empty equipment.imageUrl}"><span class="text-danger">*</span></c:if></label>
                    <input type="file" class="form-control" name="imageFile" accept="image/*" ${empty equipment.imageUrl ? 'required' : ''}>
                    
                    <c:if test="${not empty equipment.imageUrl}">
                        <div class="mt-3">
                            <span class="d-block text-muted small mb-2">Ảnh hiện tại:</span>
                            <div style="width: 150px; height: 150px;" class="border rounded overflow-hidden">
                                <img class="w-100 h-100 object-fit-cover" src="${equipment.imageUrl}" alt="${equipment.equipmentName}">
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <div class="d-flex align-items-center justify-content-end gap-2 mt-4 pt-3 border-top">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment?action=list">Hủy bỏ</a>
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-save me-2"></i> ${edit ? 'Cập nhật' : 'Thêm thiết bị'}
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    const purchaseDateInput = document.querySelector('input[name="purchaseDate"]');
    const warrantyDateInput = document.querySelector('input[name="warrantyDate"]');
    const equipmentForm = document.getElementById('equipmentForm');

    function syncWarrantyMinDate() {
        // Ràng buộc ngày hết hạn bảo hành không được chọn trước ngày mua
        if (purchaseDateInput.value) {
            warrantyDateInput.min = purchaseDateInput.value;
        } else {
            warrantyDateInput.removeAttribute('min');
        }
    }

    purchaseDateInput.addEventListener('change', syncWarrantyMinDate);
    warrantyDateInput.addEventListener('input', function () {
        warrantyDateInput.setCustomValidity('');
    });
    
    // Xử lý kiểm tra khi submit form
    equipmentForm.addEventListener('submit', function (event) {
        syncWarrantyMinDate();
        if (purchaseDateInput.value && warrantyDateInput.value && warrantyDateInput.value < purchaseDateInput.value) {
            event.preventDefault();
            // Thiết lập thông báo lỗi hiển thị nếu logic không hợp lệ
            warrantyDateInput.setCustomValidity('Ngày hết hạn bảo hành không được trước ngày mua.');
            warrantyDateInput.reportValidity();
        } else {
            warrantyDateInput.setCustomValidity('');
        }
    });
    
    syncWarrantyMinDate();
</script>

<jsp:include page="../common/dashboard_footer.jsp" />

