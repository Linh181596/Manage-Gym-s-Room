package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.FinancialRevenueReportData;
import com.mycompany.gymcentermanagement.dto.RevenueChartFilter;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.FinancialRevenueReportService;
import com.mycompany.gymcentermanagement.service.impl.FinancialRevenueReportServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "FinancialRevenueReportController", urlPatterns = {"/admin/financial-revenue-report"})
public class FinancialRevenueReportController extends HttpServlet {
    
    private final FinancialRevenueReportService reportService = new FinancialRevenueReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ensure only Admin can access
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null || currentUser.getRole() != User.Role.Admin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này.");
            return;
        }

        try {
            RevenueChartFilter revenueFilter = RevenueChartFilter.fromRequest(
                    request.getParameter("revenueRange"),
                    request.getParameter("fromDate"),
                    request.getParameter("toDate"),
                    request.getParameter("revenueType"));
            
            FinancialRevenueReportData reportData = reportService.getReportData(revenueFilter);
            request.setAttribute("reportData", reportData);
            
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Không thể tải dữ liệu báo cáo doanh thu. Vui lòng thử lại sau.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/financial-revenue-report.jsp").forward(request, response);
    }
}
