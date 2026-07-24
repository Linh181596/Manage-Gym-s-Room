<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Page Header & Action Buttons -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-boxes me-2 text-primary"></i>Gói tập PT</h4>
            <small class="text-muted">Danh sách các gói tập thuê huấn luyện viên cá nhân cho hội viên</small>
        </div>
        <!-- Chỉ Admin mới được thêm mới gói PT -->
        <c:if test="${sessionScope.currentUser.role == 'Admin'}">
            <a href="${pageContext.request.contextPath}/admin/pt/packages?action=create"
                class="btn btn-primary d-flex align-items-center shadow-sm">
                <i class="fa fa-plus me-2"></i> Thêm gói tập PT mới
            </a>
        </c:if>
    </div>

    <!-- Feedback Message Display -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${param.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Filter Card -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row align-items-end g-3 justify-content-between">
            <div class="col-md-6 col-lg-4">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Lọc theo trạng thái</label>
                <select id="statusFilter" class="form-select" onchange="filterByStatus(this.value)">
                    <option value="All" ${selectedStatus == 'All' ? 'selected' : ''}>Tất cả trạng thái</option>
                    <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Hoạt động</option>
                    <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                </select>
            </div>
            <div class="col-md-4 col-lg-3 text-end">
                <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100" onclick="filterByStatus('All')">
                    <i class="fa fa-undo me-1"></i> Đặt lại bộ lọc
                </button>
            </div>
        </div>
    </div>

    <!-- Package List Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0" id="packageTable">
                <thead>
                    <tr class="text-dark bg-light-gradient">
                        <th scope="col" style="width: 80px;" class="text-center">Mã</th>
                        <th scope="col">Tên gói tập PT</th>
                        <th scope="col" class="text-center" style="width: 150px;">Hạn sử dụng</th>
                        <th scope="col" class="text-center" style="width: 150px;">Số ca tập</th>
                        <th scope="col" style="width: 140px;" class="text-center">Trạng thái</th>
                        <th scope="col" class="text-center" style="width: 240px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty packages}">
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">
                                    <i class="fa fa-box-open fa-3x mb-3 text-secondary d-block"></i>
                                    Không tìm thấy gói tập PT nào.
                                    <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                                        Nhấp "Thêm gói tập PT mới" để tạo.
                                    </c:if>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="pkg" items="${packages}">
                                <tr>
                                    <td class="fw-bold text-secondary text-center">PT-${pkg.ptPackageTypeId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${pkg.packageName}</div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 450px;">
                                            ${not empty pkg.description ? pkg.description : 'Không có mô tả.'}
                                        </small>
                                    </td>
                                    <td class="text-center fw-semibold text-dark">${pkg.durationMonths} Tháng</td>
                                    <td class="text-center fw-bold text-primary">${pkg.numberOfSessions} Buổi</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${pkg.status == 'Active'}">
                                                <span class="badge bg-success rounded-pill px-3 py-1 fw-medium shadow-sm-success">
                                                    <i class="fa fa-check-circle me-1"></i>Hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary rounded-pill px-3 py-1 fw-medium">
                                                    <i class="fa fa-times-circle me-1"></i>Ngừng hoạt động
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <!-- Nút Xem chi tiết dùng chung cho cả Admin & Staff -->
                                            <button type="button" class="btn btn-sm btn-outline-info" title="Xem chi tiết"
                                                data-id="PT-${pkg.ptPackageTypeId}"
                                                data-name="${pkg.packageName}"
                                                data-duration="${pkg.durationMonths} Tháng"
                                                data-sessions="${pkg.numberOfSessions} Buổi"
                                                data-status="${pkg.status}"
                                                data-desc="${pkg.description}"
                                                onclick="viewDetails(this)">
                                                <i class="fa fa-eye"></i> Chi tiết
                                            </button>
                                            
                                            <!-- Chỉ hiển thị nút Sửa & Xóa cho Admin -->
                                            <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                                                <a href="${pageContext.request.contextPath}/admin/pt/packages?action=edit&id=${pkg.ptPackageTypeId}"
                                                    class="btn btn-sm btn-outline-primary" title="Sửa cấu hình gói">
                                                    <i class="fa fa-edit"></i> Sửa
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger" title="Xóa gói"
                                                    data-id="${pkg.ptPackageTypeId}" data-name="${pkg.packageName}"
                                                    onclick="confirmDelete(this)">
                                                    <i class="fa fa-trash-alt"></i> Xóa
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Detail Modal (Dành cho cả Admin & Staff xem thông tin chi tiết) -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content shadow-lg border-0">
                <div class="modal-header bg-info text-white border-0 py-3">
                    <h5 class="modal-title" id="detailModalLabel">
                        <i class="fa fa-info-circle me-2"></i>Chi tiết Gói tập PT
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <!-- Left Panel: Summary Statistics Card -->
                        <div class="col-md-5">
                            <div class="card border-0 bg-light p-4 h-100 text-center rounded-3 shadow-sm">
                                <div class="mb-3">
                                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle mb-3" 
                                         style="width: 70px; height: 70px; background-color: rgba(13, 202, 240, 0.15); color: #0dcaf0;">
                                        <i class="fa fa-dumbbell fa-2x"></i>
                                    </div>
                                    <h4 class="fw-bold text-dark mb-1" id="detailPackageId">PT-XX</h4>
                                    <div id="detailStatusBadgeContainer" class="mt-2"></div>
                                </div>
                                <hr class="my-3 text-muted">
                                <div class="mb-3 text-start">
                                    <span class="text-muted small d-block"><i class="fa fa-calendar-alt me-1"></i> Hạn sử dụng dự kiến</span>
                                    <strong class="text-dark fs-5" id="detailDuration">0 Tháng</strong>
                                </div>
                                <div class="text-start">
                                    <span class="text-muted small d-block"><i class="fa fa-history me-1"></i> Tổng số ca tập luyện</span>
                                    <strong class="text-primary fs-4" id="detailSessions">0 Buổi</strong>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Panel: Description Card -->
                        <div class="col-md-7">
                            <div class="h-100 d-flex flex-column">
                                <span class="text-secondary small fw-bold uppercase mb-1">Tên gói tập</span>
                                <h5 class="text-dark fw-bold mb-3" id="detailPackageName">Tên gói tập PT</h5>
                                
                                <span class="text-secondary small fw-bold uppercase mb-1">Mô tả và quyền lợi dịch vụ</span>
                                <div class="card border border-2 rounded-3 p-3 flex-grow-1 bg-white" style="min-height: 180px; overflow-y: auto;">
                                    <p class="text-dark mb-0" id="detailDescription" style="white-space: pre-line; line-height: 1.6; font-size: 14px;">
                                        Không có mô tả chi tiết cho gói tập này.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light p-3">
                    <button type="button" class="btn btn-secondary px-4 shadow-sm" data-bs-dismiss="modal">Đóng cửa sổ</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal (Chỉ dành cho Admin) -->
    <c:if test="${sessionScope.currentUser.role == 'Admin'}">
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow-lg border-0">
                    <div class="modal-header bg-danger text-white border-0 py-3">
                        <h5 class="modal-title" id="deleteModalLabel"><i class="fa fa-exclamation-triangle me-2"></i>Xác nhận xóa gói PT</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <p class="mb-2">Bạn có chắc chắn muốn xóa cấu hình gói PT sau đây không?</p>
                        <h6 id="deletePackageName" class="text-dark fw-bold mb-3 fs-5">Tên gói tập PT</h6>
                        <p class="text-muted small mb-0"><i class="fa fa-info-circle me-1"></i> Lưu ý: Thao tác này thực hiện xóa mềm. Các học viên đang sử dụng gói tập này sẽ không bị ảnh hưởng, nhưng quản trị viên không thể gán giá mới cho PT dựa trên gói này.</p>
                    </div>
                    <div class="modal-footer border-0 bg-light p-3">
                        <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                        <a id="deleteConfirmBtn" href="#" class="btn btn-danger px-4 shadow-sm">Xóa gói PT</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Inline Script for Filtering and Modal -->
    <script>
        function filterByStatus(val) {
            window.location.href = "${pageContext.request.contextPath}/admin/pt/packages?status=" + val;
        }

        // Hàm xem chi tiết gói PT (dùng chung cho cả Admin và Staff)
        function viewDetails(button) {
            const id = button.getAttribute("data-id");
            const name = button.getAttribute("data-name");
            const duration = button.getAttribute("data-duration");
            const sessions = button.getAttribute("data-sessions");
            const status = button.getAttribute("data-status");
            const desc = button.getAttribute("data-desc");

            // Đưa dữ liệu vào Modal
            document.getElementById("detailPackageId").innerText = id;
            document.getElementById("detailPackageName").innerText = name;
            document.getElementById("detailDuration").innerText = duration;
            document.getElementById("detailSessions").innerText = sessions;

            // Xử lý mô tả
            const descEl = document.getElementById("detailDescription");
            if (desc && desc.trim() !== "") {
                descEl.innerText = desc;
            } else {
                descEl.innerHTML = '<span class="text-muted italic">Không có mô tả chi tiết cho gói tập này.</span>';
            }

            // Xử lý badge trạng thái
            const badgeContainer = document.getElementById("detailStatusBadgeContainer");
            if (status === "Active") {
                badgeContainer.innerHTML = '<span class="badge bg-success rounded-pill px-3 py-1 fw-medium shadow-sm-success"><i class="fa fa-check-circle me-1"></i>Hoạt động</span>';
            } else {
                badgeContainer.innerHTML = '<span class="badge bg-secondary rounded-pill px-3 py-1 fw-medium"><i class="fa fa-times-circle me-1"></i>Ngừng hoạt động</span>';
            }

            // Hiển thị modal
            const detailModal = new bootstrap.Modal(document.getElementById('detailModal'));
            detailModal.show();
        }

        function confirmDelete(button) {
            const id = button.getAttribute("data-id");
            const name = button.getAttribute("data-name");
            document.getElementById("deletePackageName").innerText = name;
            document.getElementById("deleteConfirmBtn").href = "${pageContext.request.contextPath}/admin/pt/packages?action=delete&id=" + id;

            const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }
    </script>

    <jsp:include page="../common/dashboard_footer.jsp" />
</div>
