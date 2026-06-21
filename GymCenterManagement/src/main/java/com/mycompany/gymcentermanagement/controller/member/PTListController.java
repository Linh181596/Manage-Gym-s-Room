/**
 * =========================================================================
 *
 * @file : PTListController.java
 * @description : Controller xử lý yêu cầu hiển thị danh sách các Huấn luyện viên cá nhân (PT).
 * @author : Nguyễn Đình Phú (phund)
 * @created : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
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

    private final PersonalTrainerDAO trainerDAO = new PersonalTrainerDAOImpl();

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

        // for take keyword to filter
        String keyword = request.getParameter("keyword");

        if (keyword != null) {
            keyword = keyword.trim();

            if (keyword.isEmpty()) {
                keyword = null;
            }
        }

        List<PersonalTrainer> trainers;

        if (keyword == null && selectedSpecializations.isEmpty()) {
            trainers = trainerDAO.findActiveTrainers();
        } else {
            trainers = trainerDAO.searchActiveTrainers(keyword, selectedSpecializations);
        }

        request.setAttribute("trainers", trainers);
        request.setAttribute("trainerCount", trainers.size());
        request.setAttribute("specializationOptions", specializationOptions);
        request.setAttribute("selectedSpecializations", selectedSpecializations);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/pt/pt-list.jsp").forward(request, response);
    }
}
