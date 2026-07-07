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
    "/pt/notifications",
    "/pt/notifications/detail"
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

        configureView(request, currentUser.getRole());

        List<Map<String, String>> notis = gymDAO.getNotifications(currentUser.getUserId());
        request.setAttribute("notis", notis);

        if (servletPath.endsWith("/detail")) {
            try {
                int notiId = Integer.parseInt(request.getParameter("notiId"));
                gymDAO.markAsRead(notiId);
                Map<String, String> selectedNoti = gymDAO.getNotificationById(notiId, currentUser.getUserId());
                request.setAttribute("selectedNoti", selectedNoti);
                request.setAttribute("selectedNotiId", notiId);
            } catch (NumberFormatException ex) {
                request.setAttribute("errorMessage", "Thông báo không hợp lệ.");
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/member/notifications.jsp").forward(request, response);
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
}
