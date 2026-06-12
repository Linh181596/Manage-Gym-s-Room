<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : issue-detail.jsp
  Created on  : 2026-06-04
  Author      : Đỗ Minh Hoàng (hoangdm)
  Description : Giao diện hiển thị chi tiết thông tin báo cáo sự cố thiết bị.
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
                    <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/equipment-reports">Báo cáo thiết bị</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/equipment-issues">Sự cố thiết bị</a></li>
                    </c:otherwise>
                </c:choose>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết sự cố</li>
            </ol>
        </nav>
        <div class="d-flex gap-2">
            <c:choose>
                <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/equipment-reports">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment-issues?action=list">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại
                    </a>
                </c:otherwise>
            </c:choose>
            <a class="btn btn-warning text-dark" href="${pageContext.request.contextPath}/staff/equipment-issues?action=edit&id=${issue.issueId}">
                <i class="fa fa-edit me-2"></i>Cập nhật tiến độ
            </a>
        </div>
    </div>

    <!-- Detail View -->
    <div class="row g-4">
        <!-- Left Column: Image -->
        <div class="col-md-5">
            <div class="bg-light rounded p-4 shadow-sm h-100 text-center d-flex flex-column align-items-center justify-content-center">
                <c:choose>
                    <c:when test="${not empty issue.issueImageUrl}">
                        <img class="img-fluid rounded border shadow-sm object-fit-cover w-100" style="max-height: 400px;" src="${issue.issueImageUrl}" alt="Ảnh lỗi sự cố">
                    </c:when>
                    <c:otherwise>
                        <div class="d-flex align-items-center justify-content-center bg-danger-subtle border border-danger border-opacity-25 rounded w-100 py-5 text-danger shadow-sm" style="min-height: 250px;">
                            <i class="fa fa-exclamation-circle fa-5x"></i>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="mt-4">
                    <h5 class="fw-bold mb-1">Báo cáo sự cố #${issue.issueId}</h5>
                    <span class="badge bg-danger-subtle text-danger border px-3 py-2 fs-6">Mã sự cố: #SC-${issue.issueId}</span>
                </div>
            </div>
        </div>

        <!-- Right Column: Specs -->
        <div class="col-md-7">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h5 class="fw-bold text-danger mb-4 pb-2 border-bottom">
                    <i class="fa fa-exclamation-triangle me-2"></i>Thông tin sự cố thiết bị
                </h5>
                
                <div class="row g-3">
                    <div class="col-sm-6">
                        <span class="text-muted d-block small">Thiết bị liên quan</span>
                        <span class="fw-bold fs-5 text-dark">${issue.equipmentName}</span>
                        <span class="text-muted d-block small">Mã thiết bị: #${issue.equipmentCode}</span>
                    </div>
                    
                    <div class="col-sm-6">
                        <span class="text-muted d-block small">Trạng thái xử lý sự cố</span>
                        <c:choose>
                            <c:when test="${issue.status == 'Pending'}">
                                <span class="badge bg-warning text-dark fs-6 mt-1"><i class="fa fa-clock me-1"></i>Chờ xử lý</span>
                            </c:when>
                            <c:when test="${issue.status == 'InProgress'}">
                                <span class="badge bg-info fs-6 mt-1"><i class="fa fa-spinner me-1"></i>Đang xử lý</span>
                            </c:when>
                            <c:when test="${issue.status == 'Resolved'}">
                                <span class="badge bg-success fs-6 mt-1"><i class="fa fa-check-double me-1"></i>Đã khắc phục</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary fs-6 mt-1">${issue.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Loại sự cố</span>
                        <span class="fw-semibold text-dark">${issue.issueTypeDisplay}</span>
                    </div>

                    <div class="col-sm-6 mt-4">
                        <span class="text-muted d-block small">Người báo cáo</span>
                        <span class="fw-semibold text-dark"><i class="fa fa-user me-1 text-primary"></i>${issue.reporterName}</span>
                    </div>

                    <div class="col-sm-12 mt-4">
                        <span class="text-muted d-block small">Mô tả hiện trạng sự cố</span>
                        <div class="p-3 bg-light border rounded text-dark fs-6 font-monospace mt-1">
                            ${issue.description}
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold text-primary mt-5 mb-4 pb-2 border-bottom">
                    <i class="fa fa-history me-2"></i>Lịch sử ghi nhận
                </h5>

                <div class="row g-3 small">
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Thời điểm báo cáo sự cố</span>
                        <span class="text-dark fw-semibold">${issue.reportedAtDisplay}</span>
                    </div>
                    <c:if test="${not empty issue.updatedBy}">
                        <div class="col-sm-6">
                            <span class="text-muted d-block">Người cập nhật cuối</span>
                            <span class="text-dark fw-semibold">${issue.updatedBy}</span>
                        </div>
                        <div class="col-sm-6 mt-3">
                            <span class="text-muted d-block">Thời điểm cập nhật cuối</span>
                            <span class="text-dark fw-semibold">${issue.updatedDate}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />

