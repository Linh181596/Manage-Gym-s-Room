<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>GCMS - Gym Center Management System</title>
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
                <span class="sr-only">Loading...</span>
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
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${sessionScope.currentUser.fullName}</h6>
                        <span>${sessionScope.currentUser.role}</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <c:set var="role" value="${sessionScope.currentUser.role}" />
                    <c:choose>
                        <c:when test="${role == 'Admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-users me-2"></i>Manage Users</a>
                            <a href="${pageContext.request.contextPath}/admin/packages" class="nav-item nav-link"><i class="fa fa-box me-2"></i>Gym Packages</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-dumbbell me-2"></i>Gym Equipment</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-alt me-2"></i>Classes & Schedule</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-chart-line me-2"></i>Reports</a>
                        </c:when>
                        <c:when test="${role == 'Staff'}">
                            <a href="${pageContext.request.contextPath}/staff/dashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-clipboard-check me-2"></i>Check-in</a>
                            <a href="${pageContext.request.contextPath}/staff/register-package" class="nav-item nav-link"><i class="fa fa-user-plus me-2"></i>Register Package</a>
                            <a href="${pageContext.request.contextPath}/staff/record-payment" class="nav-item nav-link"><i class="fa fa-cash-register me-2"></i>Record Payment</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-check me-2"></i>Bookings</a>
                        </c:when>
                        <c:when test="${role == 'PT'}">
                            <a href="${pageContext.request.contextPath}/pt/dashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-user-friends me-2"></i>My Clients</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-alt me-2"></i>Sessions</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-tasks me-2"></i>Workout Plans</a>
                        </c:when>
                        <c:when test="${role == 'Member'}">
                            <a href="${pageContext.request.contextPath}/member/dashboard" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-calendar-plus me-2"></i>Book Class</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-user-tie me-2"></i>Book PT</a>
                            <a href="#" class="nav-item nav-link"><i class="fa fa-id-card me-2"></i>Membership</a>
                        </c:when>
                    </c:choose>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
