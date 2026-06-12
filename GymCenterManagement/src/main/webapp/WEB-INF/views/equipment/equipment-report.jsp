<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
  =========================================================================
  Document    : equipment-report.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện hiển thị báo cáo thống kê tình trạng thiết bị phòng tập.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Breadcrumb -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                <li class="breadcrumb-item active" aria-current="page">Báo cáo thiết bị</li>
            </ol>
        </nav>
        
        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/staff/equipment?action=list">
            <i class="fa fa-dumbbell me-2"></i>Quản lý thiết bị
        </a>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-boxes fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Tổng thiết bị</p>
                    <h5 class="mb-0 fw-bold">${report.totalEquipment}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded p-4 shadow-sm">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <i class="fa fa-heartbeat fa-3x text-success"></i>
                    <div class="text-end">
                        <p class="mb-0 text-muted">Tỷ lệ hoạt động</p>
                        <h5 class="mb-0 fw-bold">${report.activeRateDisplay}%</h5>
                    </div>
                </div>
                <div class="progress" style="height: 6px;">
                    <div class="progress-bar bg-success" role="progressbar" style="width: ${report.activeRatePercent}%" aria-valuenow="${report.activeRatePercent}" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-clipboard-list fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Tổng số sự cố</p>
                    <h5 class="mb-0 fw-bold">${report.totalIssues}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-times-circle fa-3x text-danger"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Thiết bị hỏng</p>
                    <h5 class="mb-0 fw-bold">${report.broken}</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts & Analytics Section -->
    <div class="row g-4 mb-4">
        <!-- Chart 1: Issue status distribution -->
        <div class="col-md-6">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h6 class="mb-3 fw-bold text-primary"><i class="fa fa-chart-bar me-2"></i>Thống kê sự cố thiết bị</h6>
                <p class="text-muted small mb-4">Số lượng báo cáo sự cố được phân bổ theo trạng thái xử lý hiện tại.</p>
                
                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Chờ xử lý</span>
                        <span class="fw-bold">${report.pendingIssues} sự cố</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${report.totalIssues == 0 ? 0 : (report.pendingIssues * 100 / report.totalIssues)}%"></div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Đang xử lý</span>
                        <span class="fw-bold">${report.inProgressIssues} sự cố</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-info" role="progressbar" style="width: ${report.totalIssues == 0 ? 0 : (report.inProgressIssues * 100 / report.totalIssues)}%"></div>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Đã khắc phục</span>
                        <span class="fw-bold">${report.resolvedIssues} sự cố</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${report.totalIssues == 0 ? 0 : (report.resolvedIssues * 100 / report.totalIssues)}%"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart 2: Equipment Status distribution -->
        <div class="col-md-6">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h6 class="mb-3 fw-bold text-primary"><i class="fa fa-chart-pie me-2"></i>Tình trạng trang thiết bị</h6>
                <p class="text-muted small mb-4">Trạng thái vận hành thực tế của tất cả máy móc trong phòng Gym.</p>
                
                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Hoạt động tốt</span>
                        <span class="fw-bold">${report.available} thiết bị</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${report.totalEquipment == 0 ? 0 : (report.available * 100 / report.totalEquipment)}%"></div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Đang bảo trì</span>
                        <span class="fw-bold">${report.maintenance} thiết bị</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-warning text-dark" role="progressbar" style="width: ${report.totalEquipment == 0 ? 0 : (report.maintenance * 100 / report.totalEquipment)}%"></div>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span>Hỏng hóc</span>
                        <span class="fw-bold">${report.broken} thiết bị</span>
                    </div>
                    <div class="progress" style="height: 12px;">
                        <div class="progress-bar bg-danger" role="progressbar" style="width: ${report.totalEquipment == 0 ? 0 : (report.broken * 100 / report.totalEquipment)}%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Health Checklist Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <h6 class="mb-4 fw-bold text-primary"><i class="fa fa-file-invoice me-2"></i>Báo cáo chi tiết chỉ số hoạt động</h6>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">Mã TB</th>
                        <th scope="col" style="width: 25%;">Tên thiết bị</th>
                        <th scope="col" style="width: 12%;">Loại</th>
                        <th scope="col" style="width: 12%;" class="text-center">Số lần sự cố</th>
                        <th scope="col" style="width: 15%;">Cập nhật gần nhất</th>
                        <th scope="col" style="width: 13%;">Trạng thái</th>
                        <th scope="col" style="width: 13%;">Chỉ số khả dụng</th>
                        <th scope="col" class="text-center" style="width: 10%;">Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${report.equipments}">
                        <tr>
                            <td><strong>#${item.equipmentCode}</strong></td>
                            <td><span class="fw-bold">${item.equipmentName}</span></td>
                            <td><span class="badge bg-secondary-subtle text-secondary border">${item.equipmentTypeDisplay}</span></td>
                            <td class="text-center"><span class="badge bg-danger-subtle text-danger fs-6">${item.issueCount}</span></td>
                            <td class="small">${item.updatedDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'Available'}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>
                                    <c:when test="${item.status == 'Maintenance'}">
                                        <span class="badge bg-warning text-dark">Bảo trì</span>
                                    </c:when>
                                    <c:when test="${item.status == 'Broken'}">
                                        <span class="badge bg-danger">Hỏng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${item.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'Available'}">
                                        <div class="d-flex align-items-center">
                                            <span class="me-2 small fw-bold text-success">100%</span>
                                            <div class="progress flex-grow-1" style="height: 4px; width: 50px;">
                                                <div class="progress-bar bg-success" style="width: 100%"></div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${item.status == 'Maintenance'}">
                                        <div class="d-flex align-items-center">
                                            <span class="me-2 small fw-bold text-warning">60%</span>
                                            <div class="progress flex-grow-1" style="height: 4px; width: 50px;">
                                                <div class="progress-bar bg-warning" style="width: 60%"></div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-flex align-items-center">
                                            <span class="me-2 small fw-bold text-danger">0%</span>
                                            <div class="progress flex-grow-1" style="height: 4px; width: 50px;">
                                                <div class="progress-bar bg-danger" style="width: 0%"></div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${item.issueCount > 0}">
                                        <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/staff/equipment-issues?action=detail&id=${item.latestIssueId}" title="Xem chi tiết sự cố">
                                            <i class="fa fa-eye"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/staff/equipment?action=detail&id=${item.equipmentId}&from=report" title="Xem chi tiết thiết bị">
                                            <i class="fa fa-eye"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty report.equipments}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fa fa-info-circle fa-2x mb-2 d-block"></i> Chưa có trang thiết bị nào được ghi nhận.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${showPagination}">
            <div class="d-flex align-items-center justify-content-between mt-4">
                <div class="text-muted small">
                    Hiển thị <strong>${startItem}</strong> - <strong>${endItem}</strong> của tổng số <strong>${totalItems}</strong> thiết bị báo cáo
                </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${!hasPrevious ? 'disabled' : ''}">
                            <a class="page-link" href="${queryBase}page=${previousPage}">&lsaquo; Trước</a>
                        </li>
                        <c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${pageNumber == page ? 'active' : ''}">
                                <c:choose>
                                    <c:when test="${pageNumber == page}">
                                        <span class="page-link">${pageNumber}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-link" href="${queryBase}page=${pageNumber}">${pageNumber}</a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                        <li class="page-item ${!hasNext ? 'disabled' : ''}">
                            <a class="page-link" href="${queryBase}page=${nextPage}">Sau &rsaquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />

