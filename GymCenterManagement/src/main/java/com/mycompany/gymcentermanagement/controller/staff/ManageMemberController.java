/**
 * =========================================================================
 * @file          : ManageMemberController.java
 * @description   : Controller điều phối các hoạt động quản lý danh sách và trạng thái hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.dao.GymDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller to handle Member Management for Staff role (UC09).
 * Mapped to /staff/members and its sub-paths.
 */
@WebServlet(name = "ManageMemberController", urlPatterns = {
    "/staff/members",
    "/staff/members/add",
    "/staff/members/toggle",
    "/staff/members/delete",
    "/staff/members/notify"
})
public class ManageMemberController extends HttpServlet {

    private final GymDAO gymDAO = new GymDAO();
    private static final String ACTIVE_PACKAGE_LOCK_MESSAGE =
            "Không thể khóa tài khoản hội viên vì hội viên đang có gói tập còn hạn.";
    private static final String ACTIVE_PACKAGE_DELETE_MESSAGE =
            "Không thể xóa tài khoản hội viên vì hội viên đang có gói tập còn hạn.";

    /**
     * Nhận request GET và điều hướng sang xem danh sách, khóa/mở khóa, xóa hoặc
     * gửi nhắc nhở nhanh cho hội viên.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/staff/members/toggle".equals(servletPath)) {
            toggleMemberStatus(request, response);
        } else if ("/staff/members/delete".equals(servletPath)) {
            deleteMember(request, response);
        } else if ("/staff/members/notify".equals(servletPath)) {
            sendQuickNotification(request, response);
        } else {
            showMemberList(request, response);
        }
    }

    /**
     * Nhận request POST; hiện tại chỉ xử lý thao tác thêm hội viên mới từ form
     * quản lý hội viên.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/staff/members/add".equals(servletPath)) {
            addMember(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    /**
     * Hiển thị danh sách hội viên cho Staff, áp dụng tìm kiếm, lọc loại gói và
     * phân trang trước khi forward sang trang members.jsp.
     */
    private void showMemberList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        consumeFlashMessages(request);
        
        String keyword = request.getParameter("searchKeyword");
        String memberType = request.getParameter("memberType");
        
        int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
        int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), 10));
        
        int totalItems = gymDAO.getMembersCount(keyword, memberType);
        int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
        page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;
        
        List<Map<String, String>> memberList = gymDAO.getMembers(keyword, memberType, offset, pageSize);
        
        request.setAttribute("memberList", memberList);
        
        String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                request, "/staff/members", "searchKeyword", keyword, "memberType", memberType, "pageSize", String.valueOf(pageSize));

        com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                request, page, pageSize, totalItems, queryBase, "hội viên");
                
        request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
    }

    /**
     * Thêm hội viên mới: kiểm tra dữ liệu nhập, kiểm tra trùng email/số điện
     * thoại, sau đó gọi DAO để tạo User, Member, role Member và gói tập nếu có.
     */
    private void addMember(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Họ tên và email không được để trống.");
            showMemberList(request, response);
            return;
        }

        if (phone != null && !phone.trim().isEmpty()) {
            String trimmedPhone = phone.trim();
            if (!trimmedPhone.matches("^0[0-9]{9}$")) {
                request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Số điện thoại phải bắt đầu bằng số 0 và gồm đúng 10 chữ số.");
                showMemberList(request, response);
                return;
            }
        }

        try {
            UserDAO userDAO = new UserDAOImpl();
            if (userDAO.checkEmailExists(email)) {
                request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Địa chỉ email này đã tồn tại trong hệ thống.");
                showMemberList(request, response);
                return;
            }
            if (phone != null && !phone.trim().isEmpty()) {
                if (userDAO.checkPhoneExists(phone)) {
                    request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Số điện thoại này đã tồn tại trong hệ thống.");
                    showMemberList(request, response);
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean success = gymDAO.addMember(name, email, phone, type);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/staff/members");
        } else {
            request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Vui lòng kiểm tra lại email hoặc số điện thoại.");
            showMemberList(request, response);
        }
    }

    /**
     * Khóa hoặc mở khóa tài khoản hội viên; nếu hội viên còn gói tập đang hiệu
     * lực thì không cho khóa để tránh chặn người vẫn còn quyền sử dụng dịch vụ.
     */
    private void toggleMemberStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String targetStatus = request.getParameter("targetStatus");
            if ("Locked".equals(targetStatus) && gymDAO.hasActiveMemberGymPackage(userId)) {
                setFlash(request, "errorMessage", ACTIVE_PACKAGE_LOCK_MESSAGE);
                response.sendRedirect(request.getContextPath() + "/staff/members");
                return;
            }

            boolean updated = gymDAO.updateMemberStatus(userId, targetStatus);
            if (updated) {
                String message = "Locked".equals(targetStatus)
                        ? "Khóa tài khoản hội viên thành công."
                        : "Mở khóa tài khoản hội viên thành công.";
                setFlash(request, "successMessage", message);
            } else {
                setFlash(request, "errorMessage", "Không thể cập nhật trạng thái tài khoản hội viên.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            setFlash(request, "errorMessage", "Mã hội viên không hợp lệ.");
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }

    /**
     * Xóa mềm tài khoản hội viên khỏi danh sách quản lý; trước khi xóa kiểm tra
     * hội viên không còn gói tập active.
     */
    private void deleteMember(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            if (gymDAO.hasActiveMemberGymPackage(userId)) {
                setFlash(request, "errorMessage", ACTIVE_PACKAGE_DELETE_MESSAGE);
                response.sendRedirect(request.getContextPath() + "/staff/members");
                return;
            }

            boolean deleted = gymDAO.deleteMember(userId);
            if (deleted) {
                setFlash(request, "successMessage", "Xóa tài khoản hội viên thành công.");
            } else {
                setFlash(request, "errorMessage", "Không thể xóa tài khoản hội viên.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            setFlash(request, "errorMessage", "Mã hội viên không hợp lệ.");
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }

    /**
     * Gửi thông báo nhắc gia hạn gói tập cho một hội viên cụ thể từ màn hình
     * quản lý hội viên.
     */
    private void sendQuickNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser != null) {
            try {
                int targetUserId = Integer.parseInt(request.getParameter("userId"));
                String title = "Nhắc gia hạn gói tập";
                String content = "Hội viên vui lòng kiểm tra và gia hạn gói tập nếu sắp hết hạn.";
                gymDAO.createNotificationForUser(currentUser.getUserId(), title, content, targetUserId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }

    /**
     * Lấy các flash message trong session và chuyển sang request để hiển thị một
     * lần trên trang danh sách hội viên.
     */
    private void consumeFlashMessages(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        transferFlashMessage(request, session, "errorMessage");
        transferFlashMessage(request, session, "successMessage");
    }

    /**
     * Chuyển một flash message theo key từ session sang request rồi xóa khỏi
     * session để tránh hiển thị lặp lại.
     */
    private void transferFlashMessage(HttpServletRequest request, HttpSession session, String key) {
        Object value = session.getAttribute(key);
        if (value != null) {
            request.setAttribute(key, value);
            session.removeAttribute(key);
        }
    }

    /**
     * Lưu thông báo thao tác vào session để request sau khi redirect có thể hiển
     * thị kết quả cho người dùng.
     */
    private void setFlash(HttpServletRequest request, String key, String message) {
        request.getSession().setAttribute(key, message);
    }

}
