/**
 * =========================================================================
 * @file          : MemberPortalController.java
 * @description   : Controller xử lý trang tổng quan của hội viên sau khi đăng nhập.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.GymDAO;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller to handle Member Portal GET requests (UC10).
 * Mapped to /member/portal.
 */
@WebServlet(name = "MemberPortalController", urlPatterns = {"/member/portal"})
public class MemberPortalController extends HttpServlet {

    private final GymDAO gymDAO = new GymDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = currentUser.getUserId();
        String viewMemberIdStr = request.getParameter("viewMemberId");
        
        if (viewMemberIdStr != null && !viewMemberIdStr.trim().isEmpty()) {
            // Staff and Admin are allowed to view other members' profiles
            if (currentUser.getRole() != User.Role.Staff && currentUser.getRole() != User.Role.Admin) {
                request.setAttribute("errorMessage", "Bạn không có quyền xem thông tin của hội viên khác.");
                request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                return;
            }
            try {
                userId = Integer.parseInt(viewMemberIdStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid member ID format");
                return;
            }
        } else if (currentUser.getRole() != User.Role.Member) {
            // Staff/Admin accessing /member/portal directly without viewMemberId parameter
            request.setAttribute("errorMessage", "Vui lòng chọn một hội viên cụ thể từ danh sách quản lý để xem.");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }
        
        Map<String, String> profile = gymDAO.getMemberProfile(userId);
        List<Map<String, String>> services = gymDAO.getMemberServices(userId);
        
        request.setAttribute("memberProfile", profile);
        request.setAttribute("memberServices", services);
        
        request.getRequestDispatcher("/WEB-INF/views/member/portal.jsp").forward(request, response);
    }
}
