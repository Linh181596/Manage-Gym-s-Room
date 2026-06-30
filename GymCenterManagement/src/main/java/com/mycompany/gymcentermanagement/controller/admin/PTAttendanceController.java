package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PTAttendanceController", urlPatterns = {"/admin/schedule/attendance"})
public class PTAttendanceController extends HttpServlet {

    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null || (currentUser.getRole() != User.Role.Admin && currentUser.getRole() != User.Role.Staff)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String scheduleIdStr = request.getParameter("scheduleId");
        String status = request.getParameter("status"); // "Attended", "Absent", or "Pending"

        if (scheduleIdStr != null && !scheduleIdStr.isEmpty() && status != null && !status.isEmpty()) {
            try {
                int scheduleId = Integer.parseInt(scheduleIdStr);
                if ("Attended".equals(status) || "Absent".equals(status) || "Pending".equals(status)) {
                    // Update attendance status
                    // If marked Attended or Absent, we can mark the session as Completed
                    // If marked Pending, we mark the session back to Upcoming
                    String sessionStatus = "Completed";
                    if ("Pending".equals(status)) {
                        sessionStatus = "Upcoming";
                    }
                    
                    boolean success = ptScheduleService.updateAttendance(scheduleId, status, sessionStatus);
                    if (success) {
                        if (session != null) {
                            session.setAttribute("successMessage", "Cập nhật điểm danh ca dạy thành công!");
                        }
                    } else {
                        if (session != null) {
                            session.setAttribute("errorMessage", "Không thể cập nhật trạng thái điểm danh.");
                        }
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the calling page
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");
        }
    }
}
