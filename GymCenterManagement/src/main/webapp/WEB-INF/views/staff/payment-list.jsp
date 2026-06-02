<%--
  =========================================================================
  Document    : payment-list.jsp
  Created on  : 2026-06-01
  Author      : Nguyễn Hoàng Thắng
  Description : Danh sách các giao dịch hóa đơn đăng ký gói tập dành cho Staff
  =========================================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<!-- Calculate KPI variables dynamically -->
<c:set var="totalRevenue" value="0" />
<c:set var="pendingCount" value="0" />
<c:set var="paidCount" value="0" />
<c:forEach var="inv" items="${invoices}">
    <c:choose>
        <c:when test="${inv.status == 'Paid'}">
            <c:set var="totalRevenue" value="${totalRevenue + inv.amount}" />
            <c:set var="paidCount" value="${paidCount + 1}" />
        </c:when>
        <c:when test="${inv.status == 'Pending'}">
            <c:set var="pendingCount" value="${pendingCount + 1}" />
        </c:when>
    </c:choose>
</c:forEach>

<div class="container-fluid pt-4 px-4">
    <!-- Page Header -->
    <div class="mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-cash-register me-2 text-primary"></i>Record Payments</h4>
            <small class="text-muted">Process cash invoices, print receipts, and activate member registrations</small>
        </div>
    </div>

    <!-- Feedback Message Display -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${param.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- KPI Summary Row -->
    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm border-0">
                <i class="fa fa-dollar-sign fa-3x text-success"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Total Revenue (Cash)</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm border-0">
                <i class="fa fa-clock fa-3x text-warning"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Pending Payments</p>
                    <h5 class="mb-0 text-dark fw-bold">${pendingCount} Invoices</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm border-0">
                <i class="fa fa-check-double fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Paid Invoices</p>
                    <h5 class="mb-0 text-dark fw-bold">${paidCount} Completed</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Search & Filter Card -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row align-items-end g-3">
            <div class="col-md-6 col-lg-7">
                <label for="searchInput" class="form-label fw-bold text-secondary">Search Invoices</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="fa fa-search"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0" placeholder="Search by member name, email or package name...">
                </div>
            </div>
            <div class="col-md-4 col-lg-3">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Filter by Payment Status</label>
                <select id="statusFilter" class="form-select">
                    <option value="">All Invoices</option>
                    <option value="Pending">Pending</option>
                    <option value="Paid">Paid</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <div class="col-md-2 col-lg-2">
                <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100"><i class="fa fa-undo me-1"></i> Reset</button>
            </div>
        </div>
    </div>

    <!-- Payment List Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0" id="invoiceTable">
                <thead>
                    <tr class="text-dark">
                        <th scope="col" style="width: 80px;">ID</th>
                        <th scope="col">Gym Member</th>
                        <th scope="col">Details / Description</th>
                        <th scope="col" class="text-end" style="width: 150px;">Amount (VND)</th>
                        <th scope="col" style="width: 120px;" class="text-center">Status</th>
                        <th scope="col" class="text-center" style="width: 180px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty invoices}">
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">
                                    <i class="fa fa-receipt fa-3x mb-3 text-secondary d-block"></i>
                                    No invoices recorded. Enroll members to generate pending invoices.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="inv" items="${invoices}">
                                <tr class="invoice-row" 
                                    data-search="${inv.member.userDetails.fullName.toLowerCase()} ${inv.member.userDetails.email.toLowerCase()} ${inv.memberPackage.gymPackage.packageName.toLowerCase()}" 
                                    data-status="${inv.status}">
                                    <td class="fw-bold text-secondary">INV-${inv.invoiceId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${inv.member.userDetails.fullName}</div>
                                        <small class="text-muted"><i class="fa fa-envelope me-1"></i>${inv.member.userDetails.email}</small>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border me-2"><i class="fa fa-box me-1"></i>Package</span>
                                        <span class="text-dark fw-medium">${inv.memberPackage.gymPackage.packageName}</span>
                                    </td>
                                    <td class="text-end fw-bold text-primary">
                                        <fmt:formatNumber value="${inv.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${inv.status == 'Paid'}">
                                                <span class="badge bg-success rounded-pill px-3 py-1"><i class="fa fa-check-circle me-1"></i>Paid</span>
                                            </c:when>
                                            <c:when test="${inv.status == 'Pending'}">
                                                <span class="badge bg-warning text-dark rounded-pill px-3 py-1"><i class="fa fa-clock me-1"></i>Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger rounded-pill px-3 py-1"><i class="fa fa-times-circle me-1"></i>Cancelled</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${inv.status == 'Pending'}">
                                                <a href="${pageContext.request.contextPath}/staff/record-payment?invoiceId=${inv.invoiceId}" class="btn btn-sm btn-primary px-3 shadow-sm-primary">
                                                    <i class="fa fa-cash-register me-1"></i> Pay Cash
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/staff/record-payment?invoiceId=${inv.invoiceId}" class="btn btn-sm btn-outline-secondary px-3">
                                                    <i class="fa fa-eye me-1"></i> Details
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Script to handle client side search and filtering -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchInput");
        const statusFilter = document.getElementById("statusFilter");
        const resetFilters = document.getElementById("resetFilters");
        const rows = document.querySelectorAll(".invoice-row");

        function filterInvoices() {
            const searchVal = searchInput.value.toLowerCase().trim();
            const statusVal = statusFilter.value;

            rows.forEach(row => {
                const searchMatch = row.getAttribute("data-search").includes(searchVal);
                const statusMatch = statusVal === "" || row.getAttribute("data-status") === statusVal;

                if (searchMatch && statusMatch) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        searchInput.addEventListener("input", filterInvoices);
        statusFilter.addEventListener("change", filterInvoices);

        resetFilters.addEventListener("click", function() {
            searchInput.value = "";
            statusFilter.value = "";
            rows.forEach(row => row.style.display = "");
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
