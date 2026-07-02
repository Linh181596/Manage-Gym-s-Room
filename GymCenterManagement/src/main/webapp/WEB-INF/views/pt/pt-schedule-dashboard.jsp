<%--
  Created by IntelliJ IDEA.
  User: phuga
  Date: 6/25/2026
  Time: 9:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid mt-4 px-4">
    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i>${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${sessionScope.errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4 bg-white p-3 rounded shadow-sm border">
        <h4 class="mb-0 fw-bold text-dark">
            <i class="fa fa-calendar-alt text-primary me-2"></i> Lịch Dạy Của Tôi
        </h4>
        <div class="btn-group shadow-sm">
            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard?refDate=${prevWeekDate}"
               class="btn btn-outline-primary fw-bold">
                <i class="fa fa-chevron-left"></i> Tuần trước
            </a>
            <button class="btn btn-primary fw-bold px-4" disabled>
                Tuần này: ${weekStartStr} - ${weekEndStr}
            </button>
            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard?refDate=${nextWeekDate}"
               class="btn btn-outline-primary fw-bold">
                Tuần sau <i class="fa fa-chevron-right"></i>
            </a>
        </div>
    </div>

    <div class="row flex-nowrap overflow-auto pb-4" style="min-height: 650px;">
        <c:forEach var="entry" items="${scheduleMap}">
            <div class="col" style="min-width: 260px;">
                <div class="card h-100 shadow-sm border-0 bg-secondary bg-opacity-10">
                    <div class="card-header bg-dark text-white text-center fw-bold py-3 border-bottom-0 rounded-top">
                            ${entry.key}
                    </div>

                    <div class="card-body p-2">
                        <c:if test="${empty entry.value}">
                            <div class="text-center text-muted mt-4" style="font-size: 0.9rem;">
                                <i class="fa fa-mug-hot fs-3 mb-2 opacity-50 text-secondary"></i><br>Không có ca dạy
                            </div>
                        </c:if>

                        <c:forEach var="s" items="${entry.value}">
                            <c:set var="borderColor"
                                   value="${s.sessionStatus == 'Completed' ? 'success' : (s.sessionStatus == 'Cancelled' ? 'danger' : 'primary')}"/>

                            <div class="card mb-3 border-start border-${borderColor} border-4 shadow-sm hover-zoom">
                                <div class="card-body p-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="badge bg-light text-dark border">
                                            <i class="fa fa-clock text-warning"></i>
                                            ${s.startTime.toString().substring(0,5)} - ${s.endTime.toString().substring(0,5)}
                                        </span>
                                        <div>
                                            <span class="badge bg-${borderColor}">
                                                <c:choose>
                                                    <c:when test="${s.sessionStatus == 'Completed'}">Completed</c:when>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">Cancelled</c:when>
                                                    <c:otherwise>Upcoming</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:choose>
                                                <c:when test="${s.attendanceStatus == 'Attended'}">
                                                    <span class="badge bg-success ms-1">Có mặt</span>
                                                </c:when>
                                                <c:when test="${s.attendanceStatus == 'Absent'}">
                                                    <span class="badge bg-danger ms-1">Vắng mặt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary ms-1">Chờ điểm danh</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <h6 class="fw-bold text-dark mb-1">
                                        <i class="fa fa-user text-secondary me-1"></i> ${s.memberName}
                                    </h6>

                                    <div class="text-muted small">
                                        <i class="fa fa-dumbbell me-1"></i> Gói: ${s.packageName}
                                    </div>

                                    <c:if test="${s.sessionStatus == 'Cancelled' && not empty s.note}">
                                        <div class="text-danger small mt-2" data-bs-toggle="tooltip" title="Lý do hủy: ${s.note}">
                                            <i class="fa fa-times-circle me-1"></i>
                                            <strong>Lý do hủy:</strong> ${s.note}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
    .hover-zoom {
        transition: transform 0.2s ease-in-out;
    }

    .hover-zoom:hover {
        transform: translateY(-3px);
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>

