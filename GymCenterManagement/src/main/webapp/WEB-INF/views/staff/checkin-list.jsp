<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h4 class="mb-0"><i class="fa fa-user-check me-2 text-primary"></i>Điểm Danh Staff &amp; PT</h4>
        <a href="${pageContext.request.contextPath}/staff/work-history" class="btn btn-outline-secondary btn-sm">
            <i class="fa fa-history me-1"></i>Xem lịch sử
        </a>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="alert alert-${sessionScope.flashType eq 'success' ? 'success' : (sessionScope.flashType eq 'warning' ? 'warning' : 'danger')} alert-dismissible fade show" role="alert">
            <i class="fa fa-${sessionScope.flashType eq 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
            ${sessionScope.flashMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="flashMessage" scope="session"/>
        <c:remove var="flashType" scope="session"/>
    </c:if>

    <!-- Bộ lọc Ca / Ngày -->
    <div class="bg-light rounded p-3 mb-4">
        <form method="get" action="${pageContext.request.contextPath}/staff/checkin" class="row g-3 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-semibold">Ca làm việc</label>
                <select name="shift" class="form-select">
                    <option value="Morning"   ${selectedShift eq 'Morning'   ? 'selected' : ''}>Sáng (Morning)</option>
                    <option value="Afternoon" ${selectedShift eq 'Afternoon' ? 'selected' : ''}>Chiều (Afternoon)</option>
                    <option value="Evening"   ${selectedShift eq 'Evening'   ? 'selected' : ''}>Tối (Evening)</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-semibold">Ngày</label>
                <input type="date" name="date" class="form-control" value="${selectedDate}">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fa fa-search me-1"></i>Xem
                </button>
            </div>
        </form>
    </div>

    <!-- Bảng danh sách điểm danh -->
    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                <a href="${pageContext.request.contextPath}/staff/checkin?shift=${selectedShift}&date=${selectedDate}"
                   class="btn btn-sm btn-outline-danger ms-3">Thử lại</a>
            </div>
        </c:when>
        <c:when test="${empty attendanceList}">
            <div class="text-center py-5 text-muted">
                <i class="fa fa-users fa-3x mb-3 d-block"></i>
                <p>Không có dữ liệu nhân sự để hiển thị.</p>
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
                                <th>Giờ check-in</th>
                                <th>Người điểm danh</th>
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
                                        <span class="badge ${a.userRole.name() eq 'PT' ? 'bg-info' : 'bg-secondary'}">
                                            ${a.userRole}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${a.attendanceId > 0}">
                                                <span class="badge bg-success"><i class="fa fa-check me-1"></i>Đã điểm danh</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark"><i class="fa fa-clock me-1"></i>Chưa điểm danh</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-muted small">
                                        <c:if test="${a.attendanceId > 0}">
                                            <fmt:formatDate value="${a.checkedInAt}" pattern="HH:mm:ss"
                                                            type="time"/>
                                            <%-- Fallback display if EL date formatter not available --%>
                                            <c:if test="${empty a.checkedInAt}">—</c:if>
                                        </c:if>
                                        <c:if test="${a.attendanceId == 0}">—</c:if>
                                    </td>
                                    <td class="small text-muted">
                                        <c:out value="${a.checkedByName}" default="—"/>
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${a.attendanceId == 0}">
                                            <!-- Form điểm danh -->
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/staff/checkin"
                                                  class="d-inline"
                                                  onsubmit="return confirm('Xác nhận điểm danh cho ${a.targetFullName}?')">
                                                <input type="hidden" name="targetUserId"   value="${a.userId}">
                                                <input type="hidden" name="targetUserRole" value="${a.userRole}">
                                                <input type="hidden" name="shift" value="${selectedShift}">
                                                <input type="hidden" name="date"  value="${selectedDate}">
                                                <button type="submit" class="btn btn-sm btn-primary">
                                                    <i class="fa fa-check me-1"></i>Điểm danh
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${a.attendanceId > 0}">
                                            <span class="text-muted small">✓ Đã xong</span>
                                        </c:if>
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
