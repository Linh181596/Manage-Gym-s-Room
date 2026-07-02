/**
 * =========================================================================
 * @file          : MemberDashboardController.java
 * @description   : Controller xử lý trang tổng quan/dashboard của hội viên.
 * @author        : Nguyen Dai Duong (duongnd)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.dto.MemberDashboardData;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.MemberDashboardService;
import com.mycompany.gymcentermanagement.service.impl.MemberDashboardServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Controller to handle Member Dashboard GET requests.
 * Mapped to /member/dashboard.
 */
@WebServlet(name = "MemberDashboardController", urlPatterns = {"/member/dashboard"})
public class MemberDashboardController extends HttpServlet {

    private final MemberDAO memberDAO = new MemberDAOImpl();
    private final MemberDashboardService dashboardService = new MemberDashboardServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (currentUser.getRole() != User.Role.Member) {
            request.setAttribute("errorMessage", "Trang này chỉ dành cho hội viên (Member).");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }
        
        try {
            Member member = memberDAO.findByUserId(currentUser.getUserId());
            if (member == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin hội viên.");
                return;
            }
            
            MemberDashboardData data = dashboardService.getMemberDashboardData(member.getMemberId(), currentUser.getUserId());
            request.setAttribute("dashboardData", data);
            
            request.getRequestDispatcher("/WEB-INF/views/member/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        }
    }
}
