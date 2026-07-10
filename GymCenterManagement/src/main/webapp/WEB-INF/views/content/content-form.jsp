<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h4 class="mb-0 text-dark fw-bold">
                <i class="fa fa-edit me-2 text-primary"></i>${formTitle}
            </h4>
        </div>
        <a href="${pageContext.request.contextPath}/staff/public-content" class="btn btn-outline-secondary">
            <i class="fa fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/staff/public-content"
          enctype="multipart/form-data" class="row g-4">
        <input type="hidden" name="contentId" value="${content.contentId}" />
        <input type="hidden" name="existingThumbnailUrl" value="${content.thumbnailUrl}" />

        <div class="col-xl-8">
            <div class="bg-light rounded p-4 shadow-sm h-100">
                <div class="d-flex align-items-center justify-content-between border-bottom pb-3 mb-4">
                    <div>
                        <h5 class="fw-bold text-dark mb-1">Thông tin nội dung</h5>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label fw-bold" for="title">Tiêu đề *</label>
                        <input id="title" name="title" class="form-control" maxlength="200" required
                               value="${fn:escapeXml(content.title)}" placeholder="Nhập tiêu đề hiển thị">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold" for="contentType">Loại nội dung *</label>
                        <select id="contentType" name="contentType" class="form-select" required>
                            <option value="BLOG" ${content.contentType == 'BLOG' ? 'selected' : ''}>Blog</option>
                            <option value="POLICY" ${content.contentType == 'POLICY' ? 'selected' : ''}>Chính sách</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="category">Danh mục *</label>
                        <select id="category" name="category" class="form-select" required data-current="${fn:escapeXml(content.category)}">
                            <option value="">Chọn danh mục</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold" for="status">Trạng thái</label>
                        <c:choose>
                            <c:when test="${isAdmin}">
                                <select id="status" name="status" class="form-select">
                                    <option value="Draft" ${content.status == 'Draft' ? 'selected' : ''}>Bản nháp</option>
                                    <option value="Published" ${content.status == 'Published' ? 'selected' : ''}>Đã đăng</option>
                                    <option value="Hidden" ${content.status == 'Hidden' ? 'selected' : ''}>Đã ẩn</option>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="status" value="Draft">
                                <input class="form-control" value="Bản nháp" disabled>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold" for="summary">Mô tả ngắn *</label>
                        <textarea id="summary" name="summary" class="form-control" rows="3" maxlength="500"
                                  required placeholder="Tóm tắt nội dung trong 1-2 câu"><c:out value="${content.summary}" /></textarea>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold" for="body">Nội dung chi tiết *</label>
                        <textarea id="body" name="body" class="form-control" rows="13" required
                                  placeholder="Nhập nội dung chi tiết hiển thị cho người dùng"><c:out value="${content.body}" /></textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4">
            <div id="thumbnailPanel" class="bg-light rounded p-4 shadow-sm mb-4">
                <h5 class="fw-bold text-dark mb-3">Ảnh đại diện</h5>
                <div class="border rounded bg-white p-3 text-center mb-3">
                    <c:choose>
                        <c:when test="${not empty content.thumbnailUrl}">
                            <img id="thumbnailPreview"
                                 src="${pageContext.request.contextPath}/${content.thumbnailUrl}"
                                 alt="Ảnh đại diện" class="rounded"
                                 style="width: 100%; max-height: 220px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img id="thumbnailPreview" src="" alt="Ảnh đại diện" class="rounded d-none"
                                 style="width: 100%; max-height: 220px; object-fit: cover;">
                            <div id="thumbnailPlaceholder" class="text-muted py-4">
                                <i class="fa fa-image fa-2x mb-2 d-block"></i>
                                Chưa chọn ảnh đại diện
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <label for="thumbnailFile" class="form-label fw-bold">Chọn ảnh từ máy</label>
                <input id="thumbnailFile" name="thumbnailFile" type="file" class="form-control"
                       accept=".jpg,.jpeg,.png,.gif,.webp,image/jpeg,image/png,image/gif,image/webp">
            </div>

            <div class="bg-light rounded p-4 shadow-sm">
                <h5 class="fw-bold text-dark mb-3">Xuất bản</h5>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary py-2">
                        <i class="fa fa-save me-2"></i>Lưu nội dung
                    </button>
                    <a href="${pageContext.request.contextPath}/staff/public-content" class="btn btn-outline-secondary py-2">
                        Hủy bỏ
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const typeSelect = document.getElementById("contentType");
        const categorySelect = document.getElementById("category");
        const currentCategory = categorySelect.dataset.current || "";
        const thumbnailFile = document.getElementById("thumbnailFile");
        const thumbnailPreview = document.getElementById("thumbnailPreview");
        const thumbnailPlaceholder = document.getElementById("thumbnailPlaceholder");
        const thumbnailPanel = document.getElementById("thumbnailPanel");

        const categories = {
            BLOG: [
                "Khởi động",
                "Phục hồi",
                "Dinh dưỡng",
                "Tăng cơ",
                "Giảm mỡ",
                "Cardio",
                "Yoga",
                "Boxing",
                "Kinh nghiệm tập luyện"
            ],
            POLICY: [
                "Hoàn tiền",
                "Hủy gói",
                "Bảo lưu",
                "Chuyển nhượng",
                "Nội quy hội viên",
                "Trang phục",
                "Quay video",
                "Khách đi cùng",
                "Bảo mật thông tin",
                "An toàn tập luyện"
            ]
        };

        function renderCategories() {
            const selectedType = typeSelect.value || "BLOG";
            const options = categories[selectedType] || [];
            const selectedValue = categorySelect.value || currentCategory;
            categorySelect.innerHTML = '<option value="">Chọn danh mục</option>';
            options.forEach(category => {
                const option = document.createElement("option");
                option.value = category;
                option.textContent = category;
                if (category === selectedValue) {
                    option.selected = true;
                }
                categorySelect.appendChild(option);
            });
        }

        function toggleThumbnailPanel() {
            const isPolicy = typeSelect.value === "POLICY";
            thumbnailPanel.classList.toggle("d-none", isPolicy);
            if (isPolicy) {
                thumbnailFile.value = "";
            }
        }

        typeSelect.addEventListener("change", function () {
            categorySelect.value = "";
            renderCategories();
            toggleThumbnailPanel();
        });
        renderCategories();
        toggleThumbnailPanel();

        thumbnailFile.addEventListener("change", function () {
            const file = thumbnailFile.files && thumbnailFile.files[0];
            if (!file) {
                return;
            }
            thumbnailPreview.src = URL.createObjectURL(file);
            thumbnailPreview.classList.remove("d-none");
            if (thumbnailPlaceholder) {
                thumbnailPlaceholder.classList.add("d-none");
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
