<%--
  =========================================================================
  Document : package-list.jsp Created on :
  2026-06-01 Author : Nguyễn Hoàng Thắng 
  Description : Danh sách các gói tập của phòng gym dành cho Admin quản lý
  =========================================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Page Header & Action Buttons -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-box me-2 text-primary"></i>Gói tập Gym
            </h4>
            <small class="text-muted">Quản lý các gói tập và bảng giá thẻ thành viên cho hội viên phòng
                tập</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/packages?action=create"
            class="btn btn-primary d-flex align-items-center shadow-sm">
            <i class="fa fa-plus me-2"></i> Thêm gói tập mới
        </a>
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

    <!-- Search & Filter Card -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row align-items-end g-3">
            <div class="col-md-6 col-lg-7">
                <label for="searchInput" class="form-label fw-bold text-secondary">Tìm kiếm gói
                    tập</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i
                        class="fa fa-search"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0"
                        placeholder="Tìm theo tên hoặc mô tả...">
                </div>
            </div>
            <div class="col-md-4 col-lg-3">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Lọc theo trạng
                    thái</label>
                <select id="statusFilter" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Active">Hoạt động</option>
                    <option value="Inactive">Ngừng hoạt động</option>
                </select>
            </div>
            <div class="col-md-2 col-lg-2">
                <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100"><i
                        class="fa fa-undo me-1"></i> Đặt lại</button>
            </div>
        </div>
    </div>

    <!-- Package List Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0"
                id="packageTable">
                <thead>
                    <tr class="text-dark bg-light-gradient">
                        <th scope="col" style="width: 80px;">Mã</th>
                        <th scope="col">Tên gói tập</th>
                        <th scope="col" class="text-center" style="width: 150px;">Thời hạn (Tháng)</th>
                        <th scope="col" class="text-end" style="width: 180px;">Giá tiền (VND)</th>
                        <th scope="col" style="width: 120px;" class="text-center">Trạng thái</th>
                        <th scope="col" class="text-center" style="width: 180px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty packages}">
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">
                                    <i class="fa fa-box-open fa-3x mb-3 text-secondary d-block"></i>
                                    Không tìm thấy gói tập gym nào. Nhấp "Thêm gói tập mới" để tạo.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="pkg" items="${packages}">
                                <tr class="package-row"
                                    data-name="${pkg.packageName.toLowerCase()} ${pkg.description.toLowerCase()}"
                                    data-status="${pkg.status}">
                                    <td class="fw-bold text-secondary">PKG-${pkg.packageId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${pkg.packageName}</div>
                                        <small class="text-muted d-block text-truncate"
                                            style="max-width: 350px;">
                                            ${not empty pkg.description ? pkg.description : 'Không có mô
                                            tả.'}
                                        </small>
                                    </td>
                                    <td class="text-center fw-semibold text-dark">${pkg.durationMonths}
                                        Tháng</td>
                                    <td class="text-end fw-bold text-primary">
                                        <fmt:formatNumber value="${pkg.price}" type="currency"
                                            currencySymbol="₫" maxFractionDigits="0" />
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${pkg.status == 'Active'}">
                                                <span
                                                    class="badge bg-success rounded-pill px-3 py-1 fw-medium shadow-sm-success"><i
                                                        class="fa fa-check-circle me-1"></i>Hoạt
                                                    động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="badge bg-secondary rounded-pill px-3 py-1 fw-medium"><i
                                                        class="fa fa-times-circle me-1"></i>Ngừng hoạt
                                                    động</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/packages?action=edit&id=${pkg.packageId}"
                                                class="btn btn-sm btn-outline-primary"
                                                title="Sửa gói tập">
                                                <i class="fa fa-edit"></i> Sửa
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger"
                                                title="Xóa gói tập"
                                                data-id="${pkg.packageId}"
                                                data-name="${pkg.packageName}"
                                                onclick="confirmDelete(this)">
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
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0">
                <div class="modal-header bg-danger text-white border-0 py-3">
                    <h5 class="modal-title" id="deleteModalLabel"><i
                            class="fa fa-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="mb-2">Bạn có chắc chắn muốn xóa gói tập sau đây không?</p>
                    <h6 id="deletePackageName" class="text-dark fw-bold mb-3 fs-5">Tên gói tập</h6>
                    <p class="text-muted small mb-0"><i class="fa fa-info-circle me-1"></i> Lưu ý: Hành động
                        này thực hiện xóa mềm. Các lượt đăng ký đang hoạt động sử dụng gói này vẫn tiếp tục
                        duy trì, nhưng không thể đăng ký mới bằng gói này.</p>
                </div>
                <div class="modal-footer border-0 bg-light p-3">
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                    <a id="deleteConfirmBtn" href="#" class="btn btn-danger px-4 shadow-sm">Xóa gói tập</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Premium Micro-interactions / Client Filters -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchInput = document.getElementById("searchInput");
            const statusFilter = document.getElementById("statusFilter");
            const resetFilters = document.getElementById("resetFilters");
            const rows = document.querySelectorAll(".package-row");

            function filterTable() {
                const searchTerm = searchInput.value.toLowerCase().trim();
                const statusTerm = statusFilter.value;

                rows.forEach(row => {
                    const textMatch = row.getAttribute("data-name").includes(searchTerm);
                    const statusMatch = statusTerm === "" || row.getAttribute("data-status") === statusTerm;

                    if (textMatch && statusMatch) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }

            searchInput.addEventListener("input", filterTable);
            statusFilter.addEventListener("change", filterTable);

            resetFilters.addEventListener("click", function () {
                searchInput.value = "";
                statusFilter.value = "";
                rows.forEach(row => row.style.display = "");
            });
        });

        function confirmDelete(button) {
            const id = button.getAttribute("data-id");
            const name = button.getAttribute("data-name");
            document.getElementById("deletePackageName").innerText = name;
            document.getElementById("deleteConfirmBtn").href = "${pageContext.request.contextPath}/admin/packages?action=delete&id=" + id;

            const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }
    </script>

    <jsp:include page="../common/dashboard_footer.jsp" />