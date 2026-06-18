package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "PTPersonalProfileController", urlPatterns = {"/pt/profile"})
public class PTDetailController extends HttpServlet {
    private final PersonalTrainerService ptService = new PersonalTrainerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin PT từ UserId của session
        PersonalTrainer pt = ptService.getPTByUserId(currentUser.getUserId());
        request.setAttribute("pt", pt);

        // Đẩy sang trang jsp hiển thị thông tin chi tiết (chỉ đọc)
        request.getRequestDispatcher("/WEB-INF/views/pt/profile-detail.jsp").forward(request, response);
    }
}
