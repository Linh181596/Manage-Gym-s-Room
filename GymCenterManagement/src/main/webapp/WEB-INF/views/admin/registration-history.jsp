<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:if test="${not empty sessionScope.toastMsg}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var msg = "${sessionScope.toastMsg}";
            var icon = "success";
            if (msg.includes("không") || msg.includes("Lỗi") || msg.includes("Chỉ Admin") || msg.includes("Không")) {
                icon = "error";
            }
            Swal.fire({
                icon: icon,
                title: msg,
                showConfirmButton: true,
                timer: 3000
            });
        });
    </script>
    <c:remove var="toastMsg" scope="session"/>
</c:if>

<div class="container-fluid pt-4 px-4">
    <!-- Header -->
    <div class="d-flex align-items-center justify-content-between mb-4 bg-white p-3 rounded shadow-sm border">
        <div>
            <h4 class="mb-1 text-dark fw-bold">
                <i class="fa fa-history me-2 text-primary"></i>Lịch sử duyệt đơn đăng ký PT
            </h4>
            <small class="text-muted">Danh sách các đơn đăng ký dịch vụ Personal Trainer đã được xử lý (Tổng số: ${totalCount} đơn)</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/schedule/manage" class="btn btn-outline-secondary btn-sm shadow-sm">
            <i class="fa fa-arrow-left me-1"></i> Quay lại Duyệt lịch
        </a>
    </div>

    <!-- Main List Card -->
    <div class="card border-0 shadow-sm p-4">
        <c:choose>
            <c:when test="${empty historyList}">
                <div class="text-center py-5 text-muted">
                    <i class="fa fa-folder-open fa-3x mb-3 d-block text-secondary"></i>
                    <p class="mb-0">Chưa có lịch sử duyệt đơn đăng ký nào.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 10%;">Mã đơn</th>
                                <th style="width: 25%;">Hội viên</th>
                                <th style="width: 20%;">HLV yêu cầu</th>
                                <th style="width: 15%;">Tình trạng đơn</th>
                                <th style="width: 15%;">Ngày xử lý</th>
                                <th style="width: 15%;" class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reg" items="${historyList}">
                                <tr>
                                    <td class="fw-bold">#PT-${reg.ptRegistrationId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${reg.memberName}</div>
                                        <small class="text-muted"><i class="fa fa-phone me-1"></i>${reg.memberPhone}</small>
                                    </td>
                                    <td>
                                        <span class="text-dark">${reg.ptDisplayName}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${reg.status == 'Active'}">
                                                <span class="badge bg-success px-2.5 py-1.5"><i class="fa fa-check-circle me-1"></i>Hoạt động</span>
                                            </c:when>
                                            <c:when test="${reg.status == 'Cancelled'}">
                                                <span class="badge bg-danger px-2.5 py-1.5"><i class="fa fa-times-circle me-1"></i>Đã hủy</span>
                                            </c:when>
                                            <c:when test="${reg.status == 'Completed'}">
                                                <span class="badge bg-info text-white px-2.5 py-1.5"><i class="fa fa-flag me-1"></i>Hoàn thành</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary px-2.5 py-1.5">${reg.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="text-muted small">${reg.formattedProcessedAt}</span>
                                    </td>
                                    <td class="text-center">
                                        <button type="button" class="btn btn-sm btn-outline-primary shadow-sm btn-view-detail"
                                                data-id="${reg.ptRegistrationId}"
                                                data-member-name="${reg.memberName}"
                                                data-member-phone="${reg.memberPhone}"
                                                data-pt-name="${reg.ptDisplayName}"
                                                data-package="${reg.packageName}"
                                                data-sessions="${reg.numberOfSessions}"
                                                data-start-date="${reg.formattedPreferredStartDate}"
                                                data-amount="<fmt:formatNumber value='${reg.totalAmount}' type='currency' currencySymbol='₫' maxFractionDigits='0'/>"
                                                data-status="${reg.status}"
                                                data-payment-status="${reg.paymentStatus}"
                                                data-note="${reg.note}"
                                                data-processed-by="${empty reg.processedByUserName ? 'Hệ thống' : reg.processedByUserName}"
                                                data-processed-at="${reg.formattedProcessedAt}">
                                            <i class="fa fa-eye me-1"></i>Chi tiết
                                        </button>
                                        <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                                            <form action="${pageContext.request.contextPath}/admin/schedule/registration-delete" method="POST" class="d-inline ms-1 delete-form">
                                                <input type="hidden" name="regId" value="${reg.ptRegistrationId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger shadow-sm btn-delete" 
                                                        ${reg.status == 'Active' ? 'disabled title="Không thể xóa đơn đang hoạt động"' : 'title="Xóa đơn hàng vĩnh viễn"'}>
                                                    <i class="fa fa-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center m-0">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link shadow-sm" href="${pageContext.request.contextPath}/admin/schedule/registration-history?page=${currentPage - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo; Trang trước</span>
                                </a>
                            </li>
                            <c:forEach var="p" begin="1" end="${totalPages}">
                                <li class="page-item ${p == currentPage ? 'active' : ''}">
                                    <a class="page-link shadow-sm" href="${pageContext.request.contextPath}/admin/schedule/registration-history?page=${p}">${p}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link shadow-sm" href="${pageContext.request.contextPath}/admin/schedule/registration-history?page=${currentPage + 1}" aria-label="Next">
                                    <span aria-hidden="true">Trang sau &raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- View Detail Modal -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-dark text-white py-3">
                <h5 class="modal-title fw-bold" id="detailModalLabel">
                    <i class="fa fa-info-circle text-primary me-2"></i>Chi Tiết Đơn Đăng Ký PT #PT-<span id="modal-reg-id"></span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 bg-light">
                <div class="row g-3">
                    <!-- Section 1: Member Info -->
                    <div class="col-md-6">
                        <div class="p-3 bg-white rounded shadow-sm border h-100">
                            <h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
                                <i class="fa fa-user me-1"></i> Thông tin Hội viên
                            </h6>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Tên hội viên</label>
                                <input type="text" id="modal-member-name" class="form-control-plaintext fw-bold text-dark p-0" readonly>
                            </div>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Số điện thoại</label>
                                <input type="text" id="modal-member-phone" class="form-control-plaintext text-dark p-0" readonly>
                            </div>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Gói đăng ký</label>
                                <input type="text" id="modal-package" class="form-control-plaintext text-dark p-0" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Section 2: PT & Booking Info -->
                    <div class="col-md-6">
                        <div class="p-3 bg-white rounded shadow-sm border h-100">
                            <h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
                                <i class="fa fa-dumbbell me-1"></i> Yêu cầu Huấn luyện
                            </h6>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Huấn luyện viên (PT)</label>
                                <input type="text" id="modal-pt-name" class="form-control-plaintext fw-bold text-dark p-0" readonly>
                            </div>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Ngày mong muốn bắt đầu</label>
                                <input type="text" id="modal-start-date" class="form-control-plaintext text-dark p-0" readonly>
                            </div>
                            <div class="mb-2">
                                <label class="text-muted small d-block">Tổng chi phí gói</label>
                                <input type="text" id="modal-amount" class="form-control-plaintext fw-bold text-primary p-0" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Section 3: Status & Auditing -->
                    <div class="col-12 mt-3">
                        <div class="p-3 bg-white rounded shadow-sm border">
                            <h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
                                <i class="fa fa-tasks me-1"></i> Trạng thái & Xử lý đơn
                            </h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="text-muted small d-block mb-1">Tình trạng đơn</label>
                                    <span id="modal-status-badge"></span>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="text-muted small d-block mb-1">Trạng thái thanh toán</label>
                                    <span id="modal-payment-badge"></span>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="text-muted small d-block">Người xử lý đơn</label>
                                    <input type="text" id="modal-processed-by" class="form-control-plaintext text-dark p-0" readonly>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="text-muted small d-block">Thời điểm xử lý</label>
                                    <input type="text" id="modal-processed-at" class="form-control-plaintext text-dark p-0" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section 4: Notes / Cancellation Reasons -->
                    <div class="col-12 mt-3">
                        <div class="p-3 bg-white rounded shadow-sm border">
                            <h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
                                <i class="fa fa-comment-alt me-1"></i> Ghi chú / Lý do hủy
                            </h6>
                            <textarea id="modal-note" class="form-control bg-light border-0" rows="3" readonly style="resize: none;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer bg-light py-2">
                <button type="button" class="btn btn-secondary px-4 fw-bold shadow-sm" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var detailButtons = document.querySelectorAll(".btn-view-detail");
        detailButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                document.getElementById("modal-reg-id").innerText = btn.getAttribute("data-id");
                document.getElementById("modal-member-name").value = btn.getAttribute("data-member-name");
                document.getElementById("modal-member-phone").value = btn.getAttribute("data-member-phone");
                document.getElementById("modal-pt-name").value = btn.getAttribute("data-pt-name");
                document.getElementById("modal-package").value = btn.getAttribute("data-package") + " (" + btn.getAttribute("data-sessions") + " buổi)";
                document.getElementById("modal-start-date").value = btn.getAttribute("data-start-date");
                document.getElementById("modal-amount").value = btn.getAttribute("data-amount");
                
                var status = btn.getAttribute("data-status");
                var statusBadge = document.getElementById("modal-status-badge");
                statusBadge.className = "badge px-3 py-2 ";
                if (status === 'Active') {
                    statusBadge.className += "bg-success";
                    statusBadge.innerHTML = "<i class='fa fa-check-circle me-1'></i>Hoạt động (Active)";
                } else if (status === 'Cancelled') {
                    statusBadge.className += "bg-danger";
                    statusBadge.innerHTML = "<i class='fa fa-times-circle me-1'></i>Đã hủy (Cancelled)";
                } else if (status === 'Completed') {
                    statusBadge.className += "bg-info text-white";
                    statusBadge.innerHTML = "<i class='fa fa-flag me-1'></i>Hoàn thành (Completed)";
                } else {
                    statusBadge.className += "bg-secondary";
                    statusBadge.innerText = status;
                }

                var payStatus = btn.getAttribute("data-payment-status");
                var payBadge = document.getElementById("modal-payment-badge");
                payBadge.className = "badge px-3 py-2 ";
                if (payStatus === 'Paid') {
                    payBadge.className += "bg-success";
                    payBadge.innerHTML = "<i class='fa fa-wallet me-1'></i>Đã thanh toán (Paid)";
                } else if (payStatus === 'Cancelled') {
                    payBadge.className += "bg-danger";
                    payBadge.innerHTML = "<i class='fa fa-times-circle me-1'></i>Đã hủy (Cancelled)";
                } else {
                    payBadge.className += "bg-warning text-dark";
                    payBadge.innerHTML = "<i class='fa fa-exclamation-circle me-1'></i>Chưa thanh toán (Unpaid)";
                }

                document.getElementById("modal-processed-by").value = btn.getAttribute("data-processed-by");
                document.getElementById("modal-processed-at").value = btn.getAttribute("data-processed-at");
                document.getElementById("modal-note").value = btn.getAttribute("data-note") || "Không có ghi chú";

                var myModal = new bootstrap.Modal(document.getElementById('detailModal'));
                myModal.show();
            });
        });

        // SweetAlert2 confirmation for permanent delete
        var deleteForms = document.querySelectorAll(".delete-form");
        deleteForms.forEach(function(form) {
            form.addEventListener("submit", function(event) {
                event.preventDefault();
                Swal.fire({
                    title: 'Xác nhận xóa vĩnh viễn?',
                    text: "Hành động này sẽ xóa đơn đăng ký này ra khỏi lịch sử và không thể khôi phục lại!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Đồng ý xóa',
                    cancelButtonText: 'Hủy bỏ'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
