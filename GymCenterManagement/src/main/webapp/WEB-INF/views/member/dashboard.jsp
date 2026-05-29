<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<!-- Member Dashboard Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Row 1: KPI Cards -->
    <div class="row g-4">
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-calendar-check fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">My Bookings</p>
                    <h6 class="mb-0">2 Scheduled</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-id-card fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Membership</p>
                    <h6 class="mb-0">Active (VIP)</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-running fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Visits This Month</p>
                    <h6 class="mb-0">14 Check-ins</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-tag fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Assigned PT</p>
                    <h6 class="mb-0">Coach John Doe</h6>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid pt-4 px-4">
    <!-- Row 2: Upcoming Bookings & Profile Actions -->
    <div class="row g-4">
        <!-- Upcoming Bookings Table -->
        <div class="col-12 col-xl-8">
            <div class="bg-light text-center rounded p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">My Upcoming Classes & Sessions</h6>
                    <a href="#">View Booking History</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Date</th>
                                <th scope="col">Time</th>
                                <th scope="col">Activity / Class</th>
                                <th scope="col">Trainer</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>22 May 2026</td>
                                <td>08:00 - 09:30</td>
                                <td>Personal Training Session</td>
                                <td>Coach John Doe</td>
                                <td><a class="btn btn-sm btn-danger" href="#">Cancel</a></td>
                            </tr>
                            <tr>
                                <td>23 May 2026</td>
                                <td>17:00 - 18:00</td>
                                <td>Yoga Advanced Class</td>
                                <td>Instructor Le Thi D</td>
                                <td><a class="btn btn-sm btn-danger" href="#">Cancel</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Booking Panel -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100">
                <h6 class="mb-4">Quick Actions</h6>
                <div class="d-grid gap-3">
                    <button class="btn btn-primary py-3" type="button"><i class="fa fa-dumbbell me-2"></i>Book Gym Class</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-user-tie me-2"></i>Schedule PT Session</button>
                    <button class="btn btn-outline-primary py-3" type="button"><i class="fa fa-history me-2"></i>View Workout History</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
