<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
  =========================================================================
  Document    : pt-detail.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện chi tiết thông tin và bảng giá dịch vụ của Huấn luyện viên.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid pt-4 px-4">
    <!-- Navigation Back Link -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-sm btn-outline-secondary px-3 shadow-sm">
            <i class="fa fa-arrow-left me-1"></i> Quay về danh sách PT
        </a>
    </div>

    <!-- Error message display if any -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${error}
        </div>
    </c:if>

    <c:if test="${not empty trainer}">
        <div class="row g-4 mb-4">
            <!-- Left Side: Profile Card -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm text-center p-4">
                    <div class="bg-primary-gradient rounded-top position-absolute start-0 top-0 w-100"
                         style="height: 6px;"></div>
                    <div class="mt-3">
                        <c:choose>
                            <c:when test="${not empty trainer.avatarPath}">
                                <c:set var="avatarPath" value="${trainer.avatarPath}"/>
                                <c:if test="${not fn:startsWith(avatarPath, '/')}">
                                    <c:set var="avatarPath" value="/${avatarPath}"/>
                                </c:if>
                                <img src="${pageContext.request.contextPath}${avatarPath}"
                                     alt="Ảnh đại diện HLV"
                                     class="rounded-circle border border-4 border-white shadow img-thumbnail mb-3"
                                     style="width: 150px; height: 150px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <div class="rounded-circle border border-4 border-white shadow bg-light text-primary d-flex align-items-center justify-content-center mx-auto mb-3"
                                     style="width: 150px; height: 150px; font-size: 48px;">
                                    <i class="fa fa-user"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h4 class="text-dark fw-bold mb-1">${trainer.publicName}</h4>
                    <p class="text-secondary small mb-3">${not empty trainer.email ? trainer.email : 'Email chưa cập nhật'}</p>

                    <div class="mb-3">
                        <span class="badge bg-light-primary text-primary px-3 py-2 rounded-pill fw-semibold fs-7">
                            <i class="fa fa-dumbbell me-1"></i> ${trainer.specialization}
                        </span>
                    </div>

                    <ul class="list-group list-group-flush text-start small mb-3">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-calendar-alt me-1.5 text-secondary"></i>Kinh nghiệm:</span>
                            <span class="fw-bold text-dark">${trainer.experienceYears} năm</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-phone me-1.5 text-secondary"></i>Điện thoại:</span>
                            <span class="fw-bold text-dark">${not empty trainer.phone ? trainer.phone : 'Chưa cập nhật'}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-info-circle me-1.5 text-secondary"></i>Trạng thái:</span>
                            <c:choose>
                                <c:when test="${trainer.status == 'Inactive'}">
                                    <div>
                                        <span class="badge bg-danger rounded-pill px-2.5 py-1">Ngừng hoạt động</span>
                                        <c:if test="${trainer.accountStatus == 'Locked'}">
                                            <span class="badge bg-secondary rounded-pill px-2 py-1 ms-1 text-white shadow-sm" style="font-size: 0.72rem;" title="Tài khoản đăng nhập bị khóa"><i class="fa fa-lock me-1"></i>Đã khóa tài khoản</span>
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:when test="${trainer.accountStatus == 'Locked'}">
                                    <span class="badge bg-warning text-dark rounded-pill px-2.5 py-1">Bị khóa</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-success rounded-pill px-2.5 py-1">Đang hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>

                    <c:if test="${not empty trainer.certificateFilePath}">
                        <div class="p-3 bg-light rounded mt-2 text-start">
                            <h6 class="text-dark fw-bold mb-1"><i class="fa fa-certificate text-warning me-1.5"></i>Chứng chỉ đã xác minh</h6>
                            <small class="text-muted text-truncate d-block mb-2" style="max-width: 250px;">
                                ${trainer.certificateFileName}
                            </small>
                            <c:set var="certPath" value="${trainer.certificateFilePath}"/>
                            <c:if test="${not fn:contains(certPath, 'assets/') and fn:startsWith(certPath, 'uploads/')}">
                                <c:set var="certPath" value="assets/uploads/pt-certificate/${fn:substring(certPath, 8, fn:length(certPath))}"/>
                            </c:if>
                            <c:if test="${not fn:startsWith(certPath, '/')}">
                                <c:set var="certPath" value="/${certPath}"/>
                            </c:if>
                            <a href="${pageContext.request.contextPath}${certPath}"
                               target="_blank"
                               class="btn btn-sm btn-primary w-100 shadow-sm py-1.5">
                                <i class="fa fa-eye me-1"></i> Xem File chứng chỉ
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Right Side: Biography & Service Packages -->
            <div class="col-lg-8">
                <!-- Biography / Description Card -->
                <div class="card border-0 shadow-sm p-4 mb-4">
                    <h5 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-address-card text-primary me-2"></i>Giới thiệu bản thân</h5>
                    <p class="text-dark mb-0 lh-relaxed" style="white-space: pre-line;">
                        <c:choose>
                            <c:when test="${not empty trainer.description}">
                                ${trainer.description}
                            </c:when>
                            <c:otherwise>
                                Huấn luyện viên chưa cập nhật thông tin giới thiệu.
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <!-- Service Packages Card -->
                <div class="card border-0 shadow-sm p-4">
                    <h5 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-tags text-primary me-2"></i>Bảng giá các gói tập với ${trainer.publicName}</h5>

                    <c:choose>
                        <c:when test="${empty servicePrices}">
                            <div class="text-center py-4 text-muted">
                                <i class="fa fa-box-open fa-2x mb-2 text-secondary"></i>
                                <p class="mb-0 small">Hiện HLV này chưa đăng ký biểu giá các gói tập cụ thể. Vui lòng liên hệ lễ tân để biết thêm chi tiết.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-md-2 g-3">
                                <c:forEach var="price" items="${servicePrices}">
                                    <div class="col">
                                        <div class="border rounded p-3 h-100 d-flex flex-column hover-shadow transition-all bg-white position-relative">
                                            <span class="position-absolute top-0 end-0 badge bg-primary rounded-bottom-left px-2.5 py-1.5">
                                                ${price.numberOfSessions} buổi
                                            </span>
                                            <h6 class="text-dark fw-bold mb-1 pe-5">${price.packageName}</h6>
                                            <p class="text-muted small mb-3 flex-grow-1">${price.packageDescription}</p>

                                            <div class="d-flex align-items-baseline mb-3">
                                                <span class="text-primary fw-bold fs-4">
                                                    <fmt:formatNumber value="${price.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                                <span class="text-muted small ms-1">/ ${price.durationMonths} tháng</span>
                                            </div>

                                            <c:choose>
                                                <c:when test="${sessionScope.currentUser.role == 'Member'}">
                                                    <%-- Nút chuyển hướng sang màn hình đăng ký mua gói tập PT dành cho Hội viên (Member) --%>
                                                    <a href="${pageContext.request.contextPath}/member/pt/register?priceId=${price.ptServicePriceId}"
                                                       class="btn btn-primary w-100 mt-auto py-2 fw-semibold shadow-sm">
                                                        Đăng ký gói tập này
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-outline-secondary w-100 mt-auto py-2 fw-semibold" disabled
                                                            title="Chỉ hội viên mới có thể đăng ký trực tuyến">
                                                        Đăng ký (Dành cho Member)
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${sessionScope.currentUser.role == 'Admin' or sessionScope.currentUser.role == 'Staff'}">
                    <div class="mt-4 d-flex gap-2">
                        <%-- Nút chuyển hướng sang form chỉnh sửa thông tin PT dành cho Admin/Staff --%>
                        <a href="${pageContext.request.contextPath}/admin/pt/edit?id=${trainer.ptId}" 
                           class="btn btn-warning flex-fill py-2 fw-bold shadow-sm text-dark">
                            <i class="fa fa-edit me-2"></i>Chỉnh sửa thông tin PT
                        </a>
                        <c:if test="${sessionScope.currentUser.role == 'Admin'}">
                            <%-- Nút chuyển hướng sang màn hình quản lý bảng giá dịch vụ PT dành riêng cho Admin --%>
                            <a href="${pageContext.request.contextPath}/admin/pt/service-prices?id=${trainer.ptId}" 
                               class="btn btn-primary flex-fill py-2 fw-bold shadow-sm text-white">
                                <i class="fa fa-hand-holding-usd me-2"></i>Quản lý giá dịch vụ
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="../common/dashboard_footer.jsp"/>
