<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.mycompany.gymcentermanagement.dao.GymDAO" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.User" %>
<%@ page import="java.util.*" %>
<%
    User navUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
    List<Map<String, String>> navNotifications = null;
    int navUnreadCount = 0;
    if (navUser != null) {
        try {
            GymDAO navGymDAO = new GymDAO();
            navNotifications = navGymDAO.getNotifications(navUser.getUserId());
            if (navNotifications != null) {
                for (Map<String, String> n : navNotifications) {
                    if ("false".equalsIgnoreCase(n.get("isRead"))) {
                        navUnreadCount++;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<%--
  =========================================================================
  Document    : dashboard_navbar.jsp
  Created on  : 2026-06-11
  Author      : Nguyễn Đại Dương
  Description : Thanh điều hướng phía trên (top navbar) chứa thông tin tin nhắn, thông báo và menu cá nhân
  =========================================================================
--%>
<!-- Navbar Start -->
<nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand d-flex d-lg-none me-4">
        <h2 class="text-primary mb-0"><i class="fa fa-dumbbell"></i></h2>
    </a>
    <a href="#" class="sidebar-toggler flex-shrink-0">
        <i class="fa fa-bars"></i>
    </a>
    <form class="d-none d-md-flex ms-4">
        <input class="form-control border-0" type="search" placeholder="Tìm kiếm...">
    </form>
    <div class="navbar-nav align-items-center ms-auto">
        <% if (navUser != null && navUser.getRole() != User.Role.Admin) { %>
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle position-relative" data-bs-toggle="dropdown">
                <i class="fa fa-bell me-lg-2"></i>
                <% if (navUnreadCount > 0) { %>
                    <span class="position-absolute translate-middle badge rounded-pill bg-danger" style="top: 15px; left: 22px; font-size: 0.6rem; padding: 0.25em 0.4em;">
                        <%= navUnreadCount %>
                    </span>
                <% } %>
                <span class="d-none d-lg-inline-flex">Thông báo</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0" style="min-width: 320px; max-height: 380px; overflow-y: auto; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                <div class="px-3 py-2 border-bottom bg-light d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-dark" style="font-size: 0.85rem;">Thông báo mới nhận</span>
                    <% if (navUnreadCount > 0) { %>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill" style="font-size: 0.7rem;"><%= navUnreadCount %> chưa đọc</span>
                    <% } %>
                </div>
                <% if (navNotifications != null && !navNotifications.isEmpty()) { %>
                    <% 
                        int count = 0;
                        for (Map<String, String> n : navNotifications) {
                            if (count >= 5) break;
                            count++;
                            boolean isRead = "true".equalsIgnoreCase(n.get("isRead"));
                            String rolePath = navUser.getRole() == User.Role.Admin ? "admin" : (navUser.getRole() == User.Role.Staff ? "staff" : (navUser.getRole() == User.Role.PT ? "pt" : "member"));
                            String notiLink = request.getContextPath() + "/" + rolePath + "/notifications/detail?notiId=" + n.get("id");
                    %>
                            <a href="<%= notiLink %>" class="dropdown-item px-3 py-2 border-bottom d-block <%= isRead ? "" : "bg-primary-subtle" %>" style="white-space: normal;">
                                <div class="d-flex w-100 justify-content-between align-items-start gap-1">
                                    <h6 class="mb-1 fw-bold text-dark" style="font-size: 0.8rem; line-height: 1.2;"><%= n.get("title") %></h6>
                                    <% if (!isRead) { %>
                                        <span class="rounded-circle bg-primary mt-1" style="width: 7px; height: 7px; flex-shrink: 0; display: inline-block;"></span>
                                    <% } %>
                                </div>
                                <p class="text-muted mb-1 text-truncate" style="font-size: 0.75rem;"><%= n.get("content") %></p>
                                <small class="text-muted d-block" style="font-size: 0.7rem;"><i class="fa fa-clock me-1"></i><%= n.get("createdAt").split("\\.")[0] %></small>
                            </a>
                    <% } %>
                <% } else { %>
                    <div class="text-center py-4 text-muted border-bottom">
                        <i class="fa fa-bell-slash fa-2x mb-2 text-secondary d-block"></i>
                        <small style="font-size: 0.8rem;">Bạn không có thông báo nào</small>
                    </div>
                <% } %>
                <%
                    String allNotisLink = request.getContextPath() + "/";
                    if (navUser != null) {
                        allNotisLink += (navUser.getRole() == User.Role.Admin ? "admin/notifications" : (navUser.getRole() == User.Role.Staff ? "staff/notifications" : (navUser.getRole() == User.Role.PT ? "pt/notifications" : "member/notifications")));
                    }
                %>
                <a href="<%= allNotisLink %>" class="dropdown-item text-center fw-bold py-2 text-primary text-decoration-none" style="font-size: 0.8rem;">Xem tất cả thông báo</a>
            </div>
        </div>
        <% } %>
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/${not empty sessionScope.currentUser.avatarPath ? sessionScope.currentUser.avatarPath : 'img/user.jpg'}" alt=""
                     style="width: 40px; height: 40px; object-fit: cover;">
                <!-- If had upload img then -> sessionScope.currentUser.avatarPath \\ If not -> default img: /img/user.jpg(default) -->
                <span class="d-none d-lg-inline-flex">${sessionScope.currentUser.fullName}</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="${pageContext.request.contextPath}${sessionScope.currentUser.role == 'PT' ? '/pt/profile' : '/profile'}" class="dropdown-item">Hồ sơ cá nhân</a>
                <a href="${pageContext.request.contextPath}/change-password" class="dropdown-item ${sessionScope.currentUser.role == 'PT' ? 'd-none' : ''}">Đổi mật khẩu</a>
                <a href="#" class="dropdown-item">Cài đặt</a>
                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Đăng xuất</a>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->
