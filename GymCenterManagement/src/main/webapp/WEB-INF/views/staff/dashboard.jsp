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
                    <p class="mb-2">Today Check-Ins</p>
                    <h6 class="mb-0">142</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-plus fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">New Registrations</p>
                    <h6 class="mb-0">8 Pending</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-ticket-alt fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Open Issues</p>
                    <h6 class="mb-0">3 Open</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-calendar-check fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Booked Classes</p>
                    <h6 class="mb-0">87 bookings</h6>
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
                    <h6 class="mb-0">Recent Member Check-ins</h6>
                    <a href="#">View Check-in History</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Time</th>
                                <th scope="col">Member Name</th>
                                <th scope="col">Membership ID</th>
                                <th scope="col">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>22:15</td>
                                <td>Nguyen Van A</td>
                                <td>MEM-24901</td>
                                <td><span class="badge bg-success">Access Granted</span></td>
                            </tr>
                            <tr>
                                <td>21:50</td>
                                <td>Tran Thi B</td>
                                <td>MEM-11029</td>
                                <td><span class="badge bg-success">Access Granted</span></td>
                            </tr>
                            <tr>
                                <td>21:30</td>
                                <td>Pham Minh C</td>
                                <td>MEM-98741</td>
                                <td><span class="badge bg-danger">Membership Expired</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions Panel -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100">
                <h6 class="mb-4">Quick Front Desk Actions</h6>
                <div class="d-grid gap-3">
                    <button class="btn btn-primary py-3" type="button"><i class="fa fa-qrcode me-2"></i>Scan Member QR</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-user-plus me-2"></i>New Member Signup</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-receipt me-2"></i>Process Payment</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
