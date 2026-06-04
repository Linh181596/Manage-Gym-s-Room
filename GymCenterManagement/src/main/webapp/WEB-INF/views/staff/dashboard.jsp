<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<!-- Staff Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-check fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Lượt check-in hôm nay</p>
                    <h6 class="mb-0">142</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-plus fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Đăng ký mới</p>
                    <h6 class="mb-0">8 Đang chờ</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-ticket-alt fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Vấn đề cần xử lý</p>
                    <h6 class="mb-0">3 Đang mở</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-calendar-check fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Lịch lớp đã đặt</p>
                    <h6 class="mb-0">87 lượt đặt</h6>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 2: Recent Check-Ins & Quick Actions -->
    <div class="row g-4">
        <!-- Recent Check-Ins Table -->
        <div class="col-12 col-xl-8">
            <div class="bg-light text-center rounded p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Thành viên check-in gần đây</h6>
                    <a href="#">Xem lịch sử check-in</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Thời gian</th>
                                <th scope="col">Tên hội viên</th>
                                <th scope="col">Mã thẻ thành viên</th>
                                <th scope="col">Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>22:15</td>
                                <td>Nguyễn Văn A</td>
                                <td>MEM-24901</td>
                                <td><span class="badge bg-success">Cho phép vào</span></td>
                            </tr>
                            <tr>
                                <td>21:50</td>
                                <td>Trần Thị B</td>
                                <td>MEM-11029</td>
                                <td><span class="badge bg-success">Cho phép vào</span></td>
                            </tr>
                            <tr>
                                <td>21:30</td>
                                <td>Phạm Minh C</td>
                                <td>MEM-98741</td>
                                <td><span class="badge bg-danger">Thẻ đã hết hạn</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions Panel -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100">
                <h6 class="mb-4">Thao tác quầy lễ tân nhanh</h6>
                <div class="d-grid gap-3">
                    <button class="btn btn-primary py-3" type="button"><i class="fa fa-qrcode me-2"></i>Quét mã QR hội viên</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-user-plus me-2"></i>Đăng ký hội viên mới</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-receipt me-2"></i>Xử lý thanh toán</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
