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
    <!-- Breadcrumbs -->
    <div class="mb-4 no-print">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/record-payment">Payments</a></li>
                <li class="breadcrumb-item active" aria-current="page">Invoice Details</li>
            </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-file-invoice-dollar me-2 text-primary"></i>Invoice Details</h4>
            <a href="${pageContext.request.contextPath}/staff/record-payment" class="btn btn-outline-secondary d-flex align-items-center">
                <i class="fa fa-arrow-left me-2"></i> Back to Payments
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
                            <p class="text-muted small mb-0">123 Gym Center St., District 1, Ho Chi Minh City<br>Phone: (+84) 987-654-321 | Email: support@gcms.com</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h4 class="text-uppercase text-secondary fw-semibold mb-1">Receipt / Invoice</h4>
                            <div class="text-dark fw-bold mb-1">Invoice ID: INV-${invoice.invoiceId}</div>
                            <div class="text-muted small">Date Generated: ${invoice.createdDate.dayOfMonth}/${invoice.createdDate.monthValue}/${invoice.createdDate.year}</div>
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
                                    <h6 class="alert-heading fw-bold mb-0 text-success">PAYMENT COMPLETE</h6>
                                    <span class="small text-muted">This invoice has been settled in cash. Associated gym package is now <strong>Active</strong>.</span>
                                </div>
                            </div>
                            <span class="badge bg-success rounded-pill px-3 py-1 no-print"><i class="fa fa-check"></i> Settled</span>
                        </div>
                    </c:when>
                    <c:when test="${invoice.status == 'Pending'}">
                        <div class="alert alert-warning border-0 rounded p-3 mb-4 d-flex align-items-center justify-content-between no-print">
                            <div class="d-flex align-items-center">
                                <i class="fa fa-clock fs-3 me-3 text-warning"></i>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0 text-warning">PAYMENT PENDING</h6>
                                    <span class="small text-muted">Confirm receipt of cash payment from the member to activate subscription.</span>
                                </div>
                            </div>
                            <span class="badge bg-warning text-dark rounded-pill px-3 py-1"><i class="fa fa-hourglass-half"></i> Pending</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger border-0 rounded p-3 mb-4 d-flex align-items-center">
                            <i class="fa fa-times-circle fs-3 me-3 text-danger"></i>
                            <div>
                                <h6 class="alert-heading fw-bold mb-0 text-danger">INVOICE CANCELLED</h6>
                                <span class="small text-muted">This transaction is cancelled and cannot be paid.</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Billing & Party Info -->
                <div class="row g-4 mb-4 pb-4 border-bottom">
                    <div class="col-md-6">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Billed To (Gym Member)</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.member.userDetails.fullName}</div>
                        <div class="small text-muted"><i class="fa fa-id-card me-1"></i> Member ID: MEM-${invoice.member.memberId}</div>
                        <div class="small text-muted"><i class="fa fa-phone me-1"></i> Phone: ${invoice.member.userDetails.phoneNumber}</div>
                        <div class="small text-muted"><i class="fa fa-envelope me-1"></i> Email: ${invoice.member.userDetails.email}</div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h6 class="text-uppercase text-secondary fw-bold small mb-2">Processed / Registered By</h6>
                        <div class="fw-bold text-dark fs-6">${invoice.processByUser.fullName}</div>
                        <div class="small text-muted">Role: Staff / Front Desk</div>
                        <c:if test="${not empty invoice.paymentDate}">
                            <div class="small text-dark fw-bold mt-1">Payment settled on: ${invoice.paymentDate.dayOfMonth}/${invoice.paymentDate.monthValue}/${invoice.paymentDate.year}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Package / Itemized Table -->
                <h6 class="text-uppercase text-secondary fw-bold small mb-3">Itemized Details</h6>
                <div class="table-responsive mb-4">
                    <table class="table table-bordered align-middle">
                        <thead>
                            <tr class="bg-light">
                                <th scope="col">Description / Gym Subscription Plan</th>
                                <th scope="col" class="text-center" style="width: 150px;">Duration</th>
                                <th scope="col" class="text-end" style="width: 180px;">Amount Due</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">${invoice.memberPackage.gymPackage.packageName}</div>
                                    <div class="small text-muted italic">${invoice.memberPackage.gymPackage.description}</div>
                                    <div class="small text-primary mt-1 fw-medium">
                                        <i class="fa fa-calendar-check me-1"></i> Active Validity: 
                                        ${invoice.memberPackage.startDate.dayOfMonth}/${invoice.memberPackage.startDate.monthValue}/${invoice.memberPackage.startDate.year} to 
                                        ${invoice.memberPackage.endDate.dayOfMonth}/${invoice.memberPackage.endDate.monthValue}/${invoice.memberPackage.endDate.year}
                                    </div>
                                </td>
                                <td class="text-center fw-semibold text-dark">${invoice.memberPackage.gymPackage.durationMonths} Months</td>
                                <td class="text-end fw-bold text-primary fs-6">
                                    <fmt:formatNumber value="${invoice.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                            </tr>
                            <tr class="bg-light-gradient">
                                <td colspan="2" class="text-end fw-bold text-dark">Total settlement:</td>
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
                            <span class="small text-muted d-block">Payment Method</span>
                            <span class="fw-bold text-dark"><i class="fa fa-money-bill-wave text-success me-1"></i> ${invoice.paymentMethod} (Direct Cash)</span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="p-3 bg-light rounded">
                            <span class="small text-muted d-block">Membership Status</span>
                            <span class="fw-bold text-dark">
                                <c:choose>
                                    <c:when test="${invoice.status == 'Paid'}">
                                        <i class="fa fa-check-circle text-success me-1"></i> Active Enrollment
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-hourglass text-warning me-1"></i> Pending Activation
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Footer Terms -->
                <div class="receipt-footer pt-3 text-center text-muted small">
                    <p class="mb-1">Thank you for joining GCMS Gym Center. Stay strong, stay healthy!</p>
                    <p class="mb-0 text-secondary">This receipt is officially generated. No signature required.</p>
                </div>
            </div>

            <!-- Page Action Buttons -->
            <div class="d-flex justify-content-between align-items-center mb-5 no-print">
                <a href="${pageContext.request.contextPath}/staff/record-payment" class="btn btn-lg btn-outline-secondary px-4">
                    <i class="fa fa-chevron-left me-1"></i> Back to List
                </a>
                
                <div class="d-flex gap-3">
                    <c:if test="${invoice.status == 'Paid'}">
                        <button type="button" class="btn btn-lg btn-secondary px-4" onclick="window.print()">
                            <i class="fa fa-print me-1"></i> Print Receipt
                        </button>
                    </c:if>
                    
                    <c:if test="${invoice.status == 'Pending'}">
                        <form action="${pageContext.request.contextPath}/staff/record-payment" method="post">
                            <input type="hidden" name="invoiceId" value="${invoice.invoiceId}" />
                            <input type="hidden" name="action" value="pay" />
                            <button type="submit" class="btn btn-lg btn-success px-5 shadow-sm-success">
                                <i class="fa fa-check-double me-1"></i> Confirm Cash Payment
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
