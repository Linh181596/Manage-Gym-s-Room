<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fa fa-envelope me-lg-2"></i>
                <span class="d-none d-lg-inline-flex">Tin nhắn</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="#" class="dropdown-item">
                    <div class="d-flex align-items-center">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/img/user.jpg" alt=""
                             style="width: 40px; height: 40px;">
                        <div class="ms-2">
                            <h6 class="fw-normal mb-0">John đã gửi một tin nhắn</h6>
                            <small>15 phút trước</small>
                        </div>
                    </div>
                </a>
                <hr class="dropdown-divider">
                <a href="#" class="dropdown-item text-center">Xem tất cả tin nhắn</a>
            </div>
        </div>
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fa fa-bell me-lg-2"></i>
                <span class="d-none d-lg-inline-flex">Thông báo</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="#" class="dropdown-item">
                    <h6 class="fw-normal mb-0">Cập nhật hồ sơ thành công</h6>
                    <small>15 phút trước</small>
                </a>
                <hr class="dropdown-divider">
                <a href="#" class="dropdown-item text-center">Xem tất cả thông báo</a>
            </div>
        </div>
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
