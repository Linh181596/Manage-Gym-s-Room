/**
 * =========================================================================
 * @file          : ManageEquipmentController.java
 * @description   : Controller điều phối các hoạt động CRUD thiết bị phòng gym.
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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;
import com.mycompany.gymcentermanagement.model.entity.Equipment;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.EquipmentService;

@WebServlet(name = "ManageEquipmentController", urlPatterns = {"/staff/equipment"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 8 * 1024 * 1024
)
public class ManageEquipmentController extends HttpServlet {
    private static final String VIEW_DIR = "/WEB-INF/views/equipment/";
    private static final String UPLOAD_DIR = "/assets/uploads/equipment";
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
                    if (currentUser.getRole() != User.Role.Admin) {
                        request.setAttribute("error", "Chỉ Quản trị viên mới được phép thêm thiết bị mới.");
                        list(request, response);
                    } else {
                        showForm(request, response, new Equipment(), false);
                    }
                }
                case "edit" -> showEdit(request, response);
                case "detail" -> showDetail(request, response);
                case "delete" -> {
                    if (currentUser.getRole() != User.Role.Admin) {
                        request.setAttribute("error", "Chỉ Quản trị viên mới được phép xóa thiết bị.");
                        list(request, response);
                    } else {
                        delete(request, response, currentUser.getFullName());
                    }
                }
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

        int id = parseInt(request.getParameter("id"), 0);
        if (id == 0 && currentUser.getRole() != User.Role.Admin) {
            request.setAttribute("error", "Chỉ Quản trị viên mới được phép thêm thiết bị mới.");
            try {
                list(request, response);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
            return;
        }

        try {
            Equipment equipment = readEquipment(request, currentUser.getFullName());
            service.saveEquipment(equipment);
            response.sendRedirect(request.getContextPath() + "/staff/equipment?action=list");
        } catch (SQLException | IllegalArgumentException | IOException | ServletException ex) {
            Equipment equipment = readEquipmentLenient(request);
            request.setAttribute("error", ex.getMessage());
            showForm(request, response, equipment, equipment.getEquipmentId() > 0);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String type = request.getParameter("type");
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = normalizePageSize(parseInt(request.getParameter("pageSize"), DEFAULT_PAGE_SIZE));
        int totalItems = service.countEquipments(keyword, status, type);
        int totalPages = totalPages(totalItems, pageSize);
        page = normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;
        request.setAttribute("equipments", service.searchEquipments(keyword, status, type, offset, pageSize));
        setPaginationAttributes(request, page, pageSize, totalItems,
                buildQueryBase(request, "action", "list", "keyword", keyword, "status", status, "type", type, "pageSize", String.valueOf(pageSize)));
        request.setAttribute("counts", service.buildReport());
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("type", type);
        request.getRequestDispatcher(VIEW_DIR + "equipment-list.jsp").forward(request, response);
    }

    private void showEdit(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Equipment equipment = service.getEquipment(parseInt(request.getParameter("id"), 0));
        if (equipment == null) {
            response.sendRedirect(request.getContextPath() + "/staff/equipment?action=list");
            return;
        }
        showForm(request, response, equipment, true);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Equipment equipment = service.getEquipment(parseInt(request.getParameter("id"), 0));
        if (equipment == null) {
            response.sendRedirect(request.getContextPath() + "/staff/equipment?action=list");
            return;
        }
        request.setAttribute("equipment", equipment);
        request.getRequestDispatcher(VIEW_DIR + "equipment-detail.jsp").forward(request, response);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response, String userFullName) throws SQLException, IOException {
        service.deleteEquipment(parseInt(request.getParameter("id"), 0), userFullName);
        response.sendRedirect(request.getContextPath() + "/staff/equipment?action=list");
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, Equipment equipment, boolean edit)
            throws ServletException, IOException {
        request.setAttribute("equipment", equipment);
        request.setAttribute("edit", edit);
        request.getRequestDispatcher(VIEW_DIR + "equipment-form.jsp").forward(request, response);
    }

    private Equipment readEquipment(HttpServletRequest request, String userFullName) throws IOException, ServletException {
        Equipment equipment = new Equipment();
        equipment.setEquipmentId(parseInt(request.getParameter("id"), 0));
        equipment.setEquipmentCode(trim(request.getParameter("equipmentCode")));
        equipment.setEquipmentName(trim(request.getParameter("equipmentName")));
        equipment.setEquipmentType(trim(request.getParameter("equipmentType")));
        equipment.setPurchaseDate(parseRequiredDate(request.getParameter("purchaseDate"), "Purchase date"));
        equipment.setWarrantyDate(parseRequiredDate(request.getParameter("warrantyDate"), "Warranty date"));
        equipment.setLocation(trim(request.getParameter("location")));
        equipment.setImageUrl(resolveImageUrl(request));
        equipment.setStatus(request.getParameter("status"));
        equipment.setCreatedBy(userFullName);
        equipment.setUpdatedBy(userFullName);
        return equipment;
    }

    private Equipment readEquipmentLenient(HttpServletRequest request) {
        Equipment equipment = new Equipment();
        equipment.setEquipmentId(parseInt(request.getParameter("id"), 0));
        equipment.setEquipmentCode(trim(request.getParameter("equipmentCode")));
        equipment.setEquipmentName(trim(request.getParameter("equipmentName")));
        equipment.setEquipmentType(trim(request.getParameter("equipmentType")));
        equipment.setLocation(trim(request.getParameter("location")));
        equipment.setImageUrl(trim(request.getParameter("imageUrl")));
        equipment.setStatus(request.getParameter("status"));
        String purchaseDate = request.getParameter("purchaseDate");
        if (purchaseDate != null && !purchaseDate.isBlank()) {
            try {
                equipment.setPurchaseDate(LocalDate.parse(purchaseDate));
            } catch (DateTimeParseException ex) {
                equipment.setPurchaseDate(null);
            }
        }
        String warrantyDate = request.getParameter("warrantyDate");
        if (warrantyDate != null && !warrantyDate.isBlank()) {
            try {
                equipment.setWarrantyDate(LocalDate.parse(warrantyDate));
            } catch (DateTimeParseException ex) {
                equipment.setWarrantyDate(null);
            }
        }
        return equipment;
    }

    private String resolveImageUrl(HttpServletRequest request) throws IOException, ServletException {
        Part imagePart = request.getPart("imageFile");
        if (imagePart == null || imagePart.getSize() == 0) {
            return trim(request.getParameter("imageUrl"));
        }

        String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = extensionOf(submittedName);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Only jpg, jpeg, png, gif or webp image files are allowed.");
        }

        String realUploadPath = getServletContext().getRealPath(UPLOAD_DIR);
        if (realUploadPath == null) {
            throw new IOException("Cannot resolve image upload directory.");
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

    private LocalDate parseRequiredDate(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required.");
        }
        try {
            return LocalDate.parse(value);
        } catch (DateTimeParseException ex) {
            throw new IllegalArgumentException(fieldName + " is invalid.");
        }
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, Exception ex) throws ServletException, IOException {
        request.setAttribute("error", ex.getMessage());
        request.getRequestDispatcher(VIEW_DIR + "equipment-list.jsp").forward(request, response);
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
        StringBuilder query = new StringBuilder(request.getContextPath()).append("/staff/equipment?");
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

