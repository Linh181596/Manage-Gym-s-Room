<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="dashboard_header.jsp" />
<jsp:include page="dashboard_navbar.jsp" />

<c:url var="filterAction" value="${historyBasePath}" />
<c:url var="resetUrl" value="${historyBasePath}" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center mb-4">
        <h4 class="mb-0"><i class="fa fa-history me-2 text-primary"></i>Lịch sử điểm danh</h4>
    </div>

    <div class="bg-light rounded p-3 mb-4">
        <form id="workHistoryFilterForm" method="get" action="${filterAction}" class="row g-3 align-items-end">
            <c:if test="${adminView}">
                <div class="col-md-2">
                    <label class="form-label fw-semibold">Vai trò</label>
                    <select name="role" class="form-select">
                        <option value="">Tất cả</option>
                        <option value="Staff" ${filterRole eq 'Staff' ? 'selected' : ''}>Nhân viên</option>
                        <option value="PT" ${filterRole eq 'PT' ? 'selected' : ''}>Huấn luyện viên</option>
                    </select>
                </div>
            </c:if>
            <div class="col-md-2">
                <label class="form-label fw-semibold">Ca làm việc</label>
                <select name="shift" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="Morning" ${filterShift eq 'Morning' ? 'selected' : ''}>Sáng</option>
                    <option value="Afternoon" ${filterShift eq 'Afternoon' ? 'selected' : ''}>Chiều</option>
                    <option value="Evening" ${filterShift eq 'Evening' ? 'selected' : ''}>Tối</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold">Từ ngày</label>
                <input type="date" id="fromDate" name="from" class="form-control" value="${filterFrom}" max="${filterTo}">
                <div id="fromDateError" class="text-danger small mt-1 d-none">Từ ngày phải trước hoặc bằng đến ngày.</div>
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold">Đến ngày</label>
                <input type="date" id="toDate" name="to" class="form-control" value="${filterTo}" min="${filterFrom}">
                <div id="toDateError" class="text-danger small mt-1 d-none">Đến ngày phải sau hoặc bằng từ ngày.</div>
            </div>
            <c:if test="${adminView}">
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Tìm kiếm</label>
                    <input type="text" name="keyword" class="form-control"
                           placeholder="Tên hoặc email"
                           value="${filterKeyword}">
                </div>
            </c:if>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fa fa-search me-1"></i>Tìm kiếm
                </button>
            </div>
            <div class="col-md-1">
                <a href="${resetUrl}" class="btn btn-outline-secondary w-100">Xóa lọc</a>
            </div>
        </form>
    </div>

    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                <a href="${resetUrl}" class="btn btn-sm btn-outline-danger ms-3">Thử lại</a>
            </div>
        </c:when>
        <c:when test="${empty historyList}">
            <div class="text-center py-5 text-muted bg-white rounded shadow-sm">
                <i class="fa fa-inbox fa-3x mb-3 d-block"></i>
                <p class="mb-0">${not empty emptyMessage ? emptyMessage : 'Chưa có lịch sử điểm danh.'}</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="d-flex justify-content-between align-items-center mb-2">
                <p class="text-muted small mb-0">
                    ${adminView ? 'Tổng' : 'Tìm thấy'} <strong>${total}</strong> bản ghi.
                </p>
            </div>

            <div class="bg-white rounded shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <c:if test="${adminView}">
                                    <th>Vai trò</th>
                                </c:if>
                                <th>Ngày</th>
                                <th>Ca</th>
                                <th>Giờ vào</th>
                                <th>Giờ ra</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="rowNum" value="${(currentPage - 1) * 20}" />
                            <c:forEach var="a" items="${historyList}" varStatus="loop">
                                <tr>
                                    <td class="text-muted small">${rowNum + loop.index + 1}</td>
                                    <td class="fw-semibold">${a.targetFullName}</td>
                                    <td class="text-muted small">${a.targetEmail}</td>
                                    <c:if test="${adminView}">
                                        <td>
                                            <span class="badge ${a.userRole.name() eq 'PT' ? 'bg-info' : 'bg-secondary'}">
                                                ${a.userRoleLabel}
                                            </span>
                                        </td>
                                    </c:if>
                                    <td><c:out value="${a.attendanceDate}" default="-" /></td>
                                    <td><span class="badge bg-light text-dark border">${a.shiftLabel}</span></td>
                                    <td class="small text-muted"><c:out value="${a.checkedInAtDisplay}" default="-" /></td>
                                    <td class="small text-muted"><c:out value="${a.checkedOutAtDisplay}" default="-" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <c:if test="${totalPages > 1}">
                <nav class="mt-4">
                    <ul class="pagination justify-content-center flex-wrap">
                        <c:url var="prevUrl" value="${historyBasePath}">
                            <c:param name="page" value="${currentPage - 1}" />
                            <c:param name="role" value="${filterRole}" />
                            <c:param name="shift" value="${filterShift}" />
                            <c:param name="from" value="${filterFrom}" />
                            <c:param name="to" value="${filterTo}" />
                            <c:param name="keyword" value="${filterKeyword}" />
                        </c:url>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${prevUrl}">&laquo; Trước</a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <c:url var="pageUrl" value="${historyBasePath}">
                                <c:param name="page" value="${p}" />
                                <c:param name="role" value="${filterRole}" />
                                <c:param name="shift" value="${filterShift}" />
                                <c:param name="from" value="${filterFrom}" />
                                <c:param name="to" value="${filterTo}" />
                                <c:param name="keyword" value="${filterKeyword}" />
                            </c:url>
                            <li class="page-item ${p == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageUrl}">${p}</a>
                            </li>
                        </c:forEach>

                        <c:url var="nextUrl" value="${historyBasePath}">
                            <c:param name="page" value="${currentPage + 1}" />
                            <c:param name="role" value="${filterRole}" />
                            <c:param name="shift" value="${filterShift}" />
                            <c:param name="from" value="${filterFrom}" />
                            <c:param name="to" value="${filterTo}" />
                            <c:param name="keyword" value="${filterKeyword}" />
                        </c:url>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${nextUrl}">Sau &raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('workHistoryFilterForm');
    const fromDate = document.getElementById('fromDate');
    const toDate = document.getElementById('toDate');
    const fromDateError = document.getElementById('fromDateError');
    const toDateError = document.getElementById('toDateError');

    function validateDateRange() {
        const hasInvalidRange = fromDate.value && toDate.value && fromDate.value > toDate.value;
        fromDate.classList.toggle('is-invalid', hasInvalidRange);
        toDate.classList.toggle('is-invalid', hasInvalidRange);
        fromDateError.classList.toggle('d-none', !hasInvalidRange);
        toDateError.classList.toggle('d-none', !hasInvalidRange);
        return !hasInvalidRange;
    }

    fromDate.addEventListener('change', validateDateRange);
    toDate.addEventListener('change', validateDateRange);
    form.addEventListener('submit', function (event) {
        if (!validateDateRange()) {
            event.preventDefault();
        }
    });
});
</script>

<jsp:include page="dashboard_footer.jsp" />
