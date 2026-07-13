package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.MaintenanceSchedule;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.MaintenanceScheduleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.nio.charset.StandardCharsets;
import java.util.Set;
import java.util.UUID;

@WebServlet(name = "ManageMaintenanceScheduleController", urlPatterns = {"/staff/maintenance-schedules"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 8 * 1024 * 1024
)
public class ManageMaintenanceScheduleController extends HttpServlet {
    private static final String VIEW_DIR = "/WEB-INF/views/maintenance/";
    private static final String UPLOAD_DIR = "/assets/uploads/maintenance";
    private static final int DEFAULT_PAGE_SIZE = 10;
    private static final Set<String> ALLOWED_IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");

    private final MaintenanceScheduleService service = new MaintenanceScheduleService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = currentUser(request, response);
        if (user == null) {
            return;
        }

        try {
            switch (action(request)) {
                case "create" -> showCreateForm(request, response, user);
                case "edit" -> showEditForm(request, response, user);
                case "detail" -> showDetail(request, response);
                default -> list(request, response);
            }
        } catch (SecurityException ex) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        } catch (IllegalArgumentException ex) {
            request.getSession().setAttribute("maintenanceError", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules");
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = currentUser(request, response);
        if (user == null) {
            return;
        }

        String action = action(request);
        try {
            switch (action) {
                case "create" -> create(request, response, user);
                case "update" -> update(request, response, user);
                case "cancel" -> cancel(request, response, user);
                case "approve" -> approve(request, response, user);
                case "reject" -> reject(request, response, user);
                default -> response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SecurityException ex) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        } catch (SQLException | IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            if ("create".equals(action) || "update".equals(action)) {
                MaintenanceSchedule formSchedule = readPlannedLenient(request);
                if ("update".equals(action) && formSchedule.getMaintenanceScheduleId() > 0) {
                    try {
                        formSchedule = mergeCurrentForError(formSchedule, user);
                    } catch (SQLException loadEx) {
                        throw new ServletException(loadEx);
                    }
                }
                request.setAttribute("schedule", formSchedule);
                request.setAttribute("edit", formSchedule.getMaintenanceScheduleId() > 0);
                try {
                    loadFormOptions(request);
                } catch (SQLException optionEx) {
                    throw new ServletException(optionEx);
                }
                request.getRequestDispatcher(VIEW_DIR + "maintenance-schedule-form.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("maintenanceError", ex.getMessage());
                response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules");
            }
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String keyword = trim(request.getParameter("keyword"));
        String status = trim(request.getParameter("status"));
        String type = trim(request.getParameter("type"));
        Integer equipmentId = nullablePositiveInt(request.getParameter("equipmentId"));
        
        int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
        int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
        int totalItems = service.countSearch(keyword, status, equipmentId, type);
        int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
        page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;

        request.setAttribute("schedules", service.search(keyword, status, equipmentId, type, offset, pageSize));
        request.setAttribute("statistics", service.getStatistics());
        request.setAttribute("equipments", service.getEquipmentOptions());
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("type", type);
        request.setAttribute("equipmentId", equipmentId);
        request.setAttribute("encodedReturnUrl", buildEncodedReturnUrl(request));
        exposeFlash(request);
        
        String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                request, "/staff/maintenance-schedules", "action", "list", "keyword", keyword, "status", status, 
                "equipmentId", equipmentId == null ? null : String.valueOf(equipmentId), "type", type, "pageSize", String.valueOf(pageSize));

        com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                request, page, pageSize, totalItems, queryBase, "lịch bảo trì");

        request.getRequestDispatcher(VIEW_DIR + "maintenance-schedule-list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, ServletException, IOException {
        requireAdmin(user);
        MaintenanceSchedule schedule = new MaintenanceSchedule();
        schedule.setScheduledDate(LocalDate.now());
        schedule.setMaintenanceType(MaintenanceScheduleService.TYPE_PREVENTIVE);
        request.setAttribute("schedule", schedule);
        request.setAttribute("edit", false);
        loadFormOptions(request);
        request.getRequestDispatcher(VIEW_DIR + "maintenance-schedule-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, ServletException, IOException {
        MaintenanceSchedule schedule = service.getById(parseRequiredId(request.getParameter("id")));
        if (schedule == null) {
            throw new IllegalArgumentException("Maintenance schedule does not exist or has been deleted.");
        }
        if (user.getRole() == User.Role.Admin) {
            if (!MaintenanceScheduleService.STATUS_SCHEDULED.equals(schedule.getStatus())) {
                throw new IllegalArgumentException("Only scheduled maintenance can be edited.");
            }
        } else if (user.getRole() == User.Role.Staff) {
            if (!MaintenanceScheduleService.STATUS_SCHEDULED.equals(schedule.getStatus())
                    && !MaintenanceScheduleService.STATUS_IN_PROGRESS.equals(schedule.getStatus())) {
                throw new IllegalArgumentException("Completed or cancelled schedules cannot be edited.");
            }
        } else {
            throw new SecurityException("Unauthorized role.");
        }
        request.setAttribute("schedule", schedule);
        request.setAttribute("edit", true);
        loadFormOptions(request);
        request.getRequestDispatcher(VIEW_DIR + "maintenance-schedule-form.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        MaintenanceSchedule schedule = service.getById(parseRequiredId(request.getParameter("id")));
        if (schedule == null) {
            throw new IllegalArgumentException("Maintenance schedule does not exist or has been deleted.");
        }
        request.setAttribute("schedule", schedule);
        exposeFlash(request);
        request.getRequestDispatcher(VIEW_DIR + "maintenance-schedule-detail.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        requireAdmin(user);
        int id = service.create(readPlanned(request), user.getFullName());
        setSuccess(request, "Đã tạo lịch bảo trì #" + id + ".");
        response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules?action=detail&id=" + id);
    }

    private void update(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException, ServletException {
        int id = parseRequiredId(request.getParameter("id"));
        if (user.getRole() == User.Role.Admin) {
            MaintenanceSchedule changes = readPlanned(request);
            changes.setMaintenanceScheduleId(id);
            service.updatePlanned(changes, user.getFullName());
            setSuccess(request, "Đã cập nhật thông tin lịch bảo trì.");
        } else if (user.getRole() == User.Role.Staff) {
            String nextStatus = trim(request.getParameter("status"));
            String completionNote = trim(request.getParameter("completionNote"));
            if (MaintenanceScheduleService.STATUS_PENDING_APPROVAL.equals(nextStatus)) {
                String completionImageUrl = resolveCompletionImageUrl(request);
                service.submitForApproval(id, completionNote, completionImageUrl, true, user.getFullName());
                setSuccess(request, "Đã gửi kết quả bảo trì chờ Admin duyệt.");
            } else {
                service.updateProgress(id, nextStatus, completionNote, false, user.getFullName());
                setSuccess(request, "Đã cập nhật tiến độ bảo trì.");
            }
        } else {
            throw new SecurityException("Unauthorized role.");
        }
        response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules?action=detail&id=" + id);
    }

    private void approve(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        requireAdmin(user);
        int id = parseRequiredId(request.getParameter("id"));
        service.approveCompletion(id, trim(request.getParameter("approvalNote")), user.getFullName());
        setSuccess(request, "Đã duyệt hoàn tất bảo trì #" + id + ".");
        response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules?action=detail&id=" + id);
    }

    private void reject(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        requireAdmin(user);
        int id = parseRequiredId(request.getParameter("id"));
        service.rejectCompletion(id, trim(request.getParameter("approvalNote")), user.getFullName());
        setSuccess(request, "Đã từ chối kết quả bảo trì #" + id + ".");
        response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules?action=detail&id=" + id);
    }

    private void cancel(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException {
        requireAdmin(user);
        int id = parseRequiredId(request.getParameter("id"));
        service.cancel(id, user.getFullName());
        setSuccess(request, "Đã hủy lịch bảo trì #" + id + ".");
        response.sendRedirect(request.getContextPath() + "/staff/maintenance-schedules");
    }

    private String resolveCompletionImageUrl(HttpServletRequest request) throws IOException, ServletException {
        Part imagePart = request.getPart("completionImageFile");
        if (imagePart == null || imagePart.getSize() == 0) {
            throw new IllegalArgumentException("Completion image is required.");
        }

        String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = extensionOf(submittedName);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Only jpg, jpeg, png, gif or webp image files are allowed.");
        }

        String realUploadPath = getServletContext().getRealPath(UPLOAD_DIR);
        if (realUploadPath == null) {
            throw new IOException("Cannot resolve maintenance image upload directory.");
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
            return "";
        }
        return fileName.substring(dotIndex + 1).toLowerCase();
    }

    private MaintenanceSchedule readPlanned(HttpServletRequest request) {
        MaintenanceSchedule schedule = readPlannedLenient(request);
        if (schedule.getScheduledDate() == null) {
            throw new IllegalArgumentException("Scheduled date is required.");
        }
        return schedule;
    }

    private MaintenanceSchedule readPlannedLenient(HttpServletRequest request) {
        MaintenanceSchedule schedule = new MaintenanceSchedule();
        schedule.setMaintenanceScheduleId(parseInt(request.getParameter("id"), 0));
        schedule.setEquipmentId(parseInt(request.getParameter("equipmentId"), 0));
        schedule.setIssueId(nullablePositiveInt(request.getParameter("issueId")));
        schedule.setMaintenanceType(trim(request.getParameter("maintenanceType")));
        schedule.setDescription(trim(request.getParameter("description")));
        schedule.setStatus(trim(request.getParameter("status")));
        schedule.setCompletionNote(trim(request.getParameter("completionNote")));
        String date = request.getParameter("scheduledDate");
        if (date != null && !date.isBlank()) {
            try {
                schedule.setScheduledDate(LocalDate.parse(date));
            } catch (DateTimeParseException ignored) {
                schedule.setScheduledDate(null);
            }
        }
        return schedule;
    }

    private void loadFormOptions(HttpServletRequest request) throws SQLException {
        request.setAttribute("equipments", service.getEquipmentOptions());
        request.setAttribute("issues", service.getAllIssueOptions());
        request.setAttribute("today", LocalDate.now());
    }

    private MaintenanceSchedule mergeCurrentForError(MaintenanceSchedule submitted, User user) throws SQLException {
        MaintenanceSchedule current = service.getById(submitted.getMaintenanceScheduleId());
        if (current == null) {
            return submitted;
        }
        if (user.getRole() == User.Role.Admin) {
            current.setScheduledDate(submitted.getScheduledDate());
            current.setMaintenanceType(submitted.getMaintenanceType());
            current.setIssueId(submitted.getIssueId());
            current.setDescription(submitted.getDescription());
        } else {
            current.setCompletionNote(submitted.getCompletionNote());
        }
        return current;
    }

    private User currentUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        if (user.getRole() != User.Role.Admin && user.getRole() != User.Role.Staff) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return null;
        }
        return user;
    }

    private void requireAdmin(User user) {
        if (user.getRole() != User.Role.Admin) {
            throw new SecurityException("Only Admin may perform this action.");
        }
    }

    private void setSuccess(HttpServletRequest request, String message) {
        request.getSession().setAttribute("maintenanceSuccess", message);
    }

    private void exposeFlash(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        Object success = session.getAttribute("maintenanceSuccess");
        Object error = session.getAttribute("maintenanceError");
        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("maintenanceSuccess");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("maintenanceError");
        }
    }

    private String action(HttpServletRequest request) {
        String action = request.getParameter("action");
        return action == null || action.isBlank() ? "list" : action;
    }

    private int parseRequiredId(String value) {
        int id = parseInt(value, 0);
        if (id <= 0) {
            throw new IllegalArgumentException("Maintenance schedule is required.");
        }
        return id;
    }

    private int parseInt(String value, int fallback) {
        try {
            return value == null || value.isBlank() ? fallback : Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return fallback;
        }
    }

    private Integer nullablePositiveInt(String value) {
        int parsed = parseInt(value, 0);
        return parsed > 0 ? parsed : null;
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String buildEncodedReturnUrl(HttpServletRequest request) {
        StringBuilder returnUrl = new StringBuilder(request.getRequestURI().substring(request.getContextPath().length()));
        if (request.getQueryString() != null && !request.getQueryString().isBlank()) {
            returnUrl.append("?").append(request.getQueryString());
        }
        returnUrl.append("#maintenance-table");
        return URLEncoder.encode(returnUrl.toString(), StandardCharsets.UTF_8);
    }
}
