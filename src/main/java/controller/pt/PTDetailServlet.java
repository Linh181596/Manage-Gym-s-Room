/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PersonalTrainerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.PersonalTrainer;

/**
 *
 * @author phuga
 */
@WebServlet(name = "PTDetailServlet", urlPatterns = {"/pt/detail"})
public class PTDetailServlet extends HttpServlet {

    private final PersonalTrainerDAO trainerDAO = new PersonalTrainerDAO();

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

        if (trainer == null) {
            request.setAttribute("error", "Không tìm thấy thông tin PT.");
            request.getRequestDispatcher("/views/pt/pt-detail.jsp").forward(request, response);
            return;
        }

        request.setAttribute("trainer", trainer);
        request.getRequestDispatcher("/views/pt/pt-detail.jsp").forward(request, response);
    }
}
