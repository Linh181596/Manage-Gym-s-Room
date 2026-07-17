<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:set var="data" value="${reportData}" />
<c:set var="revenueFilter" value="${data.revenueFilter}" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-1 text-dark fw-bold"><i class="fa fa-chart-line me-2 text-primary"></i>Báo cáo doanh thu tài chính</h4>
            <small class="text-muted">Phân tích chi tiết về doanh thu, chi phí và lợi nhuận của hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/financial-revenue-report" class="btn btn-sm btn-primary">
            <i class="fa fa-sync-alt me-1"></i> Làm mới
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger d-flex align-items-center justify-content-between shadow-sm" role="alert">
            <div><i class="fa fa-exclamation-circle me-2"></i>${errorMessage}</div>
        </div>
    </c:if>

    <!-- Tóm tắt kỳ báo cáo -->
    <h6 class="mb-3 text-dark fw-bold">Tóm tắt kỳ báo cáo (${revenueFilter.fromDateValue} - ${revenueFilter.toDateValue})</h6>
    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-primary">
                <i class="fa fa-dollar-sign fa-3x text-primary opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Tổng doanh thu</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${data.totalRevenue}" type="number" maxFractionDigits="0"/> đ
                    </h5>
                </div>
            </div>
        </div>
        
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-info">
                <i class="fa fa-dumbbell fa-3x text-info opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Doanh thu gói tập (Gym)</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${data.gymPackageRevenue}" type="number" maxFractionDigits="0"/> đ
                    </h5>
                </div>
            </div>
        </div>
        
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-success">
                <i class="fa fa-user-tie fa-3x text-success opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Doanh thu dịch vụ PT</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${data.ptRevenue}" type="number" maxFractionDigits="0"/> đ
                    </h5>
                </div>
            </div>
        </div>
        
        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-warning">
                <i class="fa fa-file-invoice fa-3x text-warning opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Hóa đơn thanh toán</p>
                    <h5 class="mb-0 text-dark fw-bold">${data.paidInvoicesCount} <small class="text-muted fw-normal">đã thanh toán</small></h5>
                    <small class="text-danger">${data.unpaidInvoicesCount} đang chờ</small>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-secondary">
                <i class="fa fa-wallet fa-3x text-secondary opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Chi phí vận hành (ước tính 20%)</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${data.operationalCost}" type="number" maxFractionDigits="0"/> đ
                    </h5>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-xl-4">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100 border-start border-5 border-danger">
                <i class="fa fa-chart-pie fa-3x text-danger opacity-50"></i>
                <div class="ms-3 text-end">
                    <p class="mb-2 text-muted fw-semibold">Lợi nhuận gộp</p>
                    <h5 class="mb-0 text-dark fw-bold">
                        <fmt:formatNumber value="${data.profit}" type="number" maxFractionDigits="0"/> đ
                    </h5>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4 shadow-sm mb-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h6 class="mb-0 text-dark fw-bold">Biểu đồ doanh thu</h6>
                <small class="text-muted">Doanh thu đã thanh toán từ ${revenueFilter.fromDateValue} đến ${revenueFilter.toDateValue}</small>
            </div>
        </div>
        <form method="get" action="${pageContext.request.contextPath}/admin/financial-revenue-report" class="row g-2 align-items-end mb-4">
            <div class="col-sm-6 col-lg-3">
                <label class="form-label small fw-semibold text-secondary mb-1" for="revenueRange">Khoảng thời gian</label>
                <select id="revenueRange" name="revenueRange" class="form-select form-select-sm">
                    <option value="last7" ${revenueFilter.range == 'last7' ? 'selected' : ''}>7 ngày gần nhất</option>
                    <option value="last30" ${revenueFilter.range == 'last30' ? 'selected' : ''}>30 ngày gần nhất</option>
                    <option value="this_month" ${revenueFilter.range == 'this_month' ? 'selected' : ''}>Tháng này</option>
                    <option value="this_quarter" ${revenueFilter.range == 'this_quarter' ? 'selected' : ''}>Quý này</option>
                    <option value="this_year" ${revenueFilter.range == 'this_year' ? 'selected' : ''}>Năm nay</option>
                    <option value="custom" ${revenueFilter.range == 'custom' ? 'selected' : ''}>Tùy chọn</option>
                </select>
            </div>
            <div class="col-sm-6 col-lg-2">
                <label class="form-label small fw-semibold text-secondary mb-1" for="fromDate">Từ ngày</label>
                <input id="fromDate" name="fromDate" type="date" class="form-control form-control-sm" value="${revenueFilter.fromDateValue}">
            </div>
            <div class="col-sm-6 col-lg-2">
                <label class="form-label small fw-semibold text-secondary mb-1" for="toDate">Đến ngày</label>
                <input id="toDate" name="toDate" type="date" class="form-control form-control-sm" value="${revenueFilter.toDateValue}">
            </div>
            <div class="col-sm-6 col-lg-3">
                <label class="form-label small fw-semibold text-secondary mb-1" for="revenueType">Loại doanh thu</label>
                <select id="revenueType" name="revenueType" class="form-select form-select-sm">
                    <option value="all" ${revenueFilter.revenueType == 'all' ? 'selected' : ''}>Tất cả</option>
                    <option value="gym" ${revenueFilter.revenueType == 'gym' ? 'selected' : ''}>Gói tập thể hình</option>
                    <option value="pt" ${revenueFilter.revenueType == 'pt' ? 'selected' : ''}>Dịch vụ huấn luyện viên cá nhân</option>
                </select>
            </div>
            <div class="col-sm-12 col-lg-2">
                <button type="submit" class="btn btn-sm btn-primary w-100">
                    <i class="fa fa-filter me-1"></i> Áp dụng
                </button>
            </div>
        </form>
        <div class="position-relative" style="height: 350px;">
            <canvas id="admin-revenue-chart" 
                    data-labels='${empty data ? "[]" : data.revenueChartLabelsJson}' 
                    data-values='${empty data ? "[]" : data.revenueChartValuesJson}'></canvas>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4 shadow-sm mb-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h6 class="mb-0 text-dark fw-bold">Chi tiết hóa đơn trong kỳ</h6>
                <small class="text-muted">Danh sách các hóa đơn đã thanh toán hoặc đang chờ thanh toán</small>
            </div>
            <a href="${pageContext.request.contextPath}/staff/record-payment">Quản lý hóa đơn</a>
        </div>
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">Ngày lập</th>
                        <th scope="col">Mã hóa đơn</th>
                        <th scope="col">Khách hàng</th>
                        <th scope="col">Gói dịch vụ</th>
                        <th scope="col" class="text-end">Số tiền</th>
                        <th scope="col" class="text-center">Trạng thái</th>
                        <th scope="col" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty data or empty data.recentInvoices}">
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="fa fa-receipt fa-3x mb-3 text-secondary d-block"></i>
                                    Không tìm thấy dữ liệu hóa đơn nào trong khoảng thời gian này.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="invoice" items="${data.recentInvoices}">
                                <tr>
                                    <td><small class="text-muted">${invoice.paymentDateText}</small></td>
                                    <td class="fw-bold text-secondary">${invoice.invoiceCode}</td>
                                    <td>${invoice.customerName}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border me-2">${invoice.serviceType}</span>
                                        ${invoice.serviceName}
                                    </td>
                                    <td class="text-end fw-bold text-primary">
                                        <fmt:formatNumber value="${invoice.amount}" type="number" maxFractionDigits="0"/> đ
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${invoice.status == 'Paid'}">
                                                <span class="badge bg-success">Đã thanh toán</span>
                                            </c:when>
                                            <c:when test="${invoice.status == 'Pending'}">
                                                <span class="badge bg-warning text-dark">Đang chờ</span>
                                            </c:when>
                                            <c:when test="${invoice.status == 'Cancelled'}">
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">${invoice.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/staff/record-payment?invoiceId=${invoice.invoiceId}" class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-eye me-1"></i> Chi tiết
                                        </a>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const revenueRange = document.getElementById("revenueRange");
        const fromDate = document.getElementById("fromDate");
        const toDate = document.getElementById("toDate");
        [fromDate, toDate].forEach(function(input) {
            if (input && revenueRange) {
                input.addEventListener("change", function() {
                    revenueRange.value = "custom";
                });
            }
        });

        const chartElement = document.getElementById("admin-revenue-chart");
        if (!chartElement || typeof Chart === "undefined") {
            return;
        }

        const labelsData = JSON.parse(chartElement.getAttribute("data-labels") || "[]");
        const valuesData = JSON.parse(chartElement.getAttribute("data-values") || "[]");

        new Chart(chartElement.getContext("2d"), {
            type: "bar",
            data: {
                labels: labelsData,
                datasets: [{
                    label: "Doanh thu",
                    data: valuesData,
                    backgroundColor: "rgba(40, 167, 69, 0.65)", // Greenish
                    borderColor: "rgba(40, 167, 69, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            callback: function(value) {
                                return new Intl.NumberFormat("vi-VN").format(value);
                            }
                        }
                    }]
                },
                legend: {
                    display: false
                },
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return new Intl.NumberFormat("vi-VN").format(tooltipItem.yLabel) + " đ";
                        }
                    }
                }
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
