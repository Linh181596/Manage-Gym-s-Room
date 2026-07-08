package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.dto.RescheduleRequestDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.gymcentermanagement.service.RescheduleRequestService;
import com.mycompany.gymcentermanagement.service.impl.RescheduleRequestServiceImpl;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
@WebServlet(name = "ManageScheduleController", urlPatterns = {"/admin/schedule/manage"})
public class ManageScheduleController extends HttpServlet {
    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();
    private final RescheduleRequestService rescheduleRequestService = new RescheduleRequestServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            // 1. Get Pending registrations (Tab 1)
            List<PTRegistrationDTO> pendingRegistrations = ptRegistrationService.getPendingRegistrations();
            req.setAttribute("pendingRegistrations", pendingRegistrations);

            // Escalated reschedule requests (Tab 3)
            List<RescheduleRequestDetailDTO> escalatedRequests = rescheduleRequestService.getEscalatedRequests();
            req.setAttribute("escalatedRequests", escalatedRequests);

            // 2. Get PT workout schedules for selected date (Tab 2)
            String selectedDateStr = req.getParameter("date");
            LocalDate selectedDate = (selectedDateStr != null && !selectedDateStr.isEmpty())
                    ? LocalDate.parse(selectedDateStr)
                    : LocalDate.now();

            LocalDate today = LocalDate.now();

            List<PTScheduleDetailDTO> schedulesList = ptScheduleService.getAllSchedulesByDate(selectedDate);
            req.setAttribute("schedulesList", schedulesList);
            req.setAttribute("selectedDate", selectedDate.toString());
            req.setAttribute("todayDate", today.toString());
            req.setAttribute("isFutureDate", selectedDate.isAfter(today));
            req.setAttribute("isPastDate", selectedDate.isBefore(today));

            req.getRequestDispatcher("/WEB-INF/views/admin/manage-schedule.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi hệ thống: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            String action = req.getParameter("action");
            if ("approve".equals(action)) {
                int regId = Integer.parseInt(req.getParameter("regId"));

                User currentUser =
                        (User) req.getSession().getAttribute("currentUser");
                int adminId = (currentUser != null) ? currentUser.getUserId() : 1;
                String adminName = (currentUser != null) ? currentUser.getFullName() : "Admin";

                ptRegistrationService.processRegistration(regId, "Active", "Paid", adminId, adminName);
                req.getSession().setAttribute("toastMsg", "Xác nhận thanh toán và phê duyệt đơn thành công!");
            }
        } catch (IllegalStateException e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("errorMessage", "Lỗi xử lý: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/schedule/manage");
    }
}

