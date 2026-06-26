<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : account-form.jsp
  Created on  : 2026-06-25
  Author      : Nguyễn Đại Dương (duongnd)
  Description : Giao diện tạo mới và chỉnh sửa thông tin tài khoản người dùng cho quản trị viên (Admin).
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:set var="isSelf" value="${not isCreate && account.userId == sessionScope.currentUser.userId}" />
<c:set var="isManagedRole" value="${account.role == 'Staff' || account.role == 'Member'}" />

<div class="container-fluid pt-4 px-4">
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/accounts">Tài khoản</a></li>
                <li class="breadcrumb-item active" aria-current="page">${formTitle}</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-user-cog me-2 text-primary"></i>${formTitle}</h4>
            <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i>Quay lại
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="bg-light rounded p-5 shadow-sm border-0">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                        <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/accounts" method="post" id="accountForm" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="userId" value="${account.userId}">

                    <c:if test="${not isCreate}">
                        <div class="mb-4">
                            <label class="form-label fw-bold text-dark">Mã tài khoản</label>
                            <input type="text" class="form-control form-control-lg border-2" value="USR-${account.userId}" readonly>
                        </div>
                    </c:if>

                    <div class="mb-4">
                        <label for="fullName" class="form-label fw-bold text-dark">
                            <i class="fa fa-user me-1 text-muted"></i>Họ và tên <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control form-control-lg border-2" id="fullName" name="fullName"
                               value="${account.fullName}" maxlength="100" required>
                        <div class="invalid-feedback">Vui lòng nhập họ và tên.</div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <label for="email" class="form-label fw-bold text-dark">
                                <i class="fa fa-envelope me-1 text-muted"></i>Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" class="form-control form-control-lg border-2" id="email" name="email"
                                   value="${account.email}" maxlength="100" required>
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label fw-bold text-dark">
                                <i class="fa fa-phone me-1 text-muted"></i>Số điện thoại <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control form-control-lg border-2" id="phone" name="phone"
                                   value="${account.phoneNumber}" pattern="^0[0-9]{9}$" maxlength="10" required>
                            <div class="invalid-feedback">Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số.</div>
                        </div>
                    </div>

                    <div class="row g-4 mb-5">
                        <div class="col-md-6">
                            <label for="role" class="form-label fw-bold text-dark">
                                <i class="fa fa-user-tag me-1 text-muted"></i>Vai trò <span class="text-danger">*</span>
                            </label>
                            <c:choose>
                                <c:when test="${isCreate || (isManagedRole && !isSelf)}">
                                    <select class="form-select form-select-lg border-2" id="role" name="role" required>
                                        <option value="Staff" ${account.role == 'Staff' ? 'selected' : ''}>Staff</option>
                                        <option value="Member" ${account.role == 'Member' ? 'selected' : ''}>Member</option>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" class="form-control form-control-lg border-2" value="${account.role}" readonly>
                                    <input type="hidden" name="role" value="${account.role}">
                                </c:otherwise>
                            </c:choose>
                            <div class="form-text">Chức năng này chỉ được tạo hoặc gán vai trò Staff và Member.</div>
                        </div>

                        <div class="col-md-6">
                            <label for="status" class="form-label fw-bold text-dark">
                                <i class="fa fa-toggle-on me-1 text-muted"></i>Trạng thái <span class="text-danger">*</span>
                            </label>
                            <c:choose>
                                <c:when test="${isSelf}">
                                    <input type="text" class="form-control form-control-lg border-2" value="${account.accountStatus}" readonly>
                                    <input type="hidden" name="status" value="${account.accountStatus}">
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select form-select-lg border-2" id="status" name="status" required>
                                        <c:forEach var="status" items="${statuses}">
                                            <option value="${status}" ${account.accountStatus == status ? 'selected' : ''}>${status}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-lg btn-outline-secondary px-5">Hủy bỏ</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            <i class="fa fa-save me-2"></i>Lưu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("accountForm");
        form.addEventListener("submit", function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
