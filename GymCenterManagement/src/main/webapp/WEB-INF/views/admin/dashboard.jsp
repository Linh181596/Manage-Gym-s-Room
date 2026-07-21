<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : dashboard.jsp
  Created on  : 2026-06-25
  Author      : Nguyễn Đại Dương (duongnd)
  Description : Giao diện bảng điều khiển hiển thị tổng quan vận hành cho Admin.
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:set var="data" value="${dashboardData}" />
<c:set var="metric" value="${data.metric}" />
<c:set var="revenueFilter" value="${data.revenueFilter}" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-1 text-dark fw-bold"><i class="fa fa-tachometer-alt me-2 text-primary"></i>Bảng điều khiển quản trị</h4>
            <small class="text-muted">Tổng quan vận hành phòng tập theo dữ liệu hiện có trong cơ sở dữ liệu</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-primary">
            <%-- Nút tải lại trang Dashboard để cập nhật dữ liệu mới nhất --%>
            <i class="fa fa-sync-alt me-1"></i> Làm mới
        </a>
    </div>

    <c:if test="${not empty dashboardLoadError}">
        <div class="alert alert-danger d-flex align-items-center justify-content-between shadow-sm" role="alert">
            <div><i class="fa fa-exclamation-circle me-2"></i>${dashboardLoadError}</div>
            <%-- Nút thử lại nếu xảy ra lỗi trong quá trình tải dữ liệu --%>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-danger">Thử lại</a>
        </div>
    </c:if>

    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <a class="text-decoration-none" href="${pageContext.request.contextPath}/staff/members">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-users fa-3x text-primary"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Hội viên đang hoạt động</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty metric ? 0 : metric.activeMembers}</h5>
                        <small class="text-muted">+${empty metric ? 0 : metric.newMembershipsToday} gói kích hoạt hôm nay</small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a class="text-decoration-none" href="${pageContext.request.contextPath}/staff/record-payment">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-dollar-sign fa-3x text-success"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Doanh thu hôm nay</p>
                        <h5 class="mb-0 text-dark fw-bold">
                            <fmt:formatNumber value="${empty metric ? 0 : metric.todayRevenue}" type="number" maxFractionDigits="0"/> đ
                        </h5>
                        <small class="text-muted">Tháng này:
                            <fmt:formatNumber value="${empty metric ? 0 : metric.monthRevenue}" type="number" maxFractionDigits="0"/> đ
                        </small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a class="text-decoration-none" href="${pageContext.request.contextPath}/pt/list">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-user-tie fa-3x text-info"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Huấn luyện viên đang hoạt động</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty metric ? 0 : metric.activeTrainers}</h5>
                        <small class="text-muted">${empty metric ? 0 : metric.todayPtSessions} lịch huấn luyện hôm nay</small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a class="text-decoration-none" href="#operationAlerts">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-exclamation-triangle fa-3x text-warning"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Cần xử lý</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty metric ? 0 : metric.pendingAlerts}</h5>
                        <small class="text-muted">Cảnh báo vận hành</small>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <div class="row g-4">
        <div class="col-sm-12 col-xl-8">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <h6 class="mb-0 text-dark fw-bold">Biểu đồ doanh thu</h6>
                        <small class="text-muted">Doanh thu đã thanh toán từ ${revenueFilter.fromDateValue} đến ${revenueFilter.toDateValue}</small>
                    </div>
                    <a href="${pageContext.request.contextPath}/staff/record-payment">Xem hóa đơn</a>
                </div>
                <form method="get" action="${pageContext.request.contextPath}/admin/dashboard" class="row g-2 align-items-end mb-4">
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
                        <%-- Nút submit form gửi yêu cầu lọc dữ liệu biểu đồ doanh thu --%>
                        <button type="submit" class="btn btn-sm btn-primary w-100">
                            <i class="fa fa-filter me-1"></i> Áp dụng
                        </button>
                    </div>
                </form>
                <div class="position-relative" style="height: 280px;">
                    <canvas id="admin-revenue-chart" 
                            data-labels='${empty data ? "[]" : data.revenueChartLabelsJson}' 
                            data-values='${empty data ? "[]" : data.revenueChartValuesJson}'></canvas>
                </div>
            </div>
        </div>
        <div class="col-sm-12 col-xl-4">
            <div id="operationAlerts" class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <h6 class="mb-0 text-dark fw-bold">Cảnh báo vận hành</h6>
                        <small class="text-muted">Các mục cần quản trị viên theo dõi</small>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty data or empty data.alerts}">
                        <div class="text-center text-muted py-4">
                            <i class="fa fa-check-circle fa-3x text-success mb-3 d-block"></i>
                            Không có cảnh báo đang chờ.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="alert" items="${data.alerts}">
                            <a class="text-decoration-none" href="${pageContext.request.contextPath}${alert.targetUrl}">
                                <div class="d-flex align-items-start border-bottom py-3">
                                    <div class="rounded-circle bg-${alert.severity} text-white d-flex align-items-center justify-content-center me-3" style="width: 36px; height: 36px;">
                                        <i class="fa fa-bell"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">${alert.title}</div>
                                        <small class="text-muted">${alert.message}</small>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded p-4 shadow-sm">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h6 class="mb-0 text-dark fw-bold">Hóa đơn gần đây</h6>
                <small class="text-muted">Hóa đơn đăng ký gói tập và dịch vụ huấn luyện gần đây</small>
            </div>
            <a href="${pageContext.request.contextPath}/staff/record-payment">Xem tất cả</a>
        </div>
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead>
                    <tr class="text-dark">
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
                                    Chưa có hóa đơn nào trong cơ sở dữ liệu.
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
        // Gán sự kiện khi thay đổi "Từ ngày" hoặc "Đến ngày" thì tự động chuyển khoảng thời gian sang "Tùy chọn"
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

        // Lấy dữ liệu dạng JSON cho nhãn (labels) và giá trị (values) từ thuộc tính data-*
        const labelsData = JSON.parse(chartElement.getAttribute("data-labels") || "[]");
        const valuesData = JSON.parse(chartElement.getAttribute("data-values") || "[]");

        // Khởi tạo và vẽ biểu đồ doanh thu bằng thư viện Chart.js
        new Chart(chartElement.getContext("2d"), {
            type: "bar",
            data: {
                labels: labelsData,
                datasets: [{
                    label: "Doanh thu",
                    data: valuesData,
                    backgroundColor: "rgba(0, 156, 255, 0.45)",
                    borderColor: "rgba(0, 156, 255, 1)",
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
