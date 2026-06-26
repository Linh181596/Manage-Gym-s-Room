/**
 * =========================================================================
 * @file          : PTDetailController.java
 * @description   : Controller xử lý yêu cầu xem chi tiết thông tin và bảng giá dịch vụ của PT.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller for displaying detailed profile of a Personal Trainer.
 */
@WebServlet(name = "PTDetailController", urlPatterns = {"/pt/detail"})
public class PTDetailController extends HttpServlet {

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final PTRegistrationService registrationService = new PTRegistrationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ptIdRaw = request.getParameter("id");

        if (ptIdRaw == null || ptIdRaw.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        int ptId;
        try {
            ptId = Integer.parseInt(ptIdRaw);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        PersonalTrainer trainer = personalTrainerService.getPersonalTrainerById(ptId);

        if (trainer == null) {
            request.setAttribute("error", "Không tìm thấy thông tin PT.");
            request.getRequestDispatcher("/WEB-INF/views/pt/pt-detail.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        boolean isStaffOrAdmin = currentUser != null && (currentUser.getRole() == User.Role.Admin || currentUser.getRole() == User.Role.Staff);

        if (!isStaffOrAdmin && (!trainer.isActive() || !"Active".equalsIgnoreCase(trainer.getAccountStatus()))) {
            request.setAttribute("error", "HLV hiện không hoạt động hoặc tài khoản đã bị khóa.");
            request.getRequestDispatcher("/WEB-INF/views/pt/pt-detail.jsp").forward(request, response);
            return;
        }

        List<PTServicePrice> servicePrices = registrationService.getActiveServicePricesByTrainerId(ptId);

        request.setAttribute("trainer", trainer);
        request.setAttribute("servicePrices", servicePrices);
        request.getRequestDispatcher("/WEB-INF/views/pt/pt-detail.jsp").forward(request, response);
    }
}
