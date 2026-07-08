<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
  =========================================================================
  Document    : membership-growth-report.jsp
  Created on  : 2026-07-08
  Author      : Nguyễn Trí Linh (linhnt)
  Description : View for Membership Growth Report
  =========================================================================
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<c:url var="newMembersUrl" value="/admin/membership-growth-report">
    <c:param name="year" value="${selectedYear}" />
    <c:if test="${not empty selectedMonth}">
        <c:param name="month" value="${selectedMonth}" />
    </c:if>
    <c:param name="status" value="new" />
</c:url>
<c:url var="activeMembersUrl" value="/admin/membership-growth-report">
    <c:param name="year" value="${selectedYear}" />
    <c:if test="${not empty selectedMonth}">
        <c:param name="month" value="${selectedMonth}" />
    </c:if>
    <c:param name="status" value="active" />
</c:url>
<c:url var="expiredMembersUrl" value="/admin/membership-growth-report">
    <c:param name="year" value="${selectedYear}" />
    <c:if test="${not empty selectedMonth}">
        <c:param name="month" value="${selectedMonth}" />
    </c:if>
    <c:param name="status" value="expired" />
</c:url>
<c:url var="clearSearchUrl" value="/admin/membership-growth-report">
    <c:param name="year" value="${selectedYear}" />
    <c:if test="${not empty selectedMonth}">
        <c:param name="month" value="${selectedMonth}" />
    </c:if>
    <c:if test="${not empty tableStatus}">
        <c:param name="status" value="${tableStatus}" />
    </c:if>
</c:url>

<style>
    .growth-summary-card {
        border-radius: 8px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .growth-summary-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.16) !important;
    }

    .growth-summary-card .summary-icon {
        width: 54px;
        height: 54px;
        background: rgba(255, 255, 255, 0.22);
    }

    .growth-chart-wrapper {
        min-height: 320px;
    }
</style>

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a></li>
                    <li class="breadcrumb-item">Báo cáo</li>
                    <li class="breadcrumb-item active" aria-current="page">Báo cáo tăng trưởng thành viên</li>
                </ol>
            </nav>
            <h4 class="mb-0 text-dark fw-bold">
                <i class="fa fa-chart-line me-2 text-primary"></i>Báo cáo tăng trưởng thành viên
            </h4>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary">
            <i class="fa fa-tachometer-alt me-2"></i>Bảng điều khiển
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i><c:out value="${errorMessage}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="bg-light rounded p-4 mb-4 shadow-sm">
        <form action="${pageContext.request.contextPath}/admin/membership-growth-report" method="GET" class="row align-items-end g-3">
            <div class="col-md-4 col-lg-3">
                <label for="year" class="form-label fw-bold text-secondary">Năm <span class="text-danger">*</span></label>
                <select id="year" name="year" class="form-select" required>
                    <c:forEach var="year" items="${availableYears}">
                        <option value="${year}" ${year == selectedYear ? 'selected' : ''}>${year}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4 col-lg-3">
                <label for="month" class="form-label fw-bold text-secondary">Tháng</label>
                <select id="month" name="month" class="form-select">
                    <option value="">Tất cả các tháng</option>
                    <c:forEach begin="1" end="12" var="month">
                        <option value="${month}" ${selectedMonth == month ? 'selected' : ''}>${month}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4 col-lg-3">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fa fa-eye me-2"></i>Xem báo cáo
                </button>
            </div>
            <div class="col-md-4 col-lg-3">
                <a href="${pageContext.request.contextPath}/admin/membership-growth-report" class="btn btn-outline-secondary w-100">
                    <i class="fa fa-undo me-2"></i>Đặt lại
                </a>
            </div>
        </form>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-sm-6 col-xl-3">
            <a href="${newMembersUrl}#memberTable" class="text-decoration-none">
                <div class="card growth-summary-card bg-primary text-white border-0 shadow-sm h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <p class="mb-2 fw-semibold">Thành viên mới</p>
                            <h3 class="mb-0 fw-bold">${summary.newMembers}</h3>
                            <small>${selectedPeriodText}</small>
                        </div>
                        <div class="summary-icon rounded-circle d-flex align-items-center justify-content-center">
                            <i class="fa fa-user-plus fa-2x"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${activeMembersUrl}#memberTable" class="text-decoration-none">
                <div class="card growth-summary-card bg-success text-white border-0 shadow-sm h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <p class="mb-2 fw-semibold">Thành viên đang hoạt động</p>
                            <h3 class="mb-0 fw-bold">${summary.activeMembers}</h3>
                            <small>Còn hiệu lực</small>
                        </div>
                        <div class="summary-icon rounded-circle d-flex align-items-center justify-content-center">
                            <i class="fa fa-user-check fa-2x"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="${expiredMembersUrl}#memberTable" class="text-decoration-none">
                <div class="card growth-summary-card bg-danger text-white border-0 shadow-sm h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <p class="mb-2 fw-semibold">Thành viên hết hạn</p>
                            <h3 class="mb-0 fw-bold">${summary.expiredMembers}</h3>
                            <small>Đã hết hạn</small>
                        </div>
                        <div class="summary-icon rounded-circle d-flex align-items-center justify-content-center">
                            <i class="fa fa-user-times fa-2x"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-6 col-xl-3">
            <a href="#growthChart" class="text-decoration-none">
                <div class="card growth-summary-card bg-warning text-dark border-0 shadow-sm h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <p class="mb-2 fw-semibold">Tỷ lệ tăng trưởng</p>
                            <h3 class="mb-0 fw-bold">${summary.growthRateText}</h3>
                            <small>Kỳ trước: ${summary.previousPeriodNewMembers}</small>
                        </div>
                        <div class="summary-icon rounded-circle d-flex align-items-center justify-content-center">
                            <i class="fa fa-percentage fa-2x"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div id="growthChart" class="bg-light rounded p-4 mb-4 shadow-sm">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h6 class="mb-0 text-dark fw-bold">
                    <i class="fa fa-chart-bar me-2 text-primary"></i>Biểu đồ tăng trưởng thành viên
                </h6>
                <small class="text-muted">${selectedPeriodText}</small>
            </div>
        </div>
        <div class="growth-chart-wrapper position-relative">
            <canvas id="membershipGrowthChart"
                    data-labels='${chartLabelsJson}'
                    data-values='${chartValuesJson}'></canvas>
        </div>
    </div>

    <div id="memberTable" class="bg-light rounded p-4 shadow-sm">
        <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between mb-4 gap-3">
            <div>
                <h6 class="mb-0 text-dark fw-bold">
                    <i class="fa fa-table me-2 text-primary"></i>${tableStatusLabel}
                </h6>
                <small class="text-muted">${selectedPeriodText}</small>
            </div>
            <form action="${pageContext.request.contextPath}/admin/membership-growth-report#memberTable" method="GET" class="d-flex gap-2">
                <input type="hidden" name="year" value="${selectedYear}">
                <c:if test="${not empty selectedMonth}">
                    <input type="hidden" name="month" value="${selectedMonth}">
                </c:if>
                <c:if test="${not empty tableStatus}">
                    <input type="hidden" name="status" value="${tableStatus}">
                </c:if>
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted">
                        <i class="fa fa-search"></i>
                    </span>
                    <input type="text" name="searchKeyword" class="form-control border-start-0"
                           value="${fn:escapeXml(searchKeyword)}"
                           placeholder="Tìm theo mã hoặc tên thành viên">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-search"></i>
                </button>
                <a href="${clearSearchUrl}#memberTable" class="btn btn-outline-secondary">
                    <i class="fa fa-undo"></i>
                </a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead>
                    <tr class="text-dark">
                        <th scope="col" style="width: 70px;">STT</th>
                        <th scope="col" style="width: 120px;">Mã thành viên</th>
                        <th scope="col">Họ và tên</th>
                        <th scope="col" style="width: 110px;">Giới tính</th>
                        <th scope="col" style="width: 130px;">Số điện thoại</th>
                        <th scope="col">Gói tập</th>
                        <th scope="col" style="width: 150px;">Ngày đăng ký</th>
                        <th scope="col" style="width: 160px;">Ngày hết hạn</th>
                        <th scope="col" class="text-center" style="width: 140px;">Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty members}">
                            <tr>
                                <td colspan="9" class="text-center py-4 text-muted">
                                    <i class="fa fa-info-circle fa-2x mb-2 d-block"></i>Không tìm thấy thành viên.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="member" items="${members}" varStatus="loop">
                                <tr>
                                    <td>${startItem + loop.index}</td>
                                    <td class="fw-bold text-secondary">MEM-${member.memberId}</td>
                                    <td><c:out value="${member.fullName}" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty member.gender}">
                                                <c:out value="${member.gender}" />
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty member.phone}">
                                                <c:out value="${member.phone}" />
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${member.packageName}" /></td>
                                    <td>${member.registrationDateText}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty member.membershipEndDateText}">
                                                ${member.membershipEndDateText}
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${member.membershipStatus == 'Active'}">
                                                <span class="badge bg-success">Đang hoạt động</span>
                                            </c:when>
                                            <c:when test="${member.membershipStatus == 'Expired'}">
                                                <span class="badge bg-danger">Hết hạn</span>
                                            </c:when>
                                            <c:when test="${member.membershipStatus == 'Frozen'}">
                                                <span class="badge bg-info text-dark">Tạm ngưng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">
                                                    <c:out value="${member.membershipStatus}" />
                                                </span>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const chartElement = document.getElementById("membershipGrowthChart");
        if (!chartElement || typeof Chart === "undefined") {
            return;
        }

        const monthLabelMap = {
            "Jan": "Tháng 1",
            "Feb": "Tháng 2",
            "Mar": "Tháng 3",
            "Apr": "Tháng 4",
            "May": "Tháng 5",
            "Jun": "Tháng 6",
            "Jul": "Tháng 7",
            "Aug": "Tháng 8",
            "Sep": "Tháng 9",
            "Oct": "Tháng 10",
            "Nov": "Tháng 11",
            "Dec": "Tháng 12"
        };
        const labelsData = JSON.parse(chartElement.getAttribute("data-labels") || "[]").map(function(label) {
            if (monthLabelMap[label]) {
                return monthLabelMap[label];
            }
            if (label && label.indexOf("Day ") === 0) {
                return "Ngày " + label.substring(4);
            }
            return label;
        });
        const valuesData = JSON.parse(chartElement.getAttribute("data-values") || "[]").map(function(value) {
            return parseInt(value, 10) || 0;
        });

        new Chart(chartElement.getContext("2d"), {
            type: "bar",
            data: {
                labels: labelsData,
                datasets: [{
                    label: "Thành viên",
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
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0,
                            stepSize: 1,
                            callback: function(value) {
                                return Number.isInteger(Number(value)) ? Number(value) : "";
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            title: function(tooltipItems) {
                                return tooltipItems.length > 0 ? tooltipItems[0].label : "";
                            },
                            label: function(context) {
                                return Math.round(context.parsed.y) + " thành viên";
                            }
                        }
                    }
                }
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
