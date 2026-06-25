<%--
  =========================================================================
  Document    : package-renew.jsp
  Created on  : 2026-06-25
  Author      : Antigravity AI
  Description : Trang gia hạn gói tập cho hội viên dành cho Staff
  =========================================================================
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <!-- Page Title -->
    <div class="mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-history me-2 text-primary"></i>Gia hạn gói tập Gym</h4>
            <small class="text-muted">Gia hạn thời hạn gói tập luyện hội viên phòng tập</small>
        </div>
    </div>

    <!-- Error/Notice messages -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Selection Form Column -->
        <div class="col-xl-7 col-lg-8">
            <div class="bg-light rounded p-4 p-md-5 shadow-sm border-0 h-100">
                <h5 class="text-dark fw-bold mb-4 border-bottom pb-2">Thông tin gia hạn</h5>
                
                <form action="${pageContext.request.contextPath}/staff/package/renew" method="post" id="renewForm" class="needs-validation" novalidate>
                    <input type="hidden" name="memberId" value="${member.userId}">
                    
                    <!-- Member Info display -->
                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark"><i class="fa fa-user me-1 text-muted"></i> Hội viên gia hạn</label>
                        <div class="p-3 bg-white rounded border border-2">
                            <div class="fw-bold text-dark fs-6">${member.userDetails.fullName}</div>
                            <div class="small text-muted mt-1"><i class="fa fa-id-card me-1"></i> Mã số: MEM-${member.memberId}</div>
                            <div class="small text-muted"><i class="fa fa-phone me-1"></i> Số điện thoại: ${member.userDetails.phoneNumber}</div>
                            <div class="small text-muted"><i class="fa fa-envelope me-1"></i> Email: ${member.userDetails.email}</div>
                        </div>
                    </div>

                    <!-- Current Package display -->
                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark"><i class="fa fa-box me-1 text-muted"></i> Gói tập đang hoạt động hiện tại</label>
                        <c:choose>
                            <c:when test="${not empty activePkg}">
                                <div class="p-3 bg-white rounded border border-success border-2">
                                    <div class="fw-bold text-success fs-6"><i class="fa fa-check-circle me-1"></i> ${activePkg.gymPackage.packageName}</div>
                                    <div class="small text-muted mt-1"><i class="fa fa-calendar-alt me-1"></i> Ngày bắt đầu: ${activePkg.startDate}</div>
                                    <div class="small text-dark fw-bold"><i class="fa fa-calendar-check me-1"></i> Ngày hết hạn: ${activePkg.endDate}</div>
                                    <div class="small text-muted"><i class="fa fa-clock me-1"></i> Giá trị: ${activePkg.gymPackage.durationMonths} Tháng</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="p-3 bg-white rounded border border-warning border-dashed border-2 text-warning">
                                    <i class="fa fa-exclamation-triangle me-1"></i> Không có gói tập nào đang hoạt động hoặc gói tập đã hết hạn. Gói gia hạn mới sẽ được kích hoạt kể từ <strong>Hôm nay</strong>.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Package Selector -->
                    <div class="mb-5">
                        <label for="packageSelect" class="form-label fw-bold text-dark"><i class="fa fa-cart-plus me-1 text-muted"></i> Chọn gói tập Gym gia hạn <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg border-2" id="packageSelect" name="packageId" required>
                            <option value="" disabled selected>-- Chọn gói tập --</option>
                            <c:forEach var="pkg" items="${packages}">
                                <option value="${pkg.packageId}" 
                                        data-name="${pkg.packageName}" 
                                        data-price="${pkg.price}" 
                                        data-duration="${pkg.durationMonths}"
                                        data-desc="${pkg.description}">
                                    ${pkg.packageName} (${pkg.durationMonths} Tháng - <fmt:formatNumber value="${pkg.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>)
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn một gói tập để gia hạn.</div>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/staff/members" class="btn btn-lg btn-outline-secondary px-4">Quay lại</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            Tạo hóa đơn gia hạn <i class="fa fa-arrow-right ms-2"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Real-time Live Summary Column -->
        <div class="col-xl-5 col-lg-4">
            <div class="card border-0 shadow-sm rounded h-100 bg-white">
                <div class="card-header bg-dark text-white p-4 border-0 rounded-top d-flex align-items-center">
                    <i class="fa fa-shopping-cart me-2 fs-5 text-primary"></i>
                    <h5 class="mb-0 fw-bold">Tóm tắt gia hạn</h5>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div>
                        <!-- Member Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Thông tin hội viên</h6>
                            <div class="p-3 bg-light rounded border text-dark">
                                <div class="fw-bold">${member.userDetails.fullName}</div>
                                <small class="text-muted">Mã: MEM-${member.memberId}</small>
                            </div>
                        </div>

                        <!-- Date Calculations Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Thời gian gói mới dự kiến</h6>
                            <div id="summaryDatesContainer" class="p-3 bg-light rounded border border-dashed text-muted">
                                <i class="fa fa-calendar-plus me-1"></i> Chưa chọn gói tập mới để tính toán.
                            </div>
                        </div>
                    </div>

                    <!-- Total Cost Summary -->
                    <div class="border-top pt-4 mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted fw-bold">Tổng số tiền gia hạn:</span>
                            <span class="fs-3 fw-extrabold text-primary" id="totalAmountText">₫0</span>
                        </div>
                        <div class="alert alert-warning small border-0 py-2 px-3 mb-0" role="alert">
                            <i class="fa fa-info-circle me-1"></i> Xác nhận gia hạn sẽ tạo <strong>Hóa đơn chờ thanh toán</strong>. Gói mới sẽ ở trạng thái <strong>Chờ xử lý</strong> và tự động kích hoạt sau khi thanh toán.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("renewForm");
        
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        const packageSelect = document.getElementById("packageSelect");
        const summaryDates = document.getElementById("summaryDatesContainer");
        const totalAmountText = document.getElementById("totalAmountText");

        // Format currency helper
        function formatVND(value) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value).replace('₫', '₫');
        }

        // Parse date from java model to JS LocalDate
        let currentEndDate = null;
        <c:if test="${not empty activePkg}">
            currentEndDate = new Date("${activePkg.endDate}");
        </c:if>

        packageSelect.addEventListener("change", function() {
            const selectedOpt = packageSelect.options[packageSelect.selectedIndex];
            if (selectedOpt) {
                const name = selectedOpt.getAttribute("data-name");
                const price = parseFloat(selectedOpt.getAttribute("data-price"));
                const duration = parseInt(selectedOpt.getAttribute("data-duration"));

                // Tính toán ngày bắt đầu và kết thúc gói mới
                let startDate = new Date(); // Mặc định là hôm nay nếu không có gói cũ
                if (currentEndDate && currentEndDate >= new Date()) {
                    startDate = new Date(currentEndDate);
                    startDate.setDate(startDate.getDate() + 1); // Bắt đầu ngày hôm sau ngày hết hạn gói cũ
                }

                let endDate = new Date(startDate);
                endDate.setMonth(endDate.getMonth() + duration);

                // Format dates to dd/mm/yyyy
                const startStr = startDate.toLocaleDateString('vi-VN');
                const endStr = endDate.toLocaleDateString('vi-VN');

                summaryDates.innerHTML = `
                    <div class="fw-bold text-dark">${name}</div>
                    <div class="small text-muted mt-1"><i class="fa fa-calendar-alt me-1"></i> Ngày bắt đầu gói mới: <strong>${startStr}</strong></div>
                    <div class="small text-primary fw-bold"><i class="fa fa-calendar-check me-1"></i> Ngày hết hạn gói mới: <strong>${endStr}</strong></div>
                    <div class="small text-muted"><i class="fa fa-hourglass-half me-1"></i> Thời gian cộng thêm: ${duration} Tháng</div>
                `;
                summaryDates.classList.remove("text-muted");
                summaryDates.classList.add("border-solid");

                totalAmountText.innerText = formatVND(price);
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
