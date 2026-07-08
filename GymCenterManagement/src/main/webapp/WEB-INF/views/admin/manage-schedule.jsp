<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<!-- Main Content with Tabs -->
<div class="container-fluid pt-4 px-4">
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

    <c:set var="activeTabParam" value="${param.activeTab}" />
    <c:if test="${empty activeTabParam}">
        <c:set var="activeTabParam" value="pending" />
    </c:if>

    <!-- Navigation Tabs -->
    <ul class="nav nav-tabs border-bottom-0 mb-3" id="scheduleTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTabParam == 'pending' ? 'active' : ''} fw-bold text-dark" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="${activeTabParam == 'pending'}">
                <i class="fa fa-list-ul me-2 text-primary"></i>Yêu cầu chờ duyệt
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTabParam == 'attendance' ? 'active' : ''} fw-bold text-dark" id="attendance-tab" data-bs-toggle="tab" data-bs-target="#attendance" type="button" role="tab" aria-controls="attendance" aria-selected="${activeTabParam == 'attendance'}">
                <i class="fa fa-clipboard-check me-2 text-primary"></i>Điểm danh ca dạy HLV
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTabParam == 'reschedules' ? 'active' : ''} fw-bold text-dark" id="reschedules-tab" data-bs-toggle="tab" data-bs-target="#reschedules" type="button" role="tab" aria-controls="reschedules" aria-selected="${activeTabParam == 'reschedules'}">
                <i class="fa fa-handshake me-2 text-primary"></i>Hỗ trợ đổi lịch
                <c:if test="${not empty escalatedRequests && fn:length(escalatedRequests) > 0}">
                    <span class="badge bg-danger ms-1">${fn:length(escalatedRequests)}</span>
                </c:if>
            </button>
        </li>
    </ul>

    <div class="tab-content" id="scheduleTabsContent">
        <!-- Tab 1: Pending Requests -->
        <div class="tab-pane fade ${activeTabParam == 'pending' ? 'show active' : ''}" id="pending" role="tabpanel" aria-labelledby="pending-tab">
            <div class="card border-0 shadow-sm p-4">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="text-dark fw-bold m-0">
                        <i class="fa fa-list-ul text-primary me-2"></i>Yêu cầu đăng ký PT chờ duyệt
                    </h5>
                    <a href="${pageContext.request.contextPath}/admin/schedule/registration-history" 
                       class="btn btn-outline-secondary btn-sm shadow-sm">
                        <i class="fa fa-history me-1"></i> Lịch sử duyệt đơn
                    </a>
                </div>

                <c:choose>
                    <c:when test="${empty pendingRegistrations}">
                        <div class="text-center py-5">
                            <p class="text-muted">Hiện tại không có đơn đăng ký nào chờ xử lý.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Hội viên</th>
                                    <th>HLV yêu cầu</th>
                                    <th>Gói tập</th>
                                    <th>Ngày mong muốn bắt đầu</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="reg" items="${pendingRegistrations}">
                                    <tr>
                                        <td>#PT-${reg.ptRegistrationId}</td>
                                        <td>${reg.memberName}<br><small>${reg.memberPhone}</small></td>
                                        <td>${reg.ptDisplayName}</td>
                                        <td>${reg.packageName} (${reg.numberOfSessions} buổi)</td>
                                        <td>${reg.preferredStartDate}</td>
                                        <td><span class="badge bg-warning">Chờ thu tiền</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${reg.ptStatus == 'Inactive'}">
                                                    <button class="btn btn-sm btn-secondary disabled"
                                                            style="cursor: not-allowed;"
                                                            title="HLV này đã nghỉ việc hoặc bị khóa">
                                                        <i class="fa fa-lock me-1"></i> PT Đã Khóa
                                                    </button>
                                                    <div class="small text-danger mt-1">Yêu cầu đổi PT</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex gap-2">
                                                        <form action="${pageContext.request.contextPath}/admin/schedule/manage" method="POST" class="m-0" onsubmit="return confirm('Xác nhận đã thu tiền cho đơn #PT-${reg.ptRegistrationId}?');">
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="regId" value="${reg.ptRegistrationId}">
                                                            <button type="submit" class="btn btn-sm btn-success text-white" title="Xác nhận thanh toán">
                                                                <i class="fa fa-money-bill-wave me-1"></i> Thu tiền
                                                            </button>
                                                        </form>
                                                        <button type="button" 
                                                                class="btn btn-sm btn-danger" 
                                                                data-reg-id="${reg.ptRegistrationId}" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#cancelModal" 
                                                                title="Hủy đơn đăng ký">
                                                            <i class="fa fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Tab 2: PT Session Attendance -->
        <div class="tab-pane fade ${activeTabParam == 'attendance' ? 'show active' : ''}" id="attendance" role="tabpanel" aria-labelledby="attendance-tab">
            <div class="card border-0 shadow-sm p-4">
                <h5 class="text-dark fw-bold mb-3">
                    <i class="fa fa-user-check text-primary me-2"></i>Điểm danh ca dạy Huấn luyện viên
                </h5>
                
                <!-- Date Filter Form -->
                <form method="get" action="${pageContext.request.contextPath}/admin/schedule/manage" class="row g-3 align-items-end mb-4">
                    <input type="hidden" name="activeTab" value="attendance">
                    <div class="col-md-3 col-sm-6">
                        <label class="form-label fw-semibold">Chọn ngày xem lịch:</label>
                        <input type="date" name="date" class="form-control" value="${selectedDate}">
                    </div>
                    <div class="col-md-2 col-sm-6">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fa fa-search me-1"></i>Xem lịch
                        </button>
                    </div>
                </form>

                <c:choose>
                    <c:when test="${empty schedulesList}">
                        <div class="text-center py-5">
                            <i class="fa fa-calendar-times fa-3x mb-3 text-secondary d-block"></i>
                            <p class="text-muted">Không tìm thấy ca dạy nào được lên lịch cho ngày này.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Giờ tập</th>
                                        <th>Huấn luyện viên</th>
                                        <th>Chuyên môn</th>
                                        <th>Hội viên</th>
                                        <th>Gói dịch vụ</th>
                                        <th>Trạng thái ca tập</th>
                                        <th>Điểm danh HLV</th>
                                        <th class="text-center" style="width: 250px;">Thao tác điểm danh</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${schedulesList}">
                                        <tr>
                                            <td>
                                                <span class="badge bg-light text-dark border">
                                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> - 
                                                    <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
                                                </span>
                                            </td>
                                            <td class="fw-bold text-dark">${s.ptName}</td>
                                            <td>
                                                <span class="badge px-2 py-1" style="font-size: 0.8rem; background-color: #e0f7fa; color: #00838f;">
                                                    ${s.ptSpecialization}
                                                </span>
                                            </td>
                                            <td>${s.memberName}</td>
                                            <td>${s.packageName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.sessionStatus == 'Completed'}">
                                                        <span class="badge bg-success">Completed</span>
                                                    </c:when>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">
                                                        <span class="badge bg-danger">Cancelled</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">Upcoming</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.attendanceStatus == 'Attended'}">
                                                        <span class="badge bg-success"><i class="fa fa-check me-1"></i>Có mặt</span>
                                                    </c:when>
                                                    <c:when test="${s.attendanceStatus == 'Absent'}">
                                                        <span class="badge bg-danger"><i class="fa fa-times me-1"></i>Vắng mặt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary"><i class="fa fa-clock me-1"></i>Chờ</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">
                                                        <span class="text-muted small">Ca tập đã bị hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="d-flex justify-content-center gap-1">
                                                            <c:if test="${s.sessionStatus == 'Upcoming'}">
                                                                <button type="button" class="btn btn-xs btn-outline-primary py-1 px-2 fw-bold btn-substitute-pt" 
                                                                        data-id="${s.scheduleId}" 
                                                                        data-time="<fmt:formatDate value="${s.startTime}" pattern="HH:mm"/>" 
                                                                        data-member="${s.memberName}" 
                                                                        data-pt-id="${s.ptId}"
                                                                        data-pt-name="${s.ptName}"
                                                                        style="font-size: 0.75rem;">
                                                                    <i class="fa fa-user-edit me-1"></i>Thay PT
                                                                </button>
                                                            </c:if>
                                                            <c:choose>
                                                                <c:when test="${isFutureDate}">
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                                                                            <button type="button" class="btn btn-xs btn-outline-danger py-1 px-2 fw-bold btn-cancel-session" 
                                                                                    data-id="${s.scheduleId}" 
                                                                                    data-time="<fmt:formatDate value="${s.startTime}" pattern="HH:mm"/>" 
                                                                                    data-member="${s.memberName}" 
                                                                                    data-pt="${s.ptName}"
                                                                                    style="font-size: 0.75rem;">
                                                                                Hủy ca
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button type="button" class="btn btn-xs btn-outline-danger py-1 px-2 fw-bold" 
                                                                                    disabled title="Chỉ Admin mới có quyền hủy ca học"
                                                                                    style="font-size: 0.75rem;">
                                                                                Hủy ca
                                                                            </button>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:when test="${isPastDate}">
                                                                    <span class="text-muted small"><i class="fa fa-lock me-1"></i>Đã khóa lịch quá khứ</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                        <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                        <input type="hidden" name="status" value="Attended">
                                                                        <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Attended' ? 'btn-success' : 'btn-outline-success'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                            Có mặt
                                                                        </button>
                                                                    </form>
                                                                    <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                        <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                        <input type="hidden" name="status" value="Absent">
                                                                        <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Absent' ? 'btn-danger' : 'btn-outline-danger'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                            Vắng mặt
                                                                        </button>
                                                                    </form>
                                                                    <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                        <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                        <input type="hidden" name="status" value="Pending">
                                                                        <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Pending' ? 'btn-secondary' : 'btn-outline-secondary'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                            Chờ
                                                                        </button>
                                                                    </form>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Tab 3: Escalated Reschedule Requests -->
        <div class="tab-pane fade ${activeTabParam == 'reschedules' ? 'show active' : ''}" id="reschedules" role="tabpanel" aria-labelledby="reschedules-tab">
            <div class="card border-0 shadow-sm p-4">
                <h5 class="text-dark fw-bold mb-3">
                    <i class="fa fa-handshake text-primary me-2"></i>Danh sách yêu cầu hỗ trợ đổi lịch tập
                </h5>

                <c:choose>
                    <c:when test="${empty escalatedRequests}">
                        <div class="text-center py-5">
                            <p class="text-muted">Hiện tại không có yêu cầu hỗ trợ đổi lịch nào cần xử lý.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Thời gian gửi</th>
                                        <th>Hội viên</th>
                                        <th>Huấn luyện viên</th>
                                        <th>Gói tập</th>
                                        <th>Lịch gốc</th>
                                        <th>Lịch đề xuất mới</th>
                                        <th>Lý do đề xuất & hỗ trợ</th>
                                        <th class="text-center" style="width: 220px;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${escalatedRequests}">
                                        <tr>
                                            <td class="fw-bold">#RQ-${r.requestId}</td>
                                            <td><small class="fw-semibold text-secondary">${r.formattedCreatedDate}</small></td>
                                            <td>${r.memberName}</td>
                                            <td>${r.ptName}</td>
                                            <td><span class="badge bg-info text-dark">${r.packageName}</span></td>
                                            <td>
                                                <small class="text-muted">
                                                    Ngày: ${r.formattedOriginalDate}<br>
                                                    Giờ: ${r.formattedOriginalStartTime} - ${r.formattedOriginalEndTime}
                                                </small>
                                            </td>
                                            <td>
                                                <small class="text-danger fw-bold">
                                                    Ngày: ${r.formattedProposedDate}<br>
                                                    Giờ: ${r.formattedProposedStartTime} - ${r.formattedProposedEndTime}
                                                </small>
                                            </td>
                                            <td>
                                                <div><span class="fw-semibold small text-secondary">Đề xuất:</span> <span class="fst-italic">"${r.reason}"</span></div>
                                                <div class="mt-1"><span class="fw-semibold small text-warning">Yêu cầu hỗ trợ:</span> <strong class="text-dark fst-italic">"${r.escalationReason}"</strong></div>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2 justify-content-center">
                                                    <!-- Nút Đồng ý đổi lịch -->
                                                    <button type="button" class="btn btn-sm btn-success text-white btn-action-reschedule"
                                                            data-request-id="${r.requestId}"
                                                            data-action="approve"
                                                            title="Đồng ý cập nhật lịch mới">
                                                        <i class="fa fa-check me-1"></i> Duyệt đổi
                                                    </button>
                                                    <!-- Nút Từ chối hỗ trợ -->
                                                    <button type="button" class="btn btn-sm btn-danger btn-action-reschedule"
                                                            data-request-id="${r.requestId}"
                                                            data-action="reject"
                                                            title="Từ chối hỗ trợ và giữ lịch gốc">
                                                        <i class="fa fa-times me-1"></i> Từ chối
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%-- FORM ẨN ĐỂ XỬ LÝ HỖ TRỢ ĐỔI LỊCH --%>
<form id="respondRescheduleForm" action="${pageContext.request.contextPath}/reschedule-request/respond" method="POST" style="display:none;">
    <input type="hidden" name="requestId" id="rescheduleRequestId">
    <input type="hidden" name="action" id="rescheduleAction">
    <input type="hidden" name="responseReason" id="rescheduleResponseReason">
    <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/admin/schedule/manage?activeTab=reschedules">
</form>

<%-- KHU VỰC CHỨA SCRIPT THÔNG BÁO --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty sessionScope.toastMsg}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: 'success',
                title: 'Tuyệt vời!',
                text: '${sessionScope.toastMsg}',
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: 'top-end'
            });
        });
    </script>
    <c:remove var="toastMsg" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: '${sessionScope.errorMessage}',
                timer: 4000,
                showConfirmButton: true
            });
        });
    </script>
    <c:remove var="errorMessage" scope="session"/>
</c:if>

<%-- FORM ẨN ĐỂ HỦY CA HỌC --%>
<form id="cancelSessionForm" action="${pageContext.request.contextPath}/admin/schedule/cancel-session" method="POST" style="display:none;">
    <input type="hidden" name="scheduleId" id="cancelSessionId">
    <input type="hidden" name="cancelReason" id="cancelSessionReason">
</form>

<%-- MODAL HỦY ĐƠN ĐĂNG KÝ --%>
<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/pt/cancel" method="POST">
            <input type="hidden" name="regId" id="cancelRegId" value="">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-danger" id="cancelModalLabel">
                        <i class="fa fa-exclamation-triangle me-2"></i>Xác nhận hủy đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn muốn hủy đơn đăng ký <strong class="text-danger">#PT-<span id="cancelRegIdText"></span></strong>?</p>
                    <div class="mb-3">
                        <label for="cancelReason" class="form-label fw-bold">Lý do hủy đơn:</label>
                        <textarea name="cancelReason" id="cancelReason" class="form-control" rows="3" placeholder="Nhập lý do hủy đơn..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%-- MODAL PHÂN CÔNG PT THAY THẾ --%>
<div class="modal fade" id="substitutePTModal" tabindex="-1" aria-labelledby="substitutePTModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/schedule/manage" method="POST" id="substitutePTForm">
            <input type="hidden" name="action" value="substitute">
            <input type="hidden" name="scheduleId" id="substituteScheduleId" value="">
            <input type="hidden" name="date" value="${selectedDate}">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold" id="substitutePTModalLabel">
                        <i class="fa fa-user-edit me-2"></i>Phân công PT thay thế
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3 bg-light p-3 rounded text-dark">
                        <div><span class="fw-semibold text-secondary">Hội viên:</span> <strong id="substituteMemberName"></strong></div>
                        <div class="mt-1"><span class="fw-semibold text-secondary">Thời gian ca học:</span> <strong id="substituteSessionTime"></strong></div>
                        <div class="mt-1"><span class="fw-semibold text-secondary">PT hiện tại:</span> <strong id="substituteCurrentPTName" class="text-danger"></strong></div>
                    </div>
                    
                    <div class="mb-3 text-dark">
                        <label for="substitutePtId" class="form-label fw-bold">Chọn PT thay thế:</label>
                        <select name="substitutePtId" id="substitutePtId" class="form-select" required>
                            <option value="">-- Chọn Huấn luyện viên --</option>
                            <c:forEach var="pt" items="${activeTrainers}">
                                <option value="${pt.ptId}">${pt.displayName} (${pt.specialization})</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-3 text-dark">
                        <label for="substituteReason" class="form-label fw-bold">Lý do thay thế:</label>
                        <textarea name="reason" id="substituteReason" class="form-control" rows="3" placeholder="Nhập lý do thay thế huấn luyện viên..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Xác nhận thay PT</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const cancelModal = document.getElementById('cancelModal');
        if (cancelModal) {
            cancelModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const regId = button.getAttribute('data-reg-id');
                const modalInput = cancelModal.querySelector('#cancelRegId');
                const modalText = cancelModal.querySelector('#cancelRegIdText');
                
                modalInput.value = regId;
                modalText.textContent = regId;
            });
        }

        // JSTL handles active tab server-side via activeTabParam

        // Handle Admin/Staff Action on Reschedule Requests
        const rescheduleButtons = document.querySelectorAll(".btn-action-reschedule");
        rescheduleButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                const requestId = btn.getAttribute("data-request-id");
                const action = btn.getAttribute("data-action");
                const actionText = action === "approve" ? "phê duyệt lịch mới" : "từ chối hỗ trợ";
                const confirmColor = action === "approve" ? "#28a745" : "#dc3545";

                if (action === "approve") {
                    Swal.fire({
                        title: 'Xác nhận duyệt đổi lịch?',
                        text: 'Lịch học sẽ được cập nhật sang ngày giờ đề xuất mới.',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonText: 'Đồng ý',
                        cancelButtonText: 'Hủy bỏ',
                        confirmButtonColor: confirmColor,
                    }).then((result) => {
                        if (result.isConfirmed) {
                            document.getElementById("rescheduleRequestId").value = requestId;
                            document.getElementById("rescheduleAction").value = action;
                            document.getElementById("rescheduleResponseReason").value = "Admin/Staff phê duyệt hỗ trợ.";
                            document.getElementById("respondRescheduleForm").submit();
                        }
                    });
                } else {
                    // Reject needs a reason
                    Swal.fire({
                        title: 'Lý do từ chối hỗ trợ?',
                        input: 'text',
                        inputPlaceholder: 'Nhập lý do từ chối hỗ trợ...',
                        showCancelButton: true,
                        confirmButtonText: 'Từ chối',
                        cancelButtonText: 'Hủy bỏ',
                        confirmButtonColor: confirmColor,
                        inputValidator: (value) => {
                            if (!value || value.trim() === "") {
                                return 'Vui lòng nhập lý do từ chối!';
                            }
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            document.getElementById("rescheduleRequestId").value = requestId;
                            document.getElementById("rescheduleAction").value = action;
                            document.getElementById("rescheduleResponseReason").value = result.value;
                            document.getElementById("respondRescheduleForm").submit();
                        }
                    });
                }
            });
        });

        // Cancel session click handler
        const cancelSessionButtons = document.querySelectorAll(".btn-cancel-session");
        cancelSessionButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                var scheduleId = btn.getAttribute("data-id");
                var memberName = btn.getAttribute("data-member");
                var ptName = btn.getAttribute("data-pt");
                var sessionTime = btn.getAttribute("data-time");

                Swal.fire({
                    title: 'Hủy ca dạy học?',
                    text: 'Lịch dạy của HLV ' + ptName + ' cho hội viên ' + memberName + ' lúc ' + sessionTime,
                    input: 'text',
                    inputPlaceholder: 'Nhập lý do hủy ca học...',
                    showCancelButton: true,
                    confirmButtonText: 'Đồng ý hủy',
                    cancelButtonText: 'Hủy bỏ',
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    inputValidator: (value) => {
                        if (!value || value.trim() === "") {
                            return 'Vui lòng nhập lý do hủy lịch!';
                        }
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById("cancelSessionId").value = scheduleId;
                        document.getElementById("cancelSessionReason").value = result.value;
                        document.getElementById("cancelSessionForm").submit();
                    }
                });
            });
        });

        // Substitute PT click handler
        const substituteButtons = document.querySelectorAll(".btn-substitute-pt");
        const substitutePTModal = new bootstrap.Modal(document.getElementById('substitutePTModal'));
        substituteButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                const scheduleId = btn.getAttribute("data-id");
                const time = btn.getAttribute("data-time");
                const memberName = btn.getAttribute("data-member");
                const currentPtId = btn.getAttribute("data-pt-id");
                const currentPtName = btn.getAttribute("data-pt-name");

                document.getElementById("substituteScheduleId").value = scheduleId;
                document.getElementById("substituteMemberName").textContent = memberName;
                document.getElementById("substituteSessionTime").textContent = time;
                document.getElementById("substituteCurrentPTName").textContent = currentPtName;

                // Reset dropdown and hide current PT option
                const selectEl = document.getElementById("substitutePtId");
                selectEl.value = "";
                Array.from(selectEl.options).forEach(function(option) {
                    if (option.value === currentPtId) {
                        option.style.display = "none";
                    } else {
                        option.style.display = "";
                    }
                });

                document.getElementById("substituteReason").value = "";
                substitutePTModal.show();
            });
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>