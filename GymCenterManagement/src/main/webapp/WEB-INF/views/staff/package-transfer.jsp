<%--
  =========================================================================
  Document    : package-transfer.jsp
  Created on  : 2026-06-25
  Author      : Antigravity AI
  Description : Trang chuyển nhượng gói tập cho hội viên dành cho Staff
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
            <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-exchange-alt me-2 text-primary"></i>Chuyển nhượng gói tập Gym</h4>
            <small class="text-muted">Chuyển nhượng thời gian tập luyện còn lại từ hội viên này sang hội viên khác</small>
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
        <!-- Form and Transfer Information Card -->
        <div class="col-xl-7 col-lg-8">
            <div class="bg-light rounded p-4 p-md-5 shadow-sm border-0 h-100">
                <h5 class="text-dark fw-bold mb-4 border-bottom pb-2">Thông tin chuyển nhượng</h5>
                
                <form action="${pageContext.request.contextPath}/staff/package/transfer" method="post" id="transferForm" class="needs-validation" novalidate>
                    <input type="hidden" name="senderId" value="${sender.userId}">
                    
                    <!-- Sender Info Display -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label fw-bold text-dark"><i class="fa fa-user me-1 text-muted"></i> Người chuyển nhượng (Sender)</label>
                            <div class="p-3 bg-white rounded border border-2 h-100">
                                <div class="fw-bold text-dark fs-6">${sender.userDetails.fullName}</div>
                                <div class="small text-muted mt-1"><i class="fa fa-id-card me-1"></i> Mã số: MEM-${sender.memberId}</div>
                                <div class="small text-muted"><i class="fa fa-phone me-1"></i> SĐT: ${sender.userDetails.phoneNumber}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold text-dark"><i class="fa fa-box me-1 text-muted"></i> 1. Chọn gói tập chuyển nhượng <span class="text-danger">*</span></label>
                            <div class="p-3 bg-white rounded border border-danger border-2 h-100" style="max-height: 200px; overflow-y: auto;">
                                <c:forEach var="pkg" items="${senderPackages}">
                                    <div class="form-check border-bottom pb-2 mb-2">
                                        <input class="form-check-input sender-pkg-radio" type="radio" name="senderPkgId" id="pkg_${pkg.memberPackageId}" value="${pkg.memberPackageId}" data-days="${remainingDaysMap[pkg.memberPackageId]}" data-name="${pkg.gymPackage.packageName}" required>
                                        <label class="form-check-label w-100 cursor-pointer" for="pkg_${pkg.memberPackageId}">
                                            <div class="fw-bold text-danger fs-6">${pkg.gymPackage.packageName}</div>
                                            <div class="small text-dark fw-bold mt-1"><i class="fa fa-hourglass-half me-1"></i> Thời gian còn lại: ${remainingDaysMap[pkg.memberPackageId]} ngày</div>
                                            <div class="small text-muted"><i class="fa fa-calendar-check me-1"></i> Hạn cuối: ${pkg.endDate}</div>
                                        </label>
                                    </div>
                                </c:forEach>
                                <div class="invalid-feedback">Vui lòng chọn 1 gói tập để chuyển nhượng.</div>
                            </div>
                        </div>
                    </div>

                    <!-- Searchable Receiver Selection -->
                    <div class="mb-4">
                        <label for="receiverSearch" class="form-label fw-bold text-dark"><i class="fa fa-user-friends me-1 text-muted"></i> 1. Tìm kiếm và chọn người nhận (Receiver) <span class="text-danger">*</span></label>
                        <div class="input-group mb-2">
                            <span class="input-group-text bg-white text-muted border-end-0"><i class="fa fa-search"></i></span>
                            <input type="text" id="receiverSearch" class="form-control border-start-0" placeholder="Nhập tên, email hoặc số điện thoại người nhận...">
                        </div>
                        <select class="form-select form-select-lg border-2" id="receiverSelect" name="receiverId" size="5" style="height: 140px; overflow-y: auto;" required>
                            <c:forEach var="m" items="${activeMembers}">
                                <option value="${m.userId}" 
                                        data-name="${m.userDetails.fullName}" 
                                        data-email="${m.userDetails.email}"
                                        data-phone="${m.userDetails.phoneNumber}">
                                    ${m.userDetails.fullName} (Mã: MEM-${m.memberId} | SĐT: ${m.userDetails.phoneNumber})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn người nhận chuyển nhượng.</div>
                        <div class="form-text text-muted">Hội viên người gửi không được hiển thị trong danh sách này.</div>
                    </div>

                    <!-- Fixed Transfer Fee input -->
                    <div class="mb-4">
                        <label for="transferFee" class="form-label fw-bold text-dark"><i class="fa fa-receipt me-1 text-muted"></i> 2. Phí dịch vụ chuyển nhượng (₫) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-white fw-bold text-dark">₫</span>
                            <input type="number" id="transferFee" name="transferFee" class="form-control border-2 fw-bold text-primary" value="100000" required>
                        </div>
                        <div class="form-text text-muted">Gói người nhận sẽ ở trạng thái Pending đến khi thanh toán xong phí này.</div>
                    </div>

                    <!-- Notes/Reason -->
                    <div class="mb-5">
                        <label for="note" class="form-label fw-bold text-dark"><i class="fa fa-edit me-1 text-muted"></i> 3. Lý do / Ghi chú chuyển nhượng</label>
                        <textarea class="form-control border-2" id="note" name="note" rows="3" placeholder="Nhập lý do chuyển nhượng gói tập (Ví dụ: Đổi chủ thẻ, chuyển nhượng thẻ tập cho người quen...)"></textarea>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex gap-3 justify-content-end border-top pt-4">
                        <a href="${pageContext.request.contextPath}/staff/members" class="btn btn-lg btn-outline-secondary px-4">Hủy bỏ</a>
                        <%-- Nút submit form gửi thông tin làm thủ tục chuyển nhượng và tạo hóa đơn thanh toán phí --%>
                        <button type="submit" class="btn btn-lg btn-danger px-5 shadow-sm">
                            Tạo thủ tục chuyển nhượng <i class="fa fa-arrow-right ms-2"></i>
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
                    <h5 class="mb-0 fw-bold text-white">Tóm tắt chuyển nhượng</h5>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div>
                        <!-- Sender Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Người chuyển nhượng</h6>
                            <div class="p-3 bg-light rounded border text-dark">
                                <div class="fw-bold">${sender.userDetails.fullName}</div>
                                <div id="summarySenderContainer" class="mt-2 text-muted">
                                    <i class="fa fa-box me-1"></i> Chưa chọn gói tập.
                                </div>
                            </div>
                        </div>

                        <!-- Receiver Summary -->
                        <div class="mb-4">
                            <h6 class="text-uppercase text-secondary fw-bold small mb-2">Người nhận chuyển nhượng</h6>
                            <div id="summaryReceiverContainer" class="p-3 bg-light rounded border border-dashed text-muted">
                                <i class="fa fa-user-circle me-1"></i> Chưa chọn người nhận.
                            </div>
                        </div>
                    </div>

                    <!-- Total Cost Summary -->
                    <div class="border-top pt-4 mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted fw-bold">Tổng phí chuyển nhượng:</span>
                            <span class="fs-3 fw-extrabold text-primary" id="feeAmountText">₫100,000</span>
                        </div>
                        <div class="alert alert-warning small border-0 py-2 px-3 mb-0" role="alert">
                            <i class="fa fa-info-circle me-1"></i> Lưu ý: Khi Receiver thanh toán xong hóa đơn phí, gói tập của Sender sẽ <strong>lập tức kết thúc (Expired)</strong> và gói của Receiver mới bắt đầu có hiệu lực <strong>(Active)</strong>.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("transferForm");
        
        // Xử lý chặn submit khi dữ liệu trong form không hợp lệ (validation)
        form.addEventListener("submit", function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);

        // Xử lý update phí chuyển nhượng
        const transferFeeInput = document.getElementById("transferFee");
        const feeAmountText = document.getElementById("feeAmountText");
        
        function formatVND(value) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value).replace('₫', '₫');
        }

        transferFeeInput.addEventListener("input", function() {
            const val = parseFloat(this.value) || 0;
            feeAmountText.innerText = formatVND(val);
        });

        // Receiver Search Filter
        const receiverSearch = document.getElementById("receiverSearch");
        const receiverSelect = document.getElementById("receiverSelect");
        const receiverOptions = Array.from(receiverSelect.options);

        receiverSearch.addEventListener("input", function() {
            const query = receiverSearch.value.toLowerCase().trim();
            receiverSelect.innerHTML = "";
            
            receiverOptions.forEach(opt => {
                const name = opt.getAttribute("data-name") ? opt.getAttribute("data-name").toLowerCase() : "";
                const email = opt.getAttribute("data-email") ? opt.getAttribute("data-email").toLowerCase() : "";
                const phone = opt.getAttribute("data-phone") ? opt.getAttribute("data-phone").toLowerCase() : "";
                
                if (name.includes(query) || email.includes(query) || phone.includes(query)) {
                    receiverSelect.appendChild(opt);
                }
            });
        });

        // Summary details update
        const summaryReceiver = document.getElementById("summaryReceiverContainer");
        const summarySender = document.getElementById("summarySenderContainer");
        const senderRadios = document.querySelectorAll(".sender-pkg-radio");
        let currentRemainingDays = 0;

        // Hàm cập nhật bản tóm tắt thông tin người nhận gói tập và tính toán thời gian hiệu lực mới
        function updateReceiverSummary() {
            const selectedOpt = receiverSelect.options[receiverSelect.selectedIndex];
            if (selectedOpt && currentRemainingDays > 0) {
                const name = selectedOpt.getAttribute("data-name");
                const phone = selectedOpt.getAttribute("data-phone");
                const id = selectedOpt.value;

                let startDate = new Date(); 
                let endDate = new Date(startDate);
                endDate.setDate(endDate.getDate() + currentRemainingDays);

                const startStr = startDate.toLocaleDateString('vi-VN');
                const endStr = endDate.toLocaleDateString('vi-VN');

                summaryReceiver.innerHTML = `
                    <div class="fw-bold text-dark fs-6">\${name}</div>
                    <div class="small text-muted"><i class="fa fa-id-card me-1"></i> Mã: MEM-\${id} | SĐT: \${phone}</div>
                    <div class="small text-success fw-bold mt-2"><i class="fa fa-calendar-alt me-1"></i> Ngày bắt đầu: Hôm nay (\${startStr})</div>
                    <div class="small text-success fw-bold"><i class="fa fa-calendar-check me-1"></i> Hạn sử dụng gói tập được nhận: \${endStr} (\${currentRemainingDays} ngày)</div>
                `;
                summaryReceiver.classList.remove("text-muted");
                summaryReceiver.classList.add("border-solid");
            } else if (selectedOpt) {
                summaryReceiver.innerHTML = `<i class="fa fa-info-circle me-1"></i> Vui lòng chọn gói tập để tính toán thời gian.`;
            }
        }

        senderRadios.forEach(radio => {
            radio.addEventListener("change", function() {
                if (this.checked) {
                    currentRemainingDays = parseInt(this.getAttribute("data-days")) || 0;
                    const pkgName = this.getAttribute("data-name");
                    summarySender.innerHTML = `
                        <small class="text-dark fw-bold"><i class="fa fa-box me-1"></i> Gói tập: \${pkgName}</small>
                        <br/>
                        <small class="text-danger fw-bold"><i class="fa fa-hourglass-half me-1"></i> Chuyển đi: \${currentRemainingDays} ngày tập</small>
                    `;
                    summarySender.classList.remove("text-muted");
                    updateReceiverSummary();
                }
            });
        });

        receiverSelect.addEventListener("change", updateReceiverSummary);
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
