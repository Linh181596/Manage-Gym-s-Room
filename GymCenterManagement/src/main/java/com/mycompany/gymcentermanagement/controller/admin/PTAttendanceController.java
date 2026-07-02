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
                    // Check if session is in the future
                    com.mycompany.gymcentermanagement.model.entity.PTSchedule schedule = ptScheduleService.getScheduleById(scheduleId);
                    if (schedule != null) {
                        java.time.LocalDate today = java.time.LocalDate.now();
                        java.time.LocalTime nowTime = java.time.LocalTime.now();
                        java.time.LocalDate sessionDate = schedule.getSessionDate();
                        java.time.LocalTime sessionStartTime = schedule.getStartTime().toLocalTime();
                        
                        boolean isInFuture = sessionDate.isAfter(today) || 
                            (sessionDate.isEqual(today) && sessionStartTime.isAfter(nowTime));
                        
                        if (isInFuture && ("Attended".equals(status) || "Absent".equals(status))) {
                            if (session != null) {
                                session.setAttribute("errorMessage", "Không thể điểm danh cho ca dạy trong tương lai.");
                            }
                            String referer = request.getHeader("Referer");
                            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/admin/schedule/manage");
                            return;
                        }

                        boolean isInPast = sessionDate.isBefore(today);
                        if (isInPast) {
                            if (session != null) {
                                session.setAttribute("errorMessage", "Không thể chỉnh sửa điểm danh của các ca dạy trong quá khứ.");
                            }
                            String referer = request.getHeader("Referer");
                            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/admin/schedule/manage");
                            return;
                        }
                    }

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
