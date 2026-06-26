/**
 * =========================================================================
 * @file          : WorkHistoryController.java
 * @description   : Controller điều phối xem lịch sử làm việc của Staff và PT
 *                  (UC 2.3.5).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.StaffPTAttendanceService;
import com.mycompany.gymcentermanagement.service.impl.StaffPTAttendanceServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller for UC 2.3.5 – View Staff & PT Work History.
 * URL: /staff/work-history
 *
 * Quyền truy cập:
 *   - Admin: xem tất cả mọi người
 *   - Staff: xem tất cả mọi người
 *   - PT: chỉ xem lịch sử của chính mình (A2: Access Denied nếu cố xem người khác)
 */
@WebServlet(name = "WorkHistoryController", urlPatterns = {"/staff/work-history"})
public class WorkHistoryController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(WorkHistoryController.class.getName());
    private static final int PAGE_SIZE = 20;
    private final StaffPTAttendanceService attendanceService = new StaffPTAttendanceServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = session != null ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // ---- Đọc bộ lọc từ request ------------------------------------ //
        int filterUserId = parseIntParam(request, "userId", 0);
        String filterRole = request.getParameter("role");    // 'Staff' | 'PT' | null
        String fromStr    = request.getParameter("from");
        String toStr      = request.getParameter("to");
        String keyword    = request.getParameter("keyword");
        int page          = Math.max(1, parseIntParam(request, "page", 1));

        LocalDate fromDate = parseDate(fromStr);
        LocalDate toDate   = parseDate(toStr);

        // A2: PT chỉ được xem lịch sử của chính mình
        if (currentUser.getRole() == User.Role.PT) {
            if (filterUserId != 0 && filterUserId != currentUser.getUserId()) {
                request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                return;
            }
            filterUserId = currentUser.getUserId(); // force filter về chính mình
        }

        // ---- Truy vấn DB ---------------------------------------------- //
        try {
            int total = attendanceService.countHistory(
                    filterUserId, filterRole, fromDate, toDate, keyword);

            int totalPages = (total == 0) ? 1 : (int) Math.ceil((double) total / PAGE_SIZE);
            int offset     = (page - 1) * PAGE_SIZE;

            List<StaffPTAttendance> records = attendanceService.searchHistory(
                    filterUserId, filterRole, fromDate, toDate, keyword, offset, PAGE_SIZE);

            // A1: Empty state
            if (records.isEmpty()) {
                request.setAttribute("emptyMessage", "Không tìm thấy lịch sử phù hợp với bộ lọc.");
            }

            request.setAttribute("historyList", records);
            request.setAttribute("total",       total);
            request.setAttribute("totalPages",  totalPages);
            request.setAttribute("currentPage", page);

        } catch (SQLException ex) {
            // A3: Data Retrieval Error
            LOGGER.log(Level.SEVERE, "Error loading work history", ex);
            request.setAttribute("errorMessage",
                    "Lỗi tải dữ liệu lịch sử. Vui lòng thử lại.");
        }

        // Trả lại các tham số lọc để form hiển thị đúng giá trị đã chọn
        request.setAttribute("filterUserId", filterUserId);
        request.setAttribute("filterRole",   filterRole);
        request.setAttribute("filterFrom",   fromStr);
        request.setAttribute("filterTo",     toStr);
        request.setAttribute("filterKeyword", keyword);
        request.setAttribute("currentUser",  currentUser);

        request.getRequestDispatcher("/WEB-INF/views/staff/work-history.jsp")
               .forward(request, response);
    }

    // ------------------------------------------------------------------ //
    //  Helpers
    // ------------------------------------------------------------------ //

    private int parseIntParam(HttpServletRequest req, String name, int defaultValue) {
        String val = req.getParameter(name);
        if (val == null || val.isBlank()) return defaultValue;
        try { return Integer.parseInt(val); } catch (NumberFormatException e) { return defaultValue; }
    }

    private LocalDate parseDate(String dateStr) {
        if (dateStr == null || dateStr.isBlank()) return null;
        try { return LocalDate.parse(dateStr); } catch (Exception e) { return null; }
    }
}