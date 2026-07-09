package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "CancelPTSessionController", urlPatterns = {"/admin/schedule/cancel-session"})
public class CancelPTSessionController extends HttpServlet {

    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null || currentUser.getRole() != User.Role.Admin) {
            if (session != null) {
                session.setAttribute("errorMessage", "Chỉ Admin mới có quyền hủy ca dạy học!");
            }
            redirectBack(request, response);
            return;
        }

        String scheduleIdStr = request.getParameter("scheduleId");
        String cancelReason = request.getParameter("cancelReason");

        if (scheduleIdStr == null || scheduleIdStr.trim().isEmpty() || cancelReason == null || cancelReason.trim().isEmpty()) {
            if (session != null) {
                session.setAttribute("errorMessage", "Thông tin yêu cầu hủy ca tập không đầy đủ.");
            }
            redirectBack(request, response);
            return;
        }

        try {
            int scheduleId = Integer.parseInt(scheduleIdStr.trim());
            
            // Perform cancel session in DB
            String updatedBy = currentUser.getFullName() != null ? currentUser.getFullName() : currentUser.getEmail();
            boolean success = ptScheduleService.cancelSession(scheduleId, cancelReason.trim(), currentUser.getUserId(), updatedBy);
            
            if (success) {
                if (session != null) {
                    session.setAttribute("toastMsg", "Đã hủy ca dạy thành công!");
                }
            } else {
                if (session != null) {
                    session.setAttribute("errorMessage", "Không thể hủy ca dạy học này.");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            if (session != null) {
                session.setAttribute("errorMessage", "Mã ca dạy không hợp lệ.");
            }
        }

        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");
        }
    }
}
