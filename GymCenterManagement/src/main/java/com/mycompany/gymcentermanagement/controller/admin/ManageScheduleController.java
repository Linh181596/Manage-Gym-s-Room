package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
@WebServlet(name = "ManageScheduleController", urlPatterns = {"/admin/schedule/manage"})
public class ManageScheduleController extends HttpServlet {
    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            // 1. Get Pending registrations (Tab 1)
            List<PTRegistrationDTO> pendingRegistrations = ptRegistrationService.getPendingRegistrations();
            req.setAttribute("pendingRegistrations", pendingRegistrations);

            // 2. Get PT workout schedules for selected date (Tab 2)
            String selectedDateStr = req.getParameter("date");
            LocalDate selectedDate = (selectedDateStr != null && !selectedDateStr.isEmpty())
                    ? LocalDate.parse(selectedDateStr)
                    : LocalDate.now();

            LocalDate today = LocalDate.now();
            if (selectedDate.isAfter(today)) {
                selectedDate = today;
            }

            List<PTScheduleDetailDTO> schedulesList = ptScheduleService.getAllSchedulesByDate(selectedDate);
            req.setAttribute("schedulesList", schedulesList);
            req.setAttribute("selectedDate", selectedDate.toString());
            req.setAttribute("todayDate", today.toString());

            req.getRequestDispatcher("/WEB-INF/views/admin/manage-schedule.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi hệ thống: " + e.getMessage());
        }
    }
}

