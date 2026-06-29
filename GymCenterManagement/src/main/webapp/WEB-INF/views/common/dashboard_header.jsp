<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>GCMS - Hệ thống quản lý phòng tập Gym</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Gym Center Management System" name="keywords">
    <meta content="GCMS Dashboard" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Đang tải...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="${pageContext.request.contextPath}/" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-dumbbell me-2"></i>GCMS</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/${not empty sessionScope.currentUser.avatarPath ? sessionScope.currentUser.avatarPath : 'img/user.jpg'}" alt="" style="width: 40px; height: 40px; object-fit: cover;">
                        <!-- If had upload img then -> sessionScope.currentUser.avatarPath \\ If not -> default img: /img/user.jpg(default) -->
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${sessionScope.currentUser.fullName}</h6>
                        <span>
                            <c:choose>
                                <c:when test="${sessionScope.currentUser.role == 'Admin'}">Quản trị viên</c:when>
                                <c:when test="${sessionScope.currentUser.role == 'Staff'}">Nhân viên</c:when>
                                <c:when test="${sessionScope.currentUser.role == 'PT'}">HLV (PT)</c:when>
                                <c:when test="${sessionScope.currentUser.role == 'Member'}">Hội viên</c:when>
                                <c:otherwise>${sessionScope.currentUser.role}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <c:set var="role" value="${sessionScope.currentUser.role}" />
                    <c:set var="reqUri" value="${requestScope['jakarta.servlet.forward.request_uri']}" />
                    <c:if test="${empty reqUri}">
                        <c:set var="reqUri" value="${pageContext.request.requestURI}" />
                    </c:if>
                    <c:choose>
                        <c:when test="${role == 'Admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item nav-link ${fn:contains(reqUri, '/admin/dashboard') ? 'active' : ''}"><i class="fa fa-tachometer-alt me-2"></i>Bảng điều khiển</a>
                            <a href="${pageContext.request.contextPath}/admin/accounts" class="nav-item nav-link ${fn:contains(reqUri, '/admin/accounts') ? 'active' : ''}"><i class="fa fa-users me-2"></i>Quản lý người dùng</a>
                            <a href="${pageContext.request.contextPath}/admin/packages" class="nav-item nav-link ${fn:contains(reqUri, '/admin/packages') ? 'active' : ''}"><i class="fa fa-box me-2"></i>Gói tập Gym</a>
                            <a href="${pageContext.request.contextPath}/staff/equipment" class="nav-item nav-link ${(fn:contains(reqUri, '/staff/equipment') && !fn:contains(reqUri, '/staff/equipment-issues') && param.from != 'report') ? 'active' : ''}"><i class="fa fa-dumbbell me-2"></i>Thiết bị phòng tập</a>
                            <a href="${pageContext.request.contextPath}/staff/maintenance-schedules" class="nav-item nav-link ${fn:contains(reqUri, '/staff/maintenance-schedules') ? 'active' : ''}"><i class="fa fa-tools me-2"></i>Lịch bảo trì</a>
                            <a href="${pageContext.request.contextPath}/pt/list" class="nav-item nav-link ${fn:contains(reqUri, '/pt/list') || fn:contains(reqUri, '/pt/detail') || fn:contains(reqUri, '/staff/pt/') ? 'active' : ''}"><i class="fa fa-user-tie me-2"></i>Đội ngũ HLV (PT)</a>
                            <a href="${pageContext.request.contextPath}/admin/schedule/manage" class="nav-item nav-link ${fn:contains(reqUri, '/admin/schedule/manage') || fn:contains(reqUri, '/admin/pt/schedule-setup') ? 'active' : ''}"><i class="fa fa-calendar-alt me-2"></i>Lớp học & Lịch trình</a>
                            <a href="${pageContext.request.contextPath}/admin/equipment-reports" class="nav-item nav-link ${(fn:contains(reqUri, '/admin/equipment-reports') || fn:contains(reqUri, '/staff/equipment-issues') || param.from == 'report') ? 'active' : ''}"><i class="fa fa-chart-bar me-2"></i>Báo cáo thiết bị</a>
                            <a href="${pageContext.request.contextPath}/admin/payment-history" class="nav-item nav-link ${fn:contains(reqUri, '/admin/payment-history') ? 'active' : ''}"><i class="fa fa-history me-2"></i>Lịch sử thanh toán</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-chart-line me-2"></i>Báo cáo thống kê</a>
                        </c:when>
                        <c:when test="${role == 'Staff'}">
                            <a href="${pageContext.request.contextPath}/staff/dashboard" class="nav-item nav-link ${fn:contains(reqUri, '/staff/dashboard') ? 'active' : ''}"><i class="fa fa-tachometer-alt me-2"></i>Bảng điều khiển</a>
                            <a href="${pageContext.request.contextPath}/staff/members" class="nav-item nav-link ${fn:contains(reqUri, '/staff/members') ? 'active' : ''}"><i class="fa fa-users me-2"></i>Quản lý hội viên</a>
                            <a href="${pageContext.request.contextPath}/pt/list" class="nav-item nav-link ${fn:contains(reqUri, '/pt/list') || fn:contains(reqUri, '/pt/detail') || fn:contains(reqUri, '/staff/pt/') ? 'active' : ''}"><i class="fa fa-user-tie me-2"></i>Quản lý HLV (PT)</a>
                            <a href="${pageContext.request.contextPath}/admin/schedule/manage" class="nav-item nav-link ${fn:contains(reqUri, '/admin/schedule/manage') || fn:contains(reqUri, '/admin/pt/schedule-setup') ? 'active' : ''}"><i class="fa fa-calendar-alt me-2"></i>Lớp học & Lịch trình</a>
                            <a href="${pageContext.request.contextPath}/staff/equipment" class="nav-item nav-link ${(fn:contains(reqUri, '/staff/equipment') && !fn:contains(reqUri, '/staff/equipment-issues')) ? 'active' : ''}"><i class="fa fa-dumbbell me-2"></i>Quản lý thiết bị</a>
                            <a href="${pageContext.request.contextPath}/staff/equipment-issues" class="nav-item nav-link ${fn:contains(reqUri, '/staff/equipment-issues') ? 'active' : ''}"><i class="fa fa-exclamation-triangle me-2"></i>Sự cố thiết bị</a>
                            <a href="${pageContext.request.contextPath}/staff/maintenance-schedules" class="nav-item nav-link ${fn:contains(reqUri, '/staff/maintenance-schedules') ? 'active' : ''}"><i class="fa fa-tools me-2"></i>Lịch bảo trì</a>
                            <a href="${pageContext.request.contextPath}/staff/checkin" class="nav-item nav-link ${fn:contains(reqUri, '/staff/checkin') || fn:contains(reqUri, '/staff/work-history') ? 'active' : ''}"><i class="fa fa-clipboard-check me-2"></i>Điểm danh ra vào</a>
                            <a href="${pageContext.request.contextPath}/staff/register-package" class="nav-item nav-link ${fn:contains(reqUri, '/staff/register-package') ? 'active' : ''}"><i class="fa fa-user-plus me-2"></i>Đăng ký gói tập</a>
                            <a href="${pageContext.request.contextPath}/staff/record-payment" class="nav-item nav-link ${fn:contains(reqUri, '/staff/record-payment') ? 'active' : ''}"><i class="fa fa-cash-register me-2"></i>Thanh toán hóa đơn</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-check me-2"></i>Lịch đặt trước</a>
                        </c:when>
                        <c:when test="${role == 'PT'}">
                            <a href="${pageContext.request.contextPath}/pt/dashboard" class="nav-item nav-link ${fn:contains(reqUri, '/pt/dashboard') ? 'active' : ''}"><i class="fa fa-tachometer-alt me-2"></i>Bảng điều khiển</a>
                            <a href="${pageContext.request.contextPath}/pt/members" class="nav-item nav-link ${fn:contains(reqUri, '/pt/members') ? 'active' : ''}"><i class="fa fa-user-friends me-2"></i>Hội viên của tôi</a>
                            <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="nav-item nav-link ${fn:contains(reqUri, '/pt/schedule-dashboard') ? 'active' : ''}"><i class="fa fa-calendar-alt me-2"></i>Lịch dạy học</a></c:when>
                        <c:when test="${role == 'Member'}">
                            <a href="${pageContext.request.contextPath}/member/dashboard" class="nav-item nav-link ${fn:contains(reqUri, '/member/dashboard') ? 'active' : ''}"><i class="fa fa-tachometer-alt me-2"></i>Bảng điều khiển</a>
                            <a href="${pageContext.request.contextPath}/member/portal" class="nav-item nav-link ${fn:contains(reqUri, '/member/portal') ? 'active' : ''}"><i class="fa fa-id-card me-2"></i>Thẻ & Gói tập</a>
                            <a href="${pageContext.request.contextPath}/member/notifications" class="nav-item nav-link ${fn:contains(reqUri, '/member/notifications') ? 'active' : ''}"><i class="fa fa-bell me-2"></i>Hộp thư thông báo</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-plus me-2"></i>Đặt lớp tập</a>
                            <a href="${pageContext.request.contextPath}/pt/list" class="nav-item nav-link ${fn:contains(reqUri, '/pt/list') || fn:contains(reqUri, '/pt/detail') || fn:contains(reqUri, '/member/pt/') ? 'active' : ''}"><i class="fa fa-user-tie me-2"></i>Thuê HLV (PT)</a>
                        </c:when>
                    </c:choose>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
