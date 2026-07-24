<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold">
                <i class="fa fa-newspaper me-2 text-primary"></i>Nội dung công khai
            </h4>
        </div>
        <a href="${pageContext.request.contextPath}/staff/public-content?action=create" class="btn btn-primary shadow-sm">
            <i class="fa fa-plus me-2"></i>Thêm nội dung
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i>${param.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row g-3 align-items-end">
            <div class="col-lg-6">
                <label for="contentSearch" class="form-label fw-bold text-secondary">Tìm kiếm nội dung</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="fa fa-search text-muted"></i></span>
                    <%-- Ô nhập liệu tìm kiếm theo từ khóa (tiêu đề, mô tả, danh mục) --%>
                    <input id="contentSearch" type="text" class="form-control border-start-0"
                           placeholder="Tìm theo tiêu đề, mô tả hoặc danh mục...">
                </div>
            </div>
            <div class="col-md-4 col-lg-2">
                <label for="typeFilter" class="form-label fw-bold text-secondary">Loại</label>
                <select id="typeFilter" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="BLOG">Blog</option>
                    <option value="POLICY">Chính sách</option>
                </select>
            </div>
            <div class="col-md-4 col-lg-2">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Trạng thái</label>
                <select id="statusFilter" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="Draft">Bản nháp</option>
                    <option value="Published">Đã đăng</option>
                    <option value="Hidden">Đã ẩn</option>
                </select>
            </div>
            <div class="col-md-4 col-lg-2">
                <%-- Nút reset tất cả các bộ lọc về mặc định --%>
                <button id="resetFilters" type="button" class="btn btn-outline-secondary w-100">
                    <i class="fa fa-undo me-1"></i>Đặt lại
                </button>
            </div>
        </div>
    </div>

    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead>
                    <tr class="text-dark">
                        <th style="width: 82px;">Mã</th>
                        <th style="width: 110px;">Ảnh</th>
                        <th>Nội dung</th>
                        <th style="width: 130px;">Loại</th>
                        <th style="width: 170px;">Danh mục</th>
                        <th style="width: 135px;">Trạng thái</th>
                        <th style="width: 190px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty contents}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-5">
                                    <i class="fa fa-file-alt fa-3x mb-3 d-block text-secondary"></i>
                                    Chưa có nội dung công khai.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${contents}">
                                <tr class="content-row"
                                    data-type="${item.contentType}"
                                    data-status="${item.status}"
                                    data-search="PC-${item.contentId} ${item.contentId} ${fn:escapeXml(item.title)} ${fn:escapeXml(item.summary)} ${fn:escapeXml(item.category)}">
                                    <td class="fw-bold text-secondary">PC-${item.contentId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.contentType == 'BLOG' and not empty item.thumbnailUrl}">
                                                <img src="${pageContext.request.contextPath}/${item.thumbnailUrl}"
                                                     alt="${fn:escapeXml(item.title)}" class="rounded border"
                                                     style="width: 86px; height: 58px; object-fit: cover;">
                                            </c:when>
                                            <c:when test="${item.contentType == 'BLOG'}">
                                                <span class="text-muted">--</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">--</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark"><c:out value="${item.title}" /></div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 420px;">
                                            <c:out value="${item.summary}" />
                                        </small>
                                    </td>
                                    <td>
                                        <span class="badge ${item.contentType == 'BLOG' ? 'bg-info' : 'bg-warning text-dark'} rounded-pill px-3">
                                            ${item.contentType == 'BLOG' ? 'Blog' : 'Chính sách'}
                                        </span>
                                    </td>
                                    <td><c:out value="${item.category}" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.status == 'Published'}">
                                                <span class="badge bg-success rounded-pill px-3">Đã đăng</span>
                                            </c:when>
                                            <c:when test="${item.status == 'Hidden'}">
                                                <span class="badge bg-secondary rounded-pill px-3">Đã ẩn</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-dark border rounded-pill px-3">Bản nháp</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group">
                                            <%-- Nút chuyển hướng sang form sửa nội dung --%>
                                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/staff/public-content?action=edit&id=${item.contentId}">
                                                <i class="fa fa-edit"></i> Sửa
                                            </a>
                                            <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                                                <%-- Nút xóa mềm (xóa logic) nội dung, yêu cầu xác nhận alert --%>
                                                <a class="btn btn-sm btn-outline-danger"
                                                   href="${pageContext.request.contextPath}/staff/public-content?action=delete&id=${item.contentId}"
                                                   onclick="return confirm('Bạn có chắc muốn xóa mềm nội dung này?');">
                                                    <i class="fa fa-trash"></i> Xóa
                                                </a>
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
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const searchInput = document.getElementById("contentSearch");
        const typeFilter = document.getElementById("typeFilter");
        const statusFilter = document.getElementById("statusFilter");
        const resetButton = document.getElementById("resetFilters");
        const rows = document.querySelectorAll(".content-row");

        function filterRows() {
            // Lấy từ khóa và chuyển thành chữ thường để tìm kiếm không phân biệt hoa thường
            const keyword = (searchInput.value || "").toLowerCase().trim();
            const type = typeFilter.value;
            const status = statusFilter.value;

            // Lặp qua từng dòng nội dung và so sánh dữ liệu với các bộ lọc
            rows.forEach(row => {
                const rowText = (row.dataset.search || "").toLowerCase();
                const matchesText = !keyword || rowText.includes(keyword);
                const matchesType = !type || row.dataset.type === type;
                const matchesStatus = !status || row.dataset.status === status;
                
                // Ẩn/Hiện thẻ dòng tương ứng với kết quả lọc
                row.style.display = matchesText && matchesType && matchesStatus ? "" : "none";
            });
        }

        searchInput.addEventListener("input", filterRows);
        typeFilter.addEventListener("change", filterRows);
        statusFilter.addEventListener("change", filterRows);
        resetButton.addEventListener("click", function () {
            searchInput.value = "";
            typeFilter.value = "";
            statusFilter.value = "";
            filterRows();
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
