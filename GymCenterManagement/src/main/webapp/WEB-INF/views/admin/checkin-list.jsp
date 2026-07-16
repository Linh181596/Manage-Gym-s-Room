<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h4 class="mb-0"><i class="fa fa-user-check me-2 text-primary"></i>Điểm danh ra vào</h4>
        <a href="${pageContext.request.contextPath}/admin/work-history" class="btn btn-outline-secondary btn-sm">
            <i class="fa fa-history me-1"></i>Lịch sử
        </a>
    </div>

    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="alert alert-${sessionScope.flashType eq 'success' ? 'success' : (sessionScope.flashType eq 'warning' ? 'warning' : 'danger')} alert-dismissible fade show" role="alert">
            <i class="fa fa-${sessionScope.flashType eq 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
            ${sessionScope.flashMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="flashMessage" scope="session"/>
        <c:remove var="flashType" scope="session"/>
    </c:if>

    <div class="bg-light rounded p-3 mb-4">
        <form id="checkinFilterForm" method="get" action="${pageContext.request.contextPath}/admin/checkin" class="row g-3 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-semibold">Ca làm việc</label>
                <select name="shift" class="form-select" onchange="this.form.submit()">
                    <option value="Morning" ${selectedShift eq 'Morning' ? 'selected' : ''}>Sáng</option>
                    <option value="Afternoon" ${selectedShift eq 'Afternoon' ? 'selected' : ''}>Chiều</option>
                    <option value="Evening" ${selectedShift eq 'Evening' ? 'selected' : ''}>Tối</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-semibold">Ngày</label>
                <input type="date" name="date" class="form-control" value="${selectedDate}" onchange="this.form.submit()">
            </div>
            <div class="col-md-4">
                <label class="form-label fw-semibold">Tìm nhân viên hoặc huấn luyện viên</label>
                <input type="search" name="keyword" class="form-control" value="${keyword}" placeholder="Nhập tên hoặc email">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fa fa-search me-1"></i>Xem
                </button>
            </div>
        </form>
        <div class="small text-muted mt-2">
            <i class="fa fa-clock me-1"></i>Khung giờ ca hiện tại: ${shiftWindow}
        </div>
    </div>

    <c:if test="${not attendanceAllowed}">
        <div class="alert alert-warning">
            <i class="fa fa-exclamation-triangle me-2"></i>${attendanceBlockedMessage}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                <a href="${pageContext.request.contextPath}/admin/checkin?shift=${selectedShift}&date=${selectedDate}&keyword=${keyword}"
                   class="btn btn-sm btn-outline-danger ms-3">Thử lại</a>
            </div>
        </c:when>
        <c:when test="${empty attendanceList}">
            <div class="text-center py-5 text-muted bg-white rounded shadow-sm">
                <i class="fa fa-users fa-3x mb-3 d-block"></i>
                <p class="mb-0">Không tìm thấy nhân viên hoặc huấn luyện viên phù hợp.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bg-white rounded shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Giờ vào</th>
                                <th>Giờ ra</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td class="fw-semibold">${a.targetFullName}</td>
                                    <td class="text-muted small">${a.targetEmail}</td>
                                    <td>
                                        <span class="badge ${a.userRole.name() eq 'PT' ? 'bg-info' : 'bg-secondary'}">${a.userRoleLabel}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${a.attendanceId > 0 && empty a.checkedOutAt}">
                                                <span class="badge bg-success"><i class="fa fa-check me-1"></i>Đang làm việc</span>
                                            </c:when>
                                            <c:when test="${a.attendanceId > 0}">
                                                <span class="badge bg-primary"><i class="fa fa-sign-out-alt me-1"></i>Đã ghi giờ ra</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark"><i class="fa fa-clock me-1"></i>Chưa ghi giờ vào</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small text-muted">
                                        <c:out value="${a.checkedInAtDisplay}" default="-"/>
                                    </td>
                                    <td class="small text-muted">
                                        <c:out value="${a.checkedOutAtDisplay}" default="-"/>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-inline-flex gap-2 flex-wrap justify-content-center">
                                            <c:if test="${a.attendanceId == 0}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/checkin"
                                                      onsubmit="return confirm('Xác nhận ghi giờ vào cho ${a.targetFullName}?')">
                                                    <input type="hidden" name="action" value="checkin">
                                                    <input type="hidden" name="targetUserId" value="${a.userId}">
                                                    <input type="hidden" name="targetUserRole" value="${a.userRole}">
                                                    <input type="hidden" name="shift" value="${selectedShift}">
                                                    <input type="hidden" name="date" value="${selectedDate}">
                                                    <input type="hidden" name="keyword" value="${keyword}">
                                                    <button type="submit" class="btn btn-sm btn-primary" ${attendanceAllowed ? '' : 'disabled'}>
                                                        <i class="fa fa-check me-1"></i>Ghi giờ vào
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${a.attendanceId > 0 && empty a.checkedOutAt}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/checkin"
                                                      onsubmit="return confirm('Xác nhận ghi giờ ra cho ${a.targetFullName}?')">
                                                    <input type="hidden" name="action" value="checkout">
                                                    <input type="hidden" name="attendanceId" value="${a.attendanceId}">
                                                    <input type="hidden" name="shift" value="${selectedShift}">
                                                    <input type="hidden" name="date" value="${selectedDate}">
                                                    <input type="hidden" name="keyword" value="${keyword}">
                                                    <button type="submit" class="btn btn-sm btn-outline-primary">
                                                        <i class="fa fa-sign-out-alt me-1"></i>Ghi giờ ra
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${a.attendanceId > 0 && not empty a.checkedOutAt}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/checkin"
                                                      onsubmit="return confirm('Hoàn tác giờ ra cho ${a.targetFullName}?')">
                                                    <input type="hidden" name="action" value="undoCheckout">
                                                    <input type="hidden" name="attendanceId" value="${a.attendanceId}">
                                                    <input type="hidden" name="shift" value="${selectedShift}">
                                                    <input type="hidden" name="date" value="${selectedDate}">
                                                    <input type="hidden" name="keyword" value="${keyword}">
                                                    <button type="submit" class="btn btn-sm btn-outline-warning">
                                                        <i class="fa fa-undo me-1"></i>Hoàn tác
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${a.attendanceId > 0}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/checkin"
                                                      onsubmit="return confirm('Hủy bản ghi điểm danh này?')">
                                                    <input type="hidden" name="action" value="cancel">
                                                    <input type="hidden" name="attendanceId" value="${a.attendanceId}">
                                                    <input type="hidden" name="shift" value="${selectedShift}">
                                                    <input type="hidden" name="date" value="${selectedDate}">
                                                    <input type="hidden" name="keyword" value="${keyword}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                                        <i class="fa fa-times me-1"></i>Hủy
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
