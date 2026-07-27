package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.StaffPTAttendanceService;
import com.mycompany.gymcentermanagement.service.impl.StaffPTAttendanceServiceImpl;
import com.mycompany.gymcentermanagement.utils.PaginationHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "WorkHistoryController", urlPatterns = {"/admin/work-history", "/staff/work-history", "/pt/work-history"})
public class WorkHistoryController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(WorkHistoryController.class.getName());
    private static final int PAGE_SIZE = 10;
    private static final int ADMIN_PAGE_SIZE = 10;
    private static final String STATUS_IN_SHIFT = "InShift";
    private static final String STATUS_COMPLETED = "Completed";
    private static final String STATUS_LATE = "Late";
    private static final String STATUS_EARLY_LEAVE = "EarlyLeave";
    private static final String STATUS_NO_RECORD = "NoRecord";
    private static final String STATUS_MISSING_CHECKOUT = "MissingCheckout";
    private static final String STATUS_UPCOMING = "Upcoming";

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

        boolean adminView = currentUser.getRole() == User.Role.Admin;
        if (adminView) {
            showAdminWorkHistory(request, response, relativePath, currentUser);
            return;
        }

        int filterUserId = parseIntParam(request, "userId", 0);
        String filterRole = normalizeRole(request.getParameter("role"));
        String filterShift = normalizeShift(request.getParameter("shift"));
        String fromStr = trimToEmpty(request.getParameter("from"));
        String toStr = trimToEmpty(request.getParameter("to"));
        String keyword = trimToEmpty(request.getParameter("keyword"));
        String selectedWorkStatus = normalizeWorkStatus(request.getParameter("status"));
        int page = Math.max(1, parseIntParam(request, "page", 1));

        LocalDate fromDate = parseDate(fromStr);
        LocalDate toDate = parseDate(toStr);
        boolean validDateRange = isValidDateRange(fromDate, toDate);

        if ((filterUserId != 0 && filterUserId != currentUser.getUserId())
                || (filterRole != null && !filterRole.equals(currentUser.getRole().name()))) {
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }
        filterUserId = currentUser.getUserId();
        filterRole = currentUser.getRole().name();
        keyword = "";

        if (!validDateRange) {
            request.setAttribute("errorMessage", "Từ ngày phải trước hoặc bằng đến ngày.");
            setEmptyResultAttributes(request);
        } else {
            try {
                int rawTotal = attendanceService.countHistory(
                        filterUserId, filterRole, filterShift, fromDate, toDate, keyword);
                List<StaffPTAttendance> records = rawTotal == 0
                        ? List.of()
                        : attendanceService.searchHistory(
                                filterUserId, filterRole, filterShift, fromDate, toDate, keyword, 0, rawTotal);
                applyWorkStatuses(records);
                request.setAttribute("statusStats", buildSelfStatusStats(
                        request, relativePath, records, filterShift, fromStr, toStr, selectedWorkStatus));

                List<StaffPTAttendance> filteredRecords = filterByWorkStatus(records, selectedWorkStatus);
                int totalItems = filteredRecords.size();
                int totalPages = PaginationHelper.totalPages(totalItems, PAGE_SIZE);
                int currentPage = PaginationHelper.normalizePage(page, totalPages);
                int offset = (currentPage - 1) * PAGE_SIZE;
                List<StaffPTAttendance> pageRecords = filteredRecords.subList(
                        Math.min(offset, totalItems),
                        Math.min(offset + PAGE_SIZE, totalItems));

                if (pageRecords.isEmpty()) {
                    request.setAttribute("emptyMessage", "Không tìm thấy lịch sử phù hợp với bộ lọc.");
                }

                String queryBase = PaginationHelper.buildQueryBase(
                        request,
                        relativePath,
                        "shift", filterShift,
                        "from", fromStr,
                        "to", toStr,
                        "status", selectedWorkStatus,
                        "pageSize", String.valueOf(PAGE_SIZE));
                PaginationHelper.setPaginationAttributes(
                        request, currentPage, PAGE_SIZE, totalItems, queryBase, "bản ghi");

                request.setAttribute("historyList", pageRecords);
                request.setAttribute("total", totalItems);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("pageSize", PAGE_SIZE);
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
        request.setAttribute("selectedWorkStatus", selectedWorkStatus);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("adminView", adminView);
        request.setAttribute("canManageAttendance", adminView);
        request.setAttribute("historyBasePath", relativePath);

        request.getRequestDispatcher("/WEB-INF/views/common/work-history.jsp")
                .forward(request, response);
    }

    private void showAdminWorkHistory(HttpServletRequest request, HttpServletResponse response,
                                      String relativePath, User currentUser)
            throws ServletException, IOException {
        String filterRole = normalizeRole(request.getParameter("role"));
        String selectedShift = normalizeShift(request.getParameter("shift"));
        if (selectedShift == null) {
            selectedShift = "Morning";
        }

        String dateStr = trimToEmpty(request.getParameter("date"));
        LocalDate selectedDate = parseDate(dateStr);
        if (selectedDate == null) {
            selectedDate = LocalDate.now();
            dateStr = selectedDate.toString();
        }
        String keyword = trimToEmpty(request.getParameter("keyword"));
        String selectedWorkStatus = normalizeWorkStatus(request.getParameter("status"));
        int page = Math.max(1, PaginationHelper.parseInt(request.getParameter("page"), 1));

        try {
            List<StaffPTAttendance> records = attendanceService.getCheckinStatusList(selectedShift, selectedDate, keyword);
            records = filterByRole(records, filterRole);
            applyWorkStatuses(records, selectedDate, selectedShift);
            request.setAttribute("statusStats", buildStatusStats(
                    request, relativePath, records, filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));

            List<StaffPTAttendance> filteredRecords = filterByWorkStatus(records, selectedWorkStatus);
            int totalItems = filteredRecords.size();
            int totalPages = PaginationHelper.totalPages(totalItems, ADMIN_PAGE_SIZE);
            int currentPage = PaginationHelper.normalizePage(page, totalPages);
            int offset = (currentPage - 1) * ADMIN_PAGE_SIZE;
            List<StaffPTAttendance> pageRecords = filteredRecords.subList(
                    Math.min(offset, totalItems),
                    Math.min(offset + ADMIN_PAGE_SIZE, totalItems));

            if (pageRecords.isEmpty()) {
                request.setAttribute("emptyMessage", "Không tìm thấy nhân viên hoặc huấn luyện viên phù hợp.");
            }

            String queryBase = PaginationHelper.buildQueryBase(
                    request,
                    relativePath,
                    "role", filterRole,
                    "shift", selectedShift,
                    "date", dateStr,
                    "keyword", keyword,
                    "status", selectedWorkStatus,
                    "pageSize", String.valueOf(ADMIN_PAGE_SIZE));
            PaginationHelper.setPaginationAttributes(
                    request, currentPage, ADMIN_PAGE_SIZE, totalItems, queryBase, "nhân sự");

            request.setAttribute("historyList", pageRecords);
            request.setAttribute("total", totalItems);
            request.setAttribute("currentPage", currentPage);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading admin work history", ex);
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu lịch sử. Vui lòng thử lại.");
            setEmptyResultAttributes(request);
        }

        request.setAttribute("filterRole", filterRole);
        request.setAttribute("filterShift", selectedShift);
        request.setAttribute("selectedShift", selectedShift);
        request.setAttribute("selectedDate", dateStr);
        request.setAttribute("selectedWorkStatus", selectedWorkStatus);
        request.setAttribute("shiftWindow", getShiftWindowLabel(selectedShift));
        request.setAttribute("filterKeyword", keyword);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("adminView", true);
        request.setAttribute("canManageAttendance", true);
        request.setAttribute("historyBasePath", relativePath);

        request.getRequestDispatcher("/WEB-INF/views/common/work-history.jsp")
                .forward(request, response);
    }

    private List<StaffPTAttendance> filterByRole(List<StaffPTAttendance> records, String filterRole) {
        if (filterRole == null || filterRole.isBlank()) {
            return records;
        }

        List<StaffPTAttendance> filtered = new ArrayList<>();
        for (StaffPTAttendance record : records) {
            if (record.getUserRole() != null && filterRole.equals(record.getUserRole().name())) {
                filtered.add(record);
            }
        }
        return filtered;
    }

    private List<StaffPTAttendance> filterByWorkStatus(List<StaffPTAttendance> records, String selectedWorkStatus) {
        if (selectedWorkStatus == null || selectedWorkStatus.isBlank()) {
            return records;
        }

        List<StaffPTAttendance> filtered = new ArrayList<>();
        for (StaffPTAttendance record : records) {
            if (hasWorkStatus(record, selectedWorkStatus)) {
                filtered.add(record);
            }
        }
        return filtered;
    }

    private List<WorkStatusSummary> buildStatusStats(HttpServletRequest request, String relativePath,
                                                     List<StaffPTAttendance> records,
                                                     String filterRole, String selectedShift,
                                                     String dateStr, String keyword,
                                                     String selectedWorkStatus) {
        List<WorkStatusSummary> stats = new ArrayList<>();
        stats.add(createStatusSummary(request, relativePath, "", "Tất cả", records.size(),
                "bg-dark", "fa-users", filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_IN_SHIFT, "Đang trong ca",
                countStatus(records, STATUS_IN_SHIFT), "bg-success", "fa-user-check",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_COMPLETED, "Đã hoàn thành ca",
                countStatus(records, STATUS_COMPLETED), "bg-primary", "fa-clipboard-check",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_LATE, "Đi muộn",
                countStatus(records, STATUS_LATE), "bg-warning text-dark", "fa-clock",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_EARLY_LEAVE, "Về sớm",
                countStatus(records, STATUS_EARLY_LEAVE), "bg-warning text-dark", "fa-sign-out-alt",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_NO_RECORD, "Không có bản ghi",
                countStatus(records, STATUS_NO_RECORD), "bg-secondary", "fa-minus-circle",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_MISSING_CHECKOUT, "Quên Check-out",
                countStatus(records, STATUS_MISSING_CHECKOUT), "bg-danger", "fa-exclamation-triangle",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        stats.add(createStatusSummary(request, relativePath, STATUS_UPCOMING, "Chưa diễn ra",
                countStatus(records, STATUS_UPCOMING), "bg-secondary", "fa-hourglass-half",
                filterRole, selectedShift, dateStr, keyword, selectedWorkStatus));
        return stats;
    }

    private WorkStatusSummary createStatusSummary(HttpServletRequest request, String relativePath,
                                                  String key, String label, int count,
                                                  String badgeClass, String iconClass,
                                                  String filterRole, String selectedShift,
                                                  String dateStr, String keyword,
                                                  String selectedWorkStatus) {
        String queryBase = PaginationHelper.buildQueryBase(
                request,
                relativePath,
                "role", filterRole,
                "shift", selectedShift,
                "date", dateStr,
                "keyword", keyword,
                "status", key,
                "pageSize", String.valueOf(ADMIN_PAGE_SIZE));
        boolean active = key == null || key.isBlank()
                ? selectedWorkStatus == null || selectedWorkStatus.isBlank()
                : key.equals(selectedWorkStatus);
        return new WorkStatusSummary(key, label, count, badgeClass, iconClass, queryBase + "page=1", active);
    }

    private int countStatus(List<StaffPTAttendance> records, String key) {
        int count = 0;
        for (StaffPTAttendance record : records) {
            if (hasWorkStatus(record, key)) {
                count++;
            }
        }
        return count;
    }

    private boolean hasWorkStatus(StaffPTAttendance record, String key) {
        return key != null
                && record.getWorkStatusKeys() != null
                && record.getWorkStatusKeys().contains("," + key + ",");
    }

    private void applyWorkStatuses(List<StaffPTAttendance> records, LocalDate selectedDate, String selectedShift) {
        ShiftWindow window = getShiftWindow(selectedShift);
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime shiftStartAt = LocalDateTime.of(selectedDate, window.shiftStart());
        LocalDateTime shiftEndAt = LocalDateTime.of(selectedDate, window.shiftEnd());

        for (StaffPTAttendance record : records) {
            record.setAttendanceDate(selectedDate);
            if (record.getShiftBlock() == null) {
                record.setShiftBlock(selectedShift);
            }
            applyWorkStatus(record, window, now, shiftStartAt, shiftEndAt);
        }
    }

    private void applyWorkStatuses(List<StaffPTAttendance> records) {
        LocalDateTime now = LocalDateTime.now();
        for (StaffPTAttendance record : records) {
            String shift = record.getShiftBlock() == null ? "Morning" : record.getShiftBlock().name();
            LocalDate date = record.getAttendanceDate();
            if (date == null && record.getCheckedInAt() != null) {
                date = record.getCheckedInAt().toLocalDate();
                record.setAttendanceDate(date);
            }
            if (date == null) {
                date = LocalDate.now();
                record.setAttendanceDate(date);
            }

            ShiftWindow window = getShiftWindow(shift);
            applyWorkStatus(
                    record,
                    window,
                    now,
                    LocalDateTime.of(date, window.shiftStart()),
                    LocalDateTime.of(date, window.shiftEnd()));
        }
    }

    private List<WorkStatusSummary> buildSelfStatusStats(HttpServletRequest request, String relativePath,
                                                         List<StaffPTAttendance> records,
                                                         String filterShift, String fromStr, String toStr,
                                                         String selectedWorkStatus) {
        List<WorkStatusSummary> stats = new ArrayList<>();
        stats.add(createSelfStatusSummary(request, relativePath, "", "Tất cả", records.size(),
                "bg-dark", "fa-list", filterShift, fromStr, toStr, selectedWorkStatus));
        stats.add(createSelfStatusSummary(request, relativePath, STATUS_IN_SHIFT, "Đang trong ca",
                countStatus(records, STATUS_IN_SHIFT), "bg-success", "fa-user-check",
                filterShift, fromStr, toStr, selectedWorkStatus));
        stats.add(createSelfStatusSummary(request, relativePath, STATUS_COMPLETED, "Đã hoàn thành ca",
                countStatus(records, STATUS_COMPLETED), "bg-primary", "fa-clipboard-check",
                filterShift, fromStr, toStr, selectedWorkStatus));
        stats.add(createSelfStatusSummary(request, relativePath, STATUS_LATE, "Đi muộn",
                countStatus(records, STATUS_LATE), "bg-warning text-dark", "fa-clock",
                filterShift, fromStr, toStr, selectedWorkStatus));
        stats.add(createSelfStatusSummary(request, relativePath, STATUS_EARLY_LEAVE, "Về sớm",
                countStatus(records, STATUS_EARLY_LEAVE), "bg-warning text-dark", "fa-sign-out-alt",
                filterShift, fromStr, toStr, selectedWorkStatus));
        stats.add(createSelfStatusSummary(request, relativePath, STATUS_MISSING_CHECKOUT, "Quên Check-out",
                countStatus(records, STATUS_MISSING_CHECKOUT), "bg-danger", "fa-exclamation-triangle",
                filterShift, fromStr, toStr, selectedWorkStatus));
        return stats;
    }

    private WorkStatusSummary createSelfStatusSummary(HttpServletRequest request, String relativePath,
                                                      String key, String label, int count,
                                                      String badgeClass, String iconClass,
                                                      String filterShift, String fromStr, String toStr,
                                                      String selectedWorkStatus) {
        String queryBase = PaginationHelper.buildQueryBase(
                request,
                relativePath,
                "shift", filterShift,
                "from", fromStr,
                "to", toStr,
                "status", key,
                "pageSize", String.valueOf(PAGE_SIZE));
        boolean active = key == null || key.isBlank()
                ? selectedWorkStatus == null || selectedWorkStatus.isBlank()
                : key.equals(selectedWorkStatus);
        return new WorkStatusSummary(key, label, count, badgeClass, iconClass, queryBase + "page=1", active);
    }

    private void applyWorkStatus(StaffPTAttendance record, ShiftWindow window, LocalDateTime now,
                                 LocalDateTime shiftStartAt, LocalDateTime shiftEndAt) {
        if (record.getAttendanceId() <= 0) {
            if (!now.isBefore(shiftEndAt)) {
                setWorkStatus(record, STATUS_NO_RECORD, "Không có bản ghi", "bg-secondary", "fa-minus-circle");
            } else {
                setWorkStatus(record, STATUS_UPCOMING, "Chưa diễn ra", "bg-secondary", "fa-hourglass-half");
            }
            return;
        }

        LocalDateTime checkedInAt = record.getCheckedInAt();
        LocalDateTime checkedOutAt = record.getCheckedOutAt();
        boolean late = checkedInAt != null && checkedInAt.toLocalTime().isAfter(window.shiftStart().plusMinutes(5));

        if (checkedInAt != null && checkedOutAt == null) {
            if (!now.isBefore(shiftEndAt)) {
                setWorkStatus(record, STATUS_MISSING_CHECKOUT, "Quên Check-out", "bg-danger", "fa-exclamation-triangle");
            } else if (late) {
                setWorkStatus(record, STATUS_LATE, "Đi muộn", "bg-warning text-dark", "fa-clock");
            } else {
                setWorkStatus(record, STATUS_IN_SHIFT, "Đang trong ca", "bg-success", "fa-user-check");
            }
            return;
        }

        boolean earlyLeave = checkedOutAt != null && checkedOutAt.toLocalTime().isBefore(window.shiftEnd());

        if (late && earlyLeave) {
            setWorkStatus(record, STATUS_LATE + "," + STATUS_EARLY_LEAVE,
                    "Đi muộn, Về sớm", "bg-warning text-dark", "fa-clock");
        } else if (late) {
            setWorkStatus(record, STATUS_LATE, "Đi muộn", "bg-warning text-dark", "fa-clock");
        } else if (earlyLeave) {
            setWorkStatus(record, STATUS_EARLY_LEAVE, "Về sớm", "bg-warning text-dark", "fa-sign-out-alt");
        } else {
            setWorkStatus(record, STATUS_COMPLETED, "Đã hoàn thành ca", "bg-primary", "fa-clipboard-check");
        }
    }

    private void setWorkStatus(StaffPTAttendance record, String key, String label, String badgeClass, String iconClass) {
        record.setWorkStatusKey(key);
        record.setWorkStatusKeys("," + key + ",");
        record.setWorkStatusLabel(label);
        record.setWorkStatusBadgeClass(badgeClass);
        record.setWorkStatusIconClass(iconClass);
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

    private String normalizeWorkStatus(String status) {
        if (STATUS_IN_SHIFT.equals(status)
                || STATUS_COMPLETED.equals(status)
                || STATUS_LATE.equals(status)
                || STATUS_EARLY_LEAVE.equals(status)
                || STATUS_NO_RECORD.equals(status)
                || STATUS_MISSING_CHECKOUT.equals(status)
                || STATUS_UPCOMING.equals(status)) {
            return status;
        }
        return null;
    }

    private static ShiftWindow getShiftWindow(String shift) {
        return switch (shift) {
            case "Afternoon" -> new ShiftWindow(LocalTime.of(13, 15), LocalTime.of(16, 45));
            case "Evening" -> new ShiftWindow(LocalTime.of(17, 0), LocalTime.of(20, 30));
            default -> new ShiftWindow(LocalTime.of(8, 0), LocalTime.of(12, 0));
        };
    }

    private static String getShiftWindowLabel(String shift) {
        ShiftWindow window = getShiftWindow(shift);
        return formatTime(window.shiftStart()) + "-" + formatTime(window.shiftEnd());
    }

    private static String formatTime(LocalTime time) {
        return String.format("%02d:%02d", time.getHour(), time.getMinute());
    }

    private record ShiftWindow(LocalTime shiftStart, LocalTime shiftEnd) {
    }

    private boolean canAccessPath(String relativePath, User.Role role) {
        return ("/admin/work-history".equals(relativePath) && role == User.Role.Admin)
                || ("/staff/work-history".equals(relativePath) && role == User.Role.Staff)
                || ("/pt/work-history".equals(relativePath) && role == User.Role.PT);
    }

    static boolean isValidDateRange(LocalDate fromDate, LocalDate toDate) {
        return fromDate == null || toDate == null || !fromDate.isAfter(toDate);
    }

    public static class WorkStatusSummary {
        private final String key;
        private final String label;
        private final int count;
        private final String badgeClass;
        private final String iconClass;
        private final String url;
        private final boolean active;

        public WorkStatusSummary(String key, String label, int count, String badgeClass,
                                 String iconClass, String url, boolean active) {
            this.key = key;
            this.label = label;
            this.count = count;
            this.badgeClass = badgeClass;
            this.iconClass = iconClass;
            this.url = url;
            this.active = active;
        }

        public String getKey() {
            return key;
        }

        public String getLabel() {
            return label;
        }

        public int getCount() {
            return count;
        }

        public String getBadgeClass() {
            return badgeClass;
        }

        public String getIconClass() {
            return iconClass;
        }

        public String getUrl() {
            return url;
        }

        public boolean isActive() {
            return active;
        }
    }
}
