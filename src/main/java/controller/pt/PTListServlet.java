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
import java.util.ArrayList;
import java.util.List;
import model.PersonalTrainer;

/**
 *
 * @author phuga
 */

/*
     * Các hàm trong class này:
     *
     * - doGet(): hiển thị danh sách các Personal Trainer đang hoạt động.
     *
     * Luồng xử lý:
     * - tạo danh sách chuyên môn để hiển thị checkbox lọc.
     * - lấy các chuyên môn member/guest đã chọn.
     * - nếu không chọn chuyên môn thì hiển thị tất cả PT đang active.
     * - nếu có chọn chuyên môn thì lọc PT theo chuyên môn đó.
     * - gửi danh sách PT sang trang pt-list.jsp để hiển thị.
 */
@WebServlet(name = "PTListServlet", urlPatterns = {"/pt/list"})
public class PTListServlet extends HttpServlet {

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

        request.getRequestDispatcher("/views/pt/pt-list.jsp").forward(request, response);
    }
}
