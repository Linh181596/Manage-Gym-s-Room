<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-start justify-content-between mb-4 gap-3">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <c:choose>
                        <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/dashboard">Bảng điều khiển</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="breadcrumb-item active">Quản lý lịch bảo trì</li>
                </ol>
            </nav>
            <h3 class="mb-1">Quản lý lịch bảo trì</h3>
            <p class="text-muted mb-0">Theo dõi kế hoạch kiểm tra, sửa chữa và bảo trì thiết bị phòng gym.</p>
        </div>
        <c:if test="${sessionScope.currentUser.role == 'Admin'}">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=create">
                <i class="fa fa-plus me-2"></i>Tạo lịch mới
            </a>
        </c:if>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i><c:out value="${error}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa fa-check-circle me-2"></i><c:out value="${success}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-calendar-alt fa-3x text-primary"></i>
                <div class="ms-3 text-end"><p class="mb-2 text-muted">Tổng lịch</p><h5 class="mb-0">${statistics.total}</h5></div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-clock fa-3x text-primary"></i>
                <div class="ms-3 text-end"><p class="mb-2 text-muted">Đã lên lịch</p><h5 class="mb-0">${statistics.scheduled}</h5></div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-tools fa-3x text-warning"></i>
                <div class="ms-3 text-end"><p class="mb-2 text-muted">Đang bảo trì</p><h5 class="mb-0">${statistics.inProgress}</h5></div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-check-double fa-3x text-success"></i>
                <div class="ms-3 text-end"><p class="mb-2 text-muted">Đã hoàn thành</p><h5 class="mb-0">${statistics.completed}</h5></div>
            </div>
        </div>
    </div>

    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <form method="get" action="${pageContext.request.contextPath}/staff/maintenance-schedules" class="row g-3">
            <input type="hidden" name="action" value="list">
            <div class="col-12 col-xl-4">
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0"><i class="fa fa-search text-muted"></i></span>
                    <input class="form-control border-start-0" name="keyword" value="${fn:escapeXml(keyword)}"
                           placeholder="Tìm mã lịch, thiết bị hoặc mô tả...">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-2">
                <select class="form-select" name="status">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Scheduled" <c:if test="${status == 'Scheduled'}">selected="selected"</c:if>>Đã lên lịch</option>
                    <option value="InProgress" <c:if test="${status == 'InProgress'}">selected="selected"</c:if>>Đang bảo trì</option>
                    <option value="Completed" <c:if test="${status == 'Completed'}">selected="selected"</c:if>>Đã hoàn thành</option>
                    <option value="Cancelled" <c:if test="${status == 'Cancelled'}">selected="selected"</c:if>>Đã hủy</option>
                </select>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <select class="form-select" name="equipmentId">
                    <option value="">Tất cả thiết bị</option>
                    <c:forEach var="equipment" items="${equipments}">
                        <option value="${equipment.equipmentId}" <c:if test="${equipmentId == equipment.equipmentId}">selected="selected"</c:if>>
                            <c:out value="${equipment.equipmentCode}" /> - <c:out value="${equipment.equipmentName}" />
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-12 col-sm-6 col-xl-2">
                <select class="form-select" name="type">
                    <option value="">Tất cả loại</option>
                    <option value="Preventive" <c:if test="${type == 'Preventive'}">selected="selected"</c:if>>Bảo trì phòng ngừa</option>
                    <option value="Corrective" <c:if test="${type == 'Corrective'}">selected="selected"</c:if>>Bảo trì sửa chữa</option>
                </select>
            </div>
            <div class="col-12 col-sm-6 col-xl-1 d-grid">
                <button class="btn btn-secondary" type="submit"><i class="fa fa-filter"></i></button>
            </div>
        </form>
    </div>

    <div class="bg-light rounded p-4 shadow-sm">
        <h5 class="mb-4 text-primary"><i class="fa fa-list me-2"></i>Danh sách lịch bảo trì</h5>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead>
                    <tr>
                        <th>Mã lịch</th>
                        <th>Thiết bị</th>
                        <th>Ngày bảo trì</th>
                        <th>Loại bảo trì</th>
                        <th>Sự cố liên quan</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${schedules}">
                        <tr>
                            <td><strong>#MT-${item.maintenanceScheduleId}</strong></td>
                            <td>
                                <div class="fw-bold"><c:out value="${item.equipmentName}" /></div>
                                <small class="text-muted">#<c:out value="${item.equipmentCode}" /></small>
                            </td>
                            <td>${item.scheduledDateDisplay}</td>
                            <td><c:out value="${item.maintenanceTypeDisplay}" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty item.issueId}">
                                        <a href="${pageContext.request.contextPath}/staff/equipment-issues?action=detail&id=${item.issueId}">
                                            #SC-${item.issueId}
                                        </a>
                                    </c:when>
                                    <c:otherwise><span class="text-muted">Không có</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'Scheduled'}"><span class="badge bg-primary">Đã lên lịch</span></c:when>
                                    <c:when test="${item.status == 'InProgress'}"><span class="badge bg-warning text-dark">Đang bảo trì</span></c:when>
                                    <c:when test="${item.status == 'Completed'}"><span class="badge bg-success">Đã hoàn thành</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">Đã hủy</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <div class="d-inline-flex gap-1">
                                    <a class="btn btn-sm btn-outline-primary"
                                       href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=detail&id=${item.maintenanceScheduleId}"
                                       title="Chi tiết"><i class="fa fa-eye"></i></a>
                                    <c:if test="${sessionScope.currentUser.role == 'Admin' && item.status == 'Scheduled'}">
                                        <a class="btn btn-sm btn-outline-warning"
                                           href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=edit&id=${item.maintenanceScheduleId}"
                                           title="Cập nhật kế hoạch"><i class="fa fa-edit"></i></a>
                                        <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=cancel"
                                              onsubmit="return confirm('Bạn có chắc muốn hủy lịch #MT-${item.maintenanceScheduleId}?');">
                                            <input type="hidden" name="id" value="${item.maintenanceScheduleId}">
                                            <button class="btn btn-sm btn-outline-danger" type="submit" title="Hủy lịch">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${sessionScope.currentUser.role == 'Staff' && (item.status == 'Scheduled' || item.status == 'InProgress')}">
                                        <a class="btn btn-sm btn-outline-warning"
                                           href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=edit&id=${item.maintenanceScheduleId}"
                                           title="Cập nhật tiến độ"><i class="fa fa-tasks"></i></a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty schedules}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class="fa fa-info-circle fa-2x d-block mb-2"></i>
                                Không tìm thấy lịch bảo trì phù hợp.
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
