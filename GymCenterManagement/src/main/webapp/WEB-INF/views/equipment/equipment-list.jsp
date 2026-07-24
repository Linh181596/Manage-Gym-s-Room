<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
  =========================================================================
  Document    : equipment-list.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện danh sách các thiết bị/dụng cụ phòng tập.
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
                <li class="breadcrumb-item active" aria-current="page">Quản lý thiết bị</li>
            </ol>
        </nav>
        
        <c:if test="${sessionScope.currentUser.role == 'Admin'}">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/staff/equipment?action=create">
                <i class="fa fa-plus me-2"></i>Thêm thiết bị
            </a>
        </c:if>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-dumbbell fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Tổng thiết bị</p>
                    <h5 class="mb-0 fw-bold">${counts.totalEquipment}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-check-circle fa-3x text-success"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Hoạt động</p>
                    <h5 class="mb-0 fw-bold">${counts.available}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-tools fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Đang bảo trì</p>
                    <h5 class="mb-0 fw-bold">${counts.maintenance}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-exclamation-triangle fa-3x text-danger"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Hỏng hóc</p>
                    <h5 class="mb-0 fw-bold">${counts.broken}</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Filters Panel -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <%-- Form lọc dữ liệu thiết bị theo từ khóa, loại và trạng thái (GET) --%>
        <form method="get" action="${pageContext.request.contextPath}/staff/equipment" class="row g-3 align-items-center">
            <input type="hidden" name="action" value="list">
            
            <div class="col-12 col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="fa fa-search text-muted"></i></span>
                    <input type="text" class="form-control border-start-0 ps-0" name="keyword" value="${keyword}" placeholder="Tìm mã hoặc tên thiết bị...">
                </div>
            </div>
            
            <div class="col-12 col-sm-6 col-md-3">
                <select class="form-select" name="type">
                    <option value="">Tất cả loại thiết bị</option>
                    <option value="Cardio" ${type == 'Cardio' ? 'selected' : ''}>Cardio</option>
                    <option value="Ta" ${type == 'Ta' ? 'selected' : ''}>Tạ</option>
                    <option value="May keo" ${type == 'May keo' ? 'selected' : ''}>Máy kéo</option>
                    <option value="Phu kien" ${type == 'Phu kien' ? 'selected' : ''}>Phụ kiện</option>
                    <option value="Khac" ${type == 'Khac' ? 'selected' : ''}>Khác</option>
                </select>
            </div>
            
            <div class="col-12 col-sm-6 col-md-3">
                <select class="form-select" name="status">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Available" ${status == 'Available' ? 'selected' : ''}>Hoạt động tốt</option>
                    <option value="Maintenance" ${status == 'Maintenance' ? 'selected' : ''}>Đang bảo trì</option>
                    <option value="Broken" ${status == 'Broken' ? 'selected' : ''}>Hỏng hóc</option>
                </select>
            </div>
            
            <div class="col-12 col-md-2 d-grid">
                <%-- Nút submit form lọc thiết bị --%>
                <button type="submit" class="btn btn-secondary">
                    <i class="fa fa-filter me-2"></i>Lọc
                </button>
            </div>
        </form>
    </div>

    <!-- Equipment Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <h6 class="mb-4 fw-bold text-primary"><i class="fa fa-list me-2"></i>Danh sách thiết bị</h6>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">Mã TB</th>
                        <th scope="col" style="width: 25%;">Tên thiết bị</th>
                        <th scope="col" style="width: 12%;">Phân loại</th>
                        <th scope="col" style="width: 13%;">Ngày mua</th>
                        <th scope="col" style="width: 15%;">Trạng thái</th>
                        <th scope="col" style="width: 13%;">Vị trí đặt</th>
                        <th scope="col" class="text-center" style="width: 12%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${equipments}">
                        <tr>
                            <td><strong>#${item.equipmentCode}</strong></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0 me-3" style="width: 45px; height: 45px;">
                                        <c:choose>
                                            <c:when test="${not empty item.imageUrl}">
                                                <img class="img-thumbnail w-100 h-100 object-fit-cover" src="${item.imageUrl}" alt="${item.equipmentName}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex align-items-center justify-content-center bg-secondary-subtle border rounded w-100 h-100 text-muted">
                                                    <i class="fa fa-dumbbell"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <span class="d-block fw-bold">${item.equipmentName}</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-secondary-subtle text-secondary border">${item.equipmentTypeDisplay}</span></td>
                            <td>${item.purchaseDateDisplay}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'Available'}">
                                        <span class="badge bg-success"><i class="fa fa-check me-1"></i>Hoạt động</span>
                                    </c:when>
                                    <c:when test="${item.status == 'Maintenance'}">
                                        <span class="badge bg-warning text-dark"><i class="fa fa-tools me-1"></i>Bảo trì</span>
                                    </c:when>
                                    <c:when test="${item.status == 'Broken'}">
                                        <span class="badge bg-danger"><i class="fa fa-exclamation-triangle me-1"></i>Hỏng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${item.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${item.location}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <%-- Nút chuyển hướng xem chi tiết thiết bị --%>
                                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/staff/equipment?action=detail&id=${item.equipmentId}" title="Xem chi tiết">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <%-- Nút chuyển hướng form sửa thông tin thiết bị --%>
                                    <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/staff/equipment?action=edit&id=${item.equipmentId}" title="Cập nhật">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                    <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                                        <%-- Nút xóa thiết bị (chỉ Admin mới có quyền), cảnh báo xác nhận --%>
                                        <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/staff/equipment?action=delete&id=${item.equipmentId}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa thiết bị này không?')" title="Xóa">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty equipments}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                <i class="fa fa-info-circle fa-2x mb-2 d-block"></i> Không tìm thấy thiết bị nào phù hợp.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <jsp:include page="../common/pagination.jsp" />
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />

