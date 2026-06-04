<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<!-- PT Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-friends fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Hội viên của tôi</p>
                    <h6 class="mb-0">12 Đang tập</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-dumbbell fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Buổi tập trong tuần</p>
                    <h6 class="mb-0">28 Đã lên lịch</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-clock fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Giờ huấn luyện</p>
                    <h6 class="mb-0">14.5 giờ</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-check-circle fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Hoàn thành hôm nay</p>
                    <h6 class="mb-0">3 / 5 Buổi</h6>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 2: Today's PT Sessions Schedule -->
    <div class="row g-4">
        <div class="col-12 col-xl-8">
            <div class="bg-light text-center rounded p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Lịch huấn luyện hôm nay</h6>
                    <a href="#">Xem lịch tuần</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Giờ tập</th>
                                <th scope="col">Tên hội viên</th>
                                <th scope="col">Mục tiêu tập</th>
                                <th scope="col">Trạng thái</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>08:00 - 09:30</td>
                                <td>Nguyễn Văn A</td>
                                <td>Giảm cân / Cardio</td>
                                <td><span class="badge bg-secondary">Hoàn thành</span></td>
                                <td><a class="btn btn-sm btn-outline-primary" href="#">Đánh giá</a></td>
                            </tr>
                            <tr>
                                <td>15:00 - 16:30</td>
                                <td>Trần Thị B</td>
                                <td>Sức mạnh / Tăng cơ</td>
                                <td><span class="badge bg-success">Đang tập</span></td>
                                <td><a class="btn btn-sm btn-primary" href="#">Theo dõi buổi tập</a></td>
                            </tr>
                            <tr>
                                <td>18:30 - 20:00</td>
                                <td>Lê Văn C</td>
                                <td>Sửa tư thế tập</td>
                                <td><span class="badge bg-warning">Sắp diễn ra</span></td>
                                <td><a class="btn btn-sm btn-outline-secondary" href="#">Chi tiết</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Trainer Notes & Checklist -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100">
                <h6 class="mb-4">Danh sách việc cần làm & Nhắc nhở</h6>
                <ul class="list-group list-group-flush bg-transparent">
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Đánh giá nhật ký ăn uống của Nguyễn Văn A.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Chuẩn bị giáo án tập chân cho Trần Thị B.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Đánh giá thể lực cho hội viên trải nghiệm mới.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
