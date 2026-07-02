<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%--
  =========================================================================
  Document    : members.jsp
  Created on  : 2026-06-04
  Author      : Nguyễn Trí Linh (linhnt)
  Description : Giao diện danh sách hội viên dành cho nhân viên lễ tân/quản lý.
  =========================================================================
--%>
<jsp:include page="../common/dashboard_header.jsp" />
<jsp:include page="../common/dashboard_navbar.jsp" />

<%
    List<Map<String, String>> memberList = (List<Map<String, String>>) request.getAttribute("memberList");
    String keyword = request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "";
    String memberType = request.getParameter("memberType") != null ? request.getParameter("memberType") : "";
    String contextPath = request.getContextPath();
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!-- Staff Member Management Content -->
<div class="container-fluid pt-4 px-4">
    <!-- Header Title and Quick Actions -->
    <div class="d-flex align-items-center justify-content-between mb-4 bg-light rounded p-4 border">
        <div>
            <h5 class="mb-1 text-primary fw-bold"><i class="fa fa-users me-2"></i>Quản lý danh sách hội viên</h5>
            <small class="text-muted">Bảng điều khiển nghiệp vụ dành riêng cho nhân viên quầy lễ tân</small>
        </div>
        <button class="btn btn-success py-2 px-3 fw-bold" onclick="toggleAddMemberForm()" id="mainActionBtn">
            <i class="fa fa-plus-circle me-2"></i>Thêm hội viên mới
        </button>
    </div>

    <!-- Error Message Alert -->
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa fa-exclamation-circle me-2"></i><%= errorMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- Add Member Section (Hidden by default, animates slide down) -->
    <section id="addMemberSection" class="bg-light rounded p-4 mb-4 border" style="display: none;">
        <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
            <i class="fa fa-user-plus me-2 text-success"></i>Điền thông tin tạo tài khoản hội viên mới
        </h6>
        <form action="<%= contextPath %>/staff/members/add" method="POST">
            <div class="row g-3 mb-3">
                <div class="col-md-3">
                    <label for="name" class="form-label fw-semibold text-secondary">Họ và tên <span class="text-danger">*</span></label>
                    <input id="name" type="text" name="name" class="form-control" placeholder="Ví dụ: Nguyễn Văn A" required>
                </div>
                <div class="col-md-3">
                    <label for="email" class="form-label fw-semibold text-secondary">Địa chỉ Email <span class="text-danger">*</span></label>
                    <input id="email" type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
                </div>
                <div class="col-md-3">
                    <label for="phone" class="form-label fw-semibold text-secondary">Số điện thoại</label>
                    <input id="phone" type="text" name="phone" class="form-control" placeholder="Ví dụ: 0912345678" pattern="^0[0-9]{9}$" title="Số điện thoại phải bắt đầu bằng số 0 và gồm 10 chữ số" maxlength="10" oninvalid="this.setCustomValidity('Số điện thoại phải bắt đầu bằng số 0 và gồm đúng 10 chữ số')" oninput="this.setCustomValidity('')">
                </div>
                <div class="col-md-3">
                    <label for="type" class="form-label fw-semibold text-secondary">Gói tập đăng ký ban đầu</label>
                    <select id="type" name="type" class="form-select">
                        <option value="Cơ bản">Gói Cơ Bản (Gym Basic - 1 Tháng)</option>
                        <option value="Cao cấp">Gói Cao Cấp (Gym Premium - 3 Tháng)</option>
                    </select>
                </div>
            </div>
            <div class="d-flex justify-content-end gap-2 border-top pt-3">
                <button class="btn btn-outline-secondary px-4" type="button" onclick="toggleAddMemberForm()">Hủy bỏ</button>
                <button class="btn btn-success px-4" type="submit">Xác nhận thêm</button>
            </div>
        </form>
    </section>

    <!-- Main Layout Grid -->
    <div class="row g-4">
        <!-- Filter Card -->
        <div class="col-lg-3">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-filter me-2 text-primary"></i>Bộ lọc dữ liệu
                </h6>
                <form action="<%= contextPath %>/staff/members" method="GET">
                    <div class="mb-3">
                        <label for="searchKeyword" class="form-label fw-semibold text-secondary">Từ khóa tìm kiếm</label>
                        <input id="searchKeyword" type="text" name="searchKeyword" value="<%= keyword %>" class="form-control" placeholder="Tên, email hoặc SĐT...">
                    </div>
                    <div class="mb-3">
                        <label for="memberType" class="form-label fw-semibold text-secondary">Phân loại gói tập</label>
                        <select id="memberType" name="memberType" class="form-select">
                            <option value="" <%= memberType.isEmpty() ? "selected" : "" %>>— Tất cả các gói —</option>
                            <option value="Cơ bản" <%="Cơ bản".equals(memberType)?"selected":"" %>>Gói Cơ Bản (Basic)</option>
                            <option value="Cao cấp" <%="Cao cấp".equals(memberType)?"selected":"" %>>Gói Cao Cấp (Premium)</option>
                        </select>
                    </div>
                    <div class="d-grid gap-2 mt-4">
                        <button class="btn btn-primary" type="submit"><i class="fa fa-search me-2"></i>Tìm kiếm</button>
                        <a href="<%= contextPath %>/staff/members" class="btn btn-outline-secondary"><i class="fa fa-undo me-2"></i>Xóa bộ lọc</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Data List Table Card -->
        <div class="col-lg-9">
            <div class="bg-light rounded p-4 border h-100">
                <h6 class="mb-3 text-dark fw-bold border-bottom pb-2">
                    <i class="fa fa-list me-2 text-primary"></i>Danh sách thành viên đăng ký
                </h6>
                <div class="table-responsive">
                    <% if (memberList != null && !memberList.isEmpty()) { %>
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark bg-white">
                                    <th scope="col" style="width: 80px;">Mã số</th>
                                    <th scope="col">Thông tin thành viên</th>
                                    <th scope="col">Gói tập hiện tại</th>
                                    <th scope="col">Ngày tham gia</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col" class="text-center" style="width: 420px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    for (Map<String, String> member : memberList) { 
                                        String userId = member.get("userId");
                                        String status = member.get("status");
                                        boolean isActive = "Active".equalsIgnoreCase(status);
                                %>
                                    <tr>
                                        <td><strong>#<%= userId %></strong></td>
                                        <td>
                                            <div class="fw-bold text-dark"><%= member.get("fullName") %></div>
                                            <div class="text-muted small"><i class="fa fa-envelope me-1"></i><%= member.get("email") %></div>
                                            <div class="text-muted small"><i class="fa fa-phone me-1"></i><%= member.get("phone") %></div>
                                        </td>
                                        <td>
                                            <span class="badge bg-white text-secondary border border-secondary fw-semibold">
                                                <%= member.get("membershipType") %>
                                            </span>
                                        </td>
                                        <td class="text-muted small"><%= member.get("date").split("\\.")[0] %></td>
                                        <td>
                                            <% if (isActive) { %>
                                                <span class="badge bg-success"><i class="fa fa-check-circle me-1"></i>Hoạt động</span>
                                            <% } else { %>
                                                <span class="badge bg-danger"><i class="fa fa-minus-circle me-1"></i>Đang khóa</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1 justify-content-center">
                                                <a href="<%= contextPath %>/member/portal?viewMemberId=<%= userId %>" class="btn btn-sm btn-outline-info" title="Xem hồ sơ">
                                                    <i class="fa fa-eye"></i> Hồ sơ
                                                </a>
                                                <% if (isActive) { %>
                                                    <a href="<%= contextPath %>/staff/package/renew?memberId=<%= userId %>" 
                                                       class="btn btn-sm btn-outline-success" 
                                                       title="Gia hạn gói tập">
                                                        <i class="fa fa-history"></i> Gia hạn
                                                    </a>
                                                    <a href="<%= contextPath %>/staff/package/transfer?senderId=<%= userId %>" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       title="Chuyển nhượng gói tập">
                                                        <i class="fa fa-exchange-alt"></i> Chuyển nhượng
                                                    </a>
                                                    <a href="<%= contextPath %>/staff/members/toggle?userId=<%= userId %>&targetStatus=Locked" 
                                                       class="btn btn-sm btn-outline-warning" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn KHÓA hội viên này?')" 
                                                       title="Khóa tài khoản">
                                                        <i class="fa fa-lock"></i> Khóa
                                                    </a>
                                                <% } else { %>
                                                    <a href="<%= contextPath %>/staff/members/toggle?userId=<%= userId %>&targetStatus=Active" 
                                                       class="btn btn-sm btn-outline-success" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn MỞ KHÓA hội viên này?')" 
                                                       title="Mở khóa tài khoản">
                                                        <i class="fa fa-lock-open"></i> Mở
                                                    </a>
                                                <% } %>
                                                <a href="<%= contextPath %>/staff/members/notify?userId=<%= userId %>" 
                                                   class="btn btn-sm btn-outline-primary" 
                                                   onclick="return confirm('Hệ thống sẽ gửi thông báo nhắc nợ tự động. Tiếp tục?')" 
                                                   title="Nhắc nhở gia hạn">
                                                    <i class="fa fa-bell"></i> Nhắc nhở
                                                </a>
                                                <a href="<%= contextPath %>/staff/members/delete?userId=<%= userId %>" 
                                                   class="btn btn-sm btn-outline-danger" 
                                                   onclick="return confirm('CẢNH BÁO: Bạn có thực sự chắc chắn muốn XÓA HỘI VIÊN này khỏi hệ thống không?')" 
                                                   title="Xóa vĩnh viễn">
                                                    <i class="fa fa-trash-alt"></i> Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        
                        <!-- Pagination -->
                        <jsp:include page="../common/pagination.jsp" />
                    <% } else { %>
                        <div class="text-center py-5 text-muted">
                            <i class="fa fa-folder-open fa-3x mb-3 text-secondary"></i>
                            <p class="mb-0">Hiện tại chưa có dữ liệu hội viên nào phù hợp với bộ lọc tìm kiếm của bạn.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleAddMemberForm() {
        var formSection = document.getElementById("addMemberSection");
        var btn = document.getElementById("mainActionBtn");
        if(!formSection) return;
        
        if (formSection.style.display === "none" || formSection.style.display === "") {
            formSection.style.display = "block";
            btn.innerHTML = "<i class='fa fa-times-circle me-2'></i>Đóng biểu mẫu thêm";
            btn.classList.replace("btn-success", "btn-danger");
            document.getElementById("name").focus();
        } else {
            formSection.style.display = "none";
            btn.innerHTML = "<i class='fa fa-plus-circle me-2'></i>Thêm hội viên mới";
            btn.classList.replace("btn-danger", "btn-success");
        }
    }
</script>

<jsp:include page="../common/dashboard_footer.jsp" />
