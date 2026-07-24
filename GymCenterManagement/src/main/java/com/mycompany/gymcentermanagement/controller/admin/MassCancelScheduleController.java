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
import java.time.LocalDate;

@WebServlet(name = "MassCancelScheduleController", urlPatterns = {"/admin/schedule/mass-cancel"})
public class MassCancelScheduleController extends HttpServlet {

    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        // Chỉ Admin được phép thực hiện chức năng này
        if (currentUser == null || currentUser.getRole() != User.Role.Admin) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String cancelDateStr = request.getParameter("cancelDate");
        String cancelSlot = request.getParameter("cancelSlot");
        String reason = request.getParameter("reason");

        if (cancelDateStr == null || cancelDateStr.isBlank()) {
            session.setAttribute("errorMessage", "Vui lòng chọn ngày cần hủy.");
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?activeTab=attendance");
            return;
        }

        if (reason == null || reason.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng nhập lý do hủy ca hàng loạt.");
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?date=" + cancelDateStr + "&activeTab=attendance");
            return;
        }

        try {
            LocalDate cancelDate = LocalDate.parse(cancelDateStr);
            
            java.sql.Time startTime = null;
            java.sql.Time endTime = null;
            String slotLabel = "Tất cả các ca";
            
            if (cancelSlot != null && !cancelSlot.isBlank() && !"All".equalsIgnoreCase(cancelSlot)) {
                com.mycompany.gymcentermanagement.utils.PTFixedSlotHelper.FixedSlot slot = 
                        com.mycompany.gymcentermanagement.utils.PTFixedSlotHelper.parseSlot(cancelSlot);
                if (slot != null) {
                    startTime = slot.startTime();
                    endTime = slot.endTime();
                    slotLabel = "Ca " + cancelSlot;
                }
            }

            String prefix = (cancelSlot == null || cancelSlot.isBlank() || "All".equalsIgnoreCase(cancelSlot)) ? "MC_ALL: " : "MC_SLOT: ";
            String updatedBy = prefix + currentUser.getFullName();
            if (updatedBy.length() > 50) {
                updatedBy = updatedBy.substring(0, 50);
            }
            
            int cancelledCount = ptScheduleService.massCancelSessions(
                    cancelDate,
                    startTime,
                    endTime,
                    reason.trim(),
                    currentUser.getUserId(),
                    updatedBy
            );

            if (cancelledCount > 0) {
                session.setAttribute("toastMsg", "Đã hủy thành công " + cancelledCount + " ca tập thuộc " + slotLabel + " ngày " + cancelDateStr + "!");
            } else if (cancelledCount == 0) {
                session.setAttribute("toastMsg", "Không tìm thấy ca tập nào ở trạng thái Upcoming thuộc " + slotLabel + " ngày " + cancelDateStr + " để hủy.");
            } else {
                session.setAttribute("errorMessage", "Hủy hàng loạt thất bại do lỗi hệ thống.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi xử lý: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?date=" + cancelDateStr + "&activeTab=attendance");
    }
}
