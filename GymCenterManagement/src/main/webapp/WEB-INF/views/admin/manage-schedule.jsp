<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../common/dashboard_header.jsp"/>
<jsp:include page="../common/dashboard_navbar.jsp"/>

<%-- 2. Nội dung chính nằm ở giữa --%>
<div class="container-fluid pt-4 px-4">
    <div class="card border-0 shadow-sm p-4">
        <h5 class="text-dark fw-bold mb-3">
            <i class="fa fa-list-ul text-primary me-2"></i>Yêu cầu đăng ký PT chờ duyệt
        </h5>

        <c:choose>
            <c:when test="${empty pendingRegistrations}">
                <div class="text-center py-5">
                    <p class="text-muted">Hiện tại không có đơn đăng ký nào chờ xử lý.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Mã đơn</th>
                            <th>Hội viên</th>
                            <th>HLV yêu cầu</th>
                            <th>Gói tập</th>
                            <th>Ngày bắt đầu</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reg" items="${pendingRegistrations}">
                            <tr>
                                <td>#PT-${reg.ptRegistrationId}</td>
                                <td>${reg.memberName}<br><small>${reg.memberPhone}</small></td>
                                <td>${reg.ptDisplayName}</td>
                                <td>${reg.packageName} (${reg.numberOfSessions} buổi)</td>
                                <td>${reg.preferredStartDate}</td>
                                <td><span class="badge bg-warning">Chờ thu tiền</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${reg.ptStatus == 'Inactive'}">
                                            <button class="btn btn-sm btn-secondary disabled"
                                                    style="cursor: not-allowed;"
                                                    title="HLV này đã nghỉ việc hoặc bị khóa">
                                                <i class="fa fa-lock me-1"></i> PT Đã Khóa
                                            </button>
                                            <div class="small text-danger mt-1">Yêu cầu đổi PT</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/pt/schedule-setup?regId=${reg.ptRegistrationId}"
                                                   class="btn btn-sm btn-info text-white" title="Xem chi tiết & xếp lịch">
                                                    <i class="fa fa-eye"></i>
                                                </a>
                                                <button type="button" 
                                                        class="btn btn-sm btn-danger" 
                                                        data-reg-id="${reg.ptRegistrationId}" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#cancelModal" 
                                                        title="Hủy đơn đăng ký">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%-- KHU VỰC CHỨA SCRIPT THÔNG BÁO --%>
<c:if test="${not empty sessionScope.toastMsg}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Swal.fire({
                icon: 'success',
                title: 'Tuyệt vời!',
                text: '${sessionScope.toastMsg}',
                timer: 3000,
                showConfirmButton: false,
                toast: true,
                position: 'top-end' // Hiện ở góc trên bên phải cho giống Toast
            });
        });
    </script>
    <%-- Xóa message đi để F5 không bị hiện lại --%>
    <c:remove var="toastMsg" scope="session"/>
</c:if>

<%-- MODAL HỦY ĐƠN ĐĂNG KÝ --%>
<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/pt/cancel" method="POST">
            <input type="hidden" name="regId" id="cancelRegId" value="">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-danger" id="cancelModalLabel">
                        <i class="fa fa-exclamation-triangle me-2"></i>Xác nhận hủy đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn muốn hủy đơn đăng ký <strong class="text-danger">#PT-<span id="cancelRegIdText"></span></strong>?</p>
                    <div class="mb-3">
                        <label for="cancelReason" class="form-label fw-bold">Lý do hủy đơn:</label>
                        <textarea name="cancelReason" id="cancelReason" class="form-control" rows="3" placeholder="Nhập lý do hủy đơn..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-danger">Xác nhận hủy</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const cancelModal = document.getElementById('cancelModal');
        if (cancelModal) {
            cancelModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const regId = button.getAttribute('data-reg-id');
                const modalInput = cancelModal.querySelector('#cancelRegId');
                const modalText = cancelModal.querySelector('#cancelRegIdText');
                
                modalInput.value = regId;
                modalText.textContent = regId;
            });
        }
    });
</script>

<%-- 3. Footer luôn phải nằm ở cuối cùng --%>
<jsp:include page="../common/dashboard_footer.jsp"/>