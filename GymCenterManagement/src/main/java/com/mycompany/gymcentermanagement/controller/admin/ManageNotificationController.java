package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.Notification;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.service.NotificationService;
import com.mycompany.gymcentermanagement.service.impl.NotificationServiceImpl;
import com.mycompany.gymcentermanagement.utils.PaginationHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "ManageNotificationController", urlPatterns = {"/admin/notifications"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class ManageNotificationController extends HttpServlet {

    private static final String NOTIFICATION_UPLOAD_DIR = "assets/uploads/notifications";
    private static final String[] ALLOWED_IMAGE_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};

    private final NotificationService notificationService = new NotificationServiceImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    /**
     * Điều phối yêu cầu GET để hiển thị danh sách, mở form tạo/sửa hoặc xóa mềm thông báo.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    Notification newNotification = new Notification();
                    newNotification.setPublishDate(LocalDateTime.now());
                    request.setAttribute("notification", newNotification);
                    request.setAttribute("formTitle", "Thêm thông báo mới");
                    loadFormData(request);
                    request.getRequestDispatcher("/WEB-INF/views/admin/notification-form.jsp").forward(request, response);
                    break;
                case "edit":
                    handleEdit(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                case "list":
                default:
                    showList(request, response);
                    break;
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi xử lý thông báo: " + ex.getMessage());
            try {
                loadListData(request);
            } catch (SQLException ignored) {
            }
            request.getRequestDispatcher("/WEB-INF/views/admin/notification-list.jsp").forward(request, response);
        }
    }

    /**
     * Nhận dữ liệu form để tạo hoặc cập nhật thông báo, kiểm tra dữ liệu và xử lý ảnh tải lên.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr = request.getParameter("notificationId");
        String title = trim(request.getParameter("title"));
        String content = trim(request.getParameter("content"));
        String deliveryMode = trim(request.getParameter("deliveryMode"));
        String targetRole = trim(request.getParameter("targetRole"));
        Integer recipientUserId = parseInteger(request.getParameter("recipientUserId"));
        LocalDateTime publishDate = parseDateTime(request.getParameter("publishDate"));
        LocalDateTime expiryDate = parseDateTime(request.getParameter("expiryDate"));
        String currentImageUrl = trim(request.getParameter("currentImageUrl"));
        boolean removeImage = "on".equals(request.getParameter("removeImage"));

        Notification formNotification = new Notification();
        formNotification.setTitle(title);
        formNotification.setContent(content);
        if ("account".equals(deliveryMode)) {
            formNotification.setTargetRole("Specific");
            formNotification.setRecipientUserId(recipientUserId);
        } else {
            formNotification.setTargetRole(targetRole);
        }
        formNotification.setPublishDate(publishDate);
        formNotification.setExpiryDate(expiryDate);
        formNotification.setNotificationImageUrl(removeImage ? null : currentImageUrl);

        try {
            int currentId = 0;
            if (idStr != null && !idStr.trim().isEmpty()) {
                currentId = Integer.parseInt(idStr);
                formNotification.setNotificationId(currentId);
            }

            String validationError = validateForm(title, content, deliveryMode, targetRole, recipientUserId,
                    publishDate, expiryDate);
            if (validationError != null) {
                forwardFormWithError(request, response, formNotification, validationError, currentId == 0);
                return;
            }

            String uploadedImageUrl;
            try {
                uploadedImageUrl = saveUploadedImage(request);
            } catch (IllegalArgumentException ex) {
                forwardFormWithError(request, response, formNotification, ex.getMessage(), currentId == 0);
                return;
            }

            if (uploadedImageUrl != null) {
                formNotification.setNotificationImageUrl(uploadedImageUrl);
            }

            String actorName = currentUser.getFullName() != null && !currentUser.getFullName().trim().isEmpty()
                    ? currentUser.getFullName()
                    : currentUser.getEmail();

            String successMsg;
            if (currentId == 0) {
                formNotification.setCreatedBy(currentUser.getUserId());
                formNotification.setCreatedByRole(currentUser.getRole().name());
                notificationService.createNotification(formNotification);
                successMsg = "Tạo thông báo thành công!";
            } else {
                Notification existing = notificationService.getNotificationById(currentId);
                if (existing == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/notifications?errorMessage="
                            + URLEncoder.encode("Không tìm thấy thông báo cần cập nhật.", StandardCharsets.UTF_8));
                    return;
                }
                existing.setTitle(title);
                existing.setContent(content);
                existing.setTargetRole(formNotification.getTargetRole());
                existing.setRecipientUserId(formNotification.getRecipientUserId());
                existing.setUpdatedBy(actorName);
                existing.setPublishDate(publishDate);
                existing.setExpiryDate(expiryDate);
                existing.setNotificationImageUrl(formNotification.getNotificationImageUrl());
                notificationService.updateNotification(existing);
                successMsg = "Cập nhật thông báo thành công!";
            }

            response.sendRedirect(request.getContextPath() + "/admin/notifications?successMsg="
                    + URLEncoder.encode(successMsg, StandardCharsets.UTF_8));
        } catch (SQLException | NumberFormatException ex) {
            forwardFormWithError(request, response, formNotification,
                    "Lỗi cơ sở dữ liệu hoặc định dạng: " + ex.getMessage(),
                    idStr == null || idStr.trim().isEmpty());
        }
    }

    /**
     * Tải thông báo theo mã, chuẩn bị danh sách người nhận và hiển thị biểu mẫu chỉnh sửa.
     */
    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Notification notification = notificationService.getNotificationById(id);
        if (notification == null) {
            response.sendRedirect(request.getContextPath() + "/admin/notifications?errorMessage="
                    + URLEncoder.encode("Không tìm thấy thông báo.", StandardCharsets.UTF_8));
            return;
        }
        request.setAttribute("notification", notification);
        request.setAttribute("formTitle", "Chỉnh sửa thông báo");
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/admin/notification-form.jsp").forward(request, response);
    }

    /**
     * Xóa mềm thông báo theo mã rồi chuyển về danh sách kèm thông báo kết quả.
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean deleted = notificationService.deleteNotification(id);
        String message = deleted ? "Xóa thông báo thành công!" : "Không tìm thấy thông báo cần xóa.";
        String paramName = deleted ? "successMsg" : "errorMessage";
        response.sendRedirect(request.getContextPath() + "/admin/notifications?" + paramName + "="
                + URLEncoder.encode(message, StandardCharsets.UTF_8));
    }

    /**
     * Nạp dữ liệu danh sách thông báo có phân trang và chuyển sang trang quản lý thông báo.
     */
    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        loadListData(request);
        request.getRequestDispatcher("/WEB-INF/views/admin/notification-list.jsp").forward(request, response);
    }

    /**
     * Tính thông tin phân trang, tải trang thông báo hiện tại và gắn dữ liệu vào request.
     */
    private void loadListData(HttpServletRequest request) throws SQLException {
        int page = PaginationHelper.parseInt(request.getParameter("page"), 1);
        int pageSize = PaginationHelper.normalizePageSize(PaginationHelper.parseInt(request.getParameter("pageSize"), 10));
        int totalItems = notificationService.getNotificationsCount();
        int totalPages = PaginationHelper.totalPages(totalItems, pageSize);
        page = PaginationHelper.normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;

        List<Notification> notifications = notificationService.getNotificationsPaginated(offset, pageSize);
        request.setAttribute("notifications", notifications);

        String queryBase = PaginationHelper.buildQueryBase(
                request, "/admin/notifications", "pageSize", String.valueOf(pageSize));
        PaginationHelper.setPaginationAttributes(request, page, pageSize, totalItems, queryBase, "thông báo");
    }

    /**
     * Kiểm tra tiêu đề, nội dung, người nhận, thời gian đăng và thời gian hết hạn của thông báo.
     */
    private String validateForm(String title, String content, String deliveryMode, String targetRole,
            Integer recipientUserId, LocalDateTime publishDate, LocalDateTime expiryDate) {
        if (title == null || title.isEmpty() || content == null || content.isEmpty()) {
            return "Vui lòng nhập đầy đủ tiêu đề và nội dung thông báo.";
        }
        if (title.length() > 255) {
            return "Tiêu đề thông báo không được vượt quá 255 ký tự.";
        }
        if ("account".equals(deliveryMode)) {
            if (recipientUserId == null || recipientUserId <= 0) {
                return "Vui lòng chọn tài khoản nhận thông báo.";
            }
            try {
                if (!notificationService.userExists(recipientUserId)) {
                    return "Tài khoản nhận thông báo không tồn tại hoặc đã bị xóa.";
                }
            } catch (SQLException ex) {
                return "Không thể kiểm tra tài khoản nhận thông báo: " + ex.getMessage();
            }
        } else {
            if (targetRole == null || targetRole.isEmpty()) {
                return "Vui lòng chọn vai trò nhận thông báo.";
            }
            if (!notificationService.isValidTargetRole(targetRole) || "Specific".equals(targetRole)) {
                return "Vai trò nhận thông báo không hợp lệ.";
            }
        }
        if (publishDate == null) {
            return "Vui lòng chọn thời gian lên thông báo.";
        }
        if (expiryDate != null && !expiryDate.isAfter(publishDate)) {
            return "Thời gian tự động ẩn phải sau thời gian lên thông báo.";
        }
        return null;
    }

    /**
     * Giữ lại dữ liệu đã nhập, gắn lỗi và hiển thị lại biểu mẫu tạo hoặc chỉnh sửa thông báo.
     */
    private void forwardFormWithError(HttpServletRequest request, HttpServletResponse response,
            Notification notification, String errorMessage, boolean creating)
            throws ServletException, IOException {
        request.setAttribute("notification", notification);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("formTitle", creating ? "Thêm thông báo mới" : "Chỉnh sửa thông báo");
        try {
            loadFormData(request);
        } catch (SQLException ignored) {
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/notification-form.jsp").forward(request, response);
    }

    /**
     * Loại bỏ khoảng trắng đầu cuối của dữ liệu biểu mẫu và giữ null nếu tham số không tồn tại.
     */
    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    /**
     * Chuyển giá trị datetime-local từ biểu mẫu sang LocalDateTime; trả về null khi không hợp lệ.
     */
    private LocalDateTime parseDateTime(String value) {
        String trimmed = trim(value);
        if (trimmed == null || trimmed.isEmpty()) {
            return null;
        }
        try {
            return LocalDateTime.parse(trimmed);
        } catch (DateTimeParseException ex) {
            return null;
        }
    }

    /**
     * Chuyển chuỗi mã người nhận hoặc mã thông báo sang số nguyên một cách an toàn.
     */
    private Integer parseInteger(String value) {
        String trimmed = trim(value);
        if (trimmed == null || trimmed.isEmpty()) {
            return null;
        }
        try {
            return Integer.valueOf(trimmed);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    /**
     * Tải tối đa 500 tài khoản Active để Admin chọn người nhận cụ thể trong biểu mẫu.
     */
    private void loadFormData(HttpServletRequest request) throws SQLException {
        request.setAttribute("recipientUsers",
                userDAO.searchAccounts(null, null, User.AccountStatus.Active, 0, 500));
    }

    /**
     * Kiểm tra và lưu ảnh thông báo hợp lệ vào thư mục upload, sau đó trả về đường dẫn ảnh tương đối.
     */
    private String saveUploadedImage(HttpServletRequest request) throws IOException, ServletException {
        Part part = request.getPart("notificationImage");
        if (part == null || part.getSize() == 0) {
            return null;
        }

        String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        if (originalFileName == null || originalFileName.trim().isEmpty()) {
            return null;
        }

        String extension = getFileExtension(originalFileName);
        if (!isAllowedExtension(extension)) {
            throw new IllegalArgumentException("Ảnh thông báo không hợp lệ. Chỉ hỗ trợ JPG, JPEG, PNG, GIF, WEBP.");
        }

        String contentType = part.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
            throw new IllegalArgumentException("Tệp tải lên phải là hình ảnh.");
        }

        String safeFileName = originalFileName.replaceAll("[^A-Za-z0-9._-]", "_");
        String uniqueFileName = "notification_" + System.currentTimeMillis() + "_" + safeFileName;
        String realUploadPath = getServletContext().getRealPath("/") + NOTIFICATION_UPLOAD_DIR;

        File uploadFolder = new File(realUploadPath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        part.write(realUploadPath + File.separator + uniqueFileName);
        return NOTIFICATION_UPLOAD_DIR + "/" + uniqueFileName;
    }

    /**
     * Lấy phần mở rộng của tên tệp ảnh để kiểm tra định dạng được phép.
     */
    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    /**
     * Kiểm tra phần mở rộng ảnh có nằm trong danh sách JPG, JPEG, PNG, GIF hoặc WEBP hay không.
     */
    private boolean isAllowedExtension(String extension) {
        for (String allowed : ALLOWED_IMAGE_EXTENSIONS) {
            if (allowed.equals(extension)) {
                return true;
            }
        }
        return false;
    }
}
