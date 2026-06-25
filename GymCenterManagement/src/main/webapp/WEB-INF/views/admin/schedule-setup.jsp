<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<div class="container-fluid pt-4 px-4">
    <div class="row g-4">

        <div class="col-sm-12 col-xl-6">
            <div class="card border-0 shadow-sm p-4 h-100">
                <h5 class="fw-bold mb-4 text-dark border-bottom pb-2">
                    <i class="fa fa-info-circle text-primary me-2"></i>Thông tin đơn đăng ký
                </h5>
                <table class="table table-borderless">
                    <tbody>
                    <tr>
                        <th class="text-muted w-50">Mã đơn:</th>
                        <td class="fw-bold">#PT-${reg.ptRegistrationId}</td>
                    </tr>
                    <tr>
                        <th class="text-muted">Hội viên:</th>
                        <td class="fw-bold text-primary">${reg.memberName}</td>
                    </tr>
                    <tr>
                        <th class="text-muted">Gói dịch vụ:</th>
                        <td><span class="badge bg-info text-dark">${reg.packageName}</span> (${reg.numberOfSessions}
                            buổi)
                        </td>
                    </tr>
                    <tr>
                        <th class="text-muted">Ngày dự kiến bắt đầu:</th>
                        <td class="text-danger fw-bold">${reg.preferredStartDate}</td>
                    </tr>
                    </tbody>
                </table>

                <div class="mb-3 mt-2">
                    <label class="text-muted small fw-bold mb-1">Mong muốn / Ghi chú của khách:</label>
                    <div class="fw-bold text-dark p-3 bg-light rounded border border-light" style="min-height: 80px;">
                        <c:out value="${empty reg.note ? 'Không có ghi chú' : reg.note}"/>
                    </div>
                </div>
                <!-- ================= BẢNG MINIMAP GỢI Ý LỊCH ================= -->
                <div class="mt-4 border-top pt-4">
                    <h6 class="fw-bold text-dark mb-3">
                        <i class="fa fa-calendar-check text-success me-2"></i>Lịch của PT trong tuần chứa Ngày bắt đầu
                        <span class="badge bg-secondary ms-1">(Từ ${weekStartStr} đến ${weekEndStr})</span>
                    </h6>
                    <div class="table-responsive">
                        <table class="table table-bordered text-center table-sm align-middle"
                               style="font-size: 0.85rem;">
                            <thead class="table-light text-muted">
                            <tr>
                                <th style="width: 16%;">Ca</th>
                                <th style="width: 12%;">T2</th>
                                <th style="width: 12%;">T3</th>
                                <th style="width: 12%;">T4</th>
                                <th style="width: 12%;">T5</th>
                                <th style="width: 12%;">T6</th>
                                <th style="width: 12%;">T7</th>
                                <th style="width: 12%;">CN</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Hàng Ca Sáng -->
                            <tr>
                                <td class="fw-bold bg-light">Sáng <br><small class="text-muted">08:00</small></td>
                                <c:forEach var="i" begin="0" end="6">
                                    <td>
                                        <c:choose>
                                            <c:when test="${timetableMatrix[0][i]}"><span
                                                    class="badge bg-danger">Bận</span></c:when>
                                            <c:otherwise><span
                                                    class="badge bg-success bg-opacity-25 text-success border border-success">Rảnh</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                            <!-- Hàng Ca Chiều -->
                            <tr>
                                <td class="fw-bold bg-light">Chiều <br><small class="text-muted">15:00</small></td>
                                <c:forEach var="i" begin="0" end="6">
                                    <td>
                                        <c:choose>
                                            <c:when test="${timetableMatrix[1][i]}"><span
                                                    class="badge bg-danger">Bận</span></c:when>
                                            <c:otherwise><span
                                                    class="badge bg-success bg-opacity-25 text-success border border-success">Rảnh</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                            <!-- Hàng Ca Tối -->
                            <tr>
                                <td class="fw-bold bg-light">Tối <br><small class="text-muted">18:00</small></td>
                                <c:forEach var="i" begin="0" end="6">
                                    <td>
                                        <c:choose>
                                            <c:when test="${timetableMatrix[2][i]}"><span
                                                    class="badge bg-danger">Bận</span></c:when>
                                            <c:otherwise><span
                                                    class="badge bg-success bg-opacity-25 text-success border border-success">Rảnh</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-12 col-xl-6">
            <div class="card border-0 shadow-sm p-4 h-100 bg-light">
                <h5 class="fw-bold mb-4 text-dark border-bottom pb-2">
                    <i class="fa fa-calendar-alt text-primary me-2"></i>Cấu hình lịch tự động
                </h5>

                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger fw-bold shadow-sm mb-4">
                        <i class="fa fa-exclamation-triangle me-2"></i>${errorMsg}
                    </div>
                </c:if>

                <form id="scheduleSetupForm" action="${pageContext.request.contextPath}/admin/pt/schedule-setup"
                      method="POST">
                    <input type="hidden" name="regId" value="${reg.ptRegistrationId}">
                    <input type="hidden" name="sessions" value="${reg.numberOfSessions}">
                    <input type="hidden" name="ptId" value="${reg.ptId}">
                    <input type="hidden" name="memberId" value="${reg.memberId}">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Ngày bắt đầu chính thức</label>
                        <input type="date" class="form-control" name="actualStartDate"
                               value="${not empty submittedStartDate ? submittedStartDate : reg.preferredStartDate}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Lịch tập cố định (Chọn ngày)</label>
                        <div class="d-flex flex-wrap gap-2">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="MONDAY"
                                       id="day1"
                                ${not empty submittedDays && submittedDays.contains('MONDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day1">Thứ 2</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="TUESDAY"
                                       id="day2"
                                ${not empty submittedDays && submittedDays.contains('TUESDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day2">Thứ 3</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="WEDNESDAY"
                                       id="day3"
                                ${not empty submittedDays && submittedDays.contains('WEDNESDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day3">Thứ 4</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="THURSDAY"
                                       id="day4"
                                ${not empty submittedDays && submittedDays.contains('THURSDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day4">Thứ 5</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="FRIDAY"
                                       id="day5"
                                ${not empty submittedDays && submittedDays.contains('FRIDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day5">Thứ 6</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="daysOfWeek" value="SATURDAY"
                                       id="day6"
                                ${not empty submittedDays && submittedDays.contains('SATURDAY') ? 'checked' : ''}>
                                <label class="form-check-label" for="day6">Thứ 7</label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Khung giờ tập (Ca tập)</label>
                        <select class="form-select" name="timeSlot" required>
                            <option value="">-- Chọn khung giờ --</option>
                            <option value="08:00-09:30" ${submittedTimeSlot == '08:00-09:30' ? 'selected' : ''}>Ca sáng:
                                08:00 - 09:30
                            </option>
                            <option value="15:00-16:30" ${submittedTimeSlot == '15:00-16:30' ? 'selected' : ''}>Ca
                                chiều: 15:00 - 16:30
                            </option>
                            <option value="18:00-19:30" ${submittedTimeSlot == '18:00-19:30' ? 'selected' : ''}>Ca tối:
                                18:00 - 19:30
                            </option>
                        </select>
                    </div>

                    <div class="form-check mb-4 bg-white p-3 rounded border border-success">
                        <input class="form-check-input ms-1 mt-2" type="checkbox" name="confirmPayment" value="true"
                               id="confirmPayment"
                        ${submittedPayment ? 'checked' : ''} required>
                        <label class="form-check-label ms-2 text-dark" for="confirmPayment">
                            <span class="fw-bold">Xác nhận đã thu tiền</span> <br>
                            <small class="text-muted">Đổi trạng thái hóa đơn sang Paid</small>
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-3 fw-bold fs-6 shadow-sm">
                        <i class="fa fa-magic me-2"></i>Tạo lịch tập & Hoàn tất
                    </button>

                    <div class="row mt-3">
                        <div class="col-6">
                            <a href="${pageContext.request.contextPath}/admin/schedule/manage" class="btn btn-outline-secondary w-100">Quay lại danh sách</a>
                        </div>
                        <div class="col-6">
                            <c:choose>
                                <c:when test="${reg.status == 'Active'}">
                                    <button type="button" class="btn btn-danger w-100 disabled" disabled title="Đơn đã ở trạng thái Hoạt động, không thể hủy">Hủy đơn đăng ký</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-danger w-100" data-bs-toggle="modal" data-bs-target="#cancelModal">Hủy đơn đăng ký</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </form>

                <div class="modal fade" id="cancelModal" tabindex="-1">
                    <div class="modal-dialog">
                        <form action="${pageContext.request.contextPath}/admin/pt/cancel" method="POST">
                            <input type="hidden" name="regId" value="${reg.ptRegistrationId}">
                            <div class="modal-content">
                                <div class="modal-header"><h5 class="modal-title text-danger">Xác nhận hủy đơn</h5></div>
                                <div class="modal-body">
                                    <p>Bạn chắc chắn muốn hủy đơn #PT-${reg.ptRegistrationId}?</p>
                                    <textarea name="cancelReason" class="form-control" placeholder="Nhập lý do hủy đơn..." required></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 1. LOGIC CHẶN NGÀY THÁNG LÙI VỀ QUÁ KHỨ
        const dateInput = document.querySelector('input[name="actualStartDate"]');
        const preferredDateStr = '${reg.preferredStartDate}';
        const preferredDate = new Date(preferredDateStr);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        let minAllowedDate = (preferredDate < today) ? today : preferredDate;

        const offset = minAllowedDate.getTimezoneOffset() * 60000;
        const minDateString = new Date(minAllowedDate - offset).toISOString().split('T')[0];

        dateInput.setAttribute('min', minDateString);

        if (new Date(dateInput.value) < minAllowedDate) {
            dateInput.value = minDateString;
        }

        // 2. LOGIC BẮT BỘC CHỌN CHECKBOX
        const form = document.getElementById('scheduleSetupForm');

        form.addEventListener('submit', function (e) {
            const checkboxes = document.querySelectorAll('input[name="daysOfWeek"]:checked');
            const timeSlot = document.querySelector('select[name="timeSlot"]').value;

            if (checkboxes.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng tích chọn ít nhất 1 ngày tập cố định trong tuần!'
                });
                e.preventDefault();
                return false;
            }

            if (!timeSlot) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng chọn khung ca tập!'
                });
                e.preventDefault();
                return false;
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>