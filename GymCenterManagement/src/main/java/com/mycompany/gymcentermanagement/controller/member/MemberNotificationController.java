/**
 * =========================================================================
 * @file          : MemberNotificationController.java
 * @description   : Controller xử lý hiển thị danh sách và chi tiết thông báo gửi tới hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.GymDAO;
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
 * Controller to handle Member Notifications GET requests (UC11).
 * Mapped to /member/notifications and sub-paths.
 */
@WebServlet(name = "MemberNotificationController", urlPatterns = {
    "/member/notifications",
    "/member/notifications/detail",
    "/member/notifications/mark-read"
})
public class MemberNotificationController extends HttpServlet {

    private final GymDAO gymDAO = new GymDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Ensure that only members can access their notification mailbox
        if (currentUser.getRole() != User.Role.Member) {
            request.setAttribute("errorMessage", "Cần quyền Member để truy cập hộp thư thông báo.");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        transferFeedbackMessage(session, request);
        
        String servletPath = request.getServletPath();
        request.setAttribute("mailboxTitle", "Hộp thư thông báo cá nhân");
        request.setAttribute("mailboxSubtitle", "Xem tin tức, nhắc nhở lịch tập, ưu đãi gia hạn từ trung tâm");
        request.setAttribute("dashboardUrl", request.getContextPath() + "/member/dashboard");
        request.setAttribute("notificationBasePath", request.getContextPath() + "/member/notifications");

        if ("/member/notifications/detail".equals(servletPath)) {
            try {
                int notiId = Integer.parseInt(request.getParameter("notiId"));
                gymDAO.markAsRead(notiId, currentUser.getUserId());
                Map<String, String> selectedNoti = gymDAO.getNotificationById(notiId, currentUser.getUserId());
                
                request.setAttribute("selectedNoti", selectedNoti);
                request.setAttribute("selectedNotiId", notiId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        List<Map<String, String>> notis = gymDAO.getNotifications(currentUser.getUserId());
        request.setAttribute("notis", notis);
        
        request.getRequestDispatcher("/WEB-INF/views/member/notifications.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (currentUser.getRole() != User.Role.Member) {
            request.setAttribute("errorMessage", "B\u1ea1n kh\u00f4ng c\u00f3 quy\u1ec1n c\u1eadp nh\u1eadt th\u00f4ng b\u00e1o n\u00e0y.");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        boolean success = gymDAO.markAllNotificationsAsRead(currentUser.getUserId());
        String message = "\u0110\u00e3 \u0111\u00e1nh d\u1ea5u t\u1ea5t c\u1ea3 th\u00f4ng b\u00e1o l\u00e0 \u0111\u00e3 \u0111\u1ecdc.";

        if (session != null) {
            session.setAttribute(success ? "notificationSuccessMessage" : "notificationErrorMessage",
                    success ? message : "Không thể cập nhật thông báo. Vui lòng thử lại.");
        }
        response.sendRedirect(request.getContextPath() + "/member/notifications");
    }

    private void transferFeedbackMessage(HttpSession session, HttpServletRequest request) {
        if (session == null) {
            return;
        }
        Object success = session.getAttribute("notificationSuccessMessage");
        Object error = session.getAttribute("notificationErrorMessage");
        if (success != null) {
            request.setAttribute("notificationSuccessMessage", success);
            session.removeAttribute("notificationSuccessMessage");
        }
        if (error != null) {
            request.setAttribute("notificationErrorMessage", error);
            session.removeAttribute("notificationErrorMessage");
        }
    }
}
