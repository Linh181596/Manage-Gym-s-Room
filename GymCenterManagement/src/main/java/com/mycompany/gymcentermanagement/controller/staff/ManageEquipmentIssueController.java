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
                case "create" -> showForm(request, response, new EquipmentIssue());
                case "edit" -> showStatusForm(request, response);
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
        try {
            if ("edit".equals(action)) {
                service.updateIssue(readIssueForUpdate(request, currentUser.getFullName()), currentUser.getFullName());
            } else {
                service.createIssue(readIssue(request, currentUser.getUserId(), currentUser.getFullName()));
            }
            response.sendRedirect(request.getContextPath() + "/staff/equipment-issues?action=list");
        } catch (SQLException | IllegalArgumentException | IOException | ServletException ex) {
            request.setAttribute("error", ex.getMessage());
            try {
                showForm(request, response, readIssueLenient(request, currentUser.getUserId(), currentUser.getFullName()));
            } catch (SQLException sqlEx) {
                throw new ServletException(sqlEx);
            }
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = normalizePageSize(parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
        int totalItems = service.countIssues(keyword, status);
        int totalPages = totalPages(totalItems, pageSize);
        page = normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;
        request.setAttribute("issues", service.searchIssues(keyword, status, offset, pageSize));
        setPaginationAttributes(request, page, pageSize, totalItems,
                buildQueryBase(request, "action", "list", "keyword", keyword, "status", status, "pageSize", String.valueOf(pageSize)));
        request.setAttribute("counts", service.buildReport());
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
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
        issue.setIssueType(trim(request.getParameter("issueType")));
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
        issue.setStatus(request.getParameter("status"));
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

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String buildQueryBase(HttpServletRequest request, String... pairs) {
        StringBuilder query = new StringBuilder(request.getContextPath()).append("/staff/equipment-issues?");
        for (int i = 0; i < pairs.length; i += 2) {
            String key = pairs[i];
            String value = pairs[i + 1];
            if (value == null || value.isBlank()) {
                continue;
            }
            if (query.charAt(query.length() - 1) != '?') {
                query.append('&');
            }
            query.append(urlEncode(key)).append('=').append(urlEncode(value));
        }
        if (query.charAt(query.length() - 1) != '?') {
            query.append('&');
        }
        return query.toString();
    }

    private String urlEncode(String value) {
        return java.net.URLEncoder.encode(value, java.nio.charset.StandardCharsets.UTF_8);
    }
}
