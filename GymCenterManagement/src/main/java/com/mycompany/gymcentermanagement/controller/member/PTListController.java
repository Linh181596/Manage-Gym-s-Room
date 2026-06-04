package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for listing Personal Trainers with specialization filter.
 */
@WebServlet(name = "PTListController", urlPatterns = {"/pt/list"})
public class PTListController extends HttpServlet {

    private final PersonalTrainerDAO trainerDAO = new PersonalTrainerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> specializationOptions = List.of(
                "Quản lý cân nặng",
                "Tăng cơ",
                "Cardio",
                "Yoga",
                "Boxing",
                "Dinh dưỡng",
                "Phục hồi thể lực"
        );

        String[] selectedArray = request.getParameterValues("specializations");
        List<String> selectedSpecializations = new ArrayList<>();

        if (selectedArray != null) {
            for (String specialization : selectedArray) {
                if (specializationOptions.contains(specialization)) {
                    selectedSpecializations.add(specialization);
                }
            }
        }

        List<PersonalTrainer> trainers;

        if (selectedSpecializations.isEmpty()) {
            trainers = trainerDAO.findActiveTrainers();
        } else {
            trainers = trainerDAO.findActiveTrainersBySpecializations(selectedSpecializations);
        }

        request.setAttribute("trainers", trainers);
        request.setAttribute("trainerCount", trainers.size());
        request.setAttribute("specializationOptions", specializationOptions);
        request.setAttribute("selectedSpecializations", selectedSpecializations);

        request.getRequestDispatcher("/WEB-INF/views/pt/pt-list.jsp").forward(request, response);
    }
}
