<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : work-history.jsp
  Created on  : 2026-06-26
  Author      : Nguyễn Trí Linh (linhnt)
  Description : Giao diện lịch sử làm việc của Staff & PT (UC 2.3.5).
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h4 class="mb-0"><i class="fa fa-history me-2 text-primary"></i>Lịch Sử Làm Việc Staff &amp; PT</h4>
        <c:if test="${currentUser.role.name() eq 'Staff' or currentUser.role.name() eq 'Admin'}">
            <a href="${pageContext.request.contextPath}/staff/checkin" class="btn btn-primary btn-sm">
                <i class="fa fa-user-check me-1"></i>Điểm danh
            </a>
        </c:if>
    </div>

    <!-- Bộ lọc tìm kiếm -->
    <div class="bg-light rounded p-3 mb-4">
        <form method="get" action="${pageContext.request.contextPath}/staff/work-history" class="row g-3 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-semibold">Tìm kiếm (tên / email)</label>
                <input type="text" name="keyword" class="form-control"
                       placeholder="Nhập tên hoặc email..."
                       value="${filterKeyword}">
            </div>
            <c:if test="${currentUser.role.name() eq 'Admin' or currentUser.role.name() eq 'Staff'}">
                <div class="col-md-2">
                    <label class="form-label fw-semibold">Vai trò</label>
                    <select name="role" class="form-select">
                        <option value="">Tất cả</option>
                        <option value="Staff" ${filterRole eq 'Staff' ? 'selected' : ''}>Staff</option>
                        <option value="PT"    ${filterRole eq 'PT'    ? 'selected' : ''}>Personal Trainer</option>
                    </select>
                </div>
            </c:if>
            <div class="col-md-2">
                <label class="form-label fw-semibold">Từ ngày</label>
                <input type="date" name="from" class="form-control" value="${filterFrom}">
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold">Đến ngày</label>
                <input type="date" name="to" class="form-control" value="${filterTo}">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fa fa-search me-1"></i>Tìm kiếm
                </button>
            </div>
            <div class="col-md-1">
                <a href="${pageContext.request.contextPath}/staff/work-history"
                   class="btn btn-outline-secondary w-100">Xoá lọc</a>
            </div>
        </form>
    </div>

    <!-- Kết quả -->
    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                <a href="${pageContext.request.contextPath}/staff/work-history"
                   class="btn btn-sm btn-outline-danger ms-3">Thử lại</a>
            </div>
        </c:when>
        <c:when test="${empty historyList}">
            <div class="text-center py-5 text-muted">
                <i class="fa fa-inbox fa-3x mb-3 d-block"></i>
                <p>${not empty emptyMessage ? emptyMessage : 'Chưa có lịch sử điểm danh.'}</p>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Tổng số bản ghi -->
            <p class="text-muted small mb-2">Tìm thấy <strong>${total}</strong> bản ghi.</p>

            <div class="bg-white rounded shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Ngày</th>
                                <th>Ca</th>
                                <th>Giờ check-in</th>
                                <th>Người điểm danh</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="rowNum" value="${(currentPage - 1) * 20}" />
                            <c:forEach var="a" items="${historyList}" varStatus="loop">
                                <tr>
                                    <td class="text-muted small">${rowNum + loop.index + 1}</td>
                                    <td class="fw-semibold">${a.targetFullName}</td>
                                    <td class="text-muted small">${a.targetEmail}</td>
                                    <td>
                                        <span class="badge ${a.userRole.name() eq 'PT' ? 'bg-info' : 'bg-secondary'}">
                                            ${a.userRole}
                                        </span>
                                    </td>
                                    <td>${a.attendanceDate}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border">${a.shiftLabel}</span>
                                    </td>
                                    <td class="small text-muted">${a.checkedInAt}</td>
                                    <td class="small text-muted">
                                        <c:out value="${a.checkedByName}" default="—"/>
                                    </td>
                                    <td class="small text-muted">
                                        <c:out value="${a.note}" default="—"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Phân trang -->
            <c:if test="${totalPages > 1}">
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/staff/work-history?page=${currentPage - 1}&role=${filterRole}&from=${filterFrom}&to=${filterTo}&keyword=${filterKeyword}">
                                &laquo; Trước
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <li class="page-item ${p == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/staff/work-history?page=${p}&role=${filterRole}&from=${filterFrom}&to=${filterTo}&keyword=${filterKeyword}">
                                    ${p}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/staff/work-history?page=${currentPage + 1}&role=${filterRole}&from=${filterFrom}&to=${filterTo}&keyword=${filterKeyword}">
                                Sau &raquo;
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>

        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="../common/dashboard_footer.jsp" />
