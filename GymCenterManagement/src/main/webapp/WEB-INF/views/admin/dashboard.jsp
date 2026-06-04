<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<!-- Admin Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-users fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Tổng số hội viên</p>
                    <h6 class="mb-0">1,248</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-tie fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">PT đang hoạt động</p>
                    <h6 class="mb-0">34</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-calendar-alt fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Lớp học hôm nay</p>
                    <h6 class="mb-0">12 Lớp</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-dollar-sign fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Doanh thu tháng này</p>
                    <h6 class="mb-0">311.250.000 ₫</h6>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 2: Charts -->
    <div class="row g-4">
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light text-center rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Số lượng đăng ký hội viên theo tháng</h6>
                    <a href="#">Xem tất cả</a>
                </div>
                <canvas id="worldwide-sales"></canvas>
            </div>
        </div>
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light text-center rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Phân tích doanh thu (Hội viên vs PT)</h6>
                    <a href="#">Xem tất cả</a>
                </div>
                <canvas id="salse-revenue"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 3: Recent Activity & Management Shortcuts -->
    <div class="bg-light text-center rounded p-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h6 class="mb-0">Người dùng đăng ký gần đây</h6>
            <a href="#">Xem tất cả người dùng</a>
        </div>
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead>
                    <tr class="text-dark">
                        <th scope="col">Mã người dùng</th>
                        <th scope="col">Họ và tên</th>
                        <th scope="col">Email</th>
                        <th scope="col">Vai trò</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>USR-01</td>
                        <td>Nguyễn Văn A</td>
                        <td>member@gym.com</td>
                        <td>Hội viên</td>
                        <td><span class="badge bg-success">Hoạt động</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Sửa</a></td>
                    </tr>
                    <tr>
                        <td>USR-02</td>
                        <td>Trần Thị B</td>
                        <td>staff@gym.com</td>
                        <td>Nhân viên</td>
                        <td><span class="badge bg-success">Hoạt động</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Sửa</a></td>
                    </tr>
                    <tr>
                        <td>USR-03</td>
                        <td>Lê Văn C</td>
                        <td>pt@gym.com</td>
                        <td>HLV (PT)</td>
                        <td><span class="badge bg-success">Hoạt động</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Sửa</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 4: Widgets (Calendar & Tasks) -->
    <div class="row g-4">
        <div class="col-sm-12 col-md-6">
            <div class="h-100 bg-light rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Lịch phòng tập</h6>
                    <a href="#">Xem tất cả</a>
                </div>
                <div id="calender"></div>
            </div>
        </div>
        <div class="col-sm-12 col-md-6">
            <div class="h-100 bg-light rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Danh sách công việc của Admin</h6>
                    <a href="#">Xem tất cả</a>
                </div>
                <div class="d-flex mb-2">
                    <input class="form-control bg-transparent" type="text" placeholder="Nhập công việc...">
                    <button type="button" class="btn btn-primary ms-2">Thêm</button>
                </div>
                <div class="d-flex align-items-center border-bottom py-2">
                    <input class="form-check-input m-0" type="checkbox">
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span>Duyệt các đăng ký PT đang chờ</span>
                            <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center border-bottom py-2">
                    <input class="form-check-input m-0" type="checkbox">
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span>Xác minh báo cáo sổ sách hàng tháng</span>
                            <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center pt-2">
                    <input class="form-check-input m-0" type="checkbox" checked>
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span><del>Cập nhật chi tiết khuyến mãi mùa hè</del></span>
                            <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
