<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<%--
  =========================================================================
  Document    : issue-form.jsp
  Created on  : 2026-06-04
  Author      : Đào Minh Hoàng (hoangdm)
  Description : Giao diện form báo cáo sự cố hỏng hóc thiết bị phòng tập.
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/equipment-issues">Sự cố thiết bị</a></li>
                <li class="breadcrumb-item active" aria-current="page">${issue.issueId > 0 ? 'Cập nhật tiến độ' : 'Báo cáo sự cố mới'}</li>
            </ol>
        </nav>
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment-issues?action=list">
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
            <h5 class="fw-bold text-danger mb-0">
                <i class="fa fa-exclamation-triangle me-2"></i>${issue.issueId > 0 ? 'Cập nhật xử lý sự cố' : 'Khai báo sự cố thiết bị'}
            </h5>
            <p class="text-muted small mb-0 mt-1">
                ${issue.issueId > 0 ? 'Cập nhật trạng thái sự cố và đồng bộ trạng thái thiết bị liên quan.' : 'Mọi báo cáo mới sẽ ở trạng thái Chờ xử lý và đổi trạng thái thiết bị thành Hỏng.'}
            </p>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/staff/equipment-issues?action=${issue.issueId > 0 ? 'edit' : 'create'}" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${issue.issueId}">
            <input type="hidden" name="reportedBy" value="${issue.reportedBy}">
            <input type="hidden" name="currentIssueImageUrl" value="${issue.issueImageUrl}">
            
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Thiết bị gặp sự cố <span class="text-danger">*</span></label>
                    <c:choose>
                        <c:when test="${issue.issueId > 0}">
                            <input type="hidden" name="equipmentId" value="${issue.equipmentId}">
                            <input type="text" class="form-control" value="${issue.equipmentCode} - ${issue.equipmentName}" readonly>
                        </c:when>
                        <c:otherwise>
                            <select class="form-select" name="equipmentId" required>
                                <option value="">Chọn thiết bị</option>
                                <c:forEach var="equip" items="${equipments}">
                                    <c:choose>
                                        <c:when test="${equip.equipmentId == issue.equipmentId}">
                                            <option value="${equip.equipmentId}" selected>
                                                [#${equip.equipmentCode}] ${equip.equipmentName}
                                            </option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${equip.equipmentId}">
                                                [#${equip.equipmentCode}] ${equip.equipmentName}
                                            </option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Người báo cáo</label>
                    <input type="text" class="form-control bg-light" name="reportedByName" 
                           value="${issue.issueId > 0 ? issue.createdBy : sessionScope.currentUser.fullName}" readonly>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Loại sự cố <span class="text-danger">*</span></label>
                    <select class="form-select" name="issueType" required>
                        <option value="">Chọn loại sự cố</option>
                        <option value="Hu hong" ${issue.issueType == 'Hu hong' ? 'selected' : ''}>Hư hỏng</option>
                        <option value="Bao tri" ${issue.issueType == 'Bao tri' ? 'selected' : ''}>Bảo trì / Sửa chữa</option>
                        <option value="An toan" ${issue.issueType == 'An toan' ? 'selected' : ''}>An toàn phòng tập</option>
                        <option value="Khac" ${issue.issueType == 'Khac' ? 'selected' : ''}>Khác</option>
                    </select>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Trạng thái xử lý</label>
                    <c:choose>
                        <c:when test="${issue.issueId > 0}">
                            <select class="form-select border-warning" name="status" required>
                                <option value="Pending" ${issue.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="InProgress" ${issue.status == 'InProgress' ? 'selected' : ''}>Đang xử lý / Sửa chữa</option>
                                <option value="Resolved" ${issue.status == 'Resolved' ? 'selected' : ''}>Đã khắc phục hoàn toàn</option>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="status" value="Pending">
                            <input type="text" class="form-control" value="Chờ xử lý (Tự động)" readonly>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="col-12">
                    <label class="form-label fw-semibold">Mô tả chi tiết sự cố <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="description" rows="4" required placeholder="Mô tả cụ thể biểu hiện hỏng hóc hoặc lý do cần sửa chữa...">${issue.description}</textarea>
                </div>
                
                <div class="col-12">
                    <label class="form-label fw-semibold">Ảnh chụp hiện trạng</label>
                    <input type="file" class="form-control" name="issueImageFile" accept="image/*">
                    
                    <c:if test="${not empty issue.issueImageUrl}">
                        <div class="mt-3">
                            <span class="d-block text-muted small mb-2">Ảnh hiện tại:</span>
                            <div style="width: 200px; height: 150px;" class="border rounded overflow-hidden">
                                <img class="w-100 h-100 object-fit-cover" src="${issue.issueImageUrl}" alt="Ảnh sự cố">
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <div class="d-flex align-items-center justify-content-end gap-2 mt-4 pt-3 border-top">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/equipment-issues?action=list">Hủy bỏ</a>
                <button type="submit" class="btn btn-danger">
                    <i class="fa fa-save me-2"></i> ${issue.issueId > 0 ? 'Cập nhật sự cố' : 'Gửi báo cáo'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
