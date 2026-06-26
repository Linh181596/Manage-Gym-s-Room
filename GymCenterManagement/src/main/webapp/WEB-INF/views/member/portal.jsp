<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.User" %>

<%--
  =========================================================================
  Document    : portal.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Trí Linh (linhnt)
  Description : Giao diện cổng thông tin (Portal) của hội viên.
  =========================================================================
--%>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    Map<String, String> profile = (Map<String, String>) request.getAttribute("memberProfile");
    List<Map<String, String>> services = (List<Map<String, String>>) request.getAttribute("memberServices");
    String contextPath = request.getContextPath();
    
    User sessionUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
    boolean isStaffOrAdmin = sessionUser != null && (sessionUser.getRole() == User.Role.Staff || sessionUser.getRole() == User.Role.Admin);
    String backLink = isStaffOrAdmin ? (contextPath + "/staff/members") : (contextPath + "/member/dashboard");
    String backText = isStaffOrAdmin ? "Quay lại danh sách" : "Về Bảng điều khiển";
%>

<!-- Member Portal Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Header Title and Actions -->
    <div class="d-flex align-items-center justify-content-between mb-4 bg-light rounded p-4 border">
        <div>
            <h5 class="mb-1 text-primary fw-bold"><i class="fa fa-id-card me-2"></i>Cổng thông tin hội viên (Portal)</h5>
            <small class="text-muted">Theo dõi và kiểm tra thời hạn các gói tập của bạn tại trung tâm</small>
        </div>
        <a href="<%= backLink %>" class="btn btn-outline-primary py-2 px-3 fw-bold">
            <i class="fa fa-arrow-left me-2"></i><%= backText %>
        </a>
    </div>

    <!-- Main Content Row -->
    <div class="row g-4">
        <!-- Profile Account Info Card -->
        <div class="col-12 col-xl-5">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-user me-2 text-primary"></i>Thông tin tài khoản chính
                </h6>
                <% if (profile != null && !profile.isEmpty()) { %>
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="p-3 bg-white rounded border">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Mã thành viên</small>
                                <span class="fw-bold text-dark fs-6">#<%= profile.get("memberId") %> (User ID: <%= profile.get("userId") %>)</span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="p-3 bg-white rounded border">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Họ và Tên</small>
                                <span class="fw-bold text-primary fs-5"><%= profile.get("fullName") %></span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="p-3 bg-white rounded border">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Hạng thẻ / Gói hiện tại</small>
                                <span class="fw-bold text-dark fs-6"><%= profile.get("type") %></span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="p-3 bg-white rounded border h-100">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Địa chỉ Email</small>
                                <span class="fw-semibold text-dark fs-6 text-break"><%= profile.get("email") %></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-white rounded border h-100">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Số điện thoại</small>
                                <span class="fw-semibold text-dark fs-6"><%= profile.get("phone") %></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-white rounded border h-100">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Trạng thái tài khoản</small>
                                <% boolean isActive = "Active".equalsIgnoreCase(profile.get("status")); %>
                                <span class="badge <%= isActive ? "bg-success" : "bg-danger" %> mt-1 fw-bold fs-7">
                                    <i class="<%= isActive ? "fa fa-check-circle" : "fa fa-minus-circle" %> me-1"></i><%= isActive ? "Đang kích hoạt" : "Đang tạm khóa" %>
                                </span>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="p-3 bg-white rounded border h-100">
                                <small class="text-muted fw-semibold text-uppercase d-block" style="font-size: 11px;">Ngày gia nhập</small>
                                <span class="fw-semibold text-dark fs-6"><%= profile.get("date").split("\\.")[0] %></span>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    <div class="text-center py-5 text-muted">
                        <i class="fa fa-exclamation-triangle fa-3x mb-3 text-warning"></i>
                        <p class="mb-0">Không tìm thấy hồ sơ dữ liệu của hội viên này. Vui lòng kiểm tra lại quyền hạn.</p>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Service History Table Card -->
        <div class="col-12 col-xl-7">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-history me-2 text-primary"></i>Lịch sử đăng ký dịch vụ & Gói tập
                </h6>
                <div class="table-responsive">
                    <% if (services != null && !services.isEmpty()) { %>
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark bg-white">
                                    <th scope="col">Tên Gói Dịch Vụ Gym</th>
                                    <th scope="col">Ngày Kích Hoạt</th>
                                    <th scope="col">Ngày Hết Hạn</th>
                                    <th scope="col">Trạng Thái Gói</th>
                                    <th scope="col" class="text-center">Hóa đơn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    java.time.LocalDate today = java.time.LocalDate.now();
                                    for (Map<String, String> service : services) { 
                                        String sStatus = service.get("status");
                                        String startStr = service.get("startDate");
                                        String endStr = service.get("endDate");
                                        
                                        java.time.LocalDate startDate = java.time.LocalDate.parse(startStr);
                                        java.time.LocalDate endDate = java.time.LocalDate.parse(endStr);
                                        
                                        String statusText = "Hết hạn / Hủy";
                                        String badgeClass = "bg-secondary";
                                        String iconClass = "fa-times-circle";
                                        
                                        if ("Pending".equalsIgnoreCase(sStatus)) {
                                            statusText = "Chờ thanh toán";
                                            badgeClass = "bg-warning text-dark";
                                            iconClass = "fa-hourglass-half";
                                        } else if ("Active".equalsIgnoreCase(sStatus)) {
                                            if (today.isBefore(startDate)) {
                                                statusText = "Chờ kích hoạt";
                                                badgeClass = "bg-info text-white";
                                                iconClass = "fa-clock";
                                            } else if (today.isAfter(endDate)) {
                                                statusText = "Hết hạn";
                                                badgeClass = "bg-secondary";
                                                iconClass = "fa-times-circle";
                                            } else {
                                                statusText = "Còn hạn dùng";
                                                badgeClass = "bg-success";
                                                iconClass = "fa-check-circle";
                                            }
                                        } else if ("Locked".equalsIgnoreCase(sStatus) || "Inactive".equalsIgnoreCase(sStatus)) {
                                            statusText = "Bị hủy / Khóa";
                                            badgeClass = "bg-danger";
                                            iconClass = "fa-ban";
                                        }
                                %>
                                    <tr>
                                        <td><strong><%= service.get("serviceName") %></strong></td>
                                        <td class="text-muted small"><%= service.get("startDate") %></td>
                                        <td class="text-dark fw-bold small"><%= service.get("endDate") %></td>
                                        <td>
                                            <span class="badge <%= badgeClass %>"><i class="fa <%= iconClass %> me-1"></i><%= statusText %></span>
                                        </td>
                                        <td class="text-center">
                                            <% 
                                                String invId = service.get("invoiceId");
                                                if (invId != null && !invId.trim().isEmpty()) { 
                                                    String extraParam = "";
                                                    String viewMemId = request.getParameter("viewMemberId");
                                                    if (viewMemId != null && !viewMemId.trim().isEmpty()) {
                                                        extraParam = "&viewMemberId=" + viewMemId;
                                                    }
                                            %>
                                                <a href="<%= contextPath %>/member/invoice-detail?invoiceId=<%= invId %><%= extraParam %>" class="btn btn-sm btn-link text-primary fw-semibold p-0">
                                                    <i class="fa fa-receipt me-1"></i>Xem #<%= invId %>
                                                </a>
                                            <% } else { %>
                                                <span class="text-muted small">-</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <div class="text-center py-5 text-muted">
                            <i class="fa fa-folder-open fa-3x mb-3 text-secondary"></i>
                            <p class="mb-0">Bạn chưa đăng ký hoặc chưa được gán bất kỳ gói dịch vụ tập luyện nào.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
