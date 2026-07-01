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

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
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

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();

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

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        com.mycompany.gymcentermanagement.model.entity.User currentUser = 
            (session != null) ? (com.mycompany.gymcentermanagement.model.entity.User) session.getAttribute("currentUser") : null;
        boolean isManagement = (currentUser != null && 
            (currentUser.getRole() == com.mycompany.gymcentermanagement.model.entity.User.Role.Admin 
            || currentUser.getRole() == com.mycompany.gymcentermanagement.model.entity.User.Role.Staff));

        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = isManagement ? "All" : "Active";
        }

        List<PersonalTrainer> trainers;

        if (isManagement) {
            trainers = personalTrainerService.searchTrainersForManagement(keyword, selectedSpecializations, status);
        } else {
            if (keyword == null && selectedSpecializations.isEmpty()) {
                trainers = personalTrainerService.getActiveTrainers();
            } else {
                trainers = personalTrainerService.searchActiveTrainers(keyword, selectedSpecializations);
            }
        }

        // Pagination (6 trainers per page)
        int page = 1;
        String pageRaw = request.getParameter("page");
        if (pageRaw != null && !pageRaw.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageRaw);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int pageSize = 6;
        int totalTrainers = trainers.size();
        int totalPages = (int) Math.ceil((double) totalTrainers / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalTrainers);
        List<PersonalTrainer> paginatedTrainers = new ArrayList<>();
        if (start < totalTrainers) {
            paginatedTrainers = trainers.subList(start, end);
        }

        request.setAttribute("trainers", paginatedTrainers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalTrainers", totalTrainers);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("specializationOptions", specializationOptions);
        request.setAttribute("selectedSpecializations", selectedSpecializations);
        request.setAttribute("keyword", keyword);
        request.setAttribute("isManagement", isManagement);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/WEB-INF/views/pt/pt-list.jsp").forward(request, response);
    }
}
