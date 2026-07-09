/**
 * =========================================================================
 * @file          : MembershipGrowthReportController.java
 * @description   : Controller for viewing membership growth report (Admin only)
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.service.MembershipGrowthReportService;
import com.mycompany.gymcentermanagement.service.impl.MembershipGrowthReportServiceImpl;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.PaginationHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet(name = "MembershipGrowthReportController", urlPatterns = {"/admin/membership-growth-report"})
public class MembershipGrowthReportController extends HttpServlet {
    private static final int PAGE_SIZE = PaginationHelper.DEFAULT_PAGE_SIZE;
    private static final String STATUS_NEW = "new";
    private static final String STATUS_ACTIVE = "active";
    private static final String STATUS_EXPIRED = "expired";

    private final MembershipGrowthReportService reportService = new MembershipGrowthReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!ensureAdmin(request, response)) {
            return;
        }

        try {
            List<Integer> availableYears = buildYearOptions(reportService.getAvailableYears());

            int selectedYear = resolveYear(request.getParameter("year"), availableYears);
            Integer selectedMonth = resolveMonth(request.getParameter("month"));
            String tableStatus = normalizeStatus(request.getParameter("status"));
            String searchKeyword = normalizeBlank(request.getParameter("searchKeyword"));

            MembershipGrowthSummary summary = reportService.getSummary(selectedYear, selectedMonth);
            List<MembershipGrowthChartPoint> chartPoints = reportService.getGrowthChart(selectedYear, selectedMonth);

            int page = PaginationHelper.parseInt(request.getParameter("page"), 1);
            int totalItems = reportService.countMembers(selectedYear, selectedMonth, tableStatus, searchKeyword);
            int totalPages = PaginationHelper.totalPages(totalItems, PAGE_SIZE);
            page = PaginationHelper.normalizePage(page, totalPages);
            int offset = (page - 1) * PAGE_SIZE;

            List<MembershipGrowthMember> members = reportService.getMemberGrowthList(
                    selectedYear, selectedMonth, tableStatus, searchKeyword, offset, PAGE_SIZE);

            setReportAttributes(request, availableYears, selectedYear, selectedMonth, tableStatus,
                    searchKeyword, summary, chartPoints, members);

            String queryBase = PaginationHelper.buildQueryBase(
                    request,
                    "/admin/membership-growth-report",
                    "year", String.valueOf(selectedYear),
                    "month", selectedMonth == null ? null : String.valueOf(selectedMonth),
                    "status", tableStatus,
                    "searchKeyword", searchKeyword);

            PaginationHelper.setPaginationAttributes(
                    request, page, PAGE_SIZE, totalItems, queryBase, "members");
        } catch (SQLException ex) {
            List<Integer> fallbackYears = buildYearOptions(new ArrayList<>());
            request.setAttribute("errorMessage", "Unable to load membership growth report. Please try again.");
            setReportAttributes(request, fallbackYears, LocalDate.now().getYear(), null, null,
                    null, new MembershipGrowthSummary(), new ArrayList<>(), new ArrayList<>());

            String queryBase = PaginationHelper.buildQueryBase(
                    request, "/admin/membership-growth-report", "year", String.valueOf(LocalDate.now().getYear()));
            PaginationHelper.setPaginationAttributes(request, 1, PAGE_SIZE, 0, queryBase, "members");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/membership-growth-report.jsp").forward(request, response);
    }

    private boolean ensureAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        if (currentUser.getRole() != User.Role.Admin) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return false;
        }
        return true;
    }

    private void setReportAttributes(HttpServletRequest request, List<Integer> availableYears, int selectedYear,
            Integer selectedMonth, String tableStatus, String searchKeyword, MembershipGrowthSummary summary,
            List<MembershipGrowthChartPoint> chartPoints, List<MembershipGrowthMember> members) {
        request.setAttribute("availableYears", availableYears);
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("tableStatus", tableStatus);
        request.setAttribute("tableStatusLabel", getStatusLabel(tableStatus));
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("summary", summary);
        request.setAttribute("members", members);
        request.setAttribute("chartLabelsJson", buildChartLabelsJson(chartPoints));
        request.setAttribute("chartValuesJson", buildChartValuesJson(chartPoints));
        request.setAttribute("selectedPeriodText", buildPeriodText(selectedYear, selectedMonth));
    }

    private int resolveYear(String value, List<Integer> availableYears) {
        int defaultYear = availableYears.isEmpty() ? LocalDate.now().getYear() : availableYears.get(0);
        int parsedYear = PaginationHelper.parseInt(value, defaultYear);
        return availableYears.contains(parsedYear) ? parsedYear : defaultYear;
    }

    private List<Integer> buildYearOptions(List<Integer> dataYears) {
        List<Integer> years = new ArrayList<>();
        int currentYear = LocalDate.now().getYear();
        for (int year = currentYear; year >= currentYear - 9; year--) {
            years.add(year);
        }

        if (dataYears != null) {
            for (Integer dataYear : dataYears) {
                if (dataYear != null && !years.contains(dataYear)) {
                    years.add(dataYear);
                }
            }
        }

        years.sort((first, second) -> Integer.compare(second, first));
        return years;
    }

    private Integer resolveMonth(String value) {
        String normalized = normalizeBlank(value);
        if (normalized == null) {
            return null;
        }

        int month = PaginationHelper.parseInt(normalized, 0);
        return month >= 1 && month <= 12 ? month : null;
    }

    private String normalizeStatus(String value) {
        String normalized = normalizeBlank(value);
        if (normalized == null) {
            return null;
        }

        normalized = normalized.toLowerCase(Locale.ROOT);
        if (STATUS_NEW.equals(normalized) || STATUS_ACTIVE.equals(normalized) || STATUS_EXPIRED.equals(normalized)) {
            return normalized;
        }
        return null;
    }

    private String normalizeBlank(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }

    private String getStatusLabel(String tableStatus) {
        if (STATUS_ACTIVE.equals(tableStatus)) {
            return "Thành viên đang hoạt động";
        }
        if (STATUS_EXPIRED.equals(tableStatus)) {
            return "Thành viên hết hạn";
        }
        if (STATUS_NEW.equals(tableStatus)) {
            return "Thành viên mới";
        }
        return "Dữ liệu tăng trưởng thành viên";
    }

    private String buildPeriodText(int selectedYear, Integer selectedMonth) {
        if (selectedMonth == null) {
            return "Năm " + selectedYear;
        }
        return "Tháng " + selectedMonth + "/" + selectedYear;
    }

    private String buildChartLabelsJson(List<MembershipGrowthChartPoint> points) {
        return points.stream()
                .map(point -> "\"" + escapeJson(point.getLabel()) + "\"")
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String buildChartValuesJson(List<MembershipGrowthChartPoint> points) {
        return points.stream()
                .map(point -> String.valueOf(point.getMemberCount()))
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
