/**
 * =========================================================================
 * @file          : ManageEquipmentIssueController.java
 * @description   : Controller điều phối xử lý báo cáo sự cố hỏng hóc thiết bị.
 * @author        : Đỗ Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đỗ Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;
import com.mycompany.gymcentermanagement.model.entity.EquipmentIssue;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.EquipmentService;

@WebServlet(name = "ManageEquipmentIssueController", urlPatterns = {"/staff/equipment-issues"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 8 * 1024 * 1024
)
public class ManageEquipmentIssueController extends HttpServlet {
    private static final String VIEW_DIR = "/WEB-INF/views/equipment/";
    private static final String UPLOAD_DIR = "/assets/uploads/equipment-issues";
    private static final int DEFAULT_PAGE_SIZE = 10;
    private static final Set<String> ALLOWED_IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");
    private final EquipmentService service = new EquipmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = action(request);
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            switch (action) {
                case "create" -> {
                    EquipmentIssue newIssue = new EquipmentIssue();
                    newIssue.setStatus(EquipmentService.ISSUE_PENDING);
                    String eqIdStr = request.getParameter("equipmentId");
                    if (eqIdStr != null && !eqIdStr.isBlank()) {
                        try {
                            newIssue.setEquipmentId(Integer.parseInt(eqIdStr));
                        } catch (NumberFormatException ignored) {}
                    }
                    showForm(request, response, newIssue);
                }
                case "detail" -> showDetail(request, response);
                default -> list(request, response);
            }
        } catch (SQLException | IllegalArgumentException ex) {
            showError(request, response, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = action(request);
        if ("edit".equals(action)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        try {
            service.createIssue(readIssue(request, currentUser.getUserId(), currentUser.getFullName()));
            if (User.Role.Admin.equals(currentUser.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/equipment-reports");
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/equipment-issues?action=list");
            }
        } catch (SQLException | IllegalArgumentException | IOException | ServletException ex) {
            request.setAttribute("error", ex.getMessage());
            try {
                showForm(request, response, readIssueLenient(request, currentUser.getUserId(), currentUser.getFullName()));
            } catch (SQLException sqlEx) {
                throw new ServletException(sqlEx);
            }
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        
        int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
        int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
        int totalItems = service.countIssues(keyword, status);
        int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
        page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;
        
        request.setAttribute("issues", service.searchIssues(keyword, status, offset, pageSize));
        request.setAttribute("counts", service.buildReport());
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        
        String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                request, "/staff/equipment-issues", "action", "list", "keyword", keyword, "status", status, "pageSize", String.valueOf(pageSize));

        com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                request, page, pageSize, totalItems, queryBase, "sự cố");

        request.getRequestDispatcher(VIEW_DIR + "issue-list.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, EquipmentIssue issue)
            throws SQLException, ServletException, IOException {
        request.setAttribute("issue", issue);
        request.setAttribute("equipments", service.findEquipmentOptions());
        request.getRequestDispatcher(VIEW_DIR + "issue-form.jsp").forward(request, response);
    }

    private void showStatusForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        EquipmentIssue issue = service.getIssue(parseInt(request.getParameter("id"), 0));
        if (issue == null) {
            response.sendRedirect(request.getContextPath() + "/staff/equipment-issues?action=list");
            return;
        }
        request.setAttribute("issue", issue);
        request.setAttribute("equipments", service.findEquipmentOptions());
        request.getRequestDispatcher(VIEW_DIR + "issue-form.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        EquipmentIssue issue = service.getIssue(parseInt(request.getParameter("id"), 0));
        if (issue == null) {
            response.sendRedirect(request.getContextPath() + "/staff/equipment-issues?action=list");
            return;
        }
        request.setAttribute("issue", issue);
        request.getRequestDispatcher(VIEW_DIR + "issue-detail.jsp").forward(request, response);
    }

    private EquipmentIssue readIssue(HttpServletRequest request, int userId, String userFullName) throws IOException, ServletException {
        EquipmentIssue issue = new EquipmentIssue();
        issue.setEquipmentId(parseInt(request.getParameter("equipmentId"), 0));
        issue.setReportedBy(userId);
        issue.setIssueType(EquipmentService.ISSUE_TYPE_DAMAGE);
        issue.setDescription(trim(request.getParameter("description")));
        issue.setIssueImageUrl(resolveIssueImageUrl(request));
        issue.setCreatedBy(userFullName);
        return issue;
    }

    private EquipmentIssue readIssueForUpdate(HttpServletRequest request, String userFullName) throws IOException, ServletException {
        EquipmentIssue issue = new EquipmentIssue();
        issue.setEquipmentId(parseInt(request.getParameter("equipmentId"), 0));
        issue.setReportedBy(parseInt(request.getParameter("reportedBy"), 0));
        issue.setIssueType(trim(request.getParameter("issueType")));
        issue.setDescription(trim(request.getParameter("description")));
        issue.setCreatedBy(trim(request.getParameter("reportedByName")));
        issue.setIssueId(parseInt(request.getParameter("id"), 0));
        issue.setStatus(trim(request.getParameter("status")));
        issue.setUpdatedBy(userFullName);
        
        String currentImageUrl = trim(request.getParameter("currentIssueImageUrl"));
        String newUploadedUrl = resolveIssueImageUrl(request);
        if (newUploadedUrl != null && !newUploadedUrl.isBlank()) {
            issue.setIssueImageUrl(newUploadedUrl);
        } else {
            issue.setIssueImageUrl(currentImageUrl);
        }
        return issue;
    }

    private EquipmentIssue readIssueLenient(HttpServletRequest request, int userId, String userFullName) {
        EquipmentIssue issue = new EquipmentIssue();
        issue.setEquipmentId(parseInt(request.getParameter("equipmentId"), 0));
        issue.setReportedBy(userId);
        issue.setIssueType(trim(request.getParameter("issueType")));
        issue.setDescription(trim(request.getParameter("description")));
        issue.setCreatedBy(userFullName);
        issue.setIssueId(parseInt(request.getParameter("id"), 0));
        if (issue.getIssueId() == 0) {
            issue.setIssueType(EquipmentService.ISSUE_TYPE_DAMAGE);
        }
        if (issue.getIssueId() > 0) {
            issue.setStatus(request.getParameter("status"));
        } else {
            issue.setStatus(EquipmentService.ISSUE_PENDING);
        }
        issue.setIssueImageUrl(trim(request.getParameter("currentIssueImageUrl")));
        return issue;
    }

    private String resolveIssueImageUrl(HttpServletRequest request) throws IOException, ServletException {
        Part imagePart = request.getPart("issueImageFile");
        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = extensionOf(submittedName);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Only jpg, jpeg, png, gif or webp image files are allowed.");
        }

        String realUploadPath = getServletContext().getRealPath(UPLOAD_DIR);
        if (realUploadPath == null) {
            throw new IOException("Cannot resolve issue image upload directory.");
        }

        Files.createDirectories(Path.of(realUploadPath));
        String fileName = UUID.randomUUID() + "." + extension;
        Path target = Path.of(realUploadPath, fileName);
        imagePart.write(target.toString());
        return request.getContextPath() + UPLOAD_DIR + "/" + fileName;
    }

    private String extensionOf(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == fileName.length() - 1) {
            throw new IllegalArgumentException("Image file must have a valid extension.");
        }
        return fileName.substring(dotIndex + 1).toLowerCase(Locale.ROOT);
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, Exception ex) throws ServletException, IOException {
        request.setAttribute("error", ex.getMessage());
        request.getRequestDispatcher(VIEW_DIR + "issue-list.jsp").forward(request, response);
    }

    private String action(HttpServletRequest request) {
        String action = request.getParameter("action");
        return action == null || action.isBlank() ? "list" : action;
    }

    private int parseInt(String value, int fallback) {
        try {
            return value == null || value.isBlank() ? fallback : Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return fallback;
        }
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}

