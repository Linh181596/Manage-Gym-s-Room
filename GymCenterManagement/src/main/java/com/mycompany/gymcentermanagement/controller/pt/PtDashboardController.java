package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.dto.PTDashboardData;
import com.mycompany.gymcentermanagement.dto.PTMemberDTO;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTDashboardService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTDashboardServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

/**
 * Controller to handle Personal Trainer Dashboard GET requests.
 * Mapped to /pt/dashboard.
 */
@WebServlet(name = "PtDashboardController", urlPatterns = { "/pt/dashboard" })
public class PtDashboardController extends HttpServlet {

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final PTDashboardService ptDashboardService = new PTDashboardServiceImpl();
    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (currentUser.getRole() != User.Role.PT) {
            request.setAttribute("errorMessage", "Trang này chỉ dành cho huấn luyện viên (PT).");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        try {
            PersonalTrainer pt = personalTrainerService.getPTByUserId(currentUser.getUserId());
            if (pt == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ huấn luyện viên.");
                return;
            }

            PTDashboardData dashboardData = ptDashboardService.getPTDashboardData(pt.getPtId());
            request.setAttribute("dashboardData", dashboardData);

            // Lấy danh sách hợp đồng PT hoạt động kèm tiến độ tập
            PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
            List<PTRegistrationDTO> registrationsWithProgress = ptRegistrationService.getPTRegistrationsWithProgress(pt.getPtId());
            request.setAttribute("registrationsWithProgress", registrationsWithProgress);

            // Lấy số lượng đơn mới đã thanh toán cần xếp lịch dạy
            List<PTRegistrationDTO> pendingSchedules = ptRegistrationService.getActivePaidRegistrationsWithoutScheduleByPT(pt.getPtId());
            request.setAttribute("pendingSchedulesCount", pendingSchedules != null ? pendingSchedules.size() : 0);

            // Lấy danh sách hội viên của PT
            List<PTMemberDTO> membersList = personalTrainerService
                    .getActiveMembersForPT(pt.getPtId());
            request.setAttribute("membersList", membersList);

            // Lấy danh sách buổi tập trong tuần
            LocalDate today = LocalDate.now();
            LocalDate monday = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
            LocalDate sunday = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
            List<PTScheduleDetailDTO> weeklySessionsList = ptScheduleService
                    .getPTScheduleDetailsForWeek(pt.getPtId(), monday, sunday);
            request.setAttribute("weeklySessionsList", weeklySessionsList);

            // Lấy danh sách ca dạy đã hoàn thành
            List<PTScheduleDetailDTO> completedSessionsList = ptScheduleService
                    .getCompletedSessions(pt.getPtId());
            request.setAttribute("completedSessionsList", completedSessionsList);

            request.getRequestDispatcher("/WEB-INF/views/pt/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
            }
        }
    }
}
