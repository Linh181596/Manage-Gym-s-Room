<%--
  Created by IntelliJ IDEA.
  User: phuga
  Date: 6/18/2026
  Time: 5:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4">
        <h4 class="mb-4 text-primary"><i class="fa fa-user-edit me-2"></i>Chỉnh sửa hồ sơ cá nhân</h4>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa fa-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/pt/edit-profile" method="POST" enctype="multipart/form-data">

            <input type="hidden" name="ptId" value="${pt.ptId}">

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label class="form-label fw-bold text-muted">Họ và tên chính thức:</label>
                    <input type="text" class="form-control" value="${pt.fullName}" readonly
                           style="background-color: #e9ecef; cursor: not-allowed;">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold text-muted">Số điện thoại liên hệ:</label>
                    <input type="text" class="form-control" value="${pt.phone}" readonly
                           style="background-color: #e9ecef; cursor: not-allowed;">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold text-muted">Chuyên môn huấn luyện:</label>
                    <input type="text" class="form-control" value="${pt.specialization}" readonly
                           style="background-color: #e9ecef; cursor: not-allowed;">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold text-muted">Chứng chỉ hồ sơ:</label>
                    <div class="form-control d-flex align-items-center justify-content-between"
                         style="background-color: #e9ecef;">
                        <span class="text-truncate"><strong>${pt.certificateFileName}</strong></span>
                        <c:set var="rawCertPath" value="${pt.certificateFilePath}" />
                        <c:set var="finalCertPath" value="${rawCertPath}" />
                        <c:if test="${not empty rawCertPath and not fn:contains(rawCertPath, 'assets/')}">
                            <c:if test="${fn:startsWith(rawCertPath, 'uploads/')}">
                                <c:set var="finalCertPath" value="assets/uploads/pt-certificate/${fn:substring(rawCertPath, 8, fn:length(rawCertPath))}" />
                            </c:if>
                        </c:if>
                        <a href="${pageContext.request.contextPath}${finalCertPath.startsWith('/') ? '' : '/'}${finalCertPath}" target="_blank"
                           class="btn btn-sm btn-primary py-0">
                            <i class="fa fa-eye me-1"></i>Xem file
                        </a>
                    </div>
                </div>
            </div>

            <hr class="my-4">

            <div class="mb-4">
                <label class="form-label fw-bold">Tên hiển thị trên hệ thống (DisplayName):</label>
                <input type="text" class="form-control" name="displayName" value="${pt.displayName}"
                       placeholder="VD: Coach Phú Nguyễn" required>
                <div class="form-text text-muted">Tên này dùng để học viên tìm kiếm và đăng ký lịch tập với bạn.</div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">Tiểu sử / Giới thiệu bản thân (Bio):</label>
                <textarea class="form-control" name="description" rows="6"
                          placeholder="Nhập kinh nghiệm, thành tích huấn luyện của bạn...">${pt.description}</textarea>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">Cập nhật ảnh đại diện mới (Avatar):</label>
                <input type="file" class="form-control" name="avatarFile" accept=".jpg, .jpeg, .png">
                <div class="form-text text-warning"><i class="fa fa-info-circle me-1"></i>Bỏ trống nếu bạn muốn giữ
                    nguyên ảnh đại diện hiện tại.
                </div>
            </div>

            <div class="text-end mt-4">
                <a href="${pageContext.request.contextPath}/pt/profile"
                   class="btn btn-outline-secondary py-2 px-4 me-2">Hủy bỏ</a>
                <button type="submit" class="btn btn-primary py-2 px-4"><i class="fa fa-save me-2"></i>Lưu thay đổi
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp"/>