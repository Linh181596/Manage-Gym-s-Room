    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <%--
      =========================================================================
      Document    : add-personal-trainer.jsp
      Created on  : 2026-06-04
      Author      : Nguyễn Đình Phú (phund)
      Description : Giao diện form nhập liệu thông tin để thêm tài khoản HLV mới.
      =========================================================================
    --%>

    <jsp:include page="../common/dashboard_header.jsp" />
    <jsp:include page="../common/dashboard_navbar.jsp" />

    <div class="container-fluid pt-4 px-4">
        <!-- Navigation Back Link -->
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-sm btn-outline-secondary px-3 shadow-sm">
                <i class="fa fa-arrow-left me-1"></i> Quay lại danh sách PT
            </a>
        </div>

        <div class="row justify-content-center mb-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <!-- Card Header -->
                    <div class="bg-primary-gradient rounded-top position-absolute start-0 top-0 w-100" style="height: 6px;"></div>
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h4 class="mb-0 text-dark fw-bold"><i class="fa fa-user-plus me-2 text-primary"></i>Tạo tài khoản Huấn luyện viên mới</h4>
                        <small class="text-muted">Nhập hồ sơ và tự động tạo tài khoản đăng nhập cho HLV (PT) mới được tuyển dụng</small>
                    </div>

                    <div class="card-body p-4">
                        <!-- Error Message Display -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                                <i class="fa fa-exclamation-circle me-2"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/staff/pt/add" enctype="multipart/form-data">

                            <!-- Block 1: Account Information -->
                            <h5 class="text-primary fw-bold mb-3 border-bottom pb-2"><i class="fa fa-key me-1.5"></i>Thông tin tài khoản & Liên hệ</h5>

                            <div class="row g-3 mb-4">
                                <!-- Full name -->
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label fw-semibold text-secondary">Họ tên chính thức <span class="text-danger">*</span></label>
                                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Nhập họ và tên đầy đủ" required value="${param.fullName}">
                                </div>

                                <!-- Display name -->
                                <div class="col-md-6">
                                    <label for="displayName" class="form-label fw-semibold text-secondary">Tên hiển thị (Public)</label>
                                    <input type="text" id="displayName" name="displayName" class="form-control" placeholder="Ví dụ: Coach Nam, HLV Quân..." value="${param.displayName}">
                                    <small class="text-muted d-block mt-1 small">Nếu trống, hệ thống sẽ sử dụng Họ tên chính thức.</small>
                                </div>

                                <!-- Email -->
                                <div class="col-md-6">
                                    <label for="email" class="form-label fw-semibold text-secondary">Địa chỉ Email <span class="text-danger">*</span></label>
                                    <input type="email" id="email" name="email" class="form-control" placeholder="Ví dụ: trainer@gym.com" required value="${param.email}">
                                    <small class="text-muted d-block mt-1 small">Email này được dùng để đăng nhập và nhận thông tin.</small>
                                </div>

                                <!-- Phone -->
                                <div class="col-md-6">
                                    <label for="phone" class="form-label fw-semibold text-secondary">Số điện thoại <span class="text-danger">*</span></label>
                                    <input type="text" id="phone" name="phone" class="form-control" placeholder="Ví dụ: 0912345678" maxlength="10" required value="${param.phone}">
                                </div>
                            </div>

                            <!-- Block 2: Professional Details -->
                            <h5 class="text-primary fw-bold mb-3 border-bottom pb-2"><i class="fa fa-dumbbell me-1.5"></i>Thông tin chuyên môn & Hồ sơ</h5>

                            <div class="row g-3 mb-4">
                                <!-- Specialization -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary d-block">Chuyên môn chính <span class="text-danger">*</span></label>
                                    <div class="border rounded p-2 bg-white d-flex flex-wrap gap-3">
                                        <c:forEach var="spec" items="${specOptions}">
                                            <c:set var="isChecked" value="false" />
                                            <c:forEach var="sel" items="${selectedSpecs}">
                                                <c:if test="${sel eq spec}">
                                                    <c:set var="isChecked" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <div class="form-check form-check-inline m-0">
                                                <input class="form-check-input" type="checkbox" name="specializations" value="${spec}" id="spec_${spec.hashCode()}"
                                                       ${isChecked ? 'checked' : ''}>
                                                <label class="form-check-label text-dark" for="spec_${spec.hashCode()}">${spec}</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Career Start Date -->
                                <div class="col-md-6">
                                    <label for="careerStartDate" class="form-label fw-semibold text-secondary">Ngày bắt đầu sự nghiệp <span class="text-danger">*</span></label>
                                    <input type="date" id="careerStartDate" name="careerStartDate" class="form-control" required value="${param.careerStartDate}" min="<%= java.time.LocalDate.now().minusYears(40) %>" max="<%= java.time.LocalDate.now() %>">
                                    <small class="text-muted d-block mt-1 small">Sử dụng để tính số năm kinh nghiệm tự động.</small>
                                </div>

                                <!-- Avatar File -->
                                <div class="col-md-6">
                                    <label for="avatarFile" class="form-label fw-semibold text-secondary">Ảnh đại diện (Avatar)</label>
                                    <input type="file" id="avatarFile" name="avatarFile" class="form-control" accept=".jpg,.jpeg,.png">
                                    <small class="text-muted d-block mt-1 small">Định dạng hỗ trợ: JPG, JPEG, PNG.</small>
                                </div>

                                <!-- Certificate File -->
                                <div class="col-md-6">
                                    <label for="certificateFile" class="form-label fw-semibold text-secondary">Tải lên Chứng chỉ HLV</label>
                                    <input type="file" id="certificateFile" name="certificateFile" class="form-control" accept=".pdf,.jpg,.jpeg,.png">
                                    <small class="text-muted d-block mt-1 small">Định dạng hỗ trợ: PDF, JPG, PNG.</small>
                                </div>

                                <!-- Biography/Description -->
                                <div class="col-12">
                                    <label for="description" class="form-label fw-semibold text-secondary">Mô tả giới thiệu bản thân</label>
                                    <textarea id="description" name="description" class="form-control" rows="5" placeholder="Nhập thông tin giới thiệu, quá trình làm việc, thành tích thể thao hoặc triết lý huấn luyện của PT...">${param.description}</textarea>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                                <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-outline-secondary px-4 py-2">Hủy bỏ</a>
                                <button type="submit" class="btn btn-primary px-5 py-2 shadow-sm"><i class="fa fa-save me-1"></i> Tạo tài khoản PT</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const descTextarea = document.getElementById('description');
            if (descTextarea) {
                const bioText = descTextarea.value.trim();
                const words = bioText ? bioText.split(/\s+/) : [];
                if (words.length > 500) {
                    alert("Mô tả giới thiệu bản thân không được vượt quá 500 từ. Hiện tại bạn đang nhập: " + words.length + " từ.");
                    e.preventDefault();
                    return false;
                }
            }
        });
    </script>

    <jsp:include page="../common/dashboard_footer.jsp" />
