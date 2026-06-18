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

import com.mycompany.gymcentermanagement.dao.PTRegistrationDAO;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for displaying detailed profile of a Personal Trainer.
 */
@WebServlet(name = "PTDetailController", urlPatterns = {"/pt/detail"})
public class PTDetailController extends HttpServlet {

    private final PersonalTrainerDAO trainerDAO = new PersonalTrainerDAOImpl();
    private final PTRegistrationDAO registrationDAO = new PTRegistrationDAO();

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

        PersonalTrainer trainer = trainerDAO.findById(ptId);

        if (trainer == null
                || !trainer.isActive()
                || !"Active".equalsIgnoreCase(trainer.getAccountStatus())) {
            request.setAttribute("error", "Không tìm thấy thông tin PT hoặc PT hiện không hoạt động.");
            request.getRequestDispatcher("/WEB-INF/views/pt/pt-detail.jsp").forward(request, response);
            return;
        }

        List<PTServicePrice> servicePrices = registrationDAO.findActiveServicePricesByTrainerId(ptId);

        request.setAttribute("trainer", trainer);
        request.setAttribute("servicePrices", servicePrices);
        request.getRequestDispatcher("/WEB-INF/views/pt/pt-detail.jsp").forward(request, response);
    }
}
