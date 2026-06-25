package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CancelPTRegistrationController", urlPatterns = {"/admin/pt/cancel"})
public class CancelPTRegistrationController extends HttpServlet {
    private PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            int regId = Integer.parseInt(request.getParameter("regId"));
            String cancelReason = request.getParameter("cancelReason");

            if (cancelReason == null || cancelReason.trim().isEmpty()) {
                throw new Exception("Lý do hủy không được để trống!");
            }

            User currentUser = (User) request.getSession().getAttribute("currentUser");
            int adminId = (currentUser != null) ? currentUser.getUserId() : 1;
            String username = (currentUser != null) ? currentUser.getFullName() : "admin";

            PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);
            if (reg == null) {
                throw new Exception("Đơn đăng ký không tồn tại!");
            }
            if ("Active".equalsIgnoreCase(reg.getStatus())) {
                request.getSession().setAttribute("toastMsg", "Không thể hủy đơn đăng ký đã ở trạng thái Hoạt động!");
                response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");
                return;
            }

            boolean success = ptRegistrationService.cancelRegistration(regId, cancelReason.trim(), adminId, username);

            if (success) {
                request.getSession().setAttribute("toastMsg", "Hủy đơn đăng ký #" + regId + " thành công!");
            } else {
                request.getSession().setAttribute("toastMsg", "Không thể hủy đơn đăng ký #" + regId + "!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý hủy đơn: " + e.getMessage());
        }
    }
}
