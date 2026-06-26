/**
 * =========================================================================
 * @file          : AdminDashboardController.java
 * @description   : Controller tải dữ liệu tổng quan vận hành cho màn hình bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.AdminDashboardData;
import com.mycompany.gymcentermanagement.service.DashboardService;
import com.mycompany.gymcentermanagement.service.impl.DashboardServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Controller to handle Admin Dashboard GET requests.
 * Mapped to /admin/dashboard.
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {
    private final DashboardService dashboardService = new DashboardServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            AdminDashboardData dashboardData = dashboardService.getAdminDashboardData();
            request.setAttribute("dashboardData", dashboardData);
        } catch (SQLException ex) {
            request.setAttribute("dashboardLoadError", "Không thể tải dữ liệu bảng điều khiển. Vui lòng thử lại.");
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
