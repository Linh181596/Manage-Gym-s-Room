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
        <%-- Nút tải lại dữ liệu bảng điều khiển (Dashboard) cho PT --%>
        <a href="${pageContext.request.contextPath}/pt/dashboard" class="btn btn-sm btn-primary shadow-sm">
            <i class="fa fa-sync-alt me-1"></i> Làm mới
        </a>
    </div>

    <!-- Alert: New Paid Registrations needing schedule -->
    <c:if test="${not empty pendingSchedulesCount && pendingSchedulesCount > 0}">
        <div class="alert alert-warning border-warning border-2 shadow-sm d-flex align-items-center justify-content-between fade show p-3 mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fa fa-exclamation-triangle text-danger me-3 fs-4"></i>
                <div>
                    <h6 class="mb-0 fw-bold text-dark">Bạn có ${pendingSchedulesCount} gói tập mới đã thanh toán cần xếp lịch dạy!</h6>
                    <small class="text-muted">Vui lòng xếp lịch để hội viên có thể bắt đầu tập luyện.</small>
                </div>
            </div>
            <%-- Nút chuyển hướng đến trang xếp lịch dạy cho gói tập mới --%>
            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="btn btn-warning fw-bold text-dark shadow-sm">
                <i class="fa fa-calendar-alt me-1"></i> Đến trang xếp lịch dạy
            </a>
        </div>
    </c:if>

    <!-- Alert: Assigned Substitute PT Sessions -->
    <c:if test="${not empty substituteSessionsCount && substituteSessionsCount > 0}">
        <div class="alert alert-info border-info border-2 shadow-sm d-flex align-items-center justify-content-between fade show p-3 mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fa fa-info-circle text-info me-3 fs-4"></i>
                <div>
                    <h6 class="mb-0 fw-bold text-dark">Bạn có ${substituteSessionsCount} ca dạy thay thế mới được phân công!</h6>
                    <small class="text-muted">Bạn được phân công dạy thay cho HLV khác. Vui lòng kiểm tra lịch để chuẩn bị giảng dạy.</small>
                </div>
            </div>
            <%-- Nút chuyển hướng đến trang xem lịch dạy thay thế --%>
            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="btn btn-info fw-bold text-white shadow-sm">
                <i class="fa fa-calendar-check me-1"></i> Xem lịch dạy của tôi
            </a>
        </div>
    </c:if>

    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <!-- Card 1: Hội viên của tôi -->
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 pt-card-btn" 
                 style="cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;" 
                 onclick="handleCardClick('members', '${empty data ? 0 : data.activeMembersCount}')">
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
                 onclick="handleCardClick('weekly', '${empty data ? 0 : data.weeklySessionsCount}')">
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
                 onclick="handleCardClick('today', '${empty data ? 0 : data.completedTodayCount}')">
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
                                    <th>Thời gian tập thực tế</th>
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
                                                        <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> - <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
                                                    </span>
                                                </td>
                                                <td>${s.memberName}</td>
                                                 <td>
                                                     ${s.packageName}
                                                     <c:choose>
                                                         <c:when test="${not empty s.originalPtId and s.ptId == pt.ptId}">
                                                             <span class="badge bg-info text-white ms-1">Dạy thay</span>
                                                         </c:when>
                                                         <c:when test="${not empty s.originalPtId and s.originalPtId == pt.ptId}">
                                                             <span class="badge bg-warning text-dark ms-1" data-bs-toggle="tooltip" title="Ca này bạn đã nhờ dạy hộ">Dạy thay bởi: ${s.ptName}</span>
                                                         </c:when>
                                                     </c:choose>
                                                 </td>
                                                  <td>
                                                     <span class="badge bg-${s.sessionStatus == 'Completed' ? 'success' : (s.sessionStatus == 'Cancelled' ? 'danger' : 'warning text-dark')}">
                                                         ${s.sessionStatus}
                                                     </span>
                                                     <c:if test="${s.sessionStatus == 'Cancelled' and not empty s.cancellationReason}">
                                                         <i class="fa fa-info-circle text-danger ms-1" 
                                                            data-bs-toggle="tooltip" 
                                                            data-bs-placement="top" 
                                                            title="Lý do hủy: ${s.cancellationReason}"></i>
                                                     </c:if>
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
                                                        <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> - <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
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
    <!-- Row 1.5: PT Packages & Progress -->
    <div class="row g-4 mb-4">
        <div class="col-12">
            <div class="bg-light rounded p-4 shadow-sm">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0 text-dark fw-bold"><i class="fa fa-tasks text-primary me-2"></i>Gói tập & Tiến độ huấn luyện</h6>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Mã đơn</th>
                                <th>Hội viên</th>
                                <th>Gói tập</th>
                                <th>Đã dạy</th>
                                <th>Sắp diễn ra</th>
                                <th>Đã hủy</th>
                                <th>Buổi đã mua</th>
                                <th>Tiến độ</th>
                                <th>Thời gian tập thực tế</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty registrationsWithProgress}">
                                    <tr>
                                        <td colspan="9" class="text-center py-4 text-muted">
                                            Không có gói tập nào đang hoạt động.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="reg" items="${registrationsWithProgress}">
                                        <tr>
                                            <td class="fw-bold">#PT-${reg.ptRegistrationId}</td>
                                            <td>
                                                <strong>${reg.memberName}</strong><br>
                                                <small class="text-muted"><i class="fa fa-phone me-1"></i>${reg.memberPhone}</small>
                                            </td>
                                            <td>${reg.packageName}</td>
                                            <td><span class="badge bg-success">${reg.completedCount} buổi</span></td>
                                            <td><span class="badge bg-warning text-dark">${reg.upcomingCount} buổi</span></td>
                                            <td><span class="badge bg-danger">${reg.cancelledCount} buổi</span></td>
                                            <td class="fw-bold">${reg.purchasedSessions} buổi</td>
                                            <td style="width: 20%;">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1" style="height: 8px;">
                                                        <div class="progress-bar bg-success pt-progress-bar" role="progressbar" 
                                                             data-progress="${reg.progressPercentage}" 
                                                             aria-valuenow="${reg.progressPercentage}" 
                                                             aria-valuemin="0" 
                                                             aria-valuemax="100"></div>
                                                    </div>
                                                    <span class="ms-2 small fw-bold text-dark">${reg.progressPercentage}%</span>
                                                </div>
                                            </td>
                                            <td class="small text-muted">
                                                <c:choose>
                                                    <c:when test="${not empty reg.startDate && not empty reg.endDate}">
                                                        Từ: <span class="text-dark fw-semibold">${reg.formattedStartDate}</span><br>
                                                        Đến: <span class="text-dark fw-semibold">${reg.formattedEndDate}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-warning"><i class="fa fa-exclamation-circle me-1"></i>Chưa xếp lịch</span>
                                                    </c:otherwise>
                                                </c:choose>
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
    </div>

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
                                            <td>
                                                ${s.packageName}
                                                <c:choose>
                                                    <c:when test="${not empty s.originalPtId and s.ptId == pt.ptId}">
                                                        <span class="badge bg-info text-white ms-1">Dạy thay</span>
                                                    </c:when>
                                                    <c:when test="${not empty s.originalPtId and s.originalPtId == pt.ptId}">
                                                        <span class="badge bg-warning text-dark ms-1" data-bs-toggle="tooltip" title="Ca này bạn đã nhờ dạy hộ">Dạy thay bởi: ${s.currentPtName}</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.sessionStatus == 'Completed'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                        <c:if test="${not empty s.cancellationReason}">
                                                            <i class="fa fa-info-circle text-danger ms-1" 
                                                               data-bs-toggle="tooltip" 
                                                               data-bs-placement="top" 
                                                               title="Lý do hủy: ${s.cancellationReason}"></i>
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
                                                <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/pt/schedule-dashboard">Chi tiết lịch</a>
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
    // Hàm xử lý sự kiện click vào các thẻ KPI, điều hướng đến trang chi tiết hoặc hiển thị bảng chi tiết bên dưới
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

    // Hàm chuyển đổi hiển thị thông tin chi tiết của thẻ KPI được chọn, tự động cuộn màn hình
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

        // Initialize dynamic progress bars
        document.querySelectorAll('.pt-progress-bar').forEach(function(bar) {
            var progress = bar.getAttribute('data-progress');
            if (progress) {
                bar.style.width = progress + '%';
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />

