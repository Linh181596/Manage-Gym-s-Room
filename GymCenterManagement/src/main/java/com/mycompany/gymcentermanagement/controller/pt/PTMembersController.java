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
import java.util.List;

@WebServlet(name = "PTMembersController", urlPatterns = { "/pt/members" })
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

            // Pagination using PaginationHelper
            int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"),
                    1);
            int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                    com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"),
                            10));

            int totalItems = personalTrainerService.getActiveMembersForPTCount(pt.getPtId());
            int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
            page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
            int offset = (page - 1) * pageSize;

            List<PTMemberDTO> membersList = personalTrainerService.getActiveMembersForPTPaginated(pt.getPtId(), offset,
                    pageSize);
            request.setAttribute("membersList", membersList);

            String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                    request, "/pt/members", "pageSize", String.valueOf(pageSize));

            com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                    request, page, pageSize, totalItems, queryBase, "hội viên");

            request.getRequestDispatcher("/WEB-INF/views/pt/my-members.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
        }
    }
}
