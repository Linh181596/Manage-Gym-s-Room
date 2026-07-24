<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="mb-1">Chi tiết lịch bảo trì #MT-${schedule.maintenanceScheduleId}</h3>
            <p class="text-muted mb-0">Thông tin kế hoạch, tiến độ và kết quả bảo trì.</p>
        </div>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}${not empty param.returnUrl ? param.returnUrl : '/staff/maintenance-schedules'}">
                <i class="fa fa-arrow-left me-2"></i>Quay lại
            </a>
            <c:if test="${sessionScope.currentUser.role == 'Admin' && schedule.status == 'Scheduled'}">
                <a class="btn btn-warning" href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=edit&id=${schedule.maintenanceScheduleId}">
                    <i class="fa fa-edit me-2"></i>Cập nhật
                </a>
                <%-- Form ẩn xử lý hủy lịch bảo trì (chỉ Admin mới có quyền) --%>
                <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=cancel"
                      onsubmit="return confirm('Bạn có chắc muốn hủy lịch #MT-${schedule.maintenanceScheduleId}?');">
                    <input type="hidden" name="id" value="${schedule.maintenanceScheduleId}">
                    <button class="btn btn-danger" type="submit"><i class="fa fa-times me-2"></i>Hủy lịch</button>
                </form>
            </c:if>
            <c:if test="${sessionScope.currentUser.role == 'Staff' && (schedule.status == 'Scheduled' || schedule.status == 'InProgress')}">
                <a class="btn btn-warning" href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=edit&id=${schedule.maintenanceScheduleId}">
                    <i class="fa fa-tasks me-2"></i>Cập nhật tiến độ
                </a>
            </c:if>
            <c:if test="${sessionScope.currentUser.role == 'Admin' && schedule.status == 'PendingApproval'}">
                <%-- Form duyệt lịch bảo trì đã hoàn thành (Admin) --%>
                <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=approve">
                    <input type="hidden" name="id" value="${schedule.maintenanceScheduleId}">
                    <button class="btn btn-success" type="submit"><i class="fa fa-check me-2"></i>Duyệt</button>
                </form>
            </c:if>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger"><c:out value="${error}" /></div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success"><c:out value="${success}" /></div>
    </c:if>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h5 class="text-primary border-bottom pb-3 mb-4"><i class="fa fa-calendar-check me-2"></i>Thông tin bảo trì</h5>
                <div class="row g-4">
                    <div class="col-md-6"><small class="text-muted d-block">Mã lịch</small><strong>#MT-${schedule.maintenanceScheduleId}</strong></div>
                    <div class="col-md-6">
                        <small class="text-muted d-block">Trạng thái</small>
                        <c:choose>
                            <c:when test="${schedule.status == 'Scheduled'}"><span class="badge bg-primary">Đã lên lịch</span></c:when>
                            <c:when test="${schedule.status == 'InProgress'}"><span class="badge bg-warning text-dark">Đang bảo trì</span></c:when>
                            <c:when test="${schedule.status == 'PendingApproval'}"><span class="badge bg-info text-dark">Chờ duyệt</span></c:when>
                            <c:when test="${schedule.status == 'Completed'}"><span class="badge bg-success">Đã hoàn thành</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">Đã hủy</span></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-6"><small class="text-muted d-block">Thiết bị</small><strong><c:out value="${schedule.equipmentName}" /></strong><div class="small text-muted">#<c:out value="${schedule.equipmentCode}" /></div></div>
                    <div class="col-md-6"><small class="text-muted d-block">Vị trí</small><strong><c:out value="${schedule.equipmentLocation}" /></strong></div>
                    <div class="col-md-6"><small class="text-muted d-block">Ngày bảo trì</small><strong>${schedule.scheduledDateDisplay}</strong></div>
                    <div class="col-md-6"><small class="text-muted d-block">Loại bảo trì</small><strong><c:out value="${schedule.maintenanceTypeDisplay}" /></strong></div>
                    <div class="col-12"><small class="text-muted d-block mb-2">Mô tả công việc</small><div class="bg-white border rounded p-3"><c:out value="${schedule.description}" /></div></div>
                    <div class="col-12">
                        <small class="text-muted d-block mb-2">Sự cố liên quan</small>
                        <c:choose>
                            <c:when test="${not empty schedule.issueId}">
                                <a href="${pageContext.request.contextPath}/staff/equipment-issues?action=detail&id=${schedule.issueId}">
                                    #SC-${schedule.issueId}
                                </a>
                                <span class="ms-2"><c:out value="${schedule.issueDescription}" /></span>
                                <span class="badge bg-secondary ms-2"><c:out value="${schedule.issueStatus}" /></span>
                            </c:when>
                            <c:otherwise><span class="text-muted">Không liên kết sự cố</span></c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${schedule.status == 'PendingApproval' || schedule.status == 'Completed'}">
                        <div class="col-md-6"><small class="text-muted d-block">Thời điểm hoàn thành</small><strong>${schedule.completionDateDisplay}</strong></div>
                        <div class="col-md-6"><small class="text-muted d-block">Người gửi duyệt</small><strong><c:out value="${schedule.submittedBy}" /></strong></div>
                        <div class="col-md-6"><small class="text-muted d-block">Thời điểm gửi duyệt</small><strong>${schedule.submittedForApprovalAtDisplay}</strong></div>
                        <div class="col-12"><small class="text-muted d-block mb-2">Kết quả hoàn thành</small><div class="bg-white border rounded p-3"><c:out value="${schedule.completionNote}" /></div></div>
                        <c:if test="${not empty schedule.completionImageUrl}">
                            <div class="col-12">
                                <small class="text-muted d-block mb-2">Ảnh minh chứng</small>
                                <a href="${schedule.completionImageUrl}" target="_blank" rel="noopener">
                                    <img src="${schedule.completionImageUrl}" alt="Ảnh minh chứng bảo trì" class="img-fluid rounded border bg-white" style="max-height: 360px;">
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${schedule.status == 'Completed'}">
                            <div class="col-md-6"><small class="text-muted d-block">Người duyệt</small><strong><c:out value="${schedule.approvedBy}" /></strong></div>
                            <div class="col-md-6"><small class="text-muted d-block">Thời điểm duyệt</small><strong>${schedule.approvedAtDisplay}</strong></div>
                        </c:if>
                        <c:if test="${not empty schedule.approvalNote}">
                            <div class="col-12"><small class="text-muted d-block mb-2">Ghi chú duyệt / lý do từ chối</small><div class="bg-white border rounded p-3"><c:out value="${schedule.approvalNote}" /></div></div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <c:if test="${sessionScope.currentUser.role == 'Admin' && schedule.status == 'PendingApproval'}">
                <div class="bg-light rounded p-4 shadow-sm mb-4">
                    <h5 class="text-primary border-bottom pb-3 mb-4"><i class="fa fa-user-check me-2"></i>Duyệt bảo trì</h5>
                    <%-- Form từ chối duyệt lịch bảo trì (Admin yêu cầu làm lại) --%>
                    <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=reject">
                        <input type="hidden" name="id" value="${schedule.maintenanceScheduleId}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Lý do từ chối <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="approvalNote" rows="4" required
                                      placeholder="Nhập lý do để nhân viên bổ sung lại kết quả hoặc ảnh minh chứng..."></textarea>
                        </div>
                        <button class="btn btn-outline-danger w-100" type="submit"
                                onclick="return confirm('Từ chối kết quả bảo trì #MT-${schedule.maintenanceScheduleId}?');">
                            <i class="fa fa-times me-2"></i>Từ chối
                        </button>
                    </form>
                </div>
            </c:if>
            <div class="bg-light rounded p-4 shadow-sm">
                <h5 class="text-primary border-bottom pb-3 mb-4"><i class="fa fa-history me-2"></i>Thông tin kiểm toán</h5>
                <div class="mb-3"><small class="text-muted d-block">Người tạo</small><strong><c:out value="${schedule.createdBy}" /></strong></div>
                <div class="mb-3"><small class="text-muted d-block">Ngày tạo</small><strong>${schedule.createdDateDisplay}</strong></div>
                <c:if test="${not empty schedule.updatedBy}">
                    <div class="mb-3"><small class="text-muted d-block">Người cập nhật</small><strong><c:out value="${schedule.updatedBy}" /></strong></div>
                    <div><small class="text-muted d-block">Ngày cập nhật</small><strong>${schedule.updatedDateDisplay}</strong></div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
