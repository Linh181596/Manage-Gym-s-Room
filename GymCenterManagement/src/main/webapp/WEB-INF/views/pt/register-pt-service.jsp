<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.PTServicePrice" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : register-pt-service.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện xác nhận đăng ký gói dịch vụ PT của hội viên.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    PTServicePrice servicePrice = (PTServicePrice) request.getAttribute("servicePrice");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<div class="container-fluid pt-4 px-4">
    <!-- Navigation Back Link -->
    <div class="mb-4">
        <% if (servicePrice != null) { %>
            <a href="${pageContext.request.contextPath}/pt/detail?id=<%= servicePrice.getPtId() %>" class="btn btn-sm btn-outline-secondary px-3 shadow-sm">
                <i class="fa fa-arrow-left me-1"></i> Quay lại chi tiết HLV
            </a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-sm btn-outline-secondary px-3 shadow-sm">
                <i class="fa fa-arrow-left me-1"></i> Quay về danh sách HLV
            </a>
        <% } %>
    </div>

    <div class="row justify-content-center mb-4">
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <!-- Top Gradient Decoration -->
                <div class="bg-primary-gradient rounded-top position-absolute start-0 top-0 w-100" style="height: 6px;"></div>
                
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-id-card-alt me-2 text-primary"></i>Xác nhận đăng ký Gói tập với PT</h4>
                    <small class="text-muted">Xem lại thông tin gói tập và gửi yêu cầu đăng ký của bạn</small>
                </div>

                <div class="card-body p-4">
                    <!-- Error Message Display -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                            <i class="fa fa-exclamation-circle me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <% if (servicePrice != null) { %>
                        <!-- Package Details Panel -->
                        <div class="bg-light rounded p-4 mb-4 border shadow-sm">
                            <h6 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-dumbbell text-primary me-2"></i>Thông tin gói dịch vụ tập luyện</h6>
                            
                            <div class="mb-2">
                                <span class="text-muted d-block small">Huấn luyện viên cá nhân (PT):</span>
                                <strong class="text-dark"><%= servicePrice.getTrainerName() %></strong>
                            </div>
                            <div class="mb-2">
                                <span class="text-muted d-block small">Tên gói tập:</span>
                                <strong class="text-dark"><%= servicePrice.getPackageName() %></strong>
                            </div>
                            <div class="mb-2">
                                <span class="text-muted d-block small">Thời hạn:</span>
                                <strong class="text-dark"><%= servicePrice.getDurationMonths() %> tháng (<%= servicePrice.getNumberOfSessions() %> buổi tập)</strong>
                            </div>
                            <div class="mb-2">
                                <span class="text-muted d-block small">Mô tả chi tiết:</span>
                                <span class="text-secondary small"><%= servicePrice.getPackageDescription() %></span>
                            </div>
                            <div class="mt-3 border-top pt-2">
                                <span class="text-muted d-block small">Tổng tiền gói dịch vụ:</span>
                                <strong class="text-primary fs-4"><%= currencyFormat.format(servicePrice.getPrice()) %></strong>
                            </div>
                        </div>

                        <!-- Registration Submission Form -->
                        <form method="post" action="${pageContext.request.contextPath}/member/pt/register">
                            <input type="hidden" name="priceId" value="<%= servicePrice.getPtServicePriceId() %>">
                            
                            <!-- Preferred Start Date -->
                            <div class="mb-3">
                                <label for="preferredStartDate" class="form-label fw-semibold text-secondary">Ngày bắt đầu tập luyện mong muốn <span class="text-danger">*</span></label>
                                <input type="date" id="preferredStartDate" name="preferredStartDate" class="form-control" required>
                                <small class="text-muted d-block mt-1 small">Lưu ý: Ngày bắt đầu không thể nhỏ hơn ngày hôm nay.</small>
                            </div>

                            <!-- Note/Goals -->
                            <div class="mb-4">
                                <label for="note" class="form-label fw-semibold text-secondary">Ghi chú huấn luyện & Mục tiêu của bạn</label>
                                <textarea id="note" name="note" class="form-control" rows="4" placeholder="Ví dụ: Tôi muốn giảm 5kg mỡ bụng, hoặc tôi bị chấn thương khớp gối cần lưu ý..."></textarea>
                            </div>

                            <!-- Form Action Buttons -->
                            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                                <a href="${pageContext.request.contextPath}/pt/detail?id=<%= servicePrice.getPtId() %>" class="btn btn-outline-secondary px-4 py-2">Hủy bỏ</a>
                                <button type="submit" class="btn btn-primary px-5 py-2 shadow-sm"><i class="fa fa-paper-plane me-1"></i> Xác nhận đăng ký</button>
                            </div>
                        </form>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Set min date of preferredStartDate to today
    document.addEventListener("DOMContentLoaded", function() {
        const dateInput = document.getElementById("preferredStartDate");
        if (dateInput) {
            const today = new Date().toISOString().split('T')[0];
            dateInput.min = today;
            dateInput.value = today;
        }
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
