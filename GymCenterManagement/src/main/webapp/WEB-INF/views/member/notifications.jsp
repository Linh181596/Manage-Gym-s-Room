<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    List<Map<String, String>> notis = (List<Map<String, String>>) request.getAttribute("notis");
    Map<String, String> selectedNoti = (Map<String, String>) request.getAttribute("selectedNoti");
    int selectedId = request.getAttribute("selectedNotiId") != null ? (Integer) request.getAttribute("selectedNotiId") : -1;
    String contextPath = request.getContextPath();
%>

<!-- Member Notifications Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Header Title and Actions -->
    <div class="d-flex align-items-center justify-content-between mb-4 bg-light rounded p-4 border">
        <div>
            <h5 class="mb-1 text-primary fw-bold"><i class="fa fa-bell me-2"></i>Hộp thư thông báo cá nhân</h5>
            <small class="text-muted">Xem tin tức, nhắc nhở lịch tập, ưu đãi gia hạn từ trung tâm</small>
        </div>
        <a href="<%= contextPath %>/member/dashboard" class="btn btn-outline-primary py-2 px-3 fw-bold">
            <i class="fa fa-arrow-left me-2"></i>Về Bảng điều khiển
        </a>
    </div>

    <!-- Main Layout Row -->
    <div class="row g-4">
        <!-- Notifications List Section -->
        <div class="col-lg-4">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-envelope-open me-2 text-primary"></i>Danh sách tin nhắn
                </h6>
                <div style="max-height: 500px; overflow-y: auto; padding-right: 4px;">
                    <% if (notis != null && !notis.isEmpty()) { %>
                        <div class="list-group">
                            <% 
                                for (Map<String, String> noti : notis) {
                                    int notiId = Integer.parseInt(noti.get("id"));
                                    boolean isActiveNoti = (notiId == selectedId);
                            %>
                                <a href="<%= contextPath %>/member/notifications/detail?notiId=<%= notiId %>" 
                                   class="list-group-item list-group-item-action <%= isActiveNoti ? "active" : "" %> p-3 border mb-2 rounded">
                                    <div class="d-flex w-100 justify-content-between align-items-center mb-1">
                                        <h6 class="mb-0 fw-bold <%= isActiveNoti ? "text-white" : "text-dark" %>">
                                            <i class="fa fa-envelope me-1"></i><%= noti.get("title") %>
                                        </h6>
                                    </div>
                                    <small class="<%= isActiveNoti ? "text-white-50" : "text-muted" %>">
                                        <i class="fa fa-clock me-1"></i>Gửi lúc: <%= noti.get("createdAt").split("\\.")[0] %>
                                    </small>
                                </a>
                            <% } %>
                        </div>
                    <% } else { %>
                        <div class="text-center py-5 text-muted">
                            <i class="fa fa-envelope-open fa-2x mb-2 text-secondary"></i>
                            <p class="mb-0 small">Hộp thư trống. Bạn chưa có thông báo nào.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Notification Detail Section -->
        <div class="col-lg-8">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-file-alt me-2 text-primary"></i>Nội dung chi tiết thông báo
                </h6>
                <% if (selectedNoti != null) { %>
                    <div class="bg-white rounded p-4 border">
                        <h4 class="text-primary fw-bold mb-2"><%= selectedNoti.get("title") %></h4>
                        <div class="text-muted small mb-3 border-bottom pb-2">
                            <i class="fa fa-calendar-alt me-2"></i>Ngày gửi: <%= selectedNoti.get("createdAt").split("\\.")[0] %>
                        </div>
                        <div class="text-dark p-3 rounded border-start border-primary border-4 bg-light" style="line-height: 1.6; font-size: 15px;">
                            <%= selectedNoti.get("content") %>
                        </div>
                        <div class="text-muted small mt-4 fst-italic">
                            <i class="fa fa-check-double me-1 text-success"></i>Hệ thống đã tự động đánh dấu thông báo này là "Đã đọc".
                        </div>
                    </div>
                <% } else { %>
                    <div class="text-center py-5 text-muted h-100 d-flex flex-column align-items-center justify-content-center">
                        <i class="fa fa-hand-point-left fa-3x mb-3 text-secondary"></i>
                        <p class="mb-0">Vui lòng chọn một tiêu đề thư ở danh sách bên trái để đọc nội dung chi tiết.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
