<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/dashboard_header.jsp" />

<div class="container-fluid pt-4 px-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="mb-1">
                <c:choose>
                    <c:when test="${sessionScope.currentUser.role == 'Staff'}">Cập nhật tiến độ bảo trì</c:when>
                    <c:when test="${edit}">Cập nhật lịch bảo trì</c:when>
                    <c:otherwise>Tạo lịch bảo trì</c:otherwise>
                </c:choose>
            </h3>
            <p class="text-muted mb-0">Lịch bảo trì sử dụng dữ liệu thiết bị và sự cố hiện có trong hệ thống.</p>
        </div>
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/maintenance-schedules">
            <i class="fa fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle me-2"></i><c:out value="${error}" /></div>
    </c:if>

    <div class="bg-light rounded p-4 shadow-sm mx-auto" style="max-width: 900px;">
        <c:choose>
            <c:when test="${sessionScope.currentUser.role == 'Admin'}">
                <c:set var="formAction" value="create" />
                <c:if test="${edit}">
                    <c:set var="formAction" value="update" />
                </c:if>
                <%-- Form tạo/sửa lịch bảo trì cho Admin --%>
                <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=${formAction}">
                    <input type="hidden" name="id" value="${schedule.maintenanceScheduleId}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Thiết bị <span class="text-danger">*</span></label>
                            <c:choose>
                                <c:when test="${edit}">
                                    <input type="hidden" id="equipmentId" name="equipmentId" value="${schedule.equipmentId}">
                                    <input class="form-control" value="[#${schedule.equipmentCode}] ${schedule.equipmentName}" readonly>
                                    <div class="form-text">Thiết bị không thể thay đổi sau khi lịch được tạo.</div>
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select" id="equipmentId" name="equipmentId" required>
                                        <option value="">Chọn thiết bị</option>
                                        <c:forEach var="equipment" items="${equipments}">
                                            <option value="${equipment.equipmentId}" <c:if test="${schedule.equipmentId == equipment.equipmentId}">selected="selected"</c:if>>
                                                [#<c:out value="${equipment.equipmentCode}" />] <c:out value="${equipment.equipmentName}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Ngày bảo trì <span class="text-danger">*</span></label>
                            <input class="form-control" type="date" name="scheduledDate" min="${today}"
                                   value="${schedule.scheduledDate}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Loại bảo trì <span class="text-danger">*</span></label>
                            <select class="form-select" id="maintenanceType" name="maintenanceType" required>
                                <option value="Preventive" <c:if test="${schedule.maintenanceType == 'Preventive'}">selected="selected"</c:if>>Bảo trì phòng ngừa</option>
                                <option value="Corrective" <c:if test="${schedule.maintenanceType == 'Corrective'}">selected="selected"</c:if>>Bảo trì sửa chữa</option>
                            </select>
                        </div>
                        <div class="col-md-6" id="issueGroup">
                            <label class="form-label fw-semibold">Sự cố liên quan</label>
                            <select class="form-select" id="issueId" name="issueId">
                                <option value="">Không liên kết sự cố</option>
                                <c:forEach var="issue" items="${issues}">
                                    <option value="${issue.issueId}" data-equipment-id="${issue.equipmentId}"
                                            <c:if test="${schedule.issueId == issue.issueId}">selected="selected"</c:if>>
                                        #SC-${issue.issueId} - <c:out value="${issue.description}" />
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">Chỉ các sự cố thuộc thiết bị đã chọn được phép liên kết.</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Mô tả công việc <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="description" rows="5" required
                                      placeholder="Nhập nội dung kiểm tra, sửa chữa hoặc bảo trì..."><c:out value="${schedule.description}" /></textarea>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/maintenance-schedules">Hủy</a>
                        <button class="btn btn-primary" type="submit"><i class="fa fa-save me-2"></i>Lưu lịch</button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <div class="row g-3 mb-4">
                    <div class="col-md-6"><small class="text-muted d-block">Mã lịch</small><strong>#MT-${schedule.maintenanceScheduleId}</strong></div>
                    <div class="col-md-6"><small class="text-muted d-block">Thiết bị</small><strong><c:out value="${schedule.equipmentName}" /></strong></div>
                    <div class="col-md-6"><small class="text-muted d-block">Ngày bảo trì</small><strong>${schedule.scheduledDateDisplay}</strong></div>
                    <div class="col-md-6"><small class="text-muted d-block">Loại bảo trì</small><strong><c:out value="${schedule.maintenanceTypeDisplay}" /></strong></div>
                    <div class="col-12"><small class="text-muted d-block">Mô tả công việc</small><div class="border rounded p-3 bg-white"><c:out value="${schedule.description}" /></div></div>
                </div>
                <%-- Form cập nhật tiến độ lịch bảo trì cho Staff (từ Scheduled -> InProgress -> PendingApproval) --%>
                <form method="post" action="${pageContext.request.contextPath}/staff/maintenance-schedules?action=update" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${schedule.maintenanceScheduleId}">
                    <c:choose>
                        <c:when test="${schedule.status == 'Scheduled'}">
                            <input type="hidden" name="status" value="InProgress">
                            <div class="alert alert-info">Xác nhận bắt đầu bảo trì. Trạng thái thiết bị sẽ được tính lại từ lịch bảo trì và các sự cố đang mở.</div>
                            <div class="d-flex justify-content-end gap-2">
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=detail&id=${schedule.maintenanceScheduleId}">Hủy</a>
                                <button class="btn btn-warning" type="submit"><i class="fa fa-play me-2"></i>Bắt đầu bảo trì</button>
                            </div>
                        </c:when>
                        <c:when test="${schedule.status == 'InProgress'}">
                            <input type="hidden" name="status" value="PendingApproval">
                            <c:if test="${not empty schedule.approvalNote}">
                                <div class="alert alert-warning">
                                    <strong>Lý do từ chối gần nhất:</strong>
                                    <div><c:out value="${schedule.approvalNote}" /></div>
                                </div>
                            </c:if>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Kết quả hoàn thành <span class="text-danger">*</span></label>
                                <textarea class="form-control" name="completionNote" rows="5" required
                                          placeholder="Ghi lại công việc đã thực hiện và kết quả kiểm tra..."><c:out value="${schedule.completionNote}" /></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Ảnh minh chứng sau bảo trì <span class="text-danger">*</span></label>
                                <input class="form-control" type="file" name="completionImageFile" accept="image/*" required>
                                <div class="form-text">Chỉ nhận jpg, jpeg, png, gif hoặc webp. Dung lượng tối đa 5MB.</div>
                            </div>
                            <c:if test="${not empty schedule.issueId}">
                                <div class="alert alert-info mb-4">
                                    Sự cố #SC-${schedule.issueId} sẽ tự chuyển sang Đã khắc phục sau khi Admin duyệt kết quả bảo trì.
                                </div>
                            </c:if>
                            <div class="d-flex justify-content-end gap-2">
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/staff/maintenance-schedules?action=detail&id=${schedule.maintenanceScheduleId}">Hủy</a>
                                <button class="btn btn-success" type="submit"><i class="fa fa-paper-plane me-2"></i>Gửi Admin duyệt</button>
                            </div>
                        </c:when>
                    </c:choose>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<c:if test="${sessionScope.currentUser.role == 'Admin'}">
    <script>
        (function () {
            const equipment = document.getElementById('equipmentId');
            const type = document.getElementById('maintenanceType');
            const issue = document.getElementById('issueId');
            const issueGroup = document.getElementById('issueGroup');
            const options = Array.from(issue.options);

            function refreshIssues() {
                const equipmentId = equipment.value;
                // Nếu loại bảo trì là định kỳ (phòng ngừa), ẩn chọn sự cố liên quan
                const preventive = type.value === 'Preventive';
                issueGroup.classList.toggle('d-none', preventive);
                options.forEach(function (option, index) {
                    if (index === 0) {
                        option.hidden = false;
                        option.disabled = false;
                        return;
                    }
                    // Lọc hiển thị danh sách sự cố phù hợp với thiết bị đã chọn
                    const valid = !preventive && option.dataset.equipmentId === equipmentId;
                    option.hidden = !valid;
                    option.disabled = !valid;
                    // Reset giá trị nếu tùy chọn cũ không còn hợp lệ
                    if (!valid && option.selected) {
                        issue.value = '';
                    }
                });
                if (preventive) {
                    issue.value = '';
                }
            }

            equipment.addEventListener('change', refreshIssues);
            type.addEventListener('change', refreshIssues);
            refreshIssues();
        })();
    </script>
</c:if>

<jsp:include page="../common/dashboard_footer.jsp" />
