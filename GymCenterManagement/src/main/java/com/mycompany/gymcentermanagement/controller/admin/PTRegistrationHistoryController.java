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

@WebServlet(name = "PTRegistrationHistoryController", urlPatterns = {"/admin/schedule/registration-history"})
public class PTRegistrationHistoryController extends HttpServlet {

    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            String pageStr = req.getParameter("page");
            int currentPage = 1;
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageStr.trim());
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            List<PTRegistrationDTO> historyList = ptRegistrationService.getProcessedRegistrations(currentPage, PAGE_SIZE);
            int totalCount = ptRegistrationService.getProcessedRegistrationsCount();
            int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
            if (totalPages < 1) {
                totalPages = 1;
            }

            req.setAttribute("historyList", historyList);
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalCount", totalCount);

            req.getRequestDispatcher("/WEB-INF/views/admin/registration-history.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi hệ thống: " + e.getMessage());
        }
    }
}
