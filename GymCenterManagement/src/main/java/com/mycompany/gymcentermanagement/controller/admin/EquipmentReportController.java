/**
 * =========================================================================
 * @file          : EquipmentReportController.java
 * @description   : Controller điều phối xử lý và hiển thị báo cáo thống kê tình trạng thiết bị.
 * @author        : Đỗ Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đỗ Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import com.mycompany.gymcentermanagement.service.EquipmentService;

@WebServlet(name = "EquipmentReportController", urlPatterns = {"/admin/equipment-reports"})
public class EquipmentReportController extends HttpServlet {
    private static final int DEFAULT_PAGE_SIZE = 10;
    private final EquipmentService service = new EquipmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
            int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                    com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
            int totalItems = service.countReportEquipments();
            int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
            page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
            int offset = (page - 1) * pageSize;
            request.setAttribute("report", service.buildReport(offset, pageSize));

            String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                    request, "/admin/equipment-reports", "pageSize", String.valueOf(pageSize));

            com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                    request, page, pageSize, totalItems, queryBase, "báo cáo thiết bị");
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/equipment/equipment-report.jsp").forward(request, response);
    }
}

