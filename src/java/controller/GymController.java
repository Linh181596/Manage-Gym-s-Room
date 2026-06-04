package controller;

import dao.GymDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/gym-system")
public class GymController extends HttpServlet {
    private final GymDAO gymDAO = new GymDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("switchRole".equals(action)) {
            switchRole(request, response, session);
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        if (action == null || action.isBlank() || "dashboard".equals(action)) {
            if (isStaffOnly(currentUser)) {
                request.setAttribute("memberList", gymDAO.getAllMembers());
            }
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            return;
        }

        try {
            switch (action) {
                case "uc09_list":
                case "memberManagement":
                    showMemberManagement(request, response, currentUser);
                    break;

                case "uc09_add":
                    addMember(request, response, currentUser);
                    break;

                case "toggleMemberStatus":
                    toggleMemberStatus(request, response, currentUser);
                    break;

                case "deleteMember":
                    deleteMember(request, response, currentUser);
                    break;

                case "sendQuickNotification":
                    sendQuickNotification(request, response, currentUser);
                    break;

                case "uc10_portal":
                case "viewMemberPortal":
                    showMemberPortal(request, response, currentUser);
                    break;

                case "uc11_notifications":
                case "viewMemberNotifications":
                    showNotifications(request, response, currentUser);
                    break;

                case "uc11_detail":
                    showNotificationDetail(request, response, currentUser);
                    break;

                default:
                    request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void switchRole(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        String targetRole = request.getParameter("role");
        if ("Staff".equals(targetRole)) {
            User staffUser = new User(2, "staff@gym.com", "Staff Member", "staff@gym.com", "0912345679", "Staff", "Active");
            session.setAttribute("currentUser", staffUser);
        } else if ("Admin".equals(targetRole)) {
            User adminUser = new User(1, "admin@gym.com", "Gym Administrator", "admin@gym.com", "0912345678", "Admin", "Active");
            session.setAttribute("currentUser", adminUser);
        } else if ("Member".equals(targetRole)) {
            User memberUser = new User(4, "member@gym.com", "Gym Member", "member@gym.com", "0912345681", "Member", "Active");
            session.setAttribute("currentUser", memberUser);
        } else {
            session.removeAttribute("currentUser");
        }
        String baseUrl = request.getContextPath() + "/gym-system";
        if ("Staff".equals(targetRole)) {
            response.sendRedirect(response.encodeRedirectURL(baseUrl + "?action=memberManagement"));
        } else if ("Member".equals(targetRole)) {
            response.sendRedirect(response.encodeRedirectURL(baseUrl + "?action=uc10_portal"));
        } else {
            response.sendRedirect(response.encodeRedirectURL(baseUrl + "?action=dashboard"));
        }
    }

    private void showMemberManagement(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (!isStaffOnly(currentUser)) {
            forwardError("Hành động này CHỈ DÀNH RIÊNG cho Nhân viên (Staff).", request, response);
            return;
        }
        String keyword = request.getParameter("searchKeyword");
        String memberType = request.getParameter("memberType");
        request.setAttribute("memberList", gymDAO.getMembers(keyword, memberType));
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    private void addMember(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (!isStaffOnly(currentUser)) {
            forwardError("Hành động này CHỈ DÀNH RIÊNG cho Nhân viên (Staff).", request, response);
            return;
        }
        boolean created = gymDAO.addMember(
                request.getParameter("name"),
                request.getParameter("email"),
                request.getParameter("phone"),
                request.getParameter("type")
        );
        if (created) {
            response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/gym-system?action=memberManagement"));
        } else {
            forwardError("Không thể thêm hội viên. Hãy kiểm tra lại.", request, response);
        }
    }

    private void toggleMemberStatus(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (!isStaffOnly(currentUser)) {
            forwardError("Hành động này CHỈ DÀNH RIÊNG cho Nhân viên (Staff).", request, response);
            return;
        }
        int userId = Integer.parseInt(request.getParameter("userId"));
        String targetStatus = request.getParameter("targetStatus");
        gymDAO.updateMemberStatus(userId, targetStatus);
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/gym-system?action=memberManagement"));
    }

    private void deleteMember(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (!isStaffOnly(currentUser)) {
            forwardError("Hành động này CHỈ DÀNH RIÊNG cho Nhân viên (Staff).", request, response);
            return;
        }
        int userId = Integer.parseInt(request.getParameter("userId"));
        gymDAO.deleteMember(userId);
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/gym-system?action=memberManagement"));
    }

    private void sendQuickNotification(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (!isStaffOnly(currentUser)) {
            forwardError("Hành động này CHỈ DÀNH RIÊNG cho Nhân viên (Staff).", request, response);
            return;
        }
        int targetUserId = Integer.parseInt(request.getParameter("userId"));
        String title = "Nhắc gia hạn gói tập";
        String content = "Hội viên #" + targetUserId + " vui lòng kiểm tra và gia hạn gói tập nếu sắp hết hạn.";
        gymDAO.createNotification(currentUser.getUserId(), title, content, "Member");
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/gym-system?action=memberManagement"));
    }

    // ĐÃ SỬA: Cho phép cả tài khoản Staff xem thông tin Portal của hội viên khác mà không bị chặn phân quyền cũ
    private void showMemberPortal(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (currentUser == null) {
            forwardError("Cần đăng nhập để xem thông tin.", request, response);
            return;
        }
        int userId = currentUser.getUserId();
        String viewMemberId = request.getParameter("viewMemberId");
        
        if (viewMemberId != null && !viewMemberId.isBlank()) {
            // Sửa đổi điều kiện kiểm tra: Nhân viên (Staff) có toàn quyền xem Portal của member khác
            if (!"Staff".equals(currentUser.getRole()) && !"Admin".equals(currentUser.getRole())) {
                forwardError("Không có quyền xem thông tin của hội viên khác.", request, response);
                return;
            }
            userId = Integer.parseInt(viewMemberId);
        } else if (!"Member".equals(currentUser.getRole())) {
            forwardError("Cần chọn một hội viên từ danh sách quản lý để xem.", request, response);
            return;
        }

        request.setAttribute("profile", gymDAO.getMemberProfile(userId));
        request.setAttribute("services", gymDAO.getMemberServices(userId));
        request.getRequestDispatcher("/uc10_portal.jsp").forward(request, response);
    }

    private void showNotifications(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (currentUser == null || !"Member".equals(currentUser.getRole())) {
            forwardError("Cần quyền Member để vào hộp thư.", request, response);
            return;
        }
        request.setAttribute("notis", gymDAO.getNotifications(currentUser.getUserId()));
        request.getRequestDispatcher("/uc11_notifications.jsp").forward(request, response);
    }

    private void showNotificationDetail(HttpServletRequest request, HttpServletResponse response, User currentUser) throws ServletException, IOException {
        if (currentUser == null || !"Member".equals(currentUser.getRole())) {
            forwardError("Cần quyền Member để xem chi tiết thông báo.", request, response);
            return;
        }
        int notiId = Integer.parseInt(request.getParameter("notiId"));
        gymDAO.markAsRead(notiId);
        request.setAttribute("selectedNoti", gymDAO.getNotificationById(notiId));
        request.setAttribute("notis", gymDAO.getNotifications(currentUser.getUserId()));
        request.setAttribute("selectedNotiId", notiId);
        request.getRequestDispatcher("/uc11_notifications.jsp").forward(request, response);
    }

    private boolean isStaffOnly(User user) {
        return user != null && "Staff".equals(user.getRole());
    }

    private void forwardError(String msg, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.getRequestDispatcher("/error.jsp").forward(req, res);
    }
}