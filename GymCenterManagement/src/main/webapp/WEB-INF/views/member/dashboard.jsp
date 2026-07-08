<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  =========================================================================
  Document    : dashboard.jsp
  Created on  : 2026-06-26
  Author      : Nguyen Dai Duong (duongnd)
  Description : Giao diện bảng điều khiển động hiển thị hoạt động và chi tiêu cho Hội viên (Member).
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:set var="data" value="${dashboardData}" />

<!-- Member Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Welcome Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-1 text-dark fw-bold"><i class="fa fa-home me-2 text-primary"></i>Chào mừng quay trở lại, ${sessionScope.currentUser.fullName}!</h4>
            <small class="text-muted">GCMS cung cấp cái nhìn tổng quan về lịch tập, các gói dịch vụ và chi tiêu của bạn</small>
        </div>
        <a href="${pageContext.request.contextPath}/member/dashboard" class="btn btn-sm btn-primary shadow-sm">
            <i class="fa fa-sync-alt me-1"></i> Làm mới
        </a>
    </div>

    <!-- Row 1: KPI Cards -->
    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <a href="#upcoming-sessions" class="text-decoration-none">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-calendar-check fa-3x text-primary"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Lịch hẹn của tôi</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.upcomingAppointmentsCount} Buổi hẹn</h5>
                        <small class="text-muted">Sắp diễn ra</small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${pageContext.request.contextPath}/member/portal" class="text-decoration-none">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-id-card fa-3x text-success"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Gói hội viên</p>
                        <h5 class="mb-0 text-dark fw-bold text-truncate" style="max-width: 150px;" title="${empty data ? 'Chưa đăng ký' : data.activePackageName}">
                            ${empty data ? "Chưa đăng ký" : data.activePackageName}
                        </h5>
                        <small class="text-success fw-semibold">Còn lại: ${empty data ? 0 : data.activePackageRemainingDays} ngày</small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${pageContext.request.contextPath}/member/portal" class="text-decoration-none">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-dollar-sign fa-3x text-info"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Chi tiêu tháng này</p>
                        <h5 class="mb-0 text-dark fw-bold">
                            <fmt:formatNumber value="${empty data ? 0 : data.spendThisMonth}" type="number" maxFractionDigits="0"/> đ
                        </h5>
                        <small class="text-muted">Lịch sử giao dịch</small>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${pageContext.request.contextPath}/member/notifications" class="text-decoration-none">
                <div class="bg-light rounded d-flex align-items-center justify-content-between p-4 shadow-sm h-100">
                    <i class="fa fa-bell fa-3x text-warning"></i>
                    <div class="ms-3 text-end">
                        <p class="mb-2 text-muted fw-semibold">Hộp thư thông báo</p>
                        <h5 class="mb-0 text-dark fw-bold">${empty data ? 0 : data.unreadNotificationsCount} Thông báo</h5>
                        <small class="text-muted">Xem tin tức mới</small>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Row 2: Spend History Chart & Quick Actions -->
    <div class="row g-4 mb-4">
        <!-- Spend Chart -->
        <div class="col-sm-12 col-xl-8">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <h6 class="mb-0 text-dark fw-bold">Biểu đồ chi tiêu hàng tháng</h6>
                        <small class="text-muted">Lịch sử chi trả phí tập và thuê PT trong 6 tháng gần nhất</small>
                    </div>
                </div>
                <div class="position-relative" style="height: 280px;">
                    <canvas id="member-spend-chart"
                            data-labels='${empty data ? "[]" : data.spendChartLabelsJson}'
                            data-values='${empty data ? "[]" : data.spendChartValuesJson}'></canvas>
                </div>
            </div>
        </div>

        <!-- Quick Actions Panel -->
        <div class="col-sm-12 col-xl-4">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <h6 class="mb-4 text-dark fw-bold">Thao tác nhanh</h6>
                <div class="d-grid gap-3">
                    <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-primary py-3 fw-bold shadow-sm">
                        <i class="fa fa-dumbbell me-2"></i>Đăng ký gói tập / PT
                    </a>
                    <a href="${pageContext.request.contextPath}/member/schedule-dashboard" class="btn btn-outline-success py-3 fw-bold shadow-sm">
                        <i class="fa fa-calendar-alt me-2"></i>Lịch tập của tôi (Tuần)
                    </a>
                    <a href="${pageContext.request.contextPath}/member/portal" class="btn btn-outline-primary py-3 fw-bold">
                        <i class="fa fa-history me-2"></i>Xem lịch sử & thẻ
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Row 3: Upcoming Sessions & Recent Invoices -->
    <div class="row g-4" id="upcoming-sessions">
        <!-- Upcoming Sessions Table -->
        <div class="col-12 col-xl-7">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0 text-dark fw-bold">Lịch tập sắp tới</h6>
                    <a href="${pageContext.request.contextPath}/member/schedule-dashboard" class="small text-decoration-none">Xem lịch tuần <i class="fa fa-chevron-right"></i></a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Ngày tập</th>
                                <th scope="col">Khung giờ</th>
                                <th scope="col">Dịch vụ</th>
                                <th scope="col">Huấn luyện viên (PT)</th>
                                <th scope="col" class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty data or empty data.upcomingSessions}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">
                                            <i class="fa fa-calendar-times fa-3x mb-3 text-secondary d-block"></i>
                                            Bạn chưa có buổi tập nào sắp tới.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="s" items="${data.upcomingSessions}">
                                        <tr>
                                            <td class="fw-bold">${s.sessionDate}</td>
                                            <td>
                                                <span class="badge bg-light text-dark border">
                                                    <fmt:formatDate value="${s.startTime}" pattern="HH:mm"/> -
                                                    <fmt:formatDate value="${s.endTime}" pattern="HH:mm"/>
                                                </span>
                                            </td>
                                            <td>${empty s.packageName ? 'Thuê PT cá nhân' : s.packageName}</td>
                                            <td><span class="text-primary fw-semibold"><i class="fa fa-user-tie me-1"></i>${s.ptName}</span></td>
                                            <td class="text-center">
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-primary"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#rescheduleModalMember_${s.scheduleId}">
                                                    Đổi lịch
                                                </button>
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

        <!-- Recent Invoices Table -->
        <div class="col-12 col-xl-5">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0 text-dark fw-bold">Hóa đơn gần đây</h6>
                    <a href="${pageContext.request.contextPath}/member/portal" class="small text-decoration-none">Tất cả hóa đơn</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Mã</th>
                                <th scope="col">Dịch vụ</th>
                                <th scope="col" class="text-end">Số tiền</th>
                                <th scope="col" class="text-center">Xem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty data or empty data.recentInvoices}">
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">
                                            <i class="fa fa-receipt fa-3x mb-3 text-secondary d-block"></i>
                                            Không tìm thấy hóa đơn nào của bạn.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="invoice" items="${data.recentInvoices}">
                                        <tr>
                                            <td class="fw-bold text-secondary text-nowrap">${invoice.invoiceCode}</td>
                                            <td>
                                                <small class="d-block text-muted text-uppercase" style="font-size: 0.7rem; font-weight: 600;">${invoice.serviceType}</small>
                                                <span class="text-truncate d-inline-block text-dark fw-semibold" style="max-width: 140px;" title="${invoice.serviceName}">${invoice.serviceName}</span>
                                            </td>
                                            <td class="text-end fw-bold text-primary text-nowrap">
                                                <fmt:formatNumber value="${invoice.amount}" type="number" maxFractionDigits="0"/> đ
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/member/invoice-detail?invoiceId=${invoice.invoiceId}" class="btn btn-sm btn-outline-primary py-0 px-2" style="font-size: 0.8rem;">
                                                    <i class="fa fa-eye"></i>
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
    </div>
</div>

<c:if test="${not empty data and not empty data.upcomingSessions}">
    <c:forEach var="s" items="${data.upcomingSessions}">
        <div class="modal fade" id="rescheduleModalMember_${s.scheduleId}" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="post" action="${pageContext.request.contextPath}/reschedule-request/create">
                        <div class="modal-header">
                            <h5 class="modal-title">Gửi yêu cầu đổi lịch</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="scheduleId" value="${s.scheduleId}">
                            <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/member/dashboard">

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Ngày đề xuất mới</label>
                                <input type="date" name="proposedDate" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Khung giờ cố định mới</label>
                                <select name="proposedSlot" class="form-select" required>
                                    <option value="">Chọn khung giờ</option>
                                    <option value="08:15-09:45">08:15 - 09:45</option>
                                    <option value="10:00-11:30">10:00 - 11:30</option>
                                    <option value="13:30-15:00">13:30 - 15:00</option>
                                    <option value="15:15-16:45">15:15 - 16:45</option>
                                    <option value="17:00-18:30">17:00 - 18:30</option>
                                    <option value="18:45-20:15">18:45 - 20:15</option>
                                </select>
                            </div>

                            <div class="mb-0">
                                <label class="form-label fw-semibold">Lý do</label>
                                <textarea name="reason" class="form-control" rows="3" maxlength="255" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Gửi request</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty sessionScope.toastMsg}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: "success",
                title: "Thành công",
                text: "${sessionScope.toastMsg}",
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: "top-end"
            });
        });
    </script>
    <c:remove var="toastMsg" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: "error",
                title: "Chưa thể gửi request",
                text: "${sessionScope.errorMessage}",
                timer: 3500,
                showConfirmButton: false,
                toast: true,
                position: "top-end"
            });
        });
    </script>
    <c:remove var="errorMessage" scope="session"/>
</c:if>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const chartElement = document.getElementById("member-spend-chart");
        if (!chartElement || typeof Chart === "undefined") {
            return;
        }

        const labelsData = JSON.parse(chartElement.getAttribute("data-labels") || "[]");
        const valuesData = JSON.parse(chartElement.getAttribute("data-values") || "[]");

        new Chart(chartElement.getContext("2d"), {
            type: "line",
            data: {
                labels: labelsData,
                datasets: [{
                    label: "Chi tiêu hàng tháng",
                    data: valuesData,
                    fill: true,
                    backgroundColor: "rgba(0, 156, 255, 0.15)",
                    borderColor: "rgba(0, 156, 255, 1)",
                    borderWidth: 2,
                    pointBackgroundColor: "rgba(0, 156, 255, 1)",
                    tension: 0.3
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
                                return new Intl.NumberFormat("vi-VN").format(value) + " đ";
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
