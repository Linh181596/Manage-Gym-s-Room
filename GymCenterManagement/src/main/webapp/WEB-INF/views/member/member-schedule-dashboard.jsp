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
            <i class="fa fa-calendar-alt text-primary me-2"></i> Lịch Tập Của Tôi
        </h4>
        <div class="btn-group shadow-sm">
            <a href="${pageContext.request.contextPath}/member/schedule-dashboard?refDate=${prevWeekDate}"
               class="btn btn-outline-primary fw-bold">
                <i class="fa fa-chevron-left"></i> Tuần trước
            </a>
            <button class="btn btn-primary fw-bold px-4" disabled>
                Tuần này: ${weekStartStr} - ${weekEndStr}
            </button>
            <a href="${pageContext.request.contextPath}/member/schedule-dashboard?refDate=${nextWeekDate}"
               class="btn btn-outline-primary fw-bold">
                Tuần sau <i class="fa fa-chevron-right"></i>
            </a>
        </div>
    </div>

    <div class="row flex-nowrap overflow-auto pb-4" style="min-height: 600px;">
        <c:forEach var="entry" items="${scheduleMap}">
            <div class="col" style="min-width: 260px;">
                <div class="card h-100 shadow-sm border-0 bg-secondary bg-opacity-10">
                    <div class="card-header bg-dark text-white text-center fw-bold py-3 border-bottom-0 rounded-top">
                        ${entry.key}
                    </div>

                    <div class="card-body p-2">
                        <c:if test="${empty entry.value}">
                            <div class="text-center text-muted mt-4" style="font-size: 0.9rem;">
                                <i class="fa fa-calendar-minus fs-3 mb-2 opacity-50 text-secondary"></i><br>Không có lịch tập
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
                                                    <span class="badge bg-secondary ms-1">Chờ tập</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <h6 class="fw-bold text-dark mb-1">
                                        <i class="fa fa-user-tie text-secondary me-1"></i> PT: ${s.ptName}
                                    </h6>

                                    <div class="text-muted small">
                                        <i class="fa fa-dumbbell me-1"></i> Gói: ${s.packageName}
                                    </div>

                                    <c:choose>
                                        <c:when test="${empty s.rescheduleRequestId}">
                                            <c:if test="${s.sessionStatus == 'Upcoming'}">
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-primary mt-3 w-100 fw-bold"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#rescheduleModalMember_${s.scheduleId}">
                                                    <i class="fa fa-calendar-alt me-1"></i> Yêu cầu đổi lịch
                                                </button>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${s.rescheduleStatus == 'Pending'}">
                                                    <c:choose>
                                                        <c:when test="${s.rescheduleSenderUserId == sessionScope.currentUser.userId}">
                                                            <button type="button" class="btn btn-sm btn-info text-white mt-3 w-100 fw-bold"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#viewRescheduleModal_${s.scheduleId}">
                                                                <i class="fa fa-clock me-1"></i> Đang chờ phản hồi
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-sm btn-danger mt-3 w-100 fw-bold position-relative blink-btn"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#respondRescheduleModal_${s.scheduleId}">
                                                                <i class="fa fa-exclamation-circle me-1"></i> Có yêu cầu đổi lịch! 🔴
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:when test="${s.rescheduleStatus == 'Approved'}">
                                                     <div class="text-success small fw-bold text-center mt-2 mb-1"><i class="fa fa-check me-1"></i> Đã đổi lịch</div>
                                                     <c:if test="${s.sessionStatus == 'Upcoming'}">
                                                         <button type="button"
                                                                 class="btn btn-sm btn-outline-primary w-100 fw-bold"
                                                                 data-bs-toggle="modal"
                                                                 data-bs-target="#rescheduleModalMember_${s.scheduleId}">
                                                             <i class="fa fa-calendar-alt me-1"></i> Yêu cầu đổi tiếp
                                                         </button>
                                                     </c:if>
                                                 </c:when>
                                                <c:when test="${s.rescheduleStatus == 'Rejected'}">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary mt-3 w-100 fw-bold"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#viewRescheduleModal_${s.scheduleId}">
                                                        <i class="fa fa-times-circle me-1"></i> Đổi lịch bị từ chối
                                                    </button>
                                                </c:when>
                                                 <c:when test="${s.rescheduleStatus == 'Escalated'}">
                                                     <button type="button" class="btn btn-sm btn-warning text-dark mt-3 w-100 fw-bold"
                                                             data-bs-toggle="modal"
                                                             data-bs-target="#viewRescheduleModal_${s.scheduleId}">
                                                         <i class="fa fa-balance-scale me-1"></i> Chờ Admin hỗ trợ
                                                     </button>
                                                 </c:when>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>

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

<c:forEach var="entry" items="${scheduleMap}">
    <c:forEach var="s" items="${entry.value}">
        <c:if test="${(empty s.rescheduleRequestId || s.rescheduleStatus == 'Approved') && s.sessionStatus == 'Upcoming'}">
            <div class="modal fade" id="rescheduleModalMember_${s.scheduleId}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form method="post" action="${pageContext.request.contextPath}/reschedule-request/create">
                            <div class="modal-header">
                                <h5 class="modal-title fw-bold">Gửi yêu cầu đổi lịch tập</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/member/schedule-dashboard${not empty param.refDate ? '?refDate='.concat(param.refDate) : ''}">

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Ngày đề xuất mới</label>
                                    <input type="date" name="proposedDate" class="form-control reschedule-date-input" 
                                           data-schedule-id="${s.scheduleId}" 
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Khung giờ tập mới</label>
                                    <select name="proposedSlot" id="rescheduleProposedSlot_first_${s.scheduleId}" class="form-select reschedule-slot-select" required>
                                        <option value="">Chọn khung giờ</option>
                                        <option value="08:15-09:45">08:15 - 09:45</option>
                                        <option value="10:00-11:30">10:00 - 11:30</option>
                                        <option value="13:30-15:00">13:30 - 15:00</option>
                                        <option value="15:15-16:45">15:15 - 16:45</option>
                                        <option value="17:00-18:30">17:00 - 18:30</option>
                                        <option value="18:45-20:15">18:45 - 20:15</option>
                                    </select>
                                </div>

                                <div class="mb-0">
                                    <label class="form-label fw-semibold">Lý do xin đổi lịch</label>
                                    <textarea name="reason" class="form-control" rows="3" maxlength="255" required placeholder="Nhập lý do đổi lịch..."></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary fw-bold">Gửi yêu cầu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Modal: Xem chi tiết yêu cầu đổi lịch (Phía Người Gửi hoặc Đã Xử Lý) -->
        <c:if test="${not empty s.rescheduleRequestId}">
            <div class="modal fade" id="viewRescheduleModal_${s.scheduleId}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content border-info border-2">
                        <div class="modal-header bg-info text-white">
                            <h5 class="modal-title fw-bold"><i class="fa fa-info-circle me-1"></i> Chi tiết yêu cầu đổi lịch</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="p-3 bg-light rounded border mb-3">
                                <div class="fw-bold text-secondary mb-1">Lịch tập gốc:</div>
                                <div><i class="fa fa-calendar-day me-1"></i> Ngày: ${s.sessionDate}</div>
                                <div><i class="fa fa-clock me-1"></i> Giờ: ${s.startTime.toString().substring(0,5)} - ${s.endTime.toString().substring(0,5)}</div>
                            </div>

                            <div class="p-3 bg-warning bg-opacity-10 rounded border border-warning mb-3">
                                <div class="fw-bold text-dark mb-1">Đề xuất lịch mới:</div>
                                <div><i class="fa fa-calendar-check me-1"></i> Ngày mới: <strong class="text-danger">${s.rescheduleProposedDate}</strong></div>
                                <div><i class="fa fa-clock me-1"></i> Giờ mới: <strong class="text-danger">${s.rescheduleProposedStartTime.toString().substring(0,5)} - ${s.rescheduleProposedEndTime.toString().substring(0,5)}</strong></div>
                            </div>

                            <div class="mb-3">
                                <div class="fw-semibold">Lý do đề xuất:</div>
                                <div class="text-muted italic border-start border-3 ps-2 mt-1" style="font-style: italic;">
                                    "${s.rescheduleReason}"
                                </div>
                            </div>

                            <c:if test="${not empty s.rescheduleResponseReason}">
                                <div class="mb-3 p-3 bg-light border-start border-3 border-secondary rounded">
                                    <div class="fw-semibold text-secondary small">Ý kiến phản hồi:</div>
                                    <div class="text-dark italic mt-1" style="font-style: italic;">
                                        "${s.rescheduleResponseReason}"
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty s.rescheduleEscalationReason}">
                                <div class="mb-3 p-3 bg-light border-start border-3 border-warning rounded">
                                    <div class="fw-semibold text-warning small">Lý do yêu cầu hỗ trợ đổi lịch:</div>
                                    <div class="text-dark italic mt-1" style="font-style: italic;">
                                        "${s.rescheduleEscalationReason}"
                                    </div>
                                </div>
                            </c:if>

                            <div class="d-flex align-items-center mb-3">
                                <div class="fw-semibold me-2">Trạng thái:</div>
                                <span class="badge bg-${s.rescheduleStatus == 'Pending' ? 'info' : (s.rescheduleStatus == 'Approved' ? 'success' : (s.rescheduleStatus == 'Rejected' ? 'danger' : 'warning'))} px-3 py-2 fs-7">
                                    ${s.rescheduleStatus}
                                </span>
                            </div>

                            <c:if test="${s.rescheduleStatus == 'Rejected' && s.sessionStatus == 'Upcoming'}">
                                <hr>
                                <div class="fw-bold text-dark mb-2"><i class="fa fa-redo me-1"></i> Gửi lại yêu cầu đổi lịch mới:</div>
                                <form method="post" action="${pageContext.request.contextPath}/reschedule-request/create">
                                    <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                    <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/member/schedule-dashboard${not empty param.refDate ? '?refDate='.concat(param.refDate) : ''}">
                                    <div class="mb-2">
                                        <label class="form-label small fw-semibold">Ngày đề xuất mới</label>
                                        <input type="date" name="proposedDate" class="form-control form-control-sm reschedule-date-input" 
                                               data-schedule-id="${s.scheduleId}" 
                                               required>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label small fw-semibold">Khung giờ mới</label>
                                        <select name="proposedSlot" id="rescheduleProposedSlot_${s.scheduleId}" class="form-select form-select-sm reschedule-slot-select" required>
                                            <option value="">Chọn khung giờ</option>
                                            <option value="08:15-09:45">08:15 - 09:45</option>
                                            <option value="10:00-11:30">10:00 - 11:30</option>
                                            <option value="13:30-15:00">13:30 - 15:00</option>
                                            <option value="15:15-16:45">15:15 - 16:45</option>
                                            <option value="17:00-18:30">17:00 - 18:30</option>
                                            <option value="18:45-20:15">18:45 - 20:15</option>
                                        </select>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label small fw-semibold">Lý do</label>
                                        <textarea name="reason" class="form-control form-control-sm" rows="2" maxlength="255" required placeholder="Nhập lý do đổi lịch mới..."></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-sm btn-primary w-100 fw-bold">Gửi yêu cầu mới</button>
                                </form>
                            </c:if>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Modal: Phản hồi yêu cầu đổi lịch (Phía Người Nhận hoặc Staff/Admin) -->
        <c:if test="${not empty s.rescheduleRequestId && (s.rescheduleStatus == 'Pending' || s.rescheduleStatus == 'Escalated') && (s.rescheduleSenderUserId != sessionScope.currentUser.userId || sessionScope.currentUser.role == 'Staff' || sessionScope.currentUser.role == 'Admin')}">
            <div class="modal fade" id="respondRescheduleModal_${s.scheduleId}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content border-danger border-2">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title fw-bold">
                                <i class="fa fa-bell me-1"></i> 
                                <c:choose>
                                    <c:when test="${s.rescheduleStatus == 'Escalated'}">Staff/Admin Xử lý hỗ trợ đổi lịch</c:when>
                                    <c:otherwise>Xử lý yêu cầu đổi lịch tập</c:otherwise>
                                </c:choose>
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="p-3 bg-light rounded border mb-3">
                                <div class="fw-bold text-secondary mb-2" style="font-size: 1rem;">
                                    <i class="fa fa-calendar-day me-1"></i> Lịch tập gốc hiện tại:
                                </div>
                                <div class="text-dark">
                                    <span class="text-secondary fw-semibold">Ngày tập:</span> 
                                    <strong class="text-dark fs-6">${s.sessionDate}</strong>
                                </div>
                                <div class="text-dark mt-1">
                                    <span class="text-secondary fw-semibold">Khung giờ:</span> 
                                    <strong class="text-dark fs-6">${s.startTime.toString().substring(0,5)} - ${s.endTime.toString().substring(0,5)}</strong>
                                </div>
                            </div>

                            <div class="p-3 rounded border border-danger border-opacity-50 mb-3" style="background-color: #fff5f5;">
                                <div class="fw-bold text-danger mb-2" style="font-size: 1rem;">
                                    <i class="fa fa-calendar-check me-1"></i> Đề xuất đổi sang:
                                </div>
                                <div class="text-dark">
                                    <span class="text-secondary fw-semibold">Ngày mới:</span> 
                                    <strong class="text-danger fs-6">${s.rescheduleProposedDate}</strong>
                                </div>
                                <div class="text-dark mt-1">
                                    <span class="text-secondary fw-semibold">Giờ mới:</span> 
                                    <strong class="text-danger fs-6">${s.rescheduleProposedStartTime.toString().substring(0,5)} - ${s.rescheduleProposedEndTime.toString().substring(0,5)}</strong>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="fw-semibold">Lý do đề xuất:</div>
                                <div class="text-muted border-start border-3 ps-2 mt-1" style="font-style: italic;">
                                    "${s.rescheduleReason}"
                                </div>
                            </div>

                            <form method="post" action="${pageContext.request.contextPath}/reschedule-request/respond" class="w-100">
                                <input type="hidden" name="requestId" value="${s.rescheduleRequestId}">
                                <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/member/schedule-dashboard${not empty param.refDate ? '?refDate='.concat(param.refDate) : ''}">

                                <div class="mb-3">
                                    <label class="form-label fw-semibold text-dark">Ý kiến phản hồi / Lý do yêu cầu hỗ trợ (nếu từ chối/yêu cầu hỗ trợ)</label>
                                    <textarea name="responseReason" class="form-control" rows="2" placeholder="Nhập ý kiến hoặc lý do từ chối/yêu cầu hỗ trợ..."></textarea>
                                </div>

                                <div class="modal-footer bg-light px-0 pb-0">
                                    <div class="d-flex justify-content-between align-items-center w-100">
                                        <c:choose>
                                            <c:when test="${s.rescheduleStatus == 'Escalated'}">
                                                <span class="badge bg-warning text-dark"><i class="fa fa-balance-scale me-1"></i> Chờ Admin hỗ trợ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="submit" name="action" value="escalate" class="btn btn-warning fw-bold text-dark">
                                                    <i class="fa fa-balance-scale me-1"></i> Yêu cầu hỗ trợ đổi lịch
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger fw-bold me-2">
                                                <i class="fa fa-times me-1"></i> Từ chối
                                            </button>
                                            <button type="submit" name="action" value="approve" class="btn btn-success fw-bold">
                                                <i class="fa fa-check me-1"></i> Đồng ý đổi
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
</c:forEach>

<style>
    .hover-zoom {
        transition: transform 0.2s ease-in-out;
    }

    .hover-zoom:hover {
        transform: translateY(-3px);
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty sessionScope.toastMsg}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: "success",
                title: "Thành công!",
                text: "${sessionScope.toastMsg}",
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: "top-end"
            });
        });
    </script>
    <c:remove var="toastMsg" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: "error",
                title: "Thất bại",
                text: "${sessionScope.errorMessage}",
                timer: 3500,
                showConfirmButton: false,
                toast: true,
                position: "top-end"
            });
        });
    </script>
    <c:remove var="errorMessage" scope="session"/>
</c:if>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Validation for reschedule response form (Từ chối / Yêu cầu hỗ trợ)
        document.querySelectorAll('form[action$="/reschedule-request/respond"]').forEach(function (form) {
            form.addEventListener('submit', function (e) {
                const actionBtn = e.submitter;
                if (actionBtn && (actionBtn.value === 'escalate' || actionBtn.value === 'reject')) {
                    const textarea = form.querySelector('textarea[name="responseReason"]');
                    if (textarea && textarea.value.trim() === '') {
                        e.preventDefault();
                        Swal.fire({
                            icon: 'warning',
                            title: 'Lưu ý!',
                            text: 'Vui lòng nhập lý do phản hồi hoặc lý do yêu cầu hỗ trợ đổi lịch!',
                            confirmButtonText: 'Đồng ý'
                        });
                    }
                }
            });
        });
    });

    const busySchedules = [
        <c:forEach var="s" items="${allUpcomingSchedules}">
            <c:if test="${s.sessionStatus != 'Cancelled'}">
            {
                date: "${s.sessionDate}",
                slot: "${s.startTime.toString().substring(0,5)}-${s.endTime.toString().substring(0,5)}"
            },
            </c:if>
        </c:forEach>
    ];

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll('.reschedule-date-input').forEach(function (input) {
            input.addEventListener('change', function () {
                const date = this.value;
                const scheduleId = this.getAttribute('data-schedule-id');

                const selects = document.querySelectorAll(
                    '#rescheduleProposedSlot_' + scheduleId + 
                    ', #rescheduleProposedSlot_first_' + scheduleId
                );

                if (!date) {
                    selects.forEach(function (select) {
                        Array.from(select.options).forEach(function (opt) {
                            opt.disabled = false;
                            opt.text = opt.text.replace(/\s*\(.*\)/, '');
                        });
                    });
                    return;
                }

                const activeBusySlots = busySchedules
                    .filter(item => item.date === date)
                    .map(item => item.slot);

                selects.forEach(function (select) {
                    Array.from(select.options).forEach(function (opt) {
                        if (!opt.value) return;

                        let originalText = opt.getAttribute('data-original-text');
                        if (!originalText) {
                            originalText = opt.text.replace(/\s*\(.*\)/, '');
                            opt.setAttribute('data-original-text', originalText);
                        }

                        let isBusy = activeBusySlots.includes(opt.value);

                        if (isBusy) {
                            opt.disabled = true;
                            opt.text = originalText + ' (Trùng lịch ❌)';
                        } else {
                            opt.disabled = false;
                            opt.text = originalText;
                        }
                    });
                });
            });
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>
