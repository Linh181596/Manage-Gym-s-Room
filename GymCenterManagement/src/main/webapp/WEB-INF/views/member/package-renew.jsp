<%--
  =========================================================================
  Document    : package-renew.jsp
  Created on  : 2026-08-03
  Author      : (AI Generated)
  Description : Trang gia hạn gói tập dành cho Hội viên
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
            <small class="text-muted">Lựa chọn gói tập phù hợp và tiến hành thanh toán để gia hạn gói tập hiện tại</small>
        </div>
    </div>

    <!-- Error/Notice messages -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <div class="row g-4">
        <!-- Selection Form Column -->
        <div class="col-xl-7 col-lg-8">
            <div class="bg-light rounded p-4 p-md-5 shadow-sm border-0 h-100">
                <h5 class="text-dark fw-bold mb-4 border-bottom pb-2">Chọn thông tin gia hạn</h5>
                
                <form action="${pageContext.request.contextPath}/member/renew-package" method="post" id="registrationForm" class="needs-validation" novalidate>

                    <!-- Package Selector -->
                    <div class="mb-4">
                        <label for="packageSelect" class="form-label fw-bold text-dark"><i class="fa fa-box me-1 text-muted"></i> 1. Chọn gói tập Gym <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg border-2" id="packageSelect" name="packageId" required>
                            <option value="" disabled selected>-- Chọn một gói tập --</option>
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
                        <div class="invalid-feedback">Vui lòng chọn một gói tập.</div>
                    </div>

                    <!-- Payment Method -->
                    <div class="mb-5">
                        <label class="form-label fw-bold text-dark"><i class="fa fa-credit-card me-1 text-muted"></i> 2. Phương thức thanh toán <span class="text-danger">*</span></label>
                        <div class="d-flex flex-column gap-2 mt-2">
                            <div class="p-3 border rounded bg-white cursor-pointer d-flex align-items-center" onclick="document.getElementById('payVNPay').click()">
                                <input class="form-check-input m-0 fs-5" type="radio" name="paymentMethod" id="payVNPay" value="VNPay" required>
                                <label class="form-check-label ms-3 w-100 cursor-pointer" for="payVNPay">
                                    <div class="fw-bold text-dark">Thanh toán trực tuyến VNPay (Khuyên dùng)</div>
                                    <div class="small text-muted fw-normal mt-1">Hỗ trợ ATM, Visa, MasterCard. Gói tập sẽ kích hoạt ngay lập tức.</div>
                                </label>
                            </div>
                            <div class="p-3 border rounded bg-white cursor-pointer d-flex align-items-center" onclick="document.getElementById('payCash').click()">
                                <input class="form-check-input m-0 fs-5" type="radio" name="paymentMethod" id="payCash" value="Cash" required>
                                <label class="form-check-label ms-3 w-100 cursor-pointer" for="payCash">
                                    <div class="fw-bold text-dark">Thanh toán Tiền mặt tại quầy</div>
                                    <div class="small text-muted fw-normal mt-1">Bạn sẽ cần đến quầy lễ tân để thanh toán và nhờ nhân viên kích hoạt gói.</div>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/member/portal" class="btn btn-lg btn-outline-secondary px-4">Hủy bỏ</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            Gia hạn & Thanh toán <i class="fa fa-arrow-right ms-2"></i>
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
                    <h5 class="mb-0 fw-bold text-white">Tóm tắt đăng ký</h5>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div>
                        <!-- Package Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Chi tiết gói tập</h6>
                            <div id="summaryPackageContainer" class="p-3 bg-light rounded border border-dashed text-muted">
                                <i class="fa fa-box-open me-1"></i> Chưa có gói tập nào được chọn.
                            </div>
                        </div>
                    </div>

                    <!-- Total Cost Summary -->
                    <div class="border-top pt-4 mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted fw-bold">Tổng số tiền cần thanh toán:</span>
                            <span class="fs-3 fw-extrabold text-primary" id="totalAmountText">₫0</span>
                        </div>
                        <div class="alert alert-info small border-0 py-2 px-3 mb-0" role="alert">
                            <i class="fa fa-info-circle me-1"></i> Với thanh toán VNPay, gói tập của bạn sẽ được kích hoạt ngay sau khi thanh toán thành công.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rich Selection JavaScript logic -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("registrationForm");
        
        // Form Validation styling
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        // Live Summary updates
        const summaryPackage = document.getElementById("summaryPackageContainer");
        const totalAmountText = document.getElementById("totalAmountText");

        // Format currency helper
        function formatVND(value) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value).replace('₫', '₫');
        }

        // Package change callback
        const packageSelect = document.getElementById("packageSelect");
        packageSelect.addEventListener("change", function() {
            const selectedOpt = packageSelect.options[packageSelect.selectedIndex];
            if (selectedOpt) {
                const name = selectedOpt.getAttribute("data-name");
                const price = parseFloat(selectedOpt.getAttribute("data-price"));
                const duration = parseInt(selectedOpt.getAttribute("data-duration"));
                const desc = selectedOpt.getAttribute("data-desc") || "Không có mô tả chi tiết.";

                let existingEndDateStr = "${latestPkg.endDate}";
                let startDate = existingEndDateStr ? new Date(existingEndDateStr) : new Date();
                
                let endDate = new Date(startDate);
                endDate.setMonth(endDate.getMonth() + duration);

                document.getElementById("summaryStartDate").innerText = "Nối tiếp gói cũ (" + startDate.toLocaleDateString('vi-VN') + ")";
                document.getElementById("summaryEndDate").innerText = endDate.toLocaleDateString('vi-VN');

                summaryPackage.innerHTML = `
                    <div class="fw-bold text-dark fs-6">\${name}</div>
                    <div class="small text-primary fw-semibold"><i class="fa fa-hourglass-half me-1"></i> Thời hạn: \${duration} Tháng</div>
                    <div class="small text-dark fw-bold mt-1"><i class="fa fa-tag me-1"></i> Giá tiền: \${formatVND(price)}</div>
                    <p class="small text-muted mt-2 mb-0 italic" style="font-size: 0.85rem;">\${desc}</p>
                `;
                summaryPackage.classList.remove("text-muted");
                summaryPackage.classList.add("border-solid");
                
                totalAmountText.innerText = formatVND(price);
            } else {
                totalAmountText.innerText = "₫0";
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
