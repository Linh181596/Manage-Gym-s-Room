<%--
  =========================================================================
  Document    : package-register.jsp
  Created on  : 2026-06-01
  Author      : Nguyễn Hoàng Thắng
  Description : Trang đăng ký gói tập cho thành viên dành cho Staff
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
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-user-plus me-2 text-primary"></i>Register Gym Package</h4>
            <small class="text-muted">Enroll active gym members into gym training and subscription packages</small>
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
                <h5 class="text-dark fw-bold mb-4 border-bottom pb-2">Select Registration Details</h5>
                
                <form action="${pageContext.request.contextPath}/staff/register-package" method="post" id="registrationForm" class="needs-validation" novalidate>
                    
                    <!-- Searchable Member Selector -->
                    <div class="mb-4">
                        <label for="memberSearch" class="form-label fw-bold text-dark"><i class="fa fa-user me-1 text-muted"></i> 1. Search and Select Member <span class="text-danger">*</span></label>
                        <div class="input-group mb-2">
                            <span class="input-group-text bg-white text-muted border-end-0"><i class="fa fa-search"></i></span>
                            <input type="text" id="memberSearch" class="form-control border-start-0" placeholder="Type member name, email or phone...">
                        </div>
                        <select class="form-select form-select-lg border-2" id="memberSelect" name="memberId" size="5" style="height: 140px; overflow-y: auto;" required>
                            <c:forEach var="member" items="${members}">
                                <option value="${member.memberId}" 
                                        data-name="${member.userDetails.fullName}" 
                                        data-email="${member.userDetails.email}"
                                        data-phone="${member.userDetails.phoneNumber}">
                                    ${member.userDetails.fullName} (ID: MEM-${member.memberId} | ${member.userDetails.phoneNumber})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select a gym member.</div>
                        <div class="form-text text-muted">Scroll and double-click or select the appropriate member from the list.</div>
                    </div>

                    <!-- Package Selector -->
                    <div class="mb-5">
                        <label for="packageSelect" class="form-label fw-bold text-dark"><i class="fa fa-box me-1 text-muted"></i> 2. Select Gym Package <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg border-2" id="packageSelect" name="packageId" required>
                            <option value="" disabled selected>-- Select a Package --</option>
                            <c:forEach var="pkg" items="${packages}">
                                <option value="${pkg.packageId}" 
                                        data-name="${pkg.packageName}" 
                                        data-price="${pkg.price}" 
                                        data-duration="${pkg.durationMonths}"
                                        data-desc="${pkg.description}">
                                    ${pkg.packageName} (${pkg.durationMonths} Mon - <fmt:formatNumber value="${pkg.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>)
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select a training package.</div>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-lg btn-outline-secondary px-4">Cancel</a>
                        <button type="submit" class="btn btn-lg btn-primary px-5 shadow-sm">
                            Next: Record Payment <i class="fa fa-arrow-right ms-2"></i>
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
                    <h5 class="mb-0 fw-bold">Registration Summary</h5>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div>
                        <!-- Member Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Member Information</h6>
                            <div id="summaryMemberContainer" class="p-3 bg-light rounded border border-dashed text-muted">
                                <i class="fa fa-user-circle me-1"></i> No member selected yet.
                            </div>
                        </div>

                        <!-- Package Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Package Details</h6>
                            <div id="summaryPackageContainer" class="p-3 bg-light rounded border border-dashed text-muted">
                                <i class="fa fa-box-open me-1"></i> No package selected yet.
                            </div>
                        </div>
                    </div>

                    <!-- Total Cost Summary -->
                    <div class="border-top pt-4 mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted fw-bold">Total Amount Due:</span>
                            <span class="fs-3 fw-extrabold text-primary" id="totalAmountText">₫0</span>
                        </div>
                        <div class="alert alert-warning small border-0 py-2 px-3 mb-0" role="alert">
                            <i class="fa fa-info-circle me-1"></i> Submitting this form will create a <strong>Pending Invoice</strong> and register the package with status <strong>Pending</strong>.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rich Selection and Filtering JavaScript logic -->
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

        // Member Search Filter
        const memberSearch = document.getElementById("memberSearch");
        const memberSelect = document.getElementById("memberSelect");
        const memberOptions = Array.from(memberSelect.options);

        memberSearch.addEventListener("input", function() {
            const query = memberSearch.value.toLowerCase().trim();
            memberSelect.innerHTML = "";
            
            memberOptions.forEach(opt => {
                const name = opt.getAttribute("data-name") ? opt.getAttribute("data-name").toLowerCase() : "";
                const email = opt.getAttribute("data-email") ? opt.getAttribute("data-email").toLowerCase() : "";
                const phone = opt.getAttribute("data-phone") ? opt.getAttribute("data-phone").toLowerCase() : "";
                
                if (name.includes(query) || email.includes(query) || phone.includes(query)) {
                    memberSelect.appendChild(opt);
                }
            });
        });

        // Live Summary updates
        const summaryMember = document.getElementById("summaryMemberContainer");
        const summaryPackage = document.getElementById("summaryPackageContainer");
        const totalAmountText = document.getElementById("totalAmountText");

        // Format currency helper
        function formatVND(value) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value).replace('₫', '₫');
        }

        // Member change callback
        memberSelect.addEventListener("change", function() {
            const selectedOpt = memberSelect.options[memberSelect.selectedIndex];
            if (selectedOpt) {
                const name = selectedOpt.getAttribute("data-name");
                const email = selectedOpt.getAttribute("data-email");
                const phone = selectedOpt.getAttribute("data-phone");
                const id = selectedOpt.value;

                summaryMember.innerHTML = `
                    <div class="fw-bold text-dark fs-6">${name}</div>
                    <div class="small text-muted"><i class="fa fa-id-card me-1"></i> ID: MEM-${id}</div>
                    <div class="small text-muted"><i class="fa fa-phone me-1"></i> ${phone}</div>
                    <div class="small text-muted"><i class="fa fa-envelope me-1"></i> ${email}</div>
                `;
                summaryMember.classList.remove("text-muted");
                summaryMember.classList.add("border-solid");
            }
        });

        // Package change callback
        const packageSelect = document.getElementById("packageSelect");
        packageSelect.addEventListener("change", function() {
            const selectedOpt = packageSelect.options[packageSelect.selectedIndex];
            if (selectedOpt) {
                const name = selectedOpt.getAttribute("data-name");
                const price = parseFloat(selectedOpt.getAttribute("data-price"));
                const duration = selectedOpt.getAttribute("data-duration");
                const desc = selectedOpt.getAttribute("data-desc") || "No detailed description.";

                summaryPackage.innerHTML = `
                    <div class="fw-bold text-dark fs-6">${name}</div>
                    <div class="small text-primary fw-semibold"><i class="fa fa-calendar-alt me-1"></i> Duration: ${duration} Months</div>
                    <div class="small text-dark fw-bold mt-1"><i class="fa fa-tag me-1"></i> Price: ${formatVND(price)}</div>
                    <p class="small text-muted mt-2 mb-0 italic" style="font-size: 0.85rem;">${desc}</p>
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
