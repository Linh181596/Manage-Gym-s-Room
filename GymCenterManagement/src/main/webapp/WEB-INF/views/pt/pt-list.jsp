<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : pt-list.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện danh sách các Huấn luyện viên cá nhân (PT) cho hội viên.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Page Title -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-user-tie me-2 text-primary"></i>Đội ngũ Huấn luyện viên (PT)</h4>
            <small class="text-muted">Lựa chọn huấn luyện viên chuyên nghiệp phù hợp với mục tiêu tập luyện của bạn</small>
        </div>
        <c:if test="${sessionScope.currentUser.role == 'Admin' || sessionScope.currentUser.role == 'Staff'}">
            <a href="${pageContext.request.contextPath}/staff/pt/add" class="btn btn-primary d-flex align-items-center shadow-sm">
                <i class="fa fa-plus-circle me-2"></i> Thêm tài khoản PT mới
            </a>
        </c:if>
    </div>

    <!-- Error/Success Feedback -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Filter Card -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <form method="get" action="${pageContext.request.contextPath}/pt/list">
            <%-- Search by keyword for name, bio/description, email --%>
            <div class="mb-3">
                <label for="keyword" class="form-label">Tìm kiếm PT</label>
                <input type="text"
                       id="keyword"
                       name="keyword"
                       value="${keyword != null ? keyword : ''}"
                       placeholder="Tìm theo tên, email, chuyên môn..."
                       class="form-control">
            </div>
            <c:if test="${isManagement}">
                <div class="mb-3 p-3 bg-white border rounded">
                    <label class="form-label fw-bold text-secondary"><i class="fa fa-info-circle me-1"></i> Trạng thái HLV</label>
                    <div class="d-flex gap-4">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusAll" value="All" ${status == 'All' ? 'checked' : ''}>
                            <label class="form-check-label text-dark" for="statusAll">Tất cả</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusActive" value="Active" ${status == 'Active' ? 'checked' : ''}>
                            <label class="form-check-label text-success" for="statusActive">Đang hoạt động (Active)</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusInactive" value="Inactive" ${status == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label text-danger" for="statusInactive">Ngừng hoạt động (Inactive)</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusLocked" value="Locked" ${status == 'Locked' ? 'checked' : ''}>
                            <label class="form-check-label text-warning" for="statusLocked">Tài khoản bị khóa (Locked)</label>
                        </div>
                    </div>
                </div>
            </c:if>
            <div class="row align-items-end g-3">
                <div class="col-12">
                    <label class="form-label fw-bold text-secondary mb-2"><i class="fa fa-filter me-1"></i> Lọc theo chuyên môn</label>
                    <div class="d-flex flex-wrap gap-3 p-3 bg-white border rounded">
                        <c:forEach var="option" items="${specializationOptions}" varStatus="status">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="specializations" 
                                       id="spec_${status.index}" value="${option}" 
                                       <c:if test="${not empty selectedSpecializations and selectedSpecializations.contains(option)}">checked</c:if>>
                                <label class="form-check-label text-dark" for="spec_${status.index}">${option}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                    <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-outline-secondary px-4"><i class="fa fa-undo me-1"></i> Xóa bộ lọc</a>
                    <button type="submit" class="btn btn-primary px-5 shadow-sm"><i class="fa fa-filter me-1"></i> Lọc kết quả</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Trainer Grid -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
        <c:choose>
            <c:when test="${empty trainers}">
                <div class="col-12 w-100 text-center py-5 bg-light rounded shadow-sm">
                    <i class="fa fa-users-slash fa-3x text-muted mb-3"></i>
                    <h5 class="text-secondary fw-semibold">Hiện tại chưa có Huấn luyện viên nào phù hợp với bộ lọc.</h5>
                    <p class="text-muted small">Vui lòng quay lại sau hoặc xóa bộ lọc để tìm kiếm lại.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="trainer" items="${trainers}">
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm hover-translate-y transition-all">
                            <!-- Top Gradient Decoration -->
                            <div class="bg-primary-gradient rounded-top" style="height: 6px;"></div>
                            <div class="card-body p-4 d-flex flex-column align-items-center text-center">
                                <!-- Avatar -->
                                <div class="position-relative mb-3">
                                    <c:choose>
                                        <c:when test="${not empty trainer.avatarPath}">
                                            <img src="${pageContext.request.contextPath}/${trainer.avatarPath}" 
                                                 alt="Ảnh đại diện ${trainer.publicName}" 
                                                 class="rounded-circle border border-3 border-white shadow" 
                                                 style="width: 100px; height: 100px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="rounded-circle border border-3 border-white shadow bg-light text-primary d-flex align-items-center justify-content-center" 
                                                 style="width: 100px; height: 100px; font-size: 32px;">
                                                <i class="fa fa-user"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${trainer.status == 'Inactive'}">
                                            <span class="position-absolute bottom-0 end-0 badge bg-danger rounded-circle border border-2 border-white p-2" title="Ngừng hoạt động">
                                                <span class="visually-hidden">Ngừng hoạt động</span>
                                            </span>
                                        </c:when>
                                        <c:when test="${trainer.accountStatus == 'Locked'}">
                                            <span class="position-absolute bottom-0 end-0 badge bg-warning rounded-circle border border-2 border-white p-2" title="Bị khóa">
                                                <span class="visually-hidden">Bị khóa</span>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="position-absolute bottom-0 end-0 badge bg-success rounded-circle border border-2 border-white p-2" title="Đang hoạt động">
                                                <span class="visually-hidden">Đang hoạt động</span>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Name & Title -->
                                <h5 class="card-title text-dark fw-bold mb-1">${trainer.publicName}</h5>
                                <p class="text-muted small mb-2">${not empty trainer.email ? trainer.email : 'Email chưa cập nhật'}</p>
                                
                                <!-- Specialization Badges -->
                                <div class="mb-3">
                                    <span class="badge bg-light-primary text-primary px-3 py-1.5 rounded-pill fw-semibold">
                                        <i class="fa fa-dumbbell me-1"></i>${trainer.specialization}
                                    </span>
                                </div>

                                <!-- Stats Block -->
                                <div class="row w-100 bg-light rounded p-3 mb-4 mt-auto">
                                    <div class="col-6 border-end text-center">
                                        <span class="d-block text-secondary small">Kinh nghiệm</span>
                                        <strong class="text-dark">${trainer.experienceYears} năm</strong>
                                    </div>
                                    <div class="col-6 text-center">
                                        <span class="d-block text-secondary small">Trạng thái</span>
                                        <c:choose>
                                            <c:when test="${trainer.status == 'Inactive'}">
                                                <strong class="text-danger">Ngừng hoạt động</strong>
                                                <c:if test="${trainer.accountStatus == 'Locked'}">
                                                    <small class="d-block text-muted" style="font-size: 0.72rem; margin-top: 2px;"><i class="fa fa-lock me-1 text-secondary"></i>Đã khóa tài khoản</small>
                                                </c:if>
                                            </c:when>
                                            <c:when test="${trainer.accountStatus == 'Locked'}">
                                                <strong class="text-warning">Bị khóa</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong class="text-success">Đang hoạt động</strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Action Button -->
                                <a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}" 
                                   class="btn btn-outline-primary w-100 py-2.5 fw-semibold d-flex align-items-center justify-content-center mt-auto shadow-sm">
                                        Xem hồ sơ chi tiết <i class="fa fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
