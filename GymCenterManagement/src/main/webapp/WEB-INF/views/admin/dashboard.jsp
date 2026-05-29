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
                    <p class="mb-2">Total Members</p>
                    <h6 class="mb-0">1,248</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-user-tie fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Active PTs</p>
                    <h6 class="mb-0">34</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-calendar-alt fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Today Classes</p>
                    <h6 class="mb-0">12 Classes</h6>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-xl-3">
            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                <i class="fa fa-dollar-sign fa-3x text-primary"></i>
                <div class="ms-3">
                    <p class="mb-2">Monthly Revenue</p>
                    <h6 class="mb-0">$12,450</h6>
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
                    <h6 class="mb-0">Monthly Membership Registrations</h6>
                    <a href="#">Show All</a>
                </div>
                <canvas id="worldwide-sales"></canvas>
            </div>
        </div>
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light text-center rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Revenue Analytics (Membership vs PT)</h6>
                    <a href="#">Show All</a>
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
            <h6 class="mb-0">Recent User Registrations</h6>
            <a href="#">View All Users</a>
        </div>
        <div class="table-responsive">
            <table class="table text-start align-middle table-bordered table-hover mb-0">
                <thead>
                    <tr class="text-dark">
                        <th scope="col">User ID</th>
                        <th scope="col">Full Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Role</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>USR-01</td>
                        <td>Nguyen Van A</td>
                        <td>member@gym.com</td>
                        <td>Member</td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Edit</a></td>
                    </tr>
                    <tr>
                        <td>USR-02</td>
                        <td>Tran Thi B</td>
                        <td>staff@gym.com</td>
                        <td>Staff</td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Edit</a></td>
                    </tr>
                    <tr>
                        <td>USR-03</td>
                        <td>Le Van C</td>
                        <td>pt@gym.com</td>
                        <td>PT</td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td><a class="btn btn-sm btn-primary" href="#">Edit</a></td>
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
                    <h6 class="mb-0">Gym Calendar</h6>
                    <a href="#">Show All</a>
                </div>
                <div id="calender"></div>
            </div>
        </div>
        <div class="col-sm-12 col-md-6">
            <div class="h-100 bg-light rounded p-4">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h6 class="mb-0">Admin Tasks List</h6>
                    <a href="#">Show All</a>
                </div>
                <div class="d-flex mb-2">
                    <input class="form-control bg-transparent" type="text" placeholder="Enter task">
                    <button type="button" class="btn btn-primary ms-2">Add</button>
                </div>
                <div class="d-flex align-items-center border-bottom py-2">
                    <input class="form-check-input m-0" type="checkbox">
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span>Approve pending PT registrations</span>
                            <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center border-bottom py-2">
                    <input class="form-check-input m-0" type="checkbox">
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span>Verify monthly bookkeeping reports</span>
                            <button class="btn btn-sm"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center pt-2">
                    <input class="form-check-input m-0" type="checkbox" checked>
                    <div class="w-100 ms-3">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span><del>Update summer promotion details</del></span>
                            <button class="btn btn-sm text-primary"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/dashboard_footer.jsp" />
