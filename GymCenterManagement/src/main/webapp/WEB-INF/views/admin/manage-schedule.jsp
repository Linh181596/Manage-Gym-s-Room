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
                                                        <a href="${pageContext.request.contextPath}/staff/record-payment?ptRegId=${reg.ptRegistrationId}" class="btn btn-sm btn-success text-white" title="Xác nhận thanh toán">
                                                            <i class="fa fa-money-bill-wave me-1"></i> Thu tiền
                                                        </a>
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
                
                <!-- Date Filter Form & Mass Cancel -->
                <div class="row g-3 align-items-end mb-4">
                    <div class="col-md-6 col-sm-12">
                        <form method="get" action="${pageContext.request.contextPath}/admin/schedule/manage" class="row g-2 align-items-end m-0">
                            <input type="hidden" name="activeTab" value="attendance">
                            <div class="col-8">
                                <label class="form-label fw-semibold">Chọn ngày xem lịch:</label>
                                <input type="date" name="date" class="form-control" value="${selectedDate}">
                            </div>
                            <div class="col-4">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fa fa-search me-1"></i>Xem lịch
                                </button>
                            </div>
                        </form>
                    </div>
                    <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                        <div class="col-md-3 col-sm-12 ms-auto">
                            <button type="button" class="btn btn-outline-danger w-100" data-bs-toggle="modal" data-bs-target="#massCancelModal">
                                <i class="fa fa-calendar-times me-1"></i>Hủy ca hàng loạt
                            </button>
                        </div>
                    </c:if>
                </div>

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
                                            <td class="text-dark">
                                                <span class="fw-bold">${s.ptName}</span>
                                                <c:if test="${not empty s.originalPtName}">
                                                    <div class="small text-muted mt-1" style="font-size: 0.75rem;">
                                                        (Dạy thay cho: <span class="text-decoration-line-through">${s.originalPtName}</span>)
                                                    </div>
                                                </c:if>
                                            </td>
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
                                                        <span class="badge bg-success">Đã hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${s.sessionStatus == 'Cancelled'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">Sắp diễn ra</span>
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
                                                         <div class="text-muted small mb-1">Ca tập đã bị hủy</div>
                                                         <c:choose>
                                                             <c:when test="${s.rescheduleStatus == 'Pending'}">
                                                                 <span class="badge bg-warning text-dark" style="font-size: 0.75rem;"><i class="fa fa-redo me-1"></i>Xếp bù: Đang chờ</span>
                                                             </c:when>
                                                             <c:when test="${s.rescheduleStatus == 'Approved'}">
                                                                 <div class="mt-1">
                                                                     <span class="badge bg-success" style="font-size: 0.75rem;" data-bs-toggle="tooltip" 
                                                                           title="Ca học bù đã được xếp vào ngày ${s.rescheduleProposedDate}">
                                                                         <i class="fa fa-check-circle me-1"></i>Đã xếp lịch lại
                                                                     </span>
                                                                     <div class="small text-success fw-bold mt-1" style="font-size: 0.75rem;">
                                                                         <i class="fa fa-calendar-alt me-1"></i>${s.rescheduleProposedDate}
                                                                         <br>
                                                                         <fmt:formatDate value="${s.rescheduleProposedStartTime}" pattern="HH:mm"/> - <fmt:formatDate value="${s.rescheduleProposedEndTime}" pattern="HH:mm"/>
                                                                     </div>
                                                                 </div>
                                                             </c:when>
                                                             <c:when test="${s.rescheduleStatus == 'Rejected'}">
                                                                 <span class="badge bg-secondary" style="font-size: 0.75rem;"><i class="fa fa-times me-1"></i>Xếp bù: Bị từ chối</span>
                                                             </c:when>
                                                             <c:otherwise>
                                                                 <span class="text-muted small" style="font-size: 0.75rem;">Chưa có yêu cầu xếp bù</span>
                                                             </c:otherwise>
                                                         </c:choose>
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


    </div>
</div>



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

    <c:if test="${sessionScope.currentUser.role == 'Admin'}">
        <!-- Modal: Hủy ca hàng loạt -->
        <div class="modal fade" id="massCancelModal" tabindex="-1" aria-labelledby="massCancelModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="post" action="${pageContext.request.contextPath}/admin/schedule/mass-cancel" onsubmit="return confirm('Bạn có chắc chắn muốn HỦY HÀNG LOẠT tất cả các ca tập sắp diễn ra trong ngày đã chọn? Thao tác này không thể hoàn tác!');">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title fw-bold" id="massCancelModalLabel">
                                <i class="fa fa-exclamation-triangle me-2"></i>Hủy Ca Dạy Hàng Loạt
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-warning small">
                                <i class="fa fa-info-circle me-1"></i> Chức năng này sẽ chuyển tất cả các ca dạy đang ở trạng thái <strong>Upcoming</strong> trong ngày được chọn sang trạng thái <strong>Cancelled</strong>. Các ca đã Hoàn thành hoặc đã Hủy sẽ không bị ảnh hưởng.
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Chọn ngày hủy:</label>
                                <input type="date" name="cancelDate" class="form-control" value="${selectedDate}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Chọn ca tập (Khung giờ):</label>
                                <select name="cancelSlot" class="form-select">
                                    <option value="All">Tất cả các ca trong ngày</option>
                                    <option value="08:15-09:45">08:15 - 09:45</option>
                                    <option value="10:00-11:30">10:00 - 11:30</option>
                                    <option value="13:30-15:00">13:30 - 15:00</option>
                                    <option value="15:15-16:45">15:15 - 16:45</option>
                                    <option value="17:00-18:30">17:00 - 18:30</option>
                                    <option value="18:45-20:15">18:45 - 20:15</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Lý do hủy hàng loạt:</label>
                                <textarea name="reason" class="form-control" rows="3" placeholder="Ví dụ: Phòng gym đóng cửa bảo trì thiết bị, nghỉ lễ đột xuất..." required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-danger fw-bold">Xác nhận Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

<jsp:include page="../common/dashboard_footer.jsp"/>