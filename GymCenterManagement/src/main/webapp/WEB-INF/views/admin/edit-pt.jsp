<%--
  Created by IntelliJ IDEA.
  User: phuga
  Date: 6/19/2026
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h4 class="mb-0">Chỉnh sửa hồ sơ Huấn luyện viên</h4>
            <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-secondary btn-sm">Quay lại danh
                sách</a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/pt/edit" method="POST" enctype="multipart/form-data">

            <input type="hidden" name="ptId" value="${pt.ptId}">
            <input type="hidden" name="userId" value="${pt.userId}">
            <input type="hidden" name="oldAvatarPath" value="${pt.avatarPath}">
            <input type="hidden" name="oldCertPath" value="${pt.certificateFilePath}">
            <input type="hidden" name="oldCertName" value="${pt.certificateFileName}">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Họ và tên thật (FullName)</label>
                    <input type="text" class="form-control" name="fullName" value="${pt.fullName}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Tên hiển thị (DisplayName)</label>
                    <input type="text" class="form-control" name="displayName" value="${pt.displayName}" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Số điện thoại</label>
                    <input type="text" class="form-control" name="phone" value="${pt.phone}" pattern="[0-9]{10}"
                           title="Vui lòng nhập 10 chữ số">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ngày bắt đầu sự nghiệp</label>
                    <input type="date" class="form-control" name="careerStartDate" value="${pt.careerStartDate}">
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Chuyên môn (Specialization)</label>
                    <input type="text" class="form-control" name="specialization" value="${pt.specialization}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Trạng thái hoạt động</label>
                    <select name="status" class="form-select">
                        <option value="Active" ${pt.status == 'Active' ? 'selected' : ''}>Hoạt động (Active)</option>
                        <option value="Inactive" ${pt.status == 'Inactive' ? 'selected' : ''}>Khóa (Inactive)</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Tiểu sử / Giới thiệu bản thân (Bio)</label>
                <textarea class="form-control" name="description" rows="5">${pt.description}</textarea>
            </div>

            <hr class="my-4">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ảnh đại diện mới (Bỏ trống nếu giữ nguyên)</label>
                    <input type="file" class="form-control mb-2" name="avatarFile"
                           accept="image/png, image/jpeg, image/jpg">
                    <small class="text-muted">Ảnh hiện tại:
                        <a href="${pageContext.request.contextPath}/${not empty pt.avatarPath ? pt.avatarPath : 'img/user.jpg'}"
                           target="_blank">Xem ảnh</a>
                    </small>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">File Chứng chỉ mới (Bỏ trống nếu giữ nguyên)</label>
                    <input type="file" class="form-control mb-2" name="certificateFile" accept=".pdf, image/*">

                    <c:set var="rawCertPath" value="${pt.certificateFilePath}"/>
                    <c:set var="finalCertPath" value="${rawCertPath}"/>
                    <c:if test="${not empty rawCertPath and not fn:contains(rawCertPath, 'assets/')}">
                        <c:if test="${fn:startsWith(rawCertPath, 'uploads/')}">
                            <c:set var="finalCertPath"
                                   value="assets/uploads/pt-certificate/${fn:substring(rawCertPath, 8, fn:length(rawCertPath))}"/>
                        </c:if>
                    </c:if>

                    <small class="text-muted">File hiện tại:
                        <a href="${pageContext.request.contextPath}${finalCertPath.startsWith('/') ? '' : '/'}${finalCertPath}"
                           target="_blank">
                            ${pt.certificateFileName}
                        </a>
                    </small>
                </div>
            </div>

            <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary px-4 py-2"><i class="fa fa-save me-2"></i>Lưu Thay Đổi
                </button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="../common/dashboard_footer.jsp"/>

