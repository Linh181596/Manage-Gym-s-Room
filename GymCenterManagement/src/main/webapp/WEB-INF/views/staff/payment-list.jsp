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

<!-- KPI variables are calculated and passed directly from the controller -->

<c:set var="isAdmin" value="${sessionScope.currentUser.role == 'Admin'}" />
<div class="container-fluid pt-4 px-4">
    <!-- Page Header -->
    <div class="mb-4">
        <div>
            <c:choose>
                <c:when test="${isAdmin}">
                    <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-history me-2 text-primary"></i>Lịch sử thanh toán</h4>
                    <small class="text-muted">Xem và tra cứu lịch sử thanh toán hóa đơn của phòng tập</small>
                </c:when>
                <c:otherwise>
                    <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-cash-register me-2 text-primary"></i>Thanh toán hóa đơn</h4>
                    <small class="text-muted">Xử lý hóa đơn tiền mặt, in biên lai và kích hoạt gói tập cho thành viên</small>
                </c:otherwise>
            </c:choose>
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
                    <p class="mb-2 text-muted fw-semibold">Tổng doanh thu (Tiền mặt)</p>
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
                    <p class="mb-2 text-muted fw-semibold">Thanh toán đang chờ</p>
                    <h5 class="mb-0 text-dark fw-bold">${pendingCount} Hóa đơn</h5>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm border-0">
                <i class="fa fa-check-double fa-3x text-primary"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hóa đơn đã thanh toán</p>
                    <h5 class="mb-0 text-dark fw-bold">${paidCount} Hoàn thành</h5>
                </div>
            </div>
        </div>
    </div>

    <!-- Search & Filter Card -->
    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="row align-items-end g-3">
            <div class="col-md-4 col-lg-4">
                <label for="searchInput" class="form-label fw-bold text-secondary">Tìm kiếm hóa đơn</label>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="fa fa-search"></i></span>
                    <input type="text" id="searchInput" class="form-control border-start-0" placeholder="Tìm theo tên, email, gói...">
                </div>
            </div>
            <div class="col-md-2 col-lg-2">
                <label for="statusFilter" class="form-label fw-bold text-secondary">Trạng thái</label>
                <select id="statusFilter" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="Pending">Đang chờ</option>
                    <option value="Paid">Đã thanh toán</option>
                    <option value="Cancelled">Đã hủy</option>
                </select>
            </div>
            <div class="col-md-2 col-lg-2">
                <label for="startDateFilter" class="form-label fw-bold text-secondary">Từ ngày</label>
                <input type="date" id="startDateFilter" class="form-control">
            </div>
            <div class="col-md-2 col-lg-2">
                <label for="endDateFilter" class="form-label fw-bold text-secondary">Đến ngày</label>
                <input type="date" id="endDateFilter" class="form-control">
            </div>
            <div class="col-md-2 col-lg-2">
                <%-- Nút reset form lọc hóa đơn về trạng thái ban đầu --%>
                <button type="button" id="resetFilters" class="btn btn-outline-secondary w-100"><i class="fa fa-undo me-1"></i> Đặt lại</button>
            </div>
        </div>
    </div>

    <!-- Payment List Table -->
    <div class="bg-light rounded p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0" id="invoiceTable">
                <thead>
                    <tr class="text-dark">
                        <th scope="col" style="width: 80px;">Mã</th>
                        <th scope="col">Hội viên Gym</th>
                        <th scope="col">Chi tiết / Mô tả</th>
                        <th scope="col" class="text-end" style="width: 150px;">Số tiền (VND)</th>
                        <th scope="col" class="text-center" style="width: 150px;">Ngày giao dịch</th>
                        <th scope="col" style="width: 120px;" class="text-center">Trạng thái</th>
                        <th scope="col" class="text-center" style="width: 180px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty invoices}">
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="fa fa-receipt fa-3x mb-3 text-secondary d-block"></i>
                                    Không tìm thấy hóa đơn nào.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:set var="viewUrl" value="${pageContext.request.contextPath}${isAdmin ? '/admin/payment-history' : '/staff/record-payment'}" />
                            <c:forEach var="inv" items="${invoices}">
                                <c:set var="txnDate" value="${inv.status == 'Paid' ? inv.paymentDate : inv.createdDate}" />
                                <c:set var="dataDate" value="" />
                                <c:if test="${not empty txnDate}">
                                    <c:set var="dataDate" value="${txnDate.year}-${txnDate.monthValue < 10 ? '0' : ''}${txnDate.monthValue}-${txnDate.dayOfMonth < 10 ? '0' : ''}${txnDate.dayOfMonth}" />
                                </c:if>
                                <tr class="invoice-row" 
                                    data-search="${inv.member.userDetails.fullName.toLowerCase()} ${inv.member.userDetails.email.toLowerCase()} ${inv.memberPackage.gymPackage.packageName.toLowerCase()}" 
                                    data-status="${inv.status}"
                                    data-date="${dataDate}">
                                    <td class="fw-bold text-secondary">INV-${inv.invoiceId}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${inv.member.userDetails.fullName}</div>
                                        <small class="text-muted"><i class="fa fa-envelope me-1"></i>${inv.member.userDetails.email}</small>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border me-2"><i class="fa fa-box me-1"></i>Gói tập</span>
                                        <span class="text-dark fw-medium">${inv.memberPackage.gymPackage.packageName}</span>
                                    </td>
                                    <td class="text-end fw-bold text-primary">
                                        <fmt:formatNumber value="${inv.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center text-dark">
                                        <c:if test="${not empty txnDate}">
                                            ${txnDate.dayOfMonth < 10 ? '0' : ''}${txnDate.dayOfMonth}/${txnDate.monthValue < 10 ? '0' : ''}${txnDate.monthValue}/${txnDate.year}
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${inv.status == 'Paid'}">
                                                <span class="badge bg-success rounded-pill px-3 py-1"><i class="fa fa-check-circle me-1"></i>Đã thanh toán</span>
                                            </c:when>
                                            <c:when test="${inv.status == 'Pending'}">
                                                <span class="badge bg-warning text-dark rounded-pill px-3 py-1"><i class="fa fa-clock me-1"></i>Đang chờ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger rounded-pill px-3 py-1"><i class="fa fa-times-circle me-1"></i>Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${inv.status == 'Pending' && !isAdmin}">
                                                <%-- Nút chuyển hướng sang màn hình thu tiền / xác nhận thanh toán (dành cho lễ tân) --%>
                                                <a href="${viewUrl}?invoiceId=${inv.invoiceId}" class="btn btn-sm btn-primary px-3 shadow-sm-primary">
                                                    <i class="fa fa-cash-register me-1"></i> Thu tiền
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <%-- Nút chuyển hướng xem chi tiết hóa đơn --%>
                                                <a href="${viewUrl}?invoiceId=${inv.invoiceId}" class="btn btn-sm btn-outline-secondary px-3">
                                                    <i class="fa fa-eye me-1"></i> Chi tiết
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
        <jsp:include page="../common/pagination.jsp" />
    </div>
</div>

<!-- Script to handle client side search and filtering -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchInput");
        const statusFilter = document.getElementById("statusFilter");
        const startDateFilter = document.getElementById("startDateFilter");
        const endDateFilter = document.getElementById("endDateFilter");
        const resetFilters = document.getElementById("resetFilters");
        const rows = document.querySelectorAll(".invoice-row");

        // Hàm lọc danh sách hóa đơn theo từ khóa, trạng thái và khoảng thời gian (Client-side)
        function filterInvoices() {
            const searchVal = searchInput.value.toLowerCase().trim();
            const statusVal = statusFilter.value;
            const startVal = startDateFilter.value;
            const endVal = endDateFilter.value;

            rows.forEach(row => {
                const searchMatch = row.getAttribute("data-search").includes(searchVal);
                const statusMatch = statusVal === "" || row.getAttribute("data-status") === statusVal;
                
                const rowDate = row.getAttribute("data-date");
                let dateMatch = true;
                if (rowDate) {
                    if (startVal && rowDate < startVal) {
                        dateMatch = false;
                    }
                    if (endVal && rowDate > endVal) {
                        dateMatch = false;
                    }
                } else {
                    if (startVal || endVal) {
                        dateMatch = false;
                    }
                }

                if (searchMatch && statusMatch && dateMatch) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        searchInput.addEventListener("input", filterInvoices);
        statusFilter.addEventListener("change", filterInvoices);
        startDateFilter.addEventListener("change", filterInvoices);
        endDateFilter.addEventListener("change", filterInvoices);

        resetFilters.addEventListener("click", function() {
            searchInput.value = "";
            statusFilter.value = "";
            startDateFilter.value = "";
            endDateFilter.value = "";
            rows.forEach(row => row.style.display = "");
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
