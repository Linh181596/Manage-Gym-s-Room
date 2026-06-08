<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  =========================================================================
  Document    : pt-account-creation-result.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Đình Phú (phund)
  Description : Giao diện hiển thị kết quả tạo tài khoản HLV kèm mật khẩu tạm thời.
  =========================================================================
--%>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="row justify-content-center mb-4">
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <!-- Top Gradient Decoration -->
                <div class="bg-success-gradient rounded-top position-absolute start-0 top-0 w-100" style="height: 6px;"></div>
                
                <div class="card-body p-5 text-center">
                    <!-- Success Icon -->
                    <div class="mb-4 text-success">
                        <i class="fa fa-check-circle fa-4x animate-bounce"></i>
                    </div>

                    <!-- Success Title -->
                    <h3 class="text-dark fw-bold mb-2">Tạo tài khoản PT thành công!</h3>
                    <p class="text-secondary small mb-4">Tài khoản huấn luyện viên cá nhân mới đã được thiết lập thành công trong hệ thống.</p>

                    <!-- Account Details Box -->
                    <div class="bg-light rounded p-4 text-start mb-4 shadow-sm border">
                        <h6 class="text-dark fw-bold mb-3 border-bottom pb-2"><i class="fa fa-id-card text-primary me-2"></i>Thông tin đăng nhập tài khoản</h6>
                        
                        <div class="mb-2">
                            <span class="text-muted d-block small">Tên hiển thị:</span>
                            <strong class="text-dark">${displayName}</strong>
                        </div>
                        <div class="mb-2">
                            <span class="text-muted d-block small">Email đăng nhập (Username):</span>
                            <strong class="text-dark">${email}</strong>
                        </div>
                        <div class="mb-3">
                            <span class="text-muted d-block small">Số điện thoại:</span>
                            <strong class="text-dark">${phone}</strong>
                        </div>
                        
                        <!-- Temporary Password Alert Box -->
                        <div class="p-3 bg-light-warning rounded border border-warning">
                            <span class="text-dark d-block fw-bold small mb-1">
                                <i class="fa fa-key text-warning me-1.5"></i> MẬT KHẨU TẠM THỜI:
                            </span>
                            <div class="d-flex align-items-center justify-content-between">
                                <code class="fs-4 fw-bold text-danger px-2 py-1 bg-white border rounded" id="tempPassword">${temporaryPassword}</code>
                                <button type="button" class="btn btn-sm btn-outline-warning shadow-sm" onclick="copyPassword()">
                                    <i class="fa fa-copy me-1"></i> Sao chép
                                </button>
                            </div>
                            <small class="text-muted d-block mt-2" style="font-size: 11px;">
                                <i class="fa fa-info-circle me-1"></i> <strong>Lưu ý quan trọng:</strong> Mật khẩu này chỉ hiển thị duy nhất <strong>một lần này</strong>. Hãy lưu lại hoặc sao chép và cung cấp cho HLV. HLV sẽ bắt buộc phải đổi mật khẩu ở lần đăng nhập đầu tiên.
                            </small>
                        </div>
                    </div>

                    <!-- Action Button -->
                    <div class="d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-primary px-5 py-2.5 fw-semibold shadow-sm">
                            <i class="fa fa-list me-1.5"></i> Danh sách Huấn luyện viên
                        </a>
                        <a href="${pageContext.request.contextPath}/staff/pt/add" class="btn btn-outline-secondary px-4 py-2.5">
                            <i class="fa fa-plus me-1.5"></i> Thêm tiếp PT khác
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function copyPassword() {
        const passwordText = document.getElementById("tempPassword").innerText;
        navigator.clipboard.writeText(passwordText).then(function() {
            alert("Đã sao chép mật khẩu tạm thời vào Clipboard!");
        }, function(err) {
            alert("Sao chép thất bại: ", err);
        });
    }
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
