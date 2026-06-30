<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:set var="data" value="${dashboardData}" />

<!-- PT Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Welcome Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-1 text-dark fw-bold"><i class="fa fa-home me-2 text-primary"></i>Chào mừng quay trở lại, ${sessionScope.currentUser.fullName}!</h4>
            <small class="text-muted">Xem tổng quan về các chỉ số huấn luyện và lịch dạy hôm nay của bạn</small>
        </div>
        <a href="${pageContext.request.contextPath}/pt/dashboard" class="btn btn-sm btn-primary shadow-sm">
            <i class="fa fa-sync-alt me-1"></i> Làm mới
        </a>
    </div>

    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-user-friends fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hội viên của tôi</p>
                    <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.activeMembersCount} Đang tập</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="text-decoration-none">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-dumbbell fa-3x text-success"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Buổi tập trong tuần</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.weeklySessionsCount} Đã lên lịch</h5>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-clock fa-3x text-info"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Giờ huấn luyện</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${empty data ? 0 : data.trainingHours}" type="number" maxFractionDigits="1"/> giờ
                    </h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm">
                <i class="fa fa-check-circle fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hoàn thành hôm nay</p>
                    <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.completedTodayCount} / ${empty data ? 0 : data.totalTodayCount} Buổi</h5>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 2: Today's PT Sessions Schedule -->
    <div class="row g-4">
        <div class="col-12 col-xl-8">
            <div class="bg-light text-center rounded p-4 h-100 shadow-sm">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0 text-dark fw-bold">Lịch huấn luyện hôm nay</h6>
                    <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="small text-decoration-none">Xem lịch tuần</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Giờ tập</th>
                                <th scope="col">Tên hội viên</th>
                                <th scope="col">Gói tập / Mục tiêu</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty data or empty data.todaySchedule}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">
                                            <i class="fa fa-calendar-times fa-3x mb-3 text-secondary d-block"></i>
                                            Hôm nay bạn không có ca dạy nào được lên lịch.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="s" items="${data.todaySchedule}">
                                        <tr>
                                            <td>
                                                <span class="badge bg-light text-dark border">
                                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> - 
                                                    <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
                                                </span>
                                            </td>
                                            <td class="fw-bold">${s.memberName}</td>
                                            <td>${s.packageName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.sessionStatus == 'Completed'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">Sắp diễn ra</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty s.attendanceStatus and s.attendanceStatus != 'Pending'}">
                                                    <span class="badge bg-${s.attendanceStatus == 'Attended' ? 'success' : 'danger'} ms-1">
                                                        ${s.attendanceStatus == 'Attended' ? 'Có mặt' : 'Vắng mặt'}
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/pt/schedule-dashboard">Chi tiết & Điểm danh</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Trainer Notes & Checklist -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100 shadow-sm">
                <h6 class="mb-4 text-dark fw-bold">Danh sách việc cần làm & Nhắc nhở</h6>
                <ul class="list-group list-group-flush bg-transparent">
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Điểm danh chính xác sau mỗi ca dạy để lưu lịch sử làm việc.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Liên hệ hội viên nếu có thay đổi hoặc hủy ca tập trước 2 tiếng.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Xem lịch tuần để sắp xếp chuẩn bị bài tập phù hợp mục tiêu của hội viên.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />

