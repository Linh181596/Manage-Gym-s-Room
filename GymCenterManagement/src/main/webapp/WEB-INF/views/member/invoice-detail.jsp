<%--
  =========================================================================
  Document    : invoice-detail.jsp
  Created on  : 2026-06-26
  Author      : Nguyễn Trí Linh (linhnt)
  Description : Giao diện xem chi tiết hóa đơn và in biên lai thanh toán dành cho hội viên
  =========================================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<style>
    /* Styling specific to the Member Invoice Detail */
    .receipt-container {
        border: 2px solid #e2e8f0;
        background-color: #ffffff;
    }
    .receipt-header {
        border-bottom: 2px dashed #cbd5e1;
    }
    .receipt-footer {
        border-top: 2px dashed #cbd5e1;
    }
    
    /* Print media styling */
    @media print {
        .sidebar, .content .navbar, .container-fluid.pt-4.px-4:not(#printAreaParent), .footer, .btn, nav, .alert {
            display: none !important;
        }
        .content {
            margin-left: 0 !important;
            width: 100% !important;
            padding: 0 !important;
        }
        body {
            background-color: #ffffff !important;
            color: #000000 !important;
            font-size: 12pt;
        }
        #printReceiptCard {
            border: none !important;
            box-shadow: none !important;
            width: 100% !important;
            max-width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
        }
        .receipt-container {
            border: none !important;
        }
        #printAreaParent {
            width: 100% !important;
            padding: 0 !important;
            margin: 0 !important;
        }
    }
</style>

<div class="container-fluid pt-4 px-4" id="printAreaParent">
    <c:set var="isStaffOrAdmin" value="${sessionScope.currentUser.role == 'Staff' || sessionScope.currentUser.role == 'Admin'}" />
    
    <c:choose>
        <c:when test="${isStaffOrAdmin && not empty param.viewMemberId}">
            <c:set var="backUrl" value="${pageContext.request.contextPath}/member/portal?viewMemberId=${param.viewMemberId}" />
        </c:when>
        <c:when test="${isStaffOrAdmin}">
            <c:set var="backUrl" value="${pageContext.request.contextPath}/staff/members" />
        </c:when>
        <c:otherwise>
            <c:set var="backUrl" value="${pageContext.request.contextPath}/member/portal" />
        </c:otherwise>
    </c:choose>
    
    <c:set var="dashboardUrl" value="${pageContext.request.contextPath}/${isStaffOrAdmin ? (sessionScope.currentUser.role == 'Admin' ? 'admin/dashboard' : 'staff/dashboard') : 'member/dashboard'}" />
    
    <!-- Breadcrumbs -->
    <div class="mb-4 no-print">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${dashboardUrl}">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${backUrl}">Cổng thông tin</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết hóa đơn</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-file-invoice-dollar me-2 text-primary"></i>Chi tiết hóa đơn</h4>
            <a href="${backUrl}" class="btn btn-outline-primary d-flex align-items-center fw-bold">
                <i class="fa fa-arrow-left me-2"></i> Quay lại cổng thông tin
            </a>
        </div>
    </div>

    <!-- Error/Success Alerts -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4 no-print" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row justify-content-center">
        <div class="col-lg-9 col-xl-8" id="printReceiptCard">
            <div class="receipt-container rounded shadow-sm p-4 p-md-5 mb-4 border">
                
                <!-- Receipt Header/Branding -->
                <div class="receipt-header pb-4 mb-4 text-center text-md-start">
                    <div class="row align-items-center">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <h3 class="text-primary fw-bold mb-1"><i class="fa fa-dumbbell me-2"></i>GCMS GYM CENTER</h3>
                            <p class="text-muted small mb-0">QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội<br>SĐT: (+84) 987-654-321 | Email: support@gcms.com</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h4 class="text-uppercase text-secondary fw-semibold mb-1">Hóa đơn / Biên lai</h4>
                            <div class="text-dark fw-bold mb-1">Mã hóa đơn: INV-${invoice.invoiceId}</div>
                            <div class="text-muted small">Ngày tạo: ${invoice.createdDate.dayOfMonth}/${invoice.createdDate.monthValue}/${invoice.createdDate.year}</div>
                        </div>
                    </div>
                </div>

                <!-- Status Alerts -->
                <c:choose>
                    <c:when test="${invoice.status == 'Paid'}">
                        <div class="alert alert-success border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-check-circle fs-3 me-3 text-success"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-success">THANH TOÁN THÀNH CÔNG</h6>
                                    <span class="small text-muted">Cảm ơn quý hội viên. Gói tập liên kết hiện đã được kích hoạt thành công.</span>
                                </div>
                            </div>
                            <span class="badge bg-success rounded-pill px-3 py-1 no-print"><i class="fa fa-check"></i> Đã thanh toán</span>
                        </div>
                    </c:when>
                    <c:when test="${invoice.status == 'Pending'}">
                        <div class="alert alert-warning border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-clock fs-3 me-3 text-warning"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-warning">ĐANG CHỜ THANH TOÁN</h6>
                                    <span class="small text-muted">Vui lòng liên hệ quầy lễ tân để hoàn tất thanh toán bằng tiền mặt.</span>
                                </div>
                            </div>
                            <span class="badge bg-warning text-dark rounded-pill px-3 py-1"><i class="fa fa-hourglass-half"></i> Chờ thanh toán</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-times-circle fs-3 me-3 text-danger"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-danger">HÓA ĐƠN ĐÃ HỦY</h6>
                                    <span class="small text-muted">Giao dịch này đã bị hủy. Vui lòng đăng ký gói mới nếu có nhu cầu tập luyện.</span>
                                </div>
                            </div>
                            <span class="badge bg-danger rounded-pill px-3 py-1"><i class="fa fa-times"></i> Đã hủy</span>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Billing details -->
                <div class="row g-4 mb-4 pb-4 border-bottom">
                    <div class="col-md-6">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Thông tin khách hàng</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.member.userDetails.fullName}</div>
                        <div class="small text-muted"><i class="fa fa-id-card me-1"></i> Mã hội viên: MEM-${invoice.member.memberId}</div>
                        <div class="small text-muted"><i class="fa fa-phone me-1"></i> SĐT: ${invoice.member.userDetails.phoneNumber}</div>
                        <div class="small text-muted"><i class="fa fa-envelope me-1"></i> Email: ${invoice.member.userDetails.email}</div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Nhân viên thực hiện</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.processByUser.fullName}</div>
                        <div class="small text-muted">Hỗ trợ thanh toán tại quầy</div>
                        <c:if test="${not empty invoice.paymentDate}">
                            <div class="small text-dark fw-bold mt-1">Ngày thanh toán: ${invoice.paymentDate.dayOfMonth}/${invoice.paymentDate.monthValue}/${invoice.paymentDate.year}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Package / Itemized Table -->
                <h6 class="text-uppercase text-secondary fw-bold small mb-3">Thông tin dịch vụ & Gói tập</h6>
                <div class="table-responsive mb-4">
                    <table class="table table-bordered align-middle">
                        <thead>
                            <tr class="bg-light">
                                <th scope="col">Mô tả gói tập</th>
                                <th scope="col" class="text-center" style="width: 150px;">Thời hạn</th>
                                <th scope="col" class="text-end" style="width: 180px;">Đơn giá</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">${invoice.memberPackage.gymPackage.packageName}</div>
                                    <div class="small text-muted italic">${invoice.memberPackage.gymPackage.description}</div>
                                    <div class="small text-primary mt-1 fw-medium">
                                        <i class="fa fa-calendar-alt me-1"></i> Hiệu lực từ: 
                                        ${invoice.memberPackage.startDate.dayOfMonth}/${invoice.memberPackage.startDate.monthValue}/${invoice.memberPackage.startDate.year} đến 
                                        ${invoice.memberPackage.endDate.dayOfMonth}/${invoice.memberPackage.endDate.monthValue}/${invoice.memberPackage.endDate.year}
                                    </div>
                                </td>
                                <td class="text-center fw-semibold text-dark">${invoice.memberPackage.gymPackage.durationMonths} Tháng</td>
                                <td class="text-end fw-bold text-primary fs-6">
                                    <fmt:formatNumber value="${invoice.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                            </tr>
                            <tr class="bg-light-gradient">
                                <td colspan="2" class="text-end fw-bold text-dark">Tổng cộng thanh toán:</td>
                                <td class="text-end fw-extrabold text-primary fs-5">
                                    <fmt:formatNumber value="${invoice.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Payment Details Card -->
                <div class="row g-3 mb-4">
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded border">
                            <span class="small text-muted d-block">Hình thức thanh toán</span>
                            <span class="fw-bold text-dark"><i class="fa fa-money-bill-wave text-success me-1"></i> ${invoice.paymentMethod} (Tiền mặt trực tiếp)</span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded border">
                            <span class="small text-muted d-block">Trạng thái kích hoạt gói</span>
                            <span class="fw-bold text-dark">
                                <c:choose>
                                    <c:when test="${invoice.status == 'Paid'}">
                                        <i class="fa fa-check-circle text-success me-1"></i> Đã kích hoạt sử dụng
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-hourglass text-warning me-1"></i> Đang chờ thu tiền
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Footer Terms -->
                <div class="receipt-footer pt-3 text-center text-muted small">
                    <p class="mb-1">Cảm ơn quý hội viên đã tin tưởng và đồng hành cùng GCMS Gym Center.</p>
                    <p class="mb-0 text-secondary">Đây là biên lai điện tử tự động được khởi tạo từ tài khoản hội viên.</p>
                </div>
            </div>

            <!-- Page Action Buttons -->
            <div class="d-flex justify-content-between align-items-center mb-5 no-print">
                <a href="${backUrl}" class="btn btn-outline-secondary py-2 px-4 fw-bold">
                    <i class="fa fa-chevron-left me-1"></i> Quay lại cổng thông tin
                </a>
                
                <c:if test="${invoice.status == 'Paid'}">
                    <button type="button" class="btn btn-primary py-2 px-4 fw-bold" onclick="window.print()">
                        <i class="fa fa-print me-1"></i> In biên lai / Hóa đơn
                    </button>
                </c:if>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
