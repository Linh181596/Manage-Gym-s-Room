/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PTRegistrationDAO;
import dao.PersonalTrainerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.PTServicePrice;
import model.PersonalTrainer;

/**
 *
 * @author phuga
 */

/*
     * Các hàm trong class này:
     *
     * - doGet(): hiển thị chi tiết một Personal Trainer.
     *
     * Luồng xử lý:
     * - lấy PTID từ request.
     * - tìm thông tin PT theo PTID.
     * - lấy các gói PT service đang active của PT đó.
     * - gửi dữ liệu sang trang pt-detail.jsp.
     *
     * Ghi chú:
     * - Trang detail là trang public cho guest/member xem.
     * - Member có thể chọn gói PT service từ trang này để đăng ký.
 */
@WebServlet(name = "PTDetailServlet", urlPatterns = {"/pt/detail"})
public class PTDetailServlet extends HttpServlet {

    private final PersonalTrainerDAO trainerDAO = new PersonalTrainerDAO();
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

        if (trainer == null || !trainer.isActive()) {
            request.setAttribute("error", "Không tìm thấy thông tin PT hoặc PT hiện không hoạt động.");
            request.getRequestDispatcher("/views/pt/pt-detail.jsp").forward(request, response);
            return;
        }

        List<PTServicePrice> servicePrices = registrationDAO.findActiveServicePricesByTrainerId(ptId);

        request.setAttribute("trainer", trainer);
        request.setAttribute("servicePrices", servicePrices);
        request.getRequestDispatcher("/views/pt/pt-detail.jsp").forward(request, response);
    }
}
