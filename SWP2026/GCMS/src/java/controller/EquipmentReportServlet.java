package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import service.EquipmentService;

@WebServlet(name = "EquipmentReportServlet", urlPatterns = {"/equipment-reports"})
public class EquipmentReportServlet extends HttpServlet {
    private static final int DEFAULT_PAGE_SIZE = 10;
    private final EquipmentService service = new EquipmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int page = parseInt(request.getParameter("page"), 1);
            int pageSize = normalizePageSize(parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
            int totalItems = service.countReportEquipments();
            int totalPages = totalPages(totalItems, pageSize);
            page = normalizePage(page, totalPages);
            int offset = (page - 1) * pageSize;
            request.setAttribute("report", service.buildReport(offset, pageSize));
            setPaginationAttributes(request, page, pageSize, totalItems, request.getContextPath() + "/equipment-reports?pageSize=" + pageSize + "&");
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/equipment/equipment-report.jsp").forward(request, response);
    }

    private int parseInt(String value, int fallback) {
        try {
            return value == null || value.isBlank() ? fallback : Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return fallback;
        }
    }

    private int normalizePageSize(int pageSize) {
        return switch (pageSize) {
            case 5, 10, 20, 50 -> pageSize;
            default -> DEFAULT_PAGE_SIZE;
        };
    }

    private int totalPages(int totalItems, int pageSize) {
        return Math.max(1, (int) Math.ceil(Math.max(0, totalItems) / (double) pageSize));
    }

    private int normalizePage(int page, int totalPages) {
        return Math.min(Math.max(1, page), totalPages);
    }

    private void setPaginationAttributes(HttpServletRequest request, int page, int pageSize, int totalItems, String queryBase) {
        int safeTotalItems = Math.max(0, totalItems);
        int totalPages = totalPages(safeTotalItems, pageSize);
        int offset = (page - 1) * pageSize;
        int visiblePages = Math.min(5, totalPages);
        int start = Math.max(1, page - visiblePages / 2);
        int end = Math.min(totalPages, start + visiblePages - 1);
        int startPage = Math.max(1, end - visiblePages + 1);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        request.setAttribute("showPagination", true);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalItems", safeTotalItems);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startItem", safeTotalItems == 0 ? 0 : offset + 1);
        request.setAttribute("endItem", Math.min(safeTotalItems, offset + pageSize));
        request.setAttribute("hasPrevious", page > 1);
        request.setAttribute("hasNext", page < totalPages);
        request.setAttribute("previousPage", Math.max(1, page - 1));
        request.setAttribute("nextPage", Math.min(totalPages, page + 1));
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("queryBase", queryBase);
    }
}
