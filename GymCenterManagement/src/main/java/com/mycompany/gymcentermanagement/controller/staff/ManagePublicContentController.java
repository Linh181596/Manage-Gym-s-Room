package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentStatus;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PublicContentService;
import com.mycompany.gymcentermanagement.service.impl.PublicContentServiceImpl;
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
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@WebServlet(name = "ManagePublicContentController", urlPatterns = {"/staff/public-content"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 8 * 1024 * 1024
)
public class ManagePublicContentController extends HttpServlet {

    private static final String UPLOAD_DIR = "/assets/uploads/public-content";
    private static final Set<String> ALLOWED_IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");
    private final PublicContentService publicContentService = new PublicContentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        try {
            switch (action) {
                case "create" -> showForm(request, response, new PublicContent(), "Thêm nội dung công khai");
                case "edit" -> {
                    PublicContent content = publicContentService.getById(parseId(request));
                    if (content == null) {
                        response.sendRedirect(request.getContextPath() + "/staff/public-content");
                        return;
                    }
                    showForm(request, response, content, "Cập nhật nội dung công khai");
                }
                case "delete" -> {
                    publicContentService.delete(parseId(request), getCurrentUser(request));
                    redirectWithMessage(request, response, "Đã xóa nội dung.");
                }
                default -> showList(request, response);
            }
        } catch (SQLException | IllegalArgumentException | SecurityException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            showList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PublicContent content = bindContent(request);
            User currentUser = getCurrentUser(request);
            publicContentService.save(content, currentUser);
            redirectWithMessage(request, response, "Đã lưu nội dung công khai.");
        } catch (SQLException | IllegalArgumentException | SecurityException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            PublicContent content = bindContentWithoutUpload(request);
            showForm(request, response, content, content.getContentId() > 0 ? "Cap nhat noi dung cong khai" : "Them noi dung cong khai");
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("contents", publicContentService.getManagementList());
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Không thể tải danh sách nội dung.");
        }
        request.getRequestDispatcher("/WEB-INF/views/content/content-list.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, PublicContent content, String formTitle)
            throws ServletException, IOException {
        request.setAttribute("content", content);
        request.setAttribute("formTitle", formTitle);
        request.setAttribute("isAdmin", isAdmin(request));
        request.getRequestDispatcher("/WEB-INF/views/content/content-form.jsp").forward(request, response);
    }

    private PublicContent bindContent(HttpServletRequest request) throws IOException, ServletException {
        PublicContent content = bindContentWithoutUpload(request);
        if (content.getContentType() == ContentType.POLICY) {
            content.setThumbnailUrl(null);
            return content;
        }
        String uploadedThumbnail = resolveThumbnailUrl(request);
        if (uploadedThumbnail != null) {
            content.setThumbnailUrl(uploadedThumbnail);
        }
        return content;
    }

    private PublicContent bindContentWithoutUpload(HttpServletRequest request) {
        PublicContent content = new PublicContent();
        String idParam = request.getParameter("contentId");
        if (idParam != null && !idParam.isBlank()) {
            content.setContentId(Integer.parseInt(idParam));
        }
        content.setTitle(trim(request.getParameter("title")));
        content.setSummary(trim(request.getParameter("summary")));
        content.setBody(trim(request.getParameter("body")));
        content.setContentType(ContentType.valueOf(request.getParameter("contentType")));
        content.setCategory(trim(request.getParameter("category")));
        content.setThumbnailUrl(trim(request.getParameter("existingThumbnailUrl")));
        String status = request.getParameter("status");
        content.setStatus(status == null || status.isBlank() ? ContentStatus.Draft : ContentStatus.valueOf(status));
        return content;
    }

    private String resolveThumbnailUrl(HttpServletRequest request) throws IOException, ServletException {
        Part imagePart = request.getPart("thumbnailFile");
        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        String submittedName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = extensionOf(submittedName);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Ảnh đại diện chỉ hỗ trợ jpg, jpeg, png, gif hoặc webp.");
        }

        String realUploadPath = getServletContext().getRealPath(UPLOAD_DIR);
        if (realUploadPath == null) {
            throw new IOException("Không xác định được thư mục lưu ảnh.");
        }

        Files.createDirectories(Path.of(realUploadPath));
        String fileName = UUID.randomUUID() + "." + extension;
        Path target = Path.of(realUploadPath, fileName);
        imagePart.write(target.toString());
        return UPLOAD_DIR.substring(1) + "/" + fileName;
    }

    private String extensionOf(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == fileName.length() - 1) {
            throw new IllegalArgumentException("Ảnh đại diện cần có phần mở rộng hợp lệ.");
        }
        return fileName.substring(dotIndex + 1).toLowerCase(Locale.ROOT);
    }

    private int parseId(HttpServletRequest request) {
        return Integer.parseInt(request.getParameter("id"));
    }

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null ? null : (User) session.getAttribute("currentUser");
    }

    private boolean isAdmin(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null && user.getRole() == User.Role.Admin;
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/staff/public-content?successMsg="
                + URLEncoder.encode(message, StandardCharsets.UTF_8));
    }
}
