package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.dto.PTMemberDTO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "PTMembersController", urlPatterns = {"/pt/members"})
public class PTMembersController extends HttpServlet {

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (currentUser.getRole() != User.Role.PT) {
            request.setAttribute("errorMessage", "Trang này chỉ dành cho huấn luyện viên (PT).");
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        try {
            PersonalTrainer pt = personalTrainerService.getPTByUserId(currentUser.getUserId());
            if (pt == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ huấn luyện viên.");
                return;
            }

            List<PTMemberDTO> membersList = personalTrainerService.getActiveMembersForPT(pt.getPtId());
            request.setAttribute("membersList", membersList);

            request.getRequestDispatcher("/WEB-INF/views/pt/my-members.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
        }
    }
}
