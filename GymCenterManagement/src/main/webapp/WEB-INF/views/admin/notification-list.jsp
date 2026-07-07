<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-bell me-2 text-primary"></i>Quản lý thông báo</h4>
            <small class="text-muted">Tạo, hẹn giờ lên sóng, tự động ẩn và đính kèm ảnh cho thông báo</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/notifications?action=create"
           class="btn btn-primary d-flex align-items-center shadow-sm">
            <i class="fa fa-plus me-2"></i> Thêm thông báo mới
        </a>
    </div>

    <c:if test="${not empty errorMessage || not empty param.errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>
            <c:out value="${not empty errorMessage ? errorMessage : param.errorMessage}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i> <c:out value="${param.successMsg}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row align-items-end g-3">
            <div class="col-md-5">
                <label for="searchInput" class="form-label fw-bold text-secondary">Tìm kiếm thông báo</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="fa fa-search"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0"
                           placeholder="Tìm theo tiêu đề hoặc nội dung...">
                </div>
            </div>
            <div class="col-md-3">
                <label for="roleFilter" class="form-label fw-bold text-secondary">Vai trò nhận</label>
                <select id="roleFilter" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="All">Tất cả người dùng</option>
                    <option value="Admin">Quản trị viên</option>
                    <option value="Staff">Nhân viên</option>
                    <option value="Member">Hội viên</option>
                    <option value="PT">Huấn luyện viên</option>
                    <option value="Specific">Tài khoản cụ thể</option>
                </select>
            </div>
            <div class="col-md-2">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Trạng thái</label>
                <select id="statusFilter" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="Scheduled">Đã hẹn giờ</option>
                    <option value="Active">Đang hiển thị</option>
                    <option value="Expired">Đã tự ẩn</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100">
                    <i class="fa fa-undo me-1"></i> Đặt lại
                </button>
            </div>
        </div>
    </div>

    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0" id="notificationTable">
                <thead>
                    <tr class="text-dark">
                        <th scope="col" style="width: 90px;">Mã</th>
                        <th scope="col">Thông báo</th>
                        <th scope="col" style="width: 120px;" class="text-center">Vai trò</th>
                        <th scope="col" style="width: 120px;" class="text-center">Trạng thái</th>
                        <th scope="col" style="width: 170px;">Lên sóng</th>
                        <th scope="col" style="width: 170px;">Tự ẩn</th>
                        <th scope="col" style="width: 80px;" class="text-center">Ảnh</th>
                        <th scope="col" class="text-center" style="width: 170px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty notifications}">
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="fa fa-bell-slash fa-3x mb-3 text-secondary d-block"></i>
                                    Chưa có thông báo nào. Nhấn "Thêm thông báo mới" để tạo nội dung đầu tiên.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="notification" items="${notifications}">
                                <tr class="notification-row"
                                    data-role="${notification.targetRole}"
                                    data-status="${notification.effectiveStatus}"
                                    data-search="${fn:toLowerCase(notification.title)} ${fn:toLowerCase(notification.content)}">
                                    <td class="fw-bold text-secondary">NTF-${notification.notificationId}</td>
                                    <td>
                                        <div class="fw-bold text-dark"><c:out value="${notification.title}" /></div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 420px;">
                                            <c:out value="${notification.content}" />
                                        </small>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-primary rounded-pill px-3 py-1">
                                            <c:choose>
                                                <c:when test="${notification.targetRole == 'All'}">Tất cả</c:when>
                                                <c:when test="${notification.targetRole == 'Admin'}">Quản trị viên</c:when>
                                                <c:when test="${notification.targetRole == 'Staff'}">Nhân viên</c:when>
                                                <c:when test="${notification.targetRole == 'Member'}">Hội viên</c:when>
                                                <c:when test="${notification.targetRole == 'PT'}">Huấn luyện viên</c:when>
                                                <c:when test="${notification.targetRole == 'Specific'}">Tài khoản cụ thể</c:when>
                                                <c:otherwise><c:out value="${notification.targetRole}" /></c:otherwise>
                                            </c:choose>
                                        </span>
                                        <c:if test="${notification.targetRole == 'Specific'}">
                                            <small class="text-muted d-block mt-1 text-truncate" style="max-width: 160px;">
                                                <c:out value="${notification.recipientLabel}" />
                                            </small>
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${notification.effectiveStatus == 'Scheduled'}">
                                                <span class="badge bg-warning text-dark rounded-pill px-3 py-1">Đã hẹn giờ</span>
                                            </c:when>
                                            <c:when test="${notification.effectiveStatus == 'Expired'}">
                                                <span class="badge bg-secondary rounded-pill px-3 py-1">Đã tự ẩn</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success rounded-pill px-3 py-1">Đang hiển thị</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><small class="text-muted"><c:out value="${notification.publishDate}" /></small></td>
                                    <td>
                                        <small class="text-muted">
                                            <c:out value="${not empty notification.expiryDate ? notification.expiryDate : 'Không giới hạn'}" />
                                        </small>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty notification.notificationImageUrl}">
                                                <i class="fa fa-image text-primary" title="${notification.notificationImageUrl}"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/notifications?action=edit&id=${notification.notificationId}"
                                               class="btn btn-sm btn-outline-primary" title="Sửa thông báo">
                                                <i class="fa fa-edit"></i> Sửa
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger"
                                                    data-id="${notification.notificationId}"
                                                    data-title="${fn:escapeXml(notification.title)}"
                                                    onclick="confirmDelete(this)" title="Xóa thông báo">
                                                <i class="fa fa-trash-alt"></i> Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <jsp:include page="../common/pagination.jsp" />
    </div>

    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0">
                <div class="modal-header bg-danger text-white border-0 py-3">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="fa fa-exclamation-triangle me-2"></i>Xác nhận xóa thông báo
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="mb-2">Bạn có chắc chắn muốn xóa thông báo sau không?</p>
                    <h6 id="deleteNotificationTitle" class="text-dark fw-bold mb-3 fs-5">Tiêu đề thông báo</h6>
                    <p class="text-muted small mb-0">
                        <i class="fa fa-info-circle me-1"></i> Hệ thống sẽ xóa mềm bằng cách cập nhật IsDeleted = 1.
                    </p>
                </div>
                <div class="modal-footer border-0 bg-light p-3">
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                    <a id="deleteConfirmBtn" href="#" class="btn btn-danger px-4 shadow-sm">Xóa thông báo</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const searchInput = document.getElementById("searchInput");
        const roleFilter = document.getElementById("roleFilter");
        const statusFilter = document.getElementById("statusFilter");
        const resetFilters = document.getElementById("resetFilters");
        const rows = document.querySelectorAll(".notification-row");

        function filterTable() {
            const searchTerm = searchInput.value.toLowerCase().trim();
            const roleTerm = roleFilter.value;
            const statusTerm = statusFilter.value;

            rows.forEach(row => {
                const textMatch = row.getAttribute("data-search").includes(searchTerm);
                const roleMatch = roleTerm === "" || row.getAttribute("data-role") === roleTerm;
                const statusMatch = statusTerm === "" || row.getAttribute("data-status") === statusTerm;
                row.style.display = textMatch && roleMatch && statusMatch ? "" : "none";
            });
        }

        searchInput.addEventListener("input", filterTable);
        roleFilter.addEventListener("change", filterTable);
        statusFilter.addEventListener("change", filterTable);
        resetFilters.addEventListener("click", function () {
            searchInput.value = "";
            roleFilter.value = "";
            statusFilter.value = "";
            rows.forEach(row => row.style.display = "");
        });
    });

    function confirmDelete(button) {
        const id = button.getAttribute("data-id");
        const title = button.getAttribute("data-title");
        document.getElementById("deleteNotificationTitle").innerText = title;
        document.getElementById("deleteConfirmBtn").href =
            "${pageContext.request.contextPath}/admin/notifications?action=delete&id=" + id;

        const deleteModal = new bootstrap.Modal(document.getElementById("deleteConfirmModal"));
        deleteModal.show();
    }
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
