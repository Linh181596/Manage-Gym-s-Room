<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h4 class="mb-0"><i class="fa fa-user me-2 text-primary"></i>Thông tin hồ sơ cá nhân</h4>
            <div>
                <a href="${pageContext.request.contextPath}/pt/dashboard" class="btn btn-outline-secondary me-2">Quay
                    lại Dashboard</a>
                <a href="${pageContext.request.contextPath}/pt/edit-profile" class="btn btn-primary"><i
                        class="fa fa-edit me-2"></i>Chỉnh sửa hồ sơ</a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 text-center border-end">
                <img src="${pageContext.request.contextPath}/${not empty pt.avatarPath ? pt.avatarPath : 'img/user.jpg'}"
                     class="img-fluid rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                <h3>${pt.publicName}</h3>
                <p class="text-muted">${pt.specialization}</p>
            </div>
            <div class="col-md-8 px-4">
                <h5 class="mb-3 text-secondary">Thông tin chi tiết</h5>
                <p><strong>Họ và tên:</strong> ${pt.fullName}</p>
                <p><strong>Số điện thoại:</strong> ${pt.phone}</p>
                <p><strong>Ngày bắt đầu sự nghiệp:</strong> ${pt.careerStartDate}</p>
                <p><strong>Trạng thái tài khoản:</strong> <span class="badge bg-success">${pt.status}</span></p>
                <p><strong>Bằng cấp/Chứng chỉ:</strong>
                    <c:set var="rawCertPath" value="${pt.certificateFilePath}"/>
                    <c:set var="finalCertPath" value="${rawCertPath}"/>
                    <%-- Sửa lỗi lệch đường dẫn nếu dữ liệu cũ chỉ có 'uploads/...' thì thêm /assets vào đầu --%>
                    <c:if test="${not empty rawCertPath and not fn:contains(rawCertPath, 'assets/')}">
                        <c:if test="${fn:startsWith(rawCertPath, 'uploads/')}">
                            <c:set var="finalCertPath"
                                   value="assets/uploads/pt-certificate/${fn:substring(rawCertPath, 8, fn:length(rawCertPath))}"/>
                        </c:if>
                    </c:if>
                    <a href="${pageContext.request.contextPath}${finalCertPath.startsWith('/') ? '' : '/'}${finalCertPath}"
                       target="_blank"
                       class="text-primary fw-bold ms-2">
                        <i class="fa fa-file-pdf me-1"></i>${pt.certificateFileName}
                    </a>
                </p>
                <p><strong>Giới thiệu bản thân (Bio):</strong></p>
                <div class="p-3 bg-white rounded border" style="min-height: 100px;">
                    ${not empty pt.description ? pt.description : 'Chưa có thông tin giới thiệu.'}
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp"/>
