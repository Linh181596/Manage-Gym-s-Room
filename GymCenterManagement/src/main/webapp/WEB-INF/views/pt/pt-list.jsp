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

<c:if test="${sessionScope.currentUser == null}">
    <!-- Custom styling to hide dashboard wrapper components and fit public page design -->
    <style>
        :root {
            --home-primary: #009cff;
            --home-primary-dark: #0078c4;
            --home-ink: #191c24;
            --home-muted: #6c7293;
            --home-soft: #f3f6f9;
            --home-line: #dce6ef;
        }

        .sidebar {
            display: none !important;
        }
        .content {
            width: 100% !important;
            margin-left: 0 !important;
        }
        .navbar.sticky-top {
            display: none !important;
        }

        .home-topbar {
            position: sticky;
            top: 0;
            z-index: 1030;
            background: rgba(255, 255, 255, 0.96);
            border-bottom: 1px solid var(--home-line);
            backdrop-filter: blur(14px);
        }

        .brand-mark {
            width: 44px;
            height: 44px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #ffffff !important;
            background: var(--home-primary);
            border-radius: 8px;
        }

        .brand-title {
            color: var(--home-ink);
            font-weight: 800;
            line-height: 1;
            letter-spacing: 0;
        }

        .home-nav a {
            color: var(--home-muted) !important;
            font-weight: 600;
            text-decoration: none;
            padding: 10px 12px;
        }

        .home-nav a:hover,
        .home-nav a:focus {
            color: var(--home-primary) !important;
        }
        
        .footer-home {
            background: var(--home-ink);
            color: rgba(255, 255, 255, 0.7);
        }
        
        .footer-home a {
            color: rgba(255, 255, 255, 0.82) !important;
            text-decoration: none;
        }

        .footer-home a:hover {
            color: #ffffff !important;
        }
    </style>
    
    <!-- Public Home-style Topbar -->
    <header class="home-topbar mb-4">
        <nav class="container py-3">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <a href="${pageContext.request.contextPath}/" class="d-inline-flex align-items-center gap-2 text-decoration-none">
                    <span class="brand-mark"><i class="fa fa-dumbbell"></i></span>
                    <span class="brand-title">GCMS<br><small class="fw-semibold text-primary">Phòng tập hiện đại</small></span>
                </a>

                <div class="home-nav d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/#gioi-thieu">Giới thiệu</a>
                    <a href="${pageContext.request.contextPath}/pt/list" class="text-primary fw-bold">Danh sách PT</a>
                    <a href="${pageContext.request.contextPath}/#goi-tap">Gói tập</a>
                    <a href="${pageContext.request.contextPath}/#tien-ich">Tiện ích</a>
                    <a href="${pageContext.request.contextPath}/#lien-he">Liên hệ</a>
                </div>

                <div class="home-actions d-flex align-items-center gap-2 flex-wrap justify-content-end">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                        <i class="fa fa-sign-in-alt me-1"></i>Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                        <i class="fa fa-user-plus me-1"></i>Đăng ký thành viên
                    </a>
                </div>
            </div>
        </nav>
    </header>
</c:if>

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

    <!-- Count Summary -->
    <c:if test="${not empty totalTrainers and totalTrainers > 0}">
        <div class="d-flex justify-content-between align-items-center mb-3 px-1">
            <span class="text-secondary fw-semibold">
                Hiển thị ${(currentPage - 1) * pageSize + 1} - ${currentPage * pageSize > totalTrainers ? totalTrainers : currentPage * pageSize} 
                trong tổng số <strong class="text-primary">${totalTrainers}</strong> Huấn luyện viên.
            </span>
        </div>
    </c:if>

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
                                <c:choose>
                                    <c:when test="${sessionScope.currentUser != null}">
                                        <a href="${pageContext.request.contextPath}/pt/detail?id=${trainer.ptId}" 
                                           class="btn btn-outline-primary w-100 py-2.5 fw-semibold d-flex align-items-center justify-content-center mt-auto shadow-sm">
                                                Xem hồ sơ chi tiết <i class="fa fa-arrow-right ms-2"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login" 
                                           class="btn btn-outline-primary w-100 py-2.5 fw-semibold d-flex align-items-center justify-content-center mt-auto shadow-sm">
                                                Đăng nhập để xem chi tiết <i class="fa fa-arrow-right ms-2"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}<c:forEach var='s' items='${selectedSpecializations}'>&specializations=${s}</c:forEach>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach var="p" begin="1" end="${totalPages}">
                    <li class="page-item ${currentPage == p ? 'active' : ''}">
                        <a class="page-link" href="?page=${p}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}<c:forEach var='s' items='${selectedSpecializations}'>&specializations=${s}</c:forEach>">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}<c:forEach var='s' items='${selectedSpecializations}'>&specializations=${s}</c:forEach>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<c:if test="${sessionScope.currentUser == null}">
    <!-- Public Home-style Footer -->
    <footer id="lien-he" class="footer-home py-5 mt-5 bg-dark text-light">
        <div class="container">
            <div class="row g-4 align-items-start text-start">
                <div class="col-lg-5">
                    <div class="d-inline-flex align-items-center gap-2 mb-3">
                        <span class="brand-mark bg-primary text-white"><i class="fa fa-dumbbell"></i></span>
                        <strong class="fs-4 text-white">GCMS</strong>
                    </div>
                    <p class="mb-0 text-muted">Không gian quản lý và tập luyện dành cho phòng gym hiện đại, rõ ràng và thân thiện với người dùng Việt.</p>
                </div>
                <div class="col-6 col-lg-2">
                    <h6 class="text-white fw-bold">Truy cập nhanh</h6>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/#gioi-thieu" class="text-muted text-decoration-none small">Giới thiệu</a>
                        <a href="${pageContext.request.contextPath}/pt/list" class="text-muted text-decoration-none small">Danh sách PT</a>
                        <a href="${pageContext.request.contextPath}/#goi-tap" class="text-muted text-decoration-none small">Gói tập</a>
                    </div>
                </div>
                <div class="col-6 col-lg-2">
                    <h6 class="text-white fw-bold">Tài khoản</h6>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="text-muted text-decoration-none small">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none small">Đăng ký thành viên</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <h6 class="text-white fw-bold">Liên hệ phòng tập</h6>
                    <p class="mb-2 text-muted"><i class="fa fa-map-marker-alt me-2 text-primary"></i>QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội</p>
                    <p class="mb-2 text-muted"><i class="fa fa-phone me-2 text-primary"></i>(+84) 987-654-321</p>
                    <p class="mb-0 text-muted"><i class="fa fa-envelope me-2 text-primary"></i>support@gcms.com</p>
                </div>
            </div>
            <div class="border-top border-secondary mt-4 pt-4 d-flex flex-wrap justify-content-between gap-2 text-muted small">
                <span>© 2026 Hệ thống quản lý phòng tập GCMS.</span>
                <span>Thiết kế cho trải nghiệm thuần Việt.</span>
            </div>
        </div>
    </footer>
</c:if>

<jsp:include page="../common/dashboard_footer.jsp" />
