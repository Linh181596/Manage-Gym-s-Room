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

@WebServlet(name = "WorkHistoryController", urlPatterns = {"/admin/work-history", "/staff/work-history", "/pt/work-history"})
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
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String relativePath = request.getRequestURI().substring(request.getContextPath().length());
        if (!canAccessPath(relativePath, currentUser.getRole())) {
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        int filterUserId = parseIntParam(request, "userId", 0);
        String filterRole = normalizeRole(request.getParameter("role"));
        String filterShift = normalizeShift(request.getParameter("shift"));
        String fromStr = trimToEmpty(request.getParameter("from"));
        String toStr = trimToEmpty(request.getParameter("to"));
        String keyword = trimToEmpty(request.getParameter("keyword"));
        int page = Math.max(1, parseIntParam(request, "page", 1));

        LocalDate fromDate = parseDate(fromStr);
        LocalDate toDate = parseDate(toStr);
        boolean validDateRange = isValidDateRange(fromDate, toDate);
        boolean adminView = currentUser.getRole() == User.Role.Admin;

        if (adminView) {
            filterUserId = 0;
        } else {
            if ((filterUserId != 0 && filterUserId != currentUser.getUserId())
                    || (filterRole != null && !filterRole.equals(currentUser.getRole().name()))) {
                request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                return;
            }
            filterUserId = currentUser.getUserId();
            filterRole = currentUser.getRole().name();
            keyword = "";
        }

        if (!validDateRange) {
            request.setAttribute("errorMessage", "Từ ngày phải trước hoặc bằng đến ngày.");
            setEmptyResultAttributes(request);
        } else {
            try {
                int total = attendanceService.countHistory(
                        filterUserId, filterRole, filterShift, fromDate, toDate, keyword);
                int totalPages = total == 0 ? 1 : (int) Math.ceil((double) total / PAGE_SIZE);
                int currentPage = Math.min(page, totalPages);
                int offset = (currentPage - 1) * PAGE_SIZE;

                List<StaffPTAttendance> records = attendanceService.searchHistory(
                        filterUserId, filterRole, filterShift, fromDate, toDate, keyword, offset, PAGE_SIZE);

                if (records.isEmpty()) {
                    request.setAttribute("emptyMessage", "Không tìm thấy lịch sử phù hợp với bộ lọc.");
                }

                request.setAttribute("historyList", records);
                request.setAttribute("total", total);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", currentPage);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error loading work history", ex);
                request.setAttribute("errorMessage", "Lỗi tải dữ liệu lịch sử. Vui lòng thử lại.");
                setEmptyResultAttributes(request);
            }
        }

        request.setAttribute("filterUserId", filterUserId);
        request.setAttribute("filterRole", filterRole);
        request.setAttribute("filterShift", filterShift);
        request.setAttribute("filterFrom", fromStr);
        request.setAttribute("filterTo", toStr);
        request.setAttribute("filterKeyword", keyword);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("adminView", adminView);
        request.setAttribute("canManageAttendance", adminView);
        request.setAttribute("historyBasePath", relativePath);

        request.getRequestDispatcher("/WEB-INF/views/common/work-history.jsp")
                .forward(request, response);
    }

    private void setEmptyResultAttributes(HttpServletRequest request) {
        request.setAttribute("historyList", List.of());
        request.setAttribute("total", 0);
        request.setAttribute("totalPages", 1);
        request.setAttribute("currentPage", 1);
    }

    private int parseIntParam(HttpServletRequest req, String name, int defaultValue) {
        String val = req.getParameter(name);
        if (val == null || val.isBlank()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(val);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private LocalDate parseDate(String dateStr) {
        if (dateStr == null || dateStr.isBlank()) {
            return null;
        }
        try {
            return LocalDate.parse(dateStr);
        } catch (Exception e) {
            return null;
        }
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private String normalizeRole(String role) {
        if ("Staff".equals(role) || "PT".equals(role)) {
            return role;
        }
        return null;
    }

    private String normalizeShift(String shift) {
        if ("Morning".equals(shift) || "Afternoon".equals(shift) || "Evening".equals(shift)) {
            return shift;
        }
        return null;
    }

    private boolean canAccessPath(String relativePath, User.Role role) {
        return ("/admin/work-history".equals(relativePath) && role == User.Role.Admin)
                || ("/staff/work-history".equals(relativePath) && role == User.Role.Staff)
                || ("/pt/work-history".equals(relativePath) && role == User.Role.PT);
    }

    static boolean isValidDateRange(LocalDate fromDate, LocalDate toDate) {
        return fromDate == null || toDate == null || !fromDate.isAfter(toDate);
    }
}
