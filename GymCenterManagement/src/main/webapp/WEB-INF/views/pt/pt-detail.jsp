<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.PersonalTrainer" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.PTServicePrice" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : pt-detail.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện chi tiết thông tin và bảng giá dịch vụ của Huấn luyện viên.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    PersonalTrainer trainer = (PersonalTrainer) request.getAttribute("trainer");
    List<PTServicePrice> servicePrices = (List<PTServicePrice>) request.getAttribute("servicePrices");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

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

    <% if (trainer != null) { %>
        <div class="row g-4 mb-4">
            <!-- Left Side: Profile Card -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm text-center p-4">
                    <div class="bg-primary-gradient rounded-top position-absolute start-0 top-0 w-100" style="height: 6px;"></div>
                    <div class="mt-3">
                        <% if (trainer.getAvatarPath() != null && !trainer.getAvatarPath().trim().isEmpty()) { %>
                            <% String avatarPath = trainer.getAvatarPath(); if (!avatarPath.startsWith("/")) avatarPath = "/" + avatarPath; %>
                            <img src="${pageContext.request.contextPath}<%= avatarPath %>" 
                                 alt="Ảnh đại diện HLV" 
                                 class="rounded-circle border border-4 border-white shadow img-thumbnail mb-3" 
                                 style="width: 150px; height: 150px; object-fit: cover;">
                        <% } else { %>
                            <div class="rounded-circle border border-4 border-white shadow bg-light text-primary d-flex align-items-center justify-content-center mx-auto mb-3" 
                                 style="width: 150px; height: 150px; font-size: 48px;">
                                <i class="fa fa-user"></i>
                            </div>
                        <% } %>
                    </div>
                    
                    <h4 class="text-dark fw-bold mb-1"><%= trainer.getPublicName() %></h4>
                    <p class="text-secondary small mb-3"><%= trainer.getEmail() != null ? trainer.getEmail() : "Email chưa cập nhật" %></p>
                    
                    <div class="mb-3">
                        <span class="badge bg-light-primary text-primary px-3 py-2 rounded-pill fw-semibold fs-7">
                            <i class="fa fa-dumbbell me-1"></i> <%= trainer.getSpecialization() %>
                        </span>
                    </div>

                    <ul class="list-group list-group-flush text-start small mb-3">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-calendar-alt me-1.5 text-secondary"></i>Kinh nghiệm:</span>
                            <span class="fw-bold text-dark"><%= trainer.getExperienceYears() %> năm</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-phone me-1.5 text-secondary"></i>Điện thoại:</span>
                            <span class="fw-bold text-dark"><%= trainer.getPhone() != null ? trainer.getPhone() : "Chưa cập nhật" %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted"><i class="fa fa-info-circle me-1.5 text-secondary"></i>Trạng thái:</span>
                            <span class="badge bg-success rounded-pill px-2.5 py-1">Hoạt động</span>
                        </li>
                    </ul>

                    <% if (trainer.hasCertificate()) { %>
                        <div class="p-3 bg-light rounded mt-2 text-start">
                            <h6 class="text-dark fw-bold mb-1"><i class="fa fa-certificate text-warning me-1.5"></i>Chứng chỉ đã xác minh</h6>
                            <small class="text-muted text-truncate d-block mb-2" style="max-width: 250px;">
                                <%= trainer.getCertificateFileName() %>
                            </small>
                            <% 
                                String certPath = trainer.getCertificateFilePath(); 
                                if (certPath != null) {
                                    // Sửa lỗi lệch đường dẫn nếu dữ liệu cũ chỉ có 'uploads/...'
                                    if (!certPath.contains("assets/") && certPath.startsWith("uploads/")) {
                                        certPath = "assets/uploads/pt-certificate/" + certPath.substring(8);
                                    }
                                    if (!certPath.startsWith("/")) certPath = "/" + certPath; 
                                }
                            %>
                            <a href="${pageContext.request.contextPath}<%= certPath %>"
                               target="_blank" 
                               class="btn btn-sm btn-primary w-100 shadow-sm py-1.5">
                                <i class="fa fa-eye me-1"></i> Xem File chứng chỉ
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Right Side: Biography & Service Packages -->
            <div class="col-lg-8">
                <!-- Biography / Description Card -->
                <div class="card border-0 shadow-sm p-4 mb-4">
                    <h5 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-address-card text-primary me-2"></i>Giới thiệu bản thân</h5>
                    <p class="text-dark mb-0 lh-relaxed" style="white-space: pre-line;">
                        <%= (trainer.getDescription() != null && !trainer.getDescription().trim().isEmpty()) ? trainer.getDescription() : "Huấn luyện viên chưa cập nhật thông tin giới thiệu." %>
                    </p>
                </div>

                <!-- Service Packages Card -->
                <div class="card border-0 shadow-sm p-4">
                    <h5 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-tags text-primary me-2"></i>Bảng giá các gói tập với <%= trainer.getPublicName() %></h5>
                    
                    <% if (servicePrices == null || servicePrices.isEmpty()) { %>
                        <div class="text-center py-4 text-muted">
                            <i class="fa fa-box-open fa-2x mb-2 text-secondary"></i>
                            <p class="mb-0 small">Hiện HLV này chưa đăng ký biểu giá các gói tập cụ thể. Vui lòng liên hệ lễ tân để biết thêm chi tiết.</p>
                        </div>
                    <% } else { %>
                        <div class="row row-cols-1 row-cols-md-2 g-3">
                            <% for (PTServicePrice price : servicePrices) { %>
                                <div class="col">
                                    <div class="border rounded p-3 h-100 d-flex flex-column hover-shadow transition-all bg-white position-relative">
                                        <span class="position-absolute top-0 end-0 badge bg-primary rounded-bottom-left px-2.5 py-1.5">
                                            <%= price.getNumberOfSessions() %> buổi
                                        </span>
                                        <h6 class="text-dark fw-bold mb-1 pe-5"><%= price.getPackageName() %></h6>
                                        <p class="text-muted small mb-3 flex-grow-1"><%= price.getPackageDescription() %></p>
                                        
                                        <div class="d-flex align-items-baseline mb-3">
                                            <span class="text-primary fw-bold fs-4"><%= currencyFormat.format(price.getPrice()) %></span>
                                            <span class="text-muted small ms-1">/ <%= price.getDurationMonths() %> tháng</span>
                                        </div>

                                        <c:choose>
                                            <c:when test="${sessionScope.currentUser.role == 'Member'}">
                                                <a href="${pageContext.request.contextPath}/member/pt/register?priceId=<%= price.getPtServicePriceId() %>" 
                                                   class="btn btn-primary w-100 mt-auto py-2 fw-semibold shadow-sm">
                                                    Đăng ký gói tập này
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-outline-secondary w-100 mt-auto py-2 fw-semibold" disabled title="Chỉ hội viên mới có thể đăng ký trực tuyến">
                                                    Đăng ký (Dành cho Member)
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    <% } %>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
