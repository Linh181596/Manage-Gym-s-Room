package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

@WebServlet(name = "PTProfileController", urlPatterns = {"/pt/edit-profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class PTProfileController extends HttpServlet {
    private static final String EDIT_PT_VIEW = "/WEB-INF/views/pt/edit-profile.jsp";
    private static final String AVATAR_UPLOAD_DIR = "assets/uploads/pt-avatar";

    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();

    // =========================================================================
    // CÁC HÀM TIỆN ÍCH (Giữ nguyên chuẩn code hiện tại của dự án)
    // =========================================================================

    private void forwardBackWithError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser != null) {
            PersonalTrainer pt = personalTrainerService.getPTByUserId(currentUser.getUserId());
            if (pt != null) {
                String displayName = request.getParameter("displayName");
                String description = request.getParameter("description");
                if (displayName != null) pt.setDisplayName(displayName);
                if (description != null) pt.setDescription(description);
            }
            request.setAttribute("pt", pt);
        }
        request.getRequestDispatcher(EDIT_PT_VIEW).forward(request, response);
    }

    private String trimToNull(String value) {
        if (value == null) return null;
        String trimmedValue = value.trim();
        return trimmedValue.isEmpty() ? null : trimmedValue;
    }

    private UploadedFile saveUploadedFile(HttpServletRequest request, String partName,
                                          String uploadDirectory, String[] allowedExtensions) throws IOException, ServletException {
        Part part = request.getPart(partName);

        // NẾU PT KHÔNG UPLOAD ẢNH MỚI -> Trả về null
        if (part == null || part.getSize() == 0) {
            return new UploadedFile(null, null);
        }

        long maxFileSize = 5 * 1024 * 1024; // 5MB
        if (part.getSize() > maxFileSize) {
            String fieldLabel = "avatarFile".equals(partName) ? "Ảnh đại diện" : "Chứng chỉ";
            throw new IllegalArgumentException(fieldLabel + " vượt quá kích thước giới hạn cho phép (tối đa 5MB).");
        }

        String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

        if (originalFileName == null || originalFileName.trim().isEmpty()) {
            return new UploadedFile(null, null);
        }

        String extension = getFileExtension(originalFileName);

        if (!isAllowedExtension(extension, allowedExtensions)) {
            throw new IllegalArgumentException("File không hợp lệ. Chỉ hỗ trợ: "
                    + String.join(", ", allowedExtensions).toUpperCase() + ".");
        }

        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;
        String realUploadPath = getServletContext().getRealPath("/") + uploadDirectory;

        File uploadFolder = new File(realUploadPath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String realFilePath = realUploadPath + File.separator + uniqueFileName;
        part.write(realFilePath);

        String relativeFilePath = uploadDirectory + "/" + uniqueFileName;
        return new UploadedFile(originalFileName, relativeFilePath);
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) return "";
        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    private boolean isAllowedExtension(String extension, String[] allowedExtensions) {
        for (String allowedExtension : allowedExtensions) {
            if (allowedExtension.equalsIgnoreCase(extension)) return true;
        }
        return false;
    }

    private static class UploadedFile {
        private final String originalFileName;
        private final String filePath;

        private UploadedFile(String originalFileName, String filePath) {
            this.originalFileName = originalFileName;
            this.filePath = filePath;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy thông tin user đang đăng nhập
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy hồ sơ PT dựa trên UserID
        // (Lưu ý: Bạn cần thêm hàm getPTByUserId vào Service và DAO nhé)
        PersonalTrainer pt = personalTrainerService.getPTByUserId(currentUser.getUserId());

        if (pt == null) {
            response.getWriter().println("Lỗi: Không tìm thấy hồ sơ chuyên môn của bạn!");
            return;
        }

        // 3. Đẩy đối tượng PT sang JSP
        request.setAttribute("pt", pt);

        // 4. Mở trang form
        request.getRequestDispatcher(EDIT_PT_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            //Get text data
            String ptRawId = trimToNull(req.getParameter("ptId"));
            String displayName = trimToNull(req.getParameter("displayName"));
            String description = trimToNull(req.getParameter("description"));

            if (description != null && countWords(description) > 500) {
                forwardBackWithError(req, resp, "Tiểu sử (Bio) không được vượt quá 500 từ.");
                return;
            }

            if (ptRawId == null) {
                forwardBackWithError(req, resp, "Lỗi hệ thống: Không tìm thấy ID của PT.");
                return;
            }
            int ptId = Integer.parseInt(ptRawId);

            PersonalTrainer ptFromDb = personalTrainerService.getPTByUserId(currentUser.getUserId());
            if (ptFromDb == null || ptFromDb.getPtId() != ptId) {
                forwardBackWithError(req, resp, "Cảnh báo bảo mật: Bạn không có quyền chỉnh sửa hồ sơ này!");
                return;
            }

            //File upload(Save new avatar(if))
            String avatarPath = null;

            try { 
                UploadedFile avatarFile = saveUploadedFile(req, "avatarFile", AVATAR_UPLOAD_DIR, new String[]{"jpg", "jpeg", "png"});
                avatarPath = avatarFile.filePath; // Lấy path từ file vừa lưu
            } catch (IllegalArgumentException e) {
                forwardBackWithError(req, resp, e.getMessage());
                return;
            }

            //Package data to Personal Trainer
            PersonalTrainer pt = new PersonalTrainer();
            pt.setPtId(ptId);
            pt.setDisplayName(displayName);
            pt.setDescription(description);
            pt.setAvatarPath(avatarPath); 
            pt.setUpdatedBy(currentUser.getEmail()); 

            boolean isSuccess = personalTrainerService.updateProfile(pt);

            if (isSuccess) {
                // Cập nhật lại thông tin PT mới nhất vào session (nếu cần hiển thị avatar ngay)
                if (avatarPath != null) {
                    // Cập nhật lại đường dẫn avatar trong object currentUser để navbar hiển thị ngay
                    currentUser.setAvatarPath(avatarPath);
                }
                
                // Lấy lại thông tin PT đầy đủ sau khi update để chắc chắn đồng bộ
                PersonalTrainer updatedPt = personalTrainerService.getPTByUserId(currentUser.getUserId());
                req.setAttribute("pt", updatedPt);
                
                session.setAttribute("toastMsg", "Cập nhật hồ sơ thành công!");
                resp.sendRedirect(req.getContextPath() + "/pt/profile");
            } else {
                forwardBackWithError(req, resp, "Cập nhật hồ sơ thất bại. Vui lòng thử lại.");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            forwardBackWithError(req, resp, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    private int countWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        return text.trim().split("\\s+").length;
    }
}
