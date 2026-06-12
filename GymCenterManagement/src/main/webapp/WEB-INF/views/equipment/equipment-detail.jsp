<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : equipment-detail.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện hiển thị chi tiết thông tin thiết bị phòng tập.
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
                <c:choose>
                    <c:when test="${param.from == 'report'}">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/equipment-reports">Báo cáo thiết bị</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/equipment">Quản lý thiết bị</a></li>
                    </c:otherwise>
                </c:choose>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết thiết bị</li>
            </ol>
        </nav>
        <div class="d-flex gap-2">
            <c:choose>
                <c:when test="${param.from == 'report'}">
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/equipment-reports">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment?action=list">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:otherwise>
            </c:choose>
            <a class="btn btn-warning text-dark" href="${pageContext.request.contextPath}/staff/equipment?action=edit&id=${equipment.equipmentId}">
                <i class="fa fa-edit me-2"></i>Chỉnh sửa
            </a>
        </div>
    </div>

    <!-- Detail View -->
    <div class="row g-4">
        <!-- Left Column: Image -->
        <div class="col-md-5">
            <div class="bg-light rounded p-4 shadow-sm h-100 text-center d-flex flex-column align-items-center justify-content-center">
                <c:choose>
                    <c:when test="${not empty equipment.imageUrl}">
                        <img class="img-fluid rounded border shadow-sm object-fit-cover w-100" style="max-height: 400px;" src="${equipment.imageUrl}" alt="${equipment.equipmentName}">
                    </c:when>
                    <c:otherwise>
                        <div class="d-flex align-items-center justify-content-center bg-secondary-subtle border rounded w-100 py-5 text-muted shadow-sm" style="min-height: 250px;">
                            <i class="fa fa-dumbbell fa-5x"></i>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="mt-4">
                    <h5 class="fw-bold mb-1">${equipment.equipmentName}</h5>
                    <span class="badge bg-secondary-subtle text-secondary border px-3 py-2 fs-6">Mã: #${equipment.equipmentCode}</span>
                </div>
            </div>
        </div>

        <!-- Right Column: Specs -->
        <div class="col-md-7">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h5 class="fw-bold text-primary mb-4 pb-2 border-bottom">
                    <i class="fa fa-info-circle me-2"></i>Thông số và Tình trạng thiết bị
                </h5>
                
                <div class="row g-3">
                    <div class="col-sm-6">
                        <span class="text-muted d-block small">Tên thiết bị</span>
                        <span class="fw-bold fs-5">${equipment.equipmentName}</span>
                    </div>
                    
                    <div class="col-sm-6">
                        <span class="text-muted d-block small">Trạng thái hoạt động</span>
                        <c:choose>
                            <c:when test="${equipment.status == 'Available'}">
                                <span class="badge bg-success fs-6 mt-1"><i class="fa fa-check me-1"></i>Sẵn sàng hoạt động</span>
                            </c:when>
                            <c:when test="${equipment.status == 'Maintenance'}">
                                <span class="badge bg-warning text-dark fs-6 mt-1"><i class="fa fa-tools me-1"></i>Đang bảo trì</span>
                            </c:when>
                            <c:when test="${equipment.status == 'Broken'}">
                                <span class="badge bg-danger fs-6 mt-1"><i class="fa fa-exclamation-triangle me-1"></i>Đang hỏng hóc</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary fs-6 mt-1">${equipment.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Phân loại loại hình</span>
                        <span class="fw-semibold text-dark">${equipment.equipmentTypeDisplay}</span>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Vị trí lắp đặt</span>
                        <span class="fw-semibold text-dark"><i class="fa fa-map-marker-alt me-1 text-danger"></i>${equipment.location}</span>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Ngày mua máy</span>
                        <span class="fw-semibold text-dark">${equipment.purchaseDateDisplay}</span>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Hạn bảo hành đến</span>
                        <span class="fw-semibold text-dark">${equipment.warrantyDateDisplay}</span>
                    </div>
                </div>

                <h5 class="fw-bold text-primary mt-5 mb-4 pb-2 border-bottom">
                    <i class="fa fa-history me-2"></i>Thông tin kiểm toán
                </h5>

                <div class="row g-3 small">
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Người tạo bản ghi</span>
                        <span class="text-dark fw-semibold">${equipment.createdBy}</span>
                    </div>
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Thời điểm ghi nhận</span>
                        <span class="text-dark fw-semibold">${equipment.createdDate}</span>
                    </div>
                    <c:if test="${not empty equipment.updatedBy}">
                        <div class="col-sm-6 mt-3">
                            <span class="text-muted d-block">Người cập nhật cuối</span>
                            <span class="text-dark fw-semibold">${equipment.updatedBy}</span>
                        </div>
                        <div class="col-sm-6 mt-3">
                            <span class="text-muted d-block">Thời điểm cập nhật cuối</span>
                            <span class="text-dark fw-semibold">${equipment.updatedDate}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />

