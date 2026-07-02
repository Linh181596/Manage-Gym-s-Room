<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
  =========================================================================
  Document    : issue-list.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện danh sách các báo cáo sự cố hỏng hóc thiết bị.
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
                <li class="breadcrumb-item active" aria-current="page">Sự cố thiết bị</li>
            </ol>
        </nav>
        
        <a class="btn btn-danger" href="${pageContext.request.contextPath}/staff/equipment-issues?action=create">
            <i class="fa fa-exclamation-triangle me-2"></i>Báo cáo sự cố mới
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
                <i class="fa fa-clipboard-list fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Tổng số sự cố</p>
                    <h5 class="mb-0 fw-bold">${counts.totalIssues}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-clock fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Chờ xử lý</p>
                    <h5 class="mb-0 fw-bold">${counts.pendingIssues}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-spinner fa-3x text-info"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Đang sửa chữa</p>
                    <h5 class="mb-0 fw-bold">${counts.inProgressIssues}</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-check-double fa-3x text-success"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted">Đã khắc phục</p>
                    <h5 class="mb-0 fw-bold">${counts.resolvedIssues}</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Filters Panel -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <form method="get" action="${pageContext.request.contextPath}/staff/equipment-issues" class="row g-3 align-items-center">
            <input type="hidden" name="action" value="list">
            
            <div class="col-12 col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="fa fa-search text-muted"></i></span>
                    <input type="text" class="form-control border-start-0 ps-0" name="keyword" value="${keyword}" placeholder="Tìm thiết bị, loại sự cố hoặc mô tả...">
                </div>
            </div>
            
            <div class="col-12 col-sm-6 col-md-4">
                <select class="form-select" name="status">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                    <option value="InProgress" ${status == 'InProgress' ? 'selected' : ''}>Đang xử lý</option>
                    <option value="Resolved" ${status == 'Resolved' ? 'selected' : ''}>Đã khắc phục</option>
                </select>
            </div>
            
            <div class="col-12 col-md-2 d-grid">
                <button type="submit" class="btn btn-secondary">
                    <i class="fa fa-filter me-2"></i>Lọc
                </button>
            </div>
        </form>
    </div>

    <!-- Issues Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <h6 class="mb-4 fw-bold text-danger"><i class="fa fa-exclamation-circle me-2"></i>Nhật ký báo cáo sự cố</h6>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead>
                    <tr>
                        <th scope="col" style="width: 8%;">Mã SC</th>
                        <th scope="col" style="width: 20%;">Thiết bị</th>
                        <th scope="col" style="width: 25%;">Chi tiết mô tả</th>
                        <th scope="col" style="width: 12%;">Phân loại</th>
                        <th scope="col" style="width: 12%;">Người báo cáo</th>
                        <th scope="col" style="width: 13%;">Ngày báo cáo</th>
                        <th scope="col" style="width: 10%;">Trạng thái</th>
                        <th scope="col" class="text-center" style="width: 10%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${issues}">
                        <tr>
                            <td><strong>#SC-${item.issueId}</strong></td>
                            <td>
                                <div class="fw-bold">${item.equipmentName}</div>
                                <span class="text-muted small">#${item.equipmentCode}</span>
                            </td>
                            <td class="text-truncate" style="max-width: 250px;" title="${item.description}">
                                ${item.description}
                            </td>
                            <td>
                                <span class="badge bg-secondary-subtle text-secondary border">
                                    ${item.issueTypeDisplay}
                                </span>
                            </td>
                            <td>${item.reporterName}</td>
                            <td class="small">${item.reportedAtDisplay}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'Pending'}">
                                        <span class="badge bg-warning text-dark"><i class="fa fa-clock me-1"></i>Chờ xử lý</span>
                                    </c:when>
                                    <c:when test="${item.status == 'InProgress'}">
                                        <span class="badge bg-info"><i class="fa fa-spinner me-1"></i>Đang xử lý</span>
                                    </c:when>
                                    <c:when test="${item.status == 'Resolved'}">
                                        <span class="badge bg-success"><i class="fa fa-check me-1"></i>Đã sửa xong</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${item.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/staff/equipment-issues?action=detail&id=${item.issueId}" title="Xem chi tiết">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/staff/equipment-issues?action=edit&id=${item.issueId}" title="Cập nhật tiến độ">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty issues}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="fa fa-info-circle fa-2x mb-2 d-block"></i> Không có báo cáo sự cố nào.
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

