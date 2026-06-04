/**
 * =========================================================================
 * @file          : MemberNotificationController.java
 * @description   : Controller xử lý hiển thị danh sách và chi tiết thông báo gửi tới hội viên.
 * @author        : Nguyễn Thành Linh (linhnt)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Thành Linh
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
    "/member/notifications/detail"
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
        
        String servletPath = request.getServletPath();
        List<Map<String, String>> notis = gymDAO.getNotifications(currentUser.getUserId());
        request.setAttribute("notis", notis);
        
        if ("/member/notifications/detail".equals(servletPath)) {
            try {
                int notiId = Integer.parseInt(request.getParameter("notiId"));
                gymDAO.markAsRead(notiId);
                Map<String, String> selectedNoti = gymDAO.getNotificationById(notiId);
                
                request.setAttribute("selectedNoti", selectedNoti);
                request.setAttribute("selectedNotiId", notiId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/member/notifications.jsp").forward(request, response);
    }
}
