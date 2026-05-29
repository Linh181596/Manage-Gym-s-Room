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
                    <p class="mb-2">My Clients</p>
                    <h6 class="mb-0">12 Active</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-dumbbell fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Weekly Sessions</p>
                    <h6 class="mb-0">28 Scheduled</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-clock fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Training Hours</p>
                    <h6 class="mb-0">14.5 hrs</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-check-circle fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Completed Today</p>
                    <h6 class="mb-0">3 / 5 Sessions</h6>
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
                    <h6 class="mb-0">Today's Training Schedule</h6>
                    <a href="#">View Week Calendar</a>
                </div>
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr class="text-dark">
                                <th scope="col">Time</th>
                                <th scope="col">Client Name</th>
                                <th scope="col">Target Focus</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>08:00 - 09:30</td>
                                <td>Nguyen Van A</td>
                                <td>Weight Loss / Cardio</td>
                                <td><span class="badge bg-secondary">Completed</span></td>
                                <td><a class="btn btn-sm btn-outline-primary" href="#">Feedback</a></td>
                            </tr>
                            <tr>
                                <td>15:00 - 16:30</td>
                                <td>Tran Thi B</td>
                                <td>Strength / Hypertrophy</td>
                                <td><span class="badge bg-success">In Progress</span></td>
                                <td><a class="btn btn-sm btn-primary" href="#">Track Workout</a></td>
                            </tr>
                            <tr>
                                <td>18:30 - 20:00</td>
                                <td>Le Van C</td>
                                <td>Posture Correction</td>
                                <td><span class="badge bg-warning">Upcoming</span></td>
                                <td><a class="btn btn-sm btn-outline-secondary" href="#">Details</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Trainer Notes & Checklist -->
        <div class="col-12 col-xl-4">
            <div class="bg-light rounded p-4 h-100">
                <h6 class="mb-4">PT Checklist & Reminders</h6>
                <ul class="list-group list-group-flush bg-transparent">
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Review meal logs for Nguyen Van A.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Prepare leg workout program for Tran Thi B.</li>
                    <li class="list-group-item bg-transparent text-muted"><i class="fa fa-info-circle text-primary me-2"></i>Conduct fitness assessment for new trial client.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
