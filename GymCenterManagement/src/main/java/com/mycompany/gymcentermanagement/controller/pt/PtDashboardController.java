package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.dto.PTDashboardData;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTDashboardService;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PTDashboardServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Controller to handle Personal Trainer Dashboard GET requests.
 * Mapped to /pt/dashboard.
 */
@WebServlet(name = "PtDashboardController", urlPatterns = {"/pt/dashboard"})
public class PtDashboardController extends HttpServlet {

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final PTDashboardService ptDashboardService = new PTDashboardServiceImpl();

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
            
            request.getRequestDispatcher("/WEB-INF/views/pt/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }
    }
}

