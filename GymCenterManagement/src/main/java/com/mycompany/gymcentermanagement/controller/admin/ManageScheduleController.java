package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageScheduleController", urlPatterns = {"/admin/schedule/manage"})
public class ManageScheduleController extends HttpServlet {
    private PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            // GỌI SERVICE
            List<PTRegistrationDTO> pendingRegistrations = ptRegistrationService.getPendingRegistrations();

            req.setAttribute("pendingRegistrations", pendingRegistrations);
            req.getRequestDispatcher("/WEB-INF/views/admin/manage-schedule.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi hệ thống: " + e.getMessage());
        }
    }
}
