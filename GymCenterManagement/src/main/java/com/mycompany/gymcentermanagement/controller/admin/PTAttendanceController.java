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
        String referer = request.getHeader("Referer");
        String redirectUrl = referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/admin/schedule/manage";

        if (scheduleIdStr == null || scheduleIdStr.isEmpty() || status == null || status.isEmpty()) {
            if (session != null) {
                session.setAttribute("errorMessage", "Yêu cầu không hợp lệ.");
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        if (!"Attended".equals(status) && !"Absent".equals(status) && !"Pending".equals(status)) {
            if (session != null) {
                session.setAttribute("errorMessage", "Trạng thái điểm danh không hợp lệ.");
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        try {
            int scheduleId = Integer.parseInt(scheduleIdStr);
            com.mycompany.gymcentermanagement.model.entity.PTSchedule schedule = ptScheduleService.getScheduleById(scheduleId);
            
            if (schedule == null) {
                if (session != null) {
                    session.setAttribute("errorMessage", "Ca dạy không tồn tại.");
                }
                response.sendRedirect(redirectUrl);
                return;
            }

            // Check 1: Không được là lịch tương lai
            java.time.LocalDate today = java.time.LocalDate.now();
            java.time.LocalTime nowTime = java.time.LocalTime.now();
            java.time.LocalDate sessionDate = schedule.getSessionDate();
            java.time.LocalTime sessionStartTime = schedule.getStartTime().toLocalTime();
            
            boolean isInFuture = sessionDate.isAfter(today) || 
                (sessionDate.isEqual(today) && sessionStartTime.isAfter(nowTime));
            
            if (isInFuture) {
                if (session != null) {
                    session.setAttribute("errorMessage", "Không thể điểm danh cho ca dạy trong tương lai.");
                }
                response.sendRedirect(redirectUrl);
                return;
            }

            // Check 2: Không được là ca học đã hủy
            if ("Cancelled".equalsIgnoreCase(schedule.getSessionStatus())) {
                if (session != null) {
                    session.setAttribute("errorMessage", "Không thể điểm danh cho ca dạy đã bị hủy.");
                }
                response.sendRedirect(redirectUrl);
                return;
            }

            // Check 3: Chưa bị khóa xử lý (Gói đăng ký PT phải còn hoạt động/Active)
            com.mycompany.gymcentermanagement.service.PTRegistrationService ptRegistrationService = 
                new com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl();
            com.mycompany.gymcentermanagement.dto.PTRegistrationDTO registration = 
                ptRegistrationService.getRegistrationById(schedule.getRegistrationId());
                
            if (registration == null || !"Active".equalsIgnoreCase(registration.getStatus())) {
                if (session != null) {
                    session.setAttribute("errorMessage", "Không thể điểm danh do gói tập của hội viên đã bị khóa xử lý hoặc đã kết thúc.");
                }
                response.sendRedirect(redirectUrl);
                return;
            }

            // Xác định trạng thái buổi tập (SessionStatus)
            String sessionStatus = "Completed";
            if ("Pending".equals(status)) {
                sessionStatus = "Upcoming";
            }

            // Cập nhật điểm danh kèm audit log (UpdatedBy)
            String actorName = currentUser.getFullName();
            boolean success = ptScheduleService.updateAttendance(scheduleId, status, sessionStatus, actorName);
            
            if (success) {
                if (session != null) {
                    session.setAttribute("successMessage", "Cập nhật kết quả buổi học thành công!");
                }
            } else {
                if (session != null) {
                    session.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật điểm danh.");
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            if (session != null) {
                session.setAttribute("errorMessage", "Mã ca dạy không hợp lệ.");
            }
        }

        response.sendRedirect(redirectUrl);
    }
}
