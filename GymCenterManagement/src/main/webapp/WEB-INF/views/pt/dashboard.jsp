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
        <!-- Card 1: Hội viên của tôi -->
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 pt-card-btn" 
                 style="cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;" 
                 onclick="handleCardClick('members', ${empty data ? 0 : data.activeMembersCount})">
                <i class="fa fa-user-friends fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hội viên của tôi</p>
                    <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.activeMembersCount} Đang tập</h5>
                </div>
            </div>
        </div>
        <!-- Card 2: Buổi tập trong tuần -->
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 pt-card-btn" 
                 style="cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;" 
                 onclick="handleCardClick('weekly', ${empty data ? 0 : data.weeklySessionsCount})">
                <i class="fa fa-dumbbell fa-3x text-success"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Buổi tập trong tuần</p>
                    <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.weeklySessionsCount} Đã lên lịch</h5>
                </div>
            </div>
        </div>
        <!-- Card 3: Giờ huấn luyện -->
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 pt-card-btn" 
                 style="cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;" 
                 onclick="handleCardClick('hours', 0)">
                <i class="fa fa-clock fa-3x text-info"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Giờ huấn luyện</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${empty data ? 0 : data.trainingHours}" type="number" maxFractionDigits="1"/> giờ
                    </h5>
                </div>
            </div>
        </div>
        <!-- Card 4: Hoàn thành hôm nay -->
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 pt-card-btn" 
                 style="cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;" 
                 onclick="handleCardClick('today', ${empty data ? 0 : data.completedTodayCount})">
                <i class="fa fa-check-circle fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hoàn thành hôm nay</p>
                    <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.completedTodayCount} / ${empty data ? 0 : data.totalTodayCount} Buổi</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Details Container (Toggled via JS) -->
    <div id="detailsCollapseContainer" class="mt-4" style="display: none;">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0 text-dark fw-bold" id="detailsTitle">Chi tiết</h5>
                <button type="button" class="btn-close" onclick="closeDetails()"></button>
            </div>
            <div class="card-body p-4">
                <!-- Members Details -->
                <div id="detailsContent_members" style="display: none;">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Hội viên</th>
                                    <th>Gói đăng ký</th>
                                    <th>Số buổi tập</th>
                                    <th>Thời hạn hợp đồng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty membersList}">
                                        <tr><td colspan="5" class="text-center py-3 text-muted">Không có hội viên</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="m" items="${membersList}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>
                                                    <div class="fw-bold">${m.memberName}</div>
                                                    <small class="text-muted"><i class="fa fa-phone me-1"></i>${m.memberPhone}</small>
                                                </td>
                                                <td><span class="badge bg-primary">${m.packageName}</span></td>
                                                <td>
                                                    <span class="badge bg-info text-white px-2 py-1">
                                                        ${m.completedSessions} / ${m.totalSessions} buổi
                                                    </span>
                                                </td>
                                                <td class="small text-muted">
                                                    Từ: ${m.formattedStartDate}<br>Đến: ${m.formattedEndDate}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Weekly Details -->
                <div id="detailsContent_weekly" style="display: none;">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Ngày tập</th>
                                    <th>Giờ tập</th>
                                    <th>Tên hội viên</th>
                                    <th>Gói tập</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty weeklySessionsList}">
                                        <tr><td colspan="5" class="text-center py-3 text-muted">Không có buổi tập trong tuần</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="s" items="${weeklySessionsList}">
                                            <tr>
                                                <td><span class="fw-bold text-dark">${s.sessionDate}</span></td>
                                                <td>
                                                    <span class="badge bg-light text-dark border">
                                                        ${s.startTime.toString().substring(0,5)} - ${s.endTime.toString().substring(0,5)}
                                                    </span>
                                                </td>
                                                <td>${s.memberName}</td>
                                                <td>${s.packageName}</td>
                                                <td>
                                                    <span class="badge bg-${s.sessionStatus == 'Completed' ? 'success' : (s.sessionStatus == 'Cancelled' ? 'danger' : 'warning text-dark')}">
                                                        ${s.sessionStatus}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Hours Details -->
                <div id="detailsContent_hours" style="display: none;">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Ngày dạy</th>
                                    <th>Giờ tập</th>
                                    <th>Tên hội viên</th>
                                    <th>Gói tập</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty completedSessionsList}">
                                        <tr><td colspan="5" class="text-center py-3 text-muted">Chưa hoàn thành ca dạy nào</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="s" items="${completedSessionsList}">
                                            <tr>
                                                <td><span class="fw-bold text-dark">${s.sessionDate}</span></td>
                                                <td>
                                                    <span class="badge bg-light text-dark border">
                                                        ${s.startTime.toString().substring(0,5)} - ${s.endTime.toString().substring(0,5)}
                                                    </span>
                                                </td>
                                                <td>${s.memberName}</td>
                                                <td>${s.packageName}</td>
                                                <td><span class="badge bg-success">Hoàn thành</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Completed Today Details -->
                <div id="detailsContent_today" style="display: none;">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Giờ tập</th>
                                    <th>Tên hội viên</th>
                                    <th>Gói tập</th>
                                    <th>Điểm danh</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="hasCompletedToday" value="false"/>
                                <c:forEach var="s" items="${data.todaySchedule}">
                                    <c:if test="${s.sessionStatus == 'Completed'}">
                                        <c:set var="hasCompletedToday" value="true"/>
                                        <tr>
                                            <td>
                                                <span class="badge bg-light text-dark border">
                                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> - 
                                                    <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
                                                </span>
                                            </td>
                                            <td>${s.memberName}</td>
                                            <td>${s.packageName}</td>
                                            <td>
                                                <span class="badge bg-${s.attendanceStatus == 'Attended' ? 'success' : 'danger'}">
                                                    ${s.attendanceStatus == 'Attended' ? 'Có mặt' : 'Vắng mặt'}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not hasCompletedToday}">
                                    <tr><td colspan="4" class="text-center py-3 text-muted">Hôm nay chưa hoàn thành ca dạy nào</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
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
                                                        <c:if test="${not empty s.note}">
                                                            <i class="fa fa-info-circle text-danger ms-1" 
                                                               data-bs-toggle="tooltip" 
                                                               data-bs-placement="top" 
                                                               title="Lý do hủy: ${s.note}"></i>
                                                        </c:if>
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
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Liên hệ hội viên nếu có thay đổi hoặc hủy ca tập trước 2 tiếng.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Xem lịch tuần để sắp xếp chuẩn bị bài tập phù hợp mục tiêu của hội viên.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<style>
    .pt-card-btn:hover {
        transform: translateY(-5px);
        box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.15)!important;
    }
</style>

<script>
    function handleCardClick(type, count) {
        if (type === 'members') {
            if (count >= 5) {
                window.location.href = "${pageContext.request.contextPath}/pt/members";
            } else {
                toggleDetailSection('members');
            }
        } else if (type === 'weekly') {
            if (count >= 5) {
                window.location.href = "${pageContext.request.contextPath}/pt/schedule-dashboard";
            } else {
                toggleDetailSection('weekly');
            }
        } else if (type === 'today') {
            if (count >= 5) {
                window.location.href = "${pageContext.request.contextPath}/pt/schedule-dashboard";
            } else {
                toggleDetailSection('today');
            }
        } else if (type === 'hours') {
            toggleDetailSection('hours');
        }
    }

    function toggleDetailSection(type) {
        const container = document.getElementById('detailsCollapseContainer');
        const sections = ['members', 'weekly', 'hours', 'today'];
        const titles = {
            'members': '<i class="fa fa-user-friends me-2 text-primary"></i>Hội viên của tôi (Dưới 5 người)',
            'weekly': '<i class="fa fa-dumbbell me-2 text-success"></i>Buổi tập trong tuần (Dưới 5 buổi)',
            'hours': '<i class="fa fa-clock me-2 text-info"></i>Lịch sử giờ huấn luyện đã hoàn thành',
            'today': '<i class="fa fa-check-circle me-2 text-warning"></i>Buổi tập đã hoàn thành hôm nay'
        };

        // If container is already visible and we click the same type, close it
        const currentActiveSection = sections.find(s => document.getElementById('detailsContent_' + s).style.display === 'block');
        if (container.style.display === 'block' && currentActiveSection === type) {
            closeDetails();
            return;
        }

        // Set title
        document.getElementById('detailsTitle').innerHTML = titles[type] || 'Chi tiết';

        // Hide all contents and show selected one
        sections.forEach(s => {
            document.getElementById('detailsContent_' + s).style.display = (s === type) ? 'block' : 'none';
        });

        // Show container with smooth transition scroll
        container.style.display = 'block';
        container.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }

    function closeDetails() {
        const container = document.getElementById('detailsCollapseContainer');
        container.style.display = 'none';
        const sections = ['members', 'weekly', 'hours', 'today'];
        sections.forEach(s => {
            document.getElementById('detailsContent_' + s).style.display = 'none';
        });
    }

    // Initialize tooltips
    document.addEventListener("DOMContentLoaded", function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />

