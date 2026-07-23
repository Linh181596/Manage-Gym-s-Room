<%--
  =========================================================================
  Document    : payment-record-detail.jsp
  Created on  : 2026-06-01
  Author      : Nguyễn Hoàng Thắng
  Description : Trang chi tiết hóa đơn thanh toán và in hóa đơn/biên lai dành cho Staff
  =========================================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<style>
    /* Styling elements specific to the Invoice Detail and Receipt */
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
        /* Hide sidebar, navbar, footer, buttons and other dashboard chrome */
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
        /* Display print area full width */
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
    <c:set var="isAdmin" value="${sessionScope.currentUser.role == 'Admin'}" />
    <c:set var="backUrl" value="${pageContext.request.contextPath}${isAdmin ? '/admin/payment-history' : '/staff/record-payment'}" />
    <c:set var="dashboardUrl" value="${pageContext.request.contextPath}${isAdmin ? '/admin/dashboard' : '/staff/dashboard'}" />
    
    <!-- Breadcrumbs -->
    <div class="mb-4 no-print">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${dashboardUrl}">Bảng điều khiển</a></li>
                <li class="breadcrumb-item"><a href="${backUrl}">Hóa đơn</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết hóa đơn</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-file-invoice-dollar me-2 text-primary"></i>Chi tiết hóa đơn</h4>
            <a href="${backUrl}" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Feedback Message Display -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4 no-print" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4 no-print" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${param.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row justify-content-center">
        <!-- Main Invoice & Checkout Column -->
        <div class="col-lg-9 col-xl-8" id="printReceiptCard">
            <div class="receipt-container rounded shadow-sm p-4 p-md-5 mb-4">
                
                <!-- Receipt Header/Gym Branding -->
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

                <!-- Status Banner / Confirmation Alerts -->
                <c:choose>
                    <c:when test="${invoice.status == 'Paid'}">
                        <div class="alert alert-success border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-check-circle fs-3 me-3 text-success"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-success">THANH TOÁN THÀNH CÔNG</h6>
                                    <span class="small text-muted">Hóa đơn này đã được thanh toán bằng tiền mặt. Gói tập liên kết hiện đã được kích hoạt (<strong>Hoạt động</strong>).</span>
                                </div>
                            </div>
                            <span class="badge bg-success rounded-pill px-3 py-1 no-print"><i class="fa fa-check"></i> Đã thanh toán</span>
                        </div>
                    </c:when>
                    <c:when test="${invoice.status == 'Pending'}">
                        <div class="alert alert-warning border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between no-print">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-clock fs-3 me-3 text-warning"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-warning">ĐANG CHỜ THANH TOÁN</h6>
                                    <span class="small text-muted">Xác nhận đã nhận thanh toán bằng tiền mặt từ hội viên để kích hoạt gói tập.</span>
                                </div>
                            </div>
                            <span class="badge bg-warning text-dark rounded-pill px-3 py-1"><i class="fa fa-hourglass-half"></i> Đang chờ</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-times-circle fs-3 me-3 text-danger"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-danger">HÓA ĐƠN ĐÃ HỦY</h6>
                                    <span class="small text-muted">Giao dịch này đã bị hủy và không thể thực hiện thanh toán.</span>
                                </div>
                            </div>
                            <span class="badge bg-danger rounded-pill px-3 py-1"><i class="fa fa-times"></i> Đã hủy</span>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Billing & Party Info -->
                <div class="row g-4 mb-4 pb-4 border-bottom">
                    <div class="col-md-6">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Người thanh toán (Hội viên)</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.member.userDetails.fullName}</div>
                        <div class="small text-muted"><i class="fa fa-id-card me-1"></i> Mã hội viên: MEM-${invoice.member.memberId}</div>
                        <div class="small text-muted"><i class="fa fa-phone me-1"></i> SĐT: ${invoice.member.userDetails.phoneNumber}</div>
                        <div class="small text-muted"><i class="fa fa-envelope me-1"></i> Email: ${invoice.member.userDetails.email}</div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Người thực hiện / Đăng ký</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.processByUser.fullName}</div>
                        <div class="small text-muted">Vai trò: Lễ tân / Nhân viên</div>
                        <c:if test="${not empty invoice.paymentDate}">
                            <div class="small text-dark fw-bold mt-1">Ngày thanh toán: ${invoice.paymentDate.dayOfMonth}/${invoice.paymentDate.monthValue}/${invoice.paymentDate.year}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Package / Itemized Table -->
                <h6 class="text-uppercase text-secondary fw-bold small mb-3">Chi tiết các khoản</h6>
                <div class="table-responsive mb-4">
                    <table class="table table-bordered align-middle">
                        <thead>
                            <tr class="bg-light">
                                <th scope="col">Mô tả / Gói đăng ký Gym</th>
                                <th scope="col" class="text-center" style="width: 150px;">Thời hạn</th>
                                <th scope="col" class="text-end" style="width: 180px;">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">${invoice.memberPackage.gymPackage.packageName}</div>
                                    <div class="small text-muted italic">${invoice.memberPackage.gymPackage.description}</div>
                                    <div class="small text-primary mt-1 fw-medium">
                                        <i class="fa fa-calendar-check me-1"></i> Thời gian hiệu lực: 
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

                <!-- Payment details -->
                <div class="row g-3 mb-4">
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded">
                            <span class="small text-muted d-block">Phương thức thanh toán</span>
                            <span class="fw-bold text-dark"><i class="fa fa-money-bill-wave text-success me-1"></i> ${invoice.paymentMethod} (Tiền mặt trực tiếp)</span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded">
                            <span class="small text-muted d-block">Trạng thái thẻ thành viên</span>
                            <span class="fw-bold text-dark">
                                <c:choose>
                                    <c:when test="${invoice.status == 'Paid'}">
                                        <i class="fa fa-check-circle text-success me-1"></i> Kích hoạt hoạt động
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-hourglass text-warning me-1"></i> Chờ kích hoạt
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Footer Terms -->
                <div class="receipt-footer pt-3 text-center text-muted small">
                    <p class="mb-1">Cảm ơn bạn đã tham gia GCMS Gym Center. Sống khỏe, sống đẹp!</p>
                    <p class="mb-0 text-secondary">Biên lai này được tạo tự động từ hệ thống. Không cần chữ ký.</p>
                </div>
            </div>

            <!-- Page Action Buttons -->
            <div class="d-flex justify-content-between align-items-center mb-5 no-print">
                <a href="${backUrl}" class="btn btn-lg btn-outline-secondary px-4">
                    <i class="fa fa-chevron-left me-1"></i> Quay lại danh sách
                </a>
                
                <div class="d-flex gap-3">
                    <c:if test="${invoice.status == 'Paid'}">
                        <%-- Nút gọi lệnh in (print) của trình duyệt để in biên lai --%>
                        <button type="button" class="btn btn-lg btn-secondary px-4" onclick="window.print()">
                            <i class="fa fa-print me-1"></i> In biên lai
                        </button>
                    </c:if>
                    
                    <c:if test="${invoice.status == 'Pending'}">
                        <form id="cancelInvoiceForm" action="${backUrl}" method="post" style="display: none;">
                            <input type="hidden" name="invoiceId" value="${invoice.invoiceId}" />
                            <input type="hidden" name="action" value="cancel" />
                        </form>
                        
                        <c:if test="${!isAdmin}">
                            <div class="d-flex gap-3">
                                <%-- Nút kích hoạt popup xác nhận trước khi submit form hủy hóa đơn --%>
                                <button type="button" class="btn btn-lg btn-outline-danger px-4" onclick="confirmCancelInvoice()">
                                    <i class="fa fa-times-circle me-1"></i> Hủy hóa đơn
                                </button>
                                
                                <form action="${pageContext.request.contextPath}/staff/vnpay-create" method="post">
                                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}" />
                                    <%-- Nút submit form khởi tạo giao dịch thanh toán qua cổng VNPAY --%>
                                    <button type="submit" class="btn btn-lg btn-primary px-4 shadow-sm">
                                        <i class="fa fa-credit-card me-1"></i> Thanh toán qua VNPAY
                                    </button>
                                </form>

                                <form action="${backUrl}" method="post">
                                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}" />
                                    <input type="hidden" name="action" value="pay" />
                                    <%-- Nút submit form xác nhận đã thu tiền mặt và cập nhật trạng thái hóa đơn thành Paid --%>
                                    <button type="submit" class="btn btn-lg btn-success px-5 shadow-sm-success">
                                        <i class="fa fa-check-double me-1"></i> Xác nhận thu tiền mặt
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
function confirmCancelInvoice() {
    if (confirm("Bạn có chắc chắn muốn HỦY hóa đơn này không? Gói đăng ký liên quan cũng sẽ bị hủy bỏ.")) {
        document.getElementById("cancelInvoiceForm").submit();
    }
}
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
