<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : account-list.jsp
  Created on  : 2026-06-25
  Author      : Nguyễn Đại Dương (duongnd)
  Description : Giao diện danh sách tài khoản người dùng cho quản trị viên (Admin).
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-users-cog me-2 text-primary"></i>Quản lý tài khoản</h4>
            <small class="text-muted">Tìm kiếm, tạo, cập nhật, khóa, mở khóa, đặt lại mật khẩu và vô hiệu hóa tài khoản.</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/accounts?action=create" class="btn btn-primary d-flex align-items-center shadow-sm">
            <i class="fa fa-user-plus me-2"></i>Tạo tài khoản
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty temporaryPassword}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <div class="fw-bold mb-1"><i class="fa fa-key me-2"></i>Thông tin đăng nhập tạm thời</div>
            <div>Tài khoản: <span class="fw-semibold">${temporaryPasswordEmail}</span></div>
            <div>Mật khẩu: <code class="fs-6">${temporaryPassword}</code></div>
            <small>Người dùng bắt buộc đổi mật khẩu trong lần đăng nhập tiếp theo.</small>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <form method="get" action="${pageContext.request.contextPath}/admin/accounts" class="row align-items-end g-3">
            <div class="col-md-4">
                <label for="keyword" class="form-label fw-bold text-secondary">Tìm kiếm</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="fa fa-search"></i></span>
                    <input type="text" id="keyword" name="keyword" class="form-control border-start-0"
                           value="${keyword}" placeholder="Tên, email, điện thoại, vai trò hoặc trạng thái">
                </div>
            </div>
            <div class="col-md-2">
                <label for="role" class="form-label fw-bold text-secondary">Vai trò</label>
                <select id="role" name="role" class="form-select">
                    <option value="">Tất cả vai trò</option>
                    <c:forEach var="role" items="${roles}">
                        <option value="${role}" ${selectedRole == role ? 'selected' : ''}>${role}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="status" class="form-label fw-bold text-secondary">Trạng thái</label>
                <select id="status" name="status" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <c:forEach var="status" items="${statuses}">
                        <option value="${status}" ${selectedStatus == status ? 'selected' : ''}>${status}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="pageSize" class="form-label fw-bold text-secondary">Dòng/trang</label>
                <select id="pageSize" name="pageSize" class="form-select">
                    <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                </select>
            </div>
            <div class="col-md-2 d-grid">
                <button type="submit" class="btn btn-primary" title="Lọc danh sách">
                    <i class="fa fa-filter"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead>
                    <tr class="text-dark">
                        <th style="width: 90px;">ID</th>
                        <th>Tài khoản</th>
                        <th style="width: 150px;">Điện thoại</th>
                        <th style="width: 120px;">Vai trò</th>
                        <th style="width: 130px;">Trạng thái</th>
                        <th class="text-center" style="width: 360px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty accounts}">
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="fa fa-user-slash fa-3x mb-3 d-block"></i>
                                    Không tìm thấy tài khoản phù hợp.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="account" items="${accounts}">
                                <c:set var="isSelf" value="${account.userId == sessionScope.currentUser.userId}" />
                                <tr>
                                    <td class="fw-bold text-secondary">USR-${account.userId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${account.fullName}</div>
                                        <small class="text-muted">${account.email}</small>
                                    </td>
                                    <td>${account.phoneNumber}</td>
                                    <td>
                                        <span class="badge bg-info text-dark px-3 py-2">${account.role}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${account.accountStatus == 'Active'}">
                                                <span class="badge bg-success px-3 py-2">Active</span>
                                            </c:when>
                                            <c:when test="${account.accountStatus == 'Locked'}">
                                                <span class="badge bg-danger px-3 py-2">Locked</span>
                                            </c:when>
                                            <c:when test="${account.accountStatus == 'Inactive'}">
                                                <span class="badge bg-secondary px-3 py-2">Inactive</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark px-3 py-2">${account.accountStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex flex-wrap gap-2 justify-content-center">
                                            <a href="${pageContext.request.contextPath}/admin/accounts?action=edit&id=${account.userId}"
                                               class="btn btn-sm btn-outline-primary" title="Xem hoặc sửa tài khoản">
                                                <i class="fa fa-edit"></i>
                                            </a>

                                            <c:choose>
                                                <c:when test="${account.accountStatus == 'Locked'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/accounts" class="d-inline">
                                                        <input type="hidden" name="action" value="unlock">
                                                        <input type="hidden" name="userId" value="${account.userId}">
                                                        <button type="submit" class="btn btn-sm btn-outline-success" title="Mở khóa tài khoản"
                                                                onclick="return confirm('Mở khóa tài khoản này?');">
                                                            <i class="fa fa-unlock"></i>
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:when test="${account.accountStatus == 'Inactive'}">
                                                    <button type="button" class="btn btn-sm btn-outline-warning" title="Tài khoản đã vô hiệu hóa không thể khóa" disabled>
                                                        <i class="fa fa-lock"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/accounts" class="d-inline">
                                                        <input type="hidden" name="action" value="lock">
                                                        <input type="hidden" name="userId" value="${account.userId}">
                                                        <button type="submit" class="btn btn-sm btn-outline-warning" title="Khóa tài khoản"
                                                                ${isSelf ? 'disabled' : ''}
                                                                onclick="return confirm('Khóa tài khoản này?');">
                                                            <i class="fa fa-lock"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>

                                            <form method="post" action="${pageContext.request.contextPath}/admin/accounts" class="d-inline">
                                                <input type="hidden" name="action" value="resetPassword">
                                                <input type="hidden" name="userId" value="${account.userId}">
                                                <button type="submit" class="btn btn-sm btn-outline-dark" title="Đặt lại mật khẩu"
                                                        onclick="return confirm('Đặt lại mật khẩu cho tài khoản này?');">
                                                    <i class="fa fa-key"></i>
                                                </button>
                                            </form>

                                            <form method="post" action="${pageContext.request.contextPath}/admin/accounts" class="d-inline">
                                                <input type="hidden" name="action" value="deactivate">
                                                <input type="hidden" name="userId" value="${account.userId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Vô hiệu hóa tài khoản"
                                                        ${isSelf ? 'disabled' : ''}
                                                        onclick="return confirm('Vô hiệu hóa tài khoản này? Dữ liệu nghiệp vụ liên quan vẫn được giữ lại.');">
                                                    <i class="fa fa-user-slash"></i>
                                                </button>
                                            </form>
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
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
