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

    <!-- Navigation Tabs -->
    <ul class="nav nav-tabs border-bottom-0 mb-3" id="scheduleTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active fw-bold text-dark" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="true">
                <i class="fa fa-list-ul me-2 text-primary"></i>Yêu cầu chờ duyệt
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-bold text-dark" id="attendance-tab" data-bs-toggle="tab" data-bs-target="#attendance" type="button" role="tab" aria-controls="attendance" aria-selected="false">
                <i class="fa fa-clipboard-check me-2 text-primary"></i>Điểm danh ca dạy HLV
            </button>
        </li>
    </ul>

    <div class="tab-content" id="scheduleTabsContent">
        <!-- Tab 1: Pending Requests -->
        <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
            <div class="card border-0 shadow-sm p-4">
                <h5 class="text-dark fw-bold mb-3">
                    <i class="fa fa-list-ul text-primary me-2"></i>Yêu cầu đăng ký PT chờ duyệt
                </h5>

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
                                    <th>Ngày bắt đầu</th>
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
                                                        <a href="${pageContext.request.contextPath}/admin/pt/schedule-setup?regId=${reg.ptRegistrationId}"
                                                           class="btn btn-sm btn-info text-white" title="Xem chi tiết & xếp lịch">
                                                            <i class="fa fa-eye"></i>
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
        <div class="tab-pane fade" id="attendance" role="tabpanel" aria-labelledby="attendance-tab">
            <div class="card border-0 shadow-sm p-4">
                <h5 class="text-dark fw-bold mb-3">
                    <i class="fa fa-user-check text-primary me-2"></i>Điểm danh ca dạy Huấn luyện viên
                </h5>
                
                <!-- Date Filter Form -->
                <form method="get" action="${pageContext.request.contextPath}/admin/schedule/manage" class="row g-3 align-items-end mb-4">
                    <input type="hidden" name="activeTab" value="attendance">
                    <div class="col-md-3 col-sm-6">
                        <label class="form-label fw-semibold">Chọn ngày xem lịch:</label>
                        <input type="date" name="date" class="form-control" value="${selectedDate}" max="${todayDate}">
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
                                                            <!-- Attended Form -->
                                                            <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                <input type="hidden" name="status" value="Attended">
                                                                <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Attended' ? 'btn-success' : 'btn-outline-success'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                    Có mặt
                                                                </button>
                                                            </form>
                                                            
                                                            <!-- Absent Form -->
                                                            <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                <input type="hidden" name="status" value="Absent">
                                                                <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Absent' ? 'btn-danger' : 'btn-outline-danger'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                    Vắng mặt
                                                                </button>
                                                            </form>

                                                            <!-- Reset Pending Form -->
                                                            <form action="${pageContext.request.contextPath}/admin/schedule/attendance" method="post" class="m-0">
                                                                <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                                                                <input type="hidden" name="status" value="Pending">
                                                                <button type="submit" class="btn btn-xs ${s.attendanceStatus == 'Pending' ? 'btn-secondary' : 'btn-outline-secondary'} py-1 px-2 fw-bold" style="font-size: 0.75rem;">
                                                                    Chờ
                                                                </button>
                                                            </form>
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
<c:if test="${not empty sessionScope.toastMsg}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

        // Active tab on page reload
        const urlParams = new URLSearchParams(window.location.search);
        const activeTab = urlParams.get('activeTab');
        if (activeTab === 'attendance') {
            const attendanceTabButton = document.getElementById('attendance-tab');
            if (attendanceTabButton) {
                const triggerEl = new bootstrap.Tab(attendanceTabButton);
                triggerEl.show();
            }
        }
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>