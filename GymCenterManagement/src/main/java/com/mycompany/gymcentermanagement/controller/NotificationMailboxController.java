package com.mycompany.gymcentermanagement.controller;

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

@WebServlet(name = "NotificationMailboxController", urlPatterns = {
    "/staff/notifications",
    "/staff/notifications/detail",
    "/staff/notifications/mark-read",
    "/pt/notifications",
    "/pt/notifications/detail",
    "/pt/notifications/mark-read"
})
public class NotificationMailboxController extends HttpServlet {

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

        String servletPath = request.getServletPath();
        boolean staffPath = servletPath.startsWith("/staff/");
        boolean ptPath = servletPath.startsWith("/pt/");

        if ((staffPath && currentUser.getRole() != User.Role.Staff)
                || (ptPath && currentUser.getRole() != User.Role.PT)) {
            request.setAttribute("errorMessage", "Bạn không có quyền truy cập hộp thư thông báo này.");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        transferFeedbackMessage(session, request);

        configureView(request, currentUser.getRole());

        if (servletPath.endsWith("/detail")) {
            try {
                int notiId = Integer.parseInt(request.getParameter("notiId"));
                gymDAO.markAsRead(notiId, currentUser.getUserId());
                Map<String, String> selectedNoti = gymDAO.getNotificationById(notiId, currentUser.getUserId());
                request.setAttribute("selectedNoti", selectedNoti);
                request.setAttribute("selectedNotiId", notiId);
            } catch (NumberFormatException ex) {
                request.setAttribute("errorMessage", "Thông báo không hợp lệ.");
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

        String servletPath = request.getServletPath();
        boolean staffPath = servletPath.startsWith("/staff/");
        boolean ptPath = servletPath.startsWith("/pt/");
        if ((staffPath && currentUser.getRole() != User.Role.Staff)
                || (ptPath && currentUser.getRole() != User.Role.PT)) {
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

        String redirectPath = staffPath ? "/staff/notifications" : "/pt/notifications";
        response.sendRedirect(request.getContextPath() + redirectPath);
    }

    private void configureView(HttpServletRequest request, User.Role role) {
        if (role == User.Role.Staff) {
            request.setAttribute("mailboxTitle", "Hộp thư thông báo nhân viên");
            request.setAttribute("mailboxSubtitle", "Xem các thông báo nội bộ, lịch vận hành và cập nhật từ trung tâm");
            request.setAttribute("dashboardUrl", request.getContextPath() + "/staff/dashboard");
            request.setAttribute("notificationBasePath", request.getContextPath() + "/staff/notifications");
        } else {
            request.setAttribute("mailboxTitle", "Hộp thư thông báo huấn luyện viên");
            request.setAttribute("mailboxSubtitle", "Xem thông báo lịch dạy, hội viên và cập nhật từ trung tâm");
            request.setAttribute("dashboardUrl", request.getContextPath() + "/pt/dashboard");
            request.setAttribute("notificationBasePath", request.getContextPath() + "/pt/notifications");
        }
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
