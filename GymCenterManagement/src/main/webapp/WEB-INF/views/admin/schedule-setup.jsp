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
                        <i class="fa fa-calendar-check text-success me-2"></i>Xem lịch bận/rảnh trong tuần
                        <span class="badge bg-secondary ms-1">(Từ ${weekStartStr} đến ${weekEndStr})</span>
                    </h6>
                    
                    <!-- Bootstrap Nav Tabs -->
                    <ul class="nav nav-tabs mb-3" id="scheduleTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active fw-bold" id="pt-tab" data-bs-toggle="tab" data-bs-target="#pt-schedule" type="button" role="tab" aria-controls="pt-schedule" aria-selected="true">
                                <i class="fa fa-user-tie me-1"></i>Lịch HLV (${reg.ptDisplayName})
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link fw-bold" id="member-tab" data-bs-toggle="tab" data-bs-target="#member-schedule" type="button" role="tab" aria-controls="member-schedule" aria-selected="false">
                                <i class="fa fa-user me-1"></i>Lịch Hội viên (${reg.memberName})
                            </button>
                        </li>
                    </ul>
                    
                    <!-- Tab Content -->
                    <div class="tab-content" id="scheduleTabContent">
                        
                        <!-- TAB 1: LỊCH PT -->
                        <div class="tab-pane fade show active" id="pt-schedule" role="tabpanel" aria-labelledby="pt-tab">
                            <div class="table-responsive">
                                <table class="table table-bordered text-center table-sm align-middle" style="font-size: 0.85rem;">
                                    <thead class="table-light text-muted">
                                    <tr>
                                        <th style="width: 16%;">Ca</th>
                                        <th style="width: 12%;">T2</th>
                                        <th style="width: 12%;">T3</th>
                                        <th style="width: 12%;">T4</th>
                                        <th style="width: 12%;">T5</th>
                                        <th style="width: 12%;">T6</th>
                                        <th style="width: 12%;">T7</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="rowIdx" begin="0" end="5">
                                        <tr>
                                            <td class="fw-bold bg-light">
                                                <c:choose>
                                                    <c:when test="${rowIdx == 0}">Sáng 1 <br><small class="text-muted">08:15 - 09:45</small></c:when>
                                                    <c:when test="${rowIdx == 1}">Sáng 2 <br><small class="text-muted">10:00 - 11:30</small></c:when>
                                                    <c:when test="${rowIdx == 2}">Chiều 1 <br><small class="text-muted">13:30 - 15:00</small></c:when>
                                                    <c:when test="${rowIdx == 3}">Chiều 2 <br><small class="text-muted">15:15 - 16:45</small></c:when>
                                                    <c:when test="${rowIdx == 4}">Tối 1 <br><small class="text-muted">17:00 - 18:30</small></c:when>
                                                    <c:when test="${rowIdx == 5}">Tối 2 <br><small class="text-muted">18:45 - 20:15</small></c:when>
                                                </c:choose>
                                            </td>
                                            <c:forEach var="colIdx" begin="0" end="5">
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${ptMatrix[rowIdx][colIdx]}">
                                                            <span class="badge bg-danger">Bận</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success bg-opacity-25 text-success border border-success">Rảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <!-- TAB 2: LỊCH HỘI VIÊN -->
                        <div class="tab-pane fade" id="member-schedule" role="tabpanel" aria-labelledby="member-tab">
                            <div class="table-responsive">
                                <table class="table table-bordered text-center table-sm align-middle" style="font-size: 0.85rem;">
                                    <thead class="table-light text-muted">
                                    <tr>
                                        <th style="width: 16%;">Ca</th>
                                        <th style="width: 12%;">T2</th>
                                        <th style="width: 12%;">T3</th>
                                        <th style="width: 12%;">T4</th>
                                        <th style="width: 12%;">T5</th>
                                        <th style="width: 12%;">T6</th>
                                        <th style="width: 12%;">T7</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="rowIdx" begin="0" end="5">
                                        <tr>
                                            <td class="fw-bold bg-light">
                                                <c:choose>
                                                    <c:when test="${rowIdx == 0}">Sáng 1 <br><small class="text-muted">08:15 - 09:45</small></c:when>
                                                    <c:when test="${rowIdx == 1}">Sáng 2 <br><small class="text-muted">10:00 - 11:30</small></c:when>
                                                    <c:when test="${rowIdx == 2}">Chiều 1 <br><small class="text-muted">13:30 - 15:00</small></c:when>
                                                    <c:when test="${rowIdx == 3}">Chiều 2 <br><small class="text-muted">15:15 - 16:45</small></c:when>
                                                    <c:when test="${rowIdx == 4}">Tối 1 <br><small class="text-muted">17:00 - 18:30</small></c:when>
                                                    <c:when test="${rowIdx == 5}">Tối 2 <br><small class="text-muted">18:45 - 20:15</small></c:when>
                                                </c:choose>
                                            </td>
                                            <c:forEach var="colIdx" begin="0" end="5">
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${memberMatrix[rowIdx][colIdx]}">
                                                            <span class="badge bg-danger">Bận</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success bg-opacity-25 text-success border border-success">Rảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
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

                    <div class="mb-4 bg-white p-3 rounded border border-light shadow-sm">
                        <label class="form-label fw-bold text-primary mb-3">Lịch tập cố định & Khung giờ tương ứng</label>
                        <div class="row g-3">
                            <c:forEach var="day" items="${['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY']}">
                                <c:set var="dayLabel" value="" />
                                <c:set var="colIdx" value="0" />
                                <c:choose>
                                    <c:when test="${day == 'MONDAY'}"><c:set var="dayLabel" value="Thứ 2" /><c:set var="colIdx" value="0" /></c:when>
                                    <c:when test="${day == 'TUESDAY'}"><c:set var="dayLabel" value="Thứ 3" /><c:set var="colIdx" value="1" /></c:when>
                                    <c:when test="${day == 'WEDNESDAY'}"><c:set var="dayLabel" value="Thứ 4" /><c:set var="colIdx" value="2" /></c:when>
                                    <c:when test="${day == 'THURSDAY'}"><c:set var="dayLabel" value="Thứ 5" /><c:set var="colIdx" value="3" /></c:when>
                                    <c:when test="${day == 'FRIDAY'}"><c:set var="dayLabel" value="Thứ 6" /><c:set var="colIdx" value="4" /></c:when>
                                    <c:when test="${day == 'SATURDAY'}"><c:set var="dayLabel" value="Thứ 7" /><c:set var="colIdx" value="5" /></c:when>
                                </c:choose>
                                <div class="col-12 d-flex align-items-center justify-content-between border-bottom pb-2">
                                    <div class="form-check">
                                        <input class="form-check-input day-checkbox" type="checkbox" name="daysOfWeek" value="${day}"
                                               id="day_${day}" data-day="${day}"
                                               ${not empty submittedDays && submittedDays.contains(day) ? 'checked' : ''}>
                                        <label class="form-check-label fw-semibold" for="day_${day}">${dayLabel}</label>
                                    </div>
                                    <div class="ms-3" style="width: 65%;">
                                        <select class="form-select form-select-sm slot-select" name="timeSlot_${day}" id="slot_${day}" 
                                                ${not empty submittedDays && submittedDays.contains(day) ? '' : 'disabled'} required>
                                            <option value="">-- Chọn ca tập --</option>
                                            
                                            <!-- Ca 1: 08:15-09:45 (rowIdx = 0) -->
                                            <c:set var="busyPt_0" value="${ptMatrix[0][colIdx]}" />
                                            <c:set var="busyMem_0" value="${memberMatrix[0][colIdx]}" />
                                            <option value="08:15-09:45" ${busyPt_0 || busyMem_0 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '08:15-09:45' ? 'selected' : ''}>
                                                08:15 - 09:45 
                                                <c:choose>
                                                    <c:when test="${busyPt_0 && busyMem_0}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_0}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_0}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                            
                                            <!-- Ca 2: 10:00-11:30 (rowIdx = 1) -->
                                            <c:set var="busyPt_1" value="${ptMatrix[1][colIdx]}" />
                                            <c:set var="busyMem_1" value="${memberMatrix[1][colIdx]}" />
                                            <option value="10:00-11:30" ${busyPt_1 || busyMem_1 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '10:00-11:30' ? 'selected' : ''}>
                                                10:00 - 11:30 
                                                <c:choose>
                                                    <c:when test="${busyPt_1 && busyMem_1}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_1}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_1}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                            
                                            <!-- Ca 3: 13:30-15:00 (rowIdx = 2) -->
                                            <c:set var="busyPt_2" value="${ptMatrix[2][colIdx]}" />
                                            <c:set var="busyMem_2" value="${memberMatrix[2][colIdx]}" />
                                            <option value="13:30-15:00" ${busyPt_2 || busyMem_2 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '13:30-15:00' ? 'selected' : ''}>
                                                13:30 - 15:00 
                                                <c:choose>
                                                    <c:when test="${busyPt_2 && busyMem_2}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_2}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_2}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                            
                                            <!-- Ca 4: 15:15-16:45 (rowIdx = 3) -->
                                            <c:set var="busyPt_3" value="${ptMatrix[3][colIdx]}" />
                                            <c:set var="busyMem_3" value="${memberMatrix[3][colIdx]}" />
                                            <option value="15:15-16:45" ${busyPt_3 || busyMem_3 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '15:15-16:45' ? 'selected' : ''}>
                                                15:15 - 16:45 
                                                <c:choose>
                                                    <c:when test="${busyPt_3 && busyMem_3}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_3}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_3}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                            
                                            <!-- Ca 5: 17:00-18:30 (rowIdx = 4) -->
                                            <c:set var="busyPt_4" value="${ptMatrix[4][colIdx]}" />
                                            <c:set var="busyMem_4" value="${memberMatrix[4][colIdx]}" />
                                            <option value="17:00-18:30" ${busyPt_4 || busyMem_4 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '17:00-18:30' ? 'selected' : ''}>
                                                17:00 - 18:30 
                                                <c:choose>
                                                    <c:when test="${busyPt_4 && busyMem_4}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_4}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_4}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                            
                                            <!-- Ca 6: 18:45-20:15 (rowIdx = 5) -->
                                            <c:set var="busyPt_5" value="${ptMatrix[5][colIdx]}" />
                                            <c:set var="busyMem_5" value="${memberMatrix[5][colIdx]}" />
                                            <option value="18:45-20:15" ${busyPt_5 || busyMem_5 ? 'disabled' : ''} ${submittedDayTimeSlots[day] == '18:45-20:15' ? 'selected' : ''}>
                                                18:45 - 20:15 
                                                <c:choose>
                                                    <c:when test="${busyPt_5 && busyMem_5}">(Cả 2 bận ❌)</c:when>
                                                    <c:when test="${busyPt_5}">(PT bận ❌)</c:when>
                                                    <c:when test="${busyMem_5}">(HV bận ❌)</c:when>
                                                </c:choose>
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <c:if test="${reg.paymentStatus != 'Paid'}">
                        <div class="form-check mb-4 bg-white p-3 rounded border border-success">
                            <input class="form-check-input ms-1 mt-2" type="checkbox" name="confirmPayment" value="true"
                                   id="confirmPayment"
                            ${submittedPayment || reg.paymentStatus == 'Paid' ? 'checked' : ''} required>
                            <label class="form-check-label ms-2 text-dark" for="confirmPayment">
                                <span class="fw-bold">Xác nhận đã thu tiền</span> <br>
                                <small class="text-muted">Đổi trạng thái hóa đơn sang Paid</small>
                            </label>
                        </div>
                    </c:if>

                    <button type="submit" class="btn btn-primary w-100 py-3 fw-bold fs-6 shadow-sm">
                        <i class="fa fa-magic me-2"></i>Tạo lịch tập & Hoàn tất
                    </button>

                    <div class="row mt-3">
                        <div class="col-6">
                            <c:choose>
                                <c:when test="${sessionScope.currentUser.role == 'PT'}">
                                    <a href="${pageContext.request.contextPath}/pt/schedule-dashboard" class="btn btn-outline-secondary w-100">Quay lại danh sách</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/schedule/manage" class="btn btn-outline-secondary w-100">Quay lại danh sách</a>
                                </c:otherwise>
                            </c:choose>
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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 1. LOGIC CHẶN NGÀY THÁNG LÙI VỀ QUÁ KHỨ VÀ GIỚI HẠN 1 NĂM TƯƠNG LAI
        const dateInput = document.querySelector('input[name="actualStartDate"]');
        const preferredDateStr = '${reg.preferredStartDate}';
        const preferredDate = new Date(preferredDateStr);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        let minAllowedDate = (preferredDate < today) ? today : preferredDate;

        const offset = minAllowedDate.getTimezoneOffset() * 60000;
        const minDateString = new Date(minAllowedDate - offset).toISOString().split('T')[0];

        dateInput.setAttribute('min', minDateString);

        const maxAllowedDate = new Date();
        maxAllowedDate.setFullYear(today.getFullYear() + 1);
        const maxDateString = new Date(maxAllowedDate - offset).toISOString().split('T')[0];
        dateInput.setAttribute('max', maxDateString);

        if (new Date(dateInput.value) < minAllowedDate) {
            dateInput.value = minDateString;
        }

        // 2. LOGIC BẬT TẮT DROPDOWN KHI CHỌN CHECKBOX
        document.querySelectorAll('.day-checkbox').forEach(function(checkbox) {
            checkbox.addEventListener('change', function() {
                const day = this.getAttribute('data-day');
                const select = document.getElementById('slot_' + day);
                if (this.checked) {
                    select.disabled = false;
                } else {
                    select.disabled = true;
                    select.value = "";
                }
            });
        });

        // 3. LOGIC BẮT BUỘC CHỌN CHECKBOX VÀ CHỌN KHUNG GIỜ CHO TỪNG THỨ
        const form = document.getElementById('scheduleSetupForm');

        form.addEventListener('submit', function (e) {
            const checkboxes = document.querySelectorAll('input[name="daysOfWeek"]:checked');

            if (checkboxes.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng tích chọn ít nhất 1 ngày tập cố định trong tuần!'
                });
                e.preventDefault();
                return false;
            }

            let missingSlot = false;
            checkboxes.forEach(function(cb) {
                const day = cb.value;
                const select = document.getElementById('slot_' + day);
                if (!select || !select.value) {
                    missingSlot = true;
                }
            });

            if (missingSlot) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng chọn khung giờ tương ứng cho tất cả các ngày tập đã chọn!'
                });
                e.preventDefault();
                return false;
            }
        });
    });
</script>

<jsp:include page="../common/dashboard_footer.jsp"/>