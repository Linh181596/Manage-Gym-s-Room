<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    List<Map<String, String>> notis = (List<Map<String, String>>) request.getAttribute("notis");
    Map<String, String> selectedNoti = (Map<String, String>) request.getAttribute("selectedNoti");
    int selectedId = request.getAttribute("selectedNotiId") != null ? (Integer) request.getAttribute("selectedNotiId") : -1;
    String contextPath = request.getContextPath();
    String mailboxTitle = request.getAttribute("mailboxTitle") != null ? (String) request.getAttribute("mailboxTitle") : "Hộp thư thông báo cá nhân";
    String mailboxSubtitle = request.getAttribute("mailboxSubtitle") != null ? (String) request.getAttribute("mailboxSubtitle") : "Xem các thông báo mới nhất từ trung tâm";
    String dashboardUrl = request.getAttribute("dashboardUrl") != null ? (String) request.getAttribute("dashboardUrl") : contextPath + "/member/dashboard";
    String notificationBasePath = request.getAttribute("notificationBasePath") != null ? (String) request.getAttribute("notificationBasePath") : contextPath + "/member/notifications";
    int unreadCount = 0;
    if (notis != null) {
        for (Map<String, String> noti : notis) {
            if ("false".equalsIgnoreCase(noti.get("isRead"))) {
                unreadCount++;
            }
        }
    }
%>

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4 bg-light rounded p-4 border">
        <div>
            <h5 class="mb-1 text-primary fw-bold"><i class="fa fa-bell me-2"></i><%= mailboxTitle %></h5>
            <small class="text-muted"><%= mailboxSubtitle %></small>
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2">
                Chưa đọc: <%= unreadCount %>
            </span>
            <a href="<%= dashboardUrl %>" class="btn btn-outline-primary py-2 px-3 fw-bold">
                <i class="fa fa-arrow-left me-2"></i>Về bảng điều khiển
            </a>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2 d-flex align-items-center justify-content-between">
                    <span><i class="fa fa-envelope-open me-2 text-primary"></i>Danh sách thông báo</span>
                    <span class="badge bg-light text-dark border"><%= notis != null ? notis.size() : 0 %></span>
                </h6>
                <div style="max-height: 500px; overflow-y: auto; padding-right: 4px;">
                    <% if (notis != null && !notis.isEmpty()) { %>
                        <div class="list-group">
                            <%
                                for (Map<String, String> noti : notis) {
                                    int notiId = Integer.parseInt(noti.get("id"));
                                    boolean isActiveNoti = (notiId == selectedId);
                                    boolean isRead = "true".equalsIgnoreCase(noti.get("isRead"));
                                    String itemClass = isActiveNoti
                                            ? "active border-primary shadow-sm"
                                            : (isRead ? "bg-white border-light-subtle" : "bg-primary-subtle border-primary-subtle shadow-sm");
                            %>
                                <a href="<%= notificationBasePath %>/detail?notiId=<%= notiId %>"
                                   class="list-group-item list-group-item-action <%= itemClass %> p-3 border mb-2 rounded">
                                    <div class="d-flex w-100 justify-content-between align-items-start gap-2 mb-1">
                                        <h6 class="mb-0 fw-bold <%= isActiveNoti ? "text-white" : "text-dark" %>">
                                            <i class="fa <%= isRead ? "fa-envelope-open" : "fa-envelope" %> me-1"></i><%= noti.get("title") %>
                                        </h6>
                                        <span class="badge <%= isActiveNoti ? "bg-white text-primary" : (isRead ? "bg-light text-secondary border" : "bg-primary text-white") %>">
                                            <%= isRead ? "Đã đọc" : "Chưa đọc" %>
                                        </span>
                                    </div>
                                    <div class="small <%= isActiveNoti ? "text-white-50" : (isRead ? "text-muted" : "text-primary-emphasis") %> mb-2 text-truncate">
                                        <%= noti.get("content") %>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between">
                                        <small class="<%= isActiveNoti ? "text-white-50" : "text-muted" %>">
                                            <i class="fa fa-clock me-1"></i>Gửi lúc: <%= noti.get("createdAt").split("\\.")[0] %>
                                        </small>
                                        <% if (!isRead && !isActiveNoti) { %>
                                            <span class="rounded-circle bg-primary" style="width: 10px; height: 10px; display: inline-block;"></span>
                                        <% } %>
                                    </div>
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

        <div class="col-lg-8">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-file-alt me-2 text-primary"></i>Nội dung chi tiết thông báo
                </h6>
                <% if (selectedNoti != null) { %>
                    <div class="bg-white rounded p-4 border">
                        <div class="d-flex align-items-start justify-content-between gap-3 mb-2">
                            <h4 class="text-primary fw-bold mb-0"><%= selectedNoti.get("title") %></h4>
                            <span class="badge bg-success-subtle text-success border border-success-subtle">Đã đọc</span>
                        </div>
                        <div class="text-muted small mb-3 border-bottom pb-2">
                            <i class="fa fa-calendar-alt me-2"></i>Ngày gửi: <%= selectedNoti.get("createdAt").split("\\.")[0] %>
                        </div>
                        <% if (selectedNoti.get("imageUrl") != null && !selectedNoti.get("imageUrl").isEmpty()) { %>
                            <div class="mb-3">
                                <img src="<%= contextPath %>/<%= selectedNoti.get("imageUrl") %>"
                                     alt="Ảnh thông báo"
                                     class="img-fluid rounded border"
                                     style="max-height: 320px; object-fit: cover;">
                            </div>
                        <% } %>
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
                        <p class="mb-0">Vui lòng chọn một thông báo ở danh sách bên trái để đọc nội dung chi tiết.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
