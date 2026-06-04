<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.PTServicePrice" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    PTServicePrice servicePrice = (PTServicePrice) request.getAttribute("servicePrice");
    LocalDate startDate = (LocalDate) request.getAttribute("startDate");
    LocalDate endDate = (LocalDate) request.getAttribute("endDate");
    
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<div class="container-fluid pt-4 px-4">
    <div class="row justify-content-center mb-4">
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <!-- Top Gradient Decoration -->
                <div class="bg-success-gradient rounded-top position-absolute start-0 top-0 w-100" style="height: 6px;"></div>
                
                <div class="card-body p-5 text-center">
                    <!-- Success Icon -->
                    <div class="mb-4 text-success">
                        <i class="fa fa-check-circle fa-4x animate-bounce"></i>
                    </div>

                    <!-- Success Title -->
                    <h3 class="text-dark fw-bold mb-2">Gửi yêu cầu đăng ký thành công!</h3>
                    <p class="text-secondary small mb-4">Yêu cầu đăng ký tập với HLV của bạn đã được ghi nhận ở trạng thái chờ duyệt.</p>

                    <!-- Details Box -->
                    <% if (servicePrice != null) { %>
                        <div class="bg-light rounded p-4 text-start mb-4 shadow-sm border">
                            <h6 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-info-circle text-primary me-2"></i>Chi tiết đăng ký gói dịch vụ</h6>
                            
                            <div class="mb-2">
                                <span class="text-muted d-block small">Huấn luyện viên cá nhân (PT):</span>
                                <strong class="text-dark"><%= servicePrice.getTrainerName() %></strong>
                            </div>
                            <div class="mb-2">
                                <span class="text-muted d-block small">Gói tập đăng ký:</span>
                                <strong class="text-dark"><%= servicePrice.getPackageName() %></strong>
                            </div>
                            <div class="mb-2">
                                <span class="text-muted d-block small">Thời hạn dự kiến:</span>
                                <strong class="text-dark">
                                    <%= startDate != null ? dateFormatter.format(startDate) : "" %> 
                                    đến 
                                    <%= endDate != null ? dateFormatter.format(endDate) : "" %>
                                </strong>
                                <small class="text-muted d-block mt-0.5" style="font-size: 11px;">
                                    (Tổng số: <%= servicePrice.getNumberOfSessions() %> buổi tập trong <%= servicePrice.getDurationMonths() %> tháng)
                                </small>
                            </div>
                            <div class="mb-3">
                                <span class="text-muted d-block small">Tổng chi phí:</span>
                                <strong class="text-primary fs-5"><%= currencyFormat.format(servicePrice.getPrice()) %></strong>
                            </div>
                            
                            <!-- Instruction Alert -->
                            <div class="p-3 bg-light-primary rounded border border-primary text-primary-dark">
                                <span class="d-block fw-bold small mb-1">
                                    <i class="fa fa-receipt text-primary me-1.5"></i> Hướng dẫn kích hoạt tập luyện:
                                </span>
                                <small class="d-block text-secondary" style="font-size: 11.5px; line-height: 1.5;">
                                    Đăng ký của bạn hiện ở trạng thái <strong>Chưa thanh toán (Unpaid)</strong>. Vui lòng đến <strong>Quầy Lễ tân (Reception)</strong> của câu lạc bộ để hoàn tất thanh toán hóa đơn. 
                                    Sau khi thanh toán thành công, HLV của bạn sẽ liên hệ trực tiếp để sắp xếp và thống nhất lịch tập luyện cụ thể.
                                </small>
                            </div>
                        </div>
                    <% } %>

                    <!-- Action Button -->
                    <div class="d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-primary px-5 py-2.5 fw-semibold shadow-sm">
                            <i class="fa fa-dumbbell me-1.5"></i> Xem danh sách HLV khác
                        </a>
                        <a href="${pageContext.request.contextPath}/member/dashboard" class="btn btn-outline-secondary px-4 py-2.5">
                            <i class="fa fa-home me-1.5"></i> Quay về Trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
