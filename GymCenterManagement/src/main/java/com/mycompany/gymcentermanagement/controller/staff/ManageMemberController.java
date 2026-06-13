/**
 * =========================================================================
 * @file          : ManageMemberController.java
 * @description   : Controller điều phối các hoạt động quản lý danh sách và trạng thái hội viên.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Trí Linh
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.dao.GymDAO;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller to handle Member Management for Staff role (UC09).
 * Mapped to /staff/members and its sub-paths.
 */
@WebServlet(name = "ManageMemberController", urlPatterns = {
    "/staff/members",
    "/staff/members/add",
    "/staff/members/toggle",
    "/staff/members/delete",
    "/staff/members/notify"
})
public class ManageMemberController extends HttpServlet {

    private final GymDAO gymDAO = new GymDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/staff/members/toggle".equals(servletPath)) {
            toggleMemberStatus(request, response);
        } else if ("/staff/members/delete".equals(servletPath)) {
            deleteMember(request, response);
        } else if ("/staff/members/notify".equals(servletPath)) {
            sendQuickNotification(request, response);
        } else {
            showMemberList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/staff/members/add".equals(servletPath)) {
            addMember(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void showMemberList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("searchKeyword");
        String memberType = request.getParameter("memberType");
        
        List<Map<String, String>> memberList = gymDAO.getMembers(keyword, memberType);
        
        request.setAttribute("memberList", memberList);
        request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
    }

    private void addMember(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");
        // Server-side validation
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Họ tên và email không được để trống.");
            showMemberList(request, response);
            return;
        }

        if (phone != null && !phone.trim().isEmpty()) {
            String trimmedPhone = phone.trim();
            if (!trimmedPhone.matches("^0[0-9]{9}$")) {
                request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Số điện thoại phải bắt đầu bằng số 0 và gồm đúng 10 chữ số.");
                showMemberList(request, response);
                return;
            }
        }

        boolean success = gymDAO.addMember(name, email, phone, type);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/staff/members");
        } else {
            request.setAttribute("errorMessage", "Không thể thêm hội viên mới. Vui lòng kiểm tra lại email hoặc số điện thoại.");
            showMemberList(request, response);
        }
    }

    private void toggleMemberStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String targetStatus = request.getParameter("targetStatus");
            gymDAO.updateMemberStatus(userId, targetStatus);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }

    private void deleteMember(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            gymDAO.deleteMember(userId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }

    private void sendQuickNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser != null) {
            try {
                int targetUserId = Integer.parseInt(request.getParameter("userId"));
                String title = "Nhắc gia hạn gói tập";
                String content = "Hội viên #" + targetUserId + " vui lòng kiểm tra và gia hạn gói tập nếu sắp hết hạn.";
                gymDAO.createNotification(currentUser.getUserId(), title, content, "Member");
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff/members");
    }
}
