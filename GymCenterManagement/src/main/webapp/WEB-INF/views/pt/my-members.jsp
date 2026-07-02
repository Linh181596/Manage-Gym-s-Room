<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-1 text-dark fw-bold">
                <i class="fa fa-user-friends me-2 text-primary"></i>Danh sách hội viên của tôi
            </h4>
            <small class="text-muted">Quản lý và theo dõi tiến trình tập luyện của các học viên trực thuộc</small>
        </div>
        <a href="${pageContext.request.contextPath}/pt/dashboard" class="btn btn-outline-secondary btn-sm shadow-sm">
            <i class="fa fa-arrow-left me-1"></i> Quay lại Dashboard
        </a>
    </div>

    <!-- Active Members Table -->
    <div class="card border-0 shadow-sm p-4">
        <c:choose>
            <c:when test="${empty membersList}">
                <div class="text-center py-5 text-muted">
                    <i class="fa fa-user-slash fa-3x mb-3 d-block text-secondary"></i>
                    <p class="mb-0">Hiện tại bạn chưa có hội viên nào đăng ký tập luyện.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 5%;">#</th>
                                <th style="width: 20%;">Hội viên</th>
                                <th style="width: 20%;">Gói đăng ký</th>
                                <th style="width: 15%;">Số buổi tập</th>
                                <th style="width: 15%;">Thứ tập</th>
                                <th style="width: 15%;">Khung giờ</th>
                                <th style="width: 15%;" class="text-center">Thời hạn hợp đồng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${membersList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${m.memberName}</div>
                                        <small class="text-muted"><i class="fa fa-phone me-1"></i>${m.memberPhone}</small>
                                    </td>
                                    <td>
                                        <span class="fw-semibold text-primary">${m.packageName}</span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="text-decoration-none">
                                            <span class="badge bg-info text-white px-2 py-1.5" style="font-size: 0.85rem;" title="Xem lịch dạy">
                                                ${m.completedSessions} / ${m.totalSessions} buổi
                                            </span>
                                        </a>
                                        <c:if test="${m.cancelledSessions > 0}">
                                            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="text-decoration-none d-block mt-1">
                                                <small class="text-danger fw-bold" title="Xem ca học bị hủy trên lịch tuần">
                                                    <i class="fa fa-times-circle"></i> Đã hủy: ${m.cancelledSessions} ca
                                                </small>
                                            </a>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.daysOfWeek}">
                                                <span class="badge bg-light text-dark border fw-bold">
                                                    ${m.daysOfWeek}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted small">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.timeSlot}">
                                                <span class="badge bg-light text-dark border">
                                                    ${m.timeSlot}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted small">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center small">
                                        <div class="text-muted">Từ: ${m.formattedStartDate}</div>
                                        <div class="text-muted">Đến: ${m.formattedEndDate}</div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <jsp:include page="../common/pagination.jsp" />
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
