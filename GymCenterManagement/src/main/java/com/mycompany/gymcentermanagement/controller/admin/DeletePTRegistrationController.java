package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DeletePTRegistrationController", urlPatterns = {"/admin/schedule/registration-delete"})
public class DeletePTRegistrationController extends HttpServlet {

    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            User currentUser = (User) req.getSession().getAttribute("currentUser");
            if (currentUser == null || currentUser.getRole() != User.Role.Admin) {
                req.getSession().setAttribute("toastMsg", "Chỉ Admin mới có quyền xóa đơn đăng ký!");
                resp.sendRedirect(req.getContextPath() + "/admin/schedule/registration-history");
                return;
            }

            String regIdStr = req.getParameter("regId");
            if (regIdStr == null || regIdStr.trim().isEmpty()) {
                req.getSession().setAttribute("toastMsg", "Mã đơn không hợp lệ!");
                resp.sendRedirect(req.getContextPath() + "/admin/schedule/registration-history");
                return;
            }

            int regId = Integer.parseInt(regIdStr.trim());
            PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);
            if (reg == null) {
                req.getSession().setAttribute("toastMsg", "Đơn đăng ký không tồn tại!");
                resp.sendRedirect(req.getContextPath() + "/admin/schedule/registration-history");
                return;
            }

            // Check if status is Active or Pending
            if ("Active".equalsIgnoreCase(reg.getStatus()) || "Pending".equalsIgnoreCase(reg.getStatus())) {
                req.getSession().setAttribute("toastMsg", "Không thể xóa đơn đăng ký đang hoạt động hoặc chờ duyệt!");
                resp.sendRedirect(req.getContextPath() + "/admin/schedule/registration-history");
                return;
            }

            boolean success = ptRegistrationService.deleteRegistrationPermanent(regId);
            if (success) {
                req.getSession().setAttribute("toastMsg", "Xóa đơn đăng ký #" + regId + " thành công!");
            } else {
                req.getSession().setAttribute("toastMsg", "Không thể xóa đơn đăng ký này!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/schedule/registration-history");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi xử lý xóa đơn: " + e.getMessage());
        }
    }
}
