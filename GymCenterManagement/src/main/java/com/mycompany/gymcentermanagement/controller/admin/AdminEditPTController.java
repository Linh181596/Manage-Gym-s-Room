/**
 * =========================================================================
 * @file          : AdminEditPTController.java
 * @description   : Controller xử lý việc chỉnh sửa hồ sơ thông tin và trạng thái hoạt động của PT bởi Admin.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;


@WebServlet(name = "AdminEditPTController", urlPatterns = {"/admin/pt/edit"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AdminEditPTController extends HttpServlet {
    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final UserService userService = new UserServiceImpl();

    //Load old i4 PT info for PT view
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idRaw = request.getParameter("id"); // Lấy ID trên URL
        if (idRaw == null || idRaw.trim().isEmpty()) {
            idRaw = request.getParameter("ptId");
        }

        try {
            if (idRaw == null || idRaw.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/pt/list?error=missing_id");
                return;
            }

            int ptId = Integer.parseInt(idRaw);
            
            // Check if pt is already set by doPost error forwarding
            PersonalTrainer pt = (PersonalTrainer) request.getAttribute("pt");
            if (pt == null) {
                pt = personalTrainerService.getPersonalTrainerById(ptId);
            }

            if (pt == null) {
                response.sendRedirect(request.getContextPath() + "/pt/list?error=notfound");
                return;
            }

            java.util.List<String> specOptions = java.util.List.of(
                "Quản lý cân nặng",
                "Tăng cơ",
                "Cardio",
                "Yoga",
                "Boxing",
                "Dinh dưỡng",
                "Phục hồi thể lực"
            );
            request.setAttribute("specOptions", specOptions);

            // Populate selectedSpecs list from PT specialization string
            if (request.getAttribute("selectedSpecs") == null && pt.getSpecialization() != null) {
                String[] parts = pt.getSpecialization().split(",");
                java.util.List<String> selectedSpecs = new java.util.ArrayList<>();
                for (String part : parts) {
                    selectedSpecs.add(part.trim());
                }
                request.setAttribute("selectedSpecs", selectedSpecs);
            }

            // Đẩy object sang form
            request.setAttribute("pt", pt);
            request.getRequestDispatcher("/WEB-INF/views/admin/edit-pt.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi hệ thống khi tải thông tin HLV", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");

        // Khai báo ngoài try-catch để giữ lại file path mới khi validate sau đó bị lỗi
        String avatarPath = req.getParameter("oldAvatarPath");
        String certPath = req.getParameter("oldCertPath");
        String certName = req.getParameter("oldCertName");
        String[] specializations = req.getParameterValues("specializations");

        try {
            // 1. Lấy thông tin cơ bản
            int ptId = Integer.parseInt(req.getParameter("ptId"));
            int userId = Integer.parseInt(req.getParameter("userId"));

            String fullName = req.getParameter("fullName");
            if (fullName != null) {
                fullName = fullName.trim();
            }
            if (fullName == null || fullName.isEmpty()) {
                throw new IllegalArgumentException("Họ và tên không được để trống.");
            }

            String phone = req.getParameter("phone");
            if (phone != null) {
                phone = phone.trim();
            }
            if (phone == null || phone.isEmpty()) {
                throw new IllegalArgumentException("Số điện thoại không được để trống.");
            }
            if (!phone.matches("^0\\d{9}$")) {
                throw new IllegalArgumentException("Số điện thoại phải bắt đầu bằng 0 và có đúng 10 chữ số.");
            }

            // Phòng chống Parameter Tampering (IDOR Protection) từ nhánh develop
            PersonalTrainer ptFromDb = personalTrainerService.getPersonalTrainerById(ptId);
            if (ptFromDb == null || ptFromDb.getUserId() != userId) {
                throw new IllegalArgumentException("Thông tin ID Huấn luyện viên không khớp.");
            }

            // Kiểm tra trùng số điện thoại nếu thay đổi số điện thoại từ nhánh develop
            if (!phone.equals(ptFromDb.getPhone())) {
                if (userService.checkPhoneExists(phone)) {
                    throw new IllegalArgumentException("Số điện thoại này đã tồn tại trong hệ thống. Vui lòng điền số khác!");
                }
            }

            // 2. Validate chuyên môn
            String specialization = null;
            if (specializations != null && specializations.length > 0) {
                specialization = String.join(", ", specializations);
                req.setAttribute("selectedSpecs", java.util.List.of(specializations));
            } else {
                req.setAttribute("selectedSpecs", java.util.List.of());
                throw new IllegalArgumentException("Vui lòng chọn ít nhất một chuyên môn của PT.");
            }

            // 3. Tiến hành upload file (lưu file trước để bảo toàn file tải lên khi gặp lỗi validate ở các bước sau)
            UploadedFile uploadedAvatar = saveUploadedFile(
                    req,
                    "avatarFile",
                    "assets/uploads/pt-avatar",
                    new String[]{"jpg", "jpeg", "png"}
            );
            if (uploadedAvatar.filePath != null) {
                avatarPath = uploadedAvatar.filePath;
            }

            UploadedFile uploadedCert = saveUploadedFile(
                    req,
                    "certificateFile",
                    "assets/uploads/pt-certificate",
                    new String[]{"pdf", "jpg", "jpeg", "png"}
            );
            if (uploadedCert.filePath != null) {
                certPath = uploadedCert.filePath;
                certName = uploadedCert.originalFileName;
            }

            // 4. Các thông tin khác
            String careerStartDate = req.getParameter("careerStartDate");
            String description = req.getParameter("description");

            // Kiểm tra giới hạn số lượng từ trong phần mô tả của PT (nhánh phund/...)
            if (description != null && countWords(description) > 500) {
                throw new IllegalArgumentException("Mô tả giới thiệu bản thân không được vượt quá 500 từ.");
            }

            String status = req.getParameter("status"); // Active / Inactive

            // 5. Cập nhật thông tin User & PT vào DB
            User userToUpdate = new User();
            userToUpdate.setUserId(userId);
            userToUpdate.setPhoneNumber(phone);
            userService.updateBasicUserInfo(userToUpdate);

            PersonalTrainer pt = new PersonalTrainer();
            pt.setPtId(ptId);
            pt.setUserId(userId);
            pt.setFullName(fullName);
            
            String displayName = req.getParameter("displayName");
            if (displayName != null && displayName.trim().isEmpty()) {
                displayName = null;
            }
            pt.setDisplayName(displayName);
            pt.setSpecialization(specialization);
            pt.setDescription(description);
            // Giữ nguyên trạng thái PT hiện tại từ CSDL (trạng thái được quản lý độc lập tại Quản lý Tài khoản)
            pt.setStatus(ptFromDb.getStatus());
            pt.setAvatarPath(avatarPath);
            pt.setCertificateFilePath(certPath);
            pt.setCertificateFileName(certName);
            pt.setUpdatedBy(currentUser.getEmail()); // Lưu vết người cập nhật

            if (careerStartDate != null && !careerStartDate.isEmpty()) {
                LocalDate careerDate = LocalDate.parse(careerStartDate);
                if (careerDate.isAfter(LocalDate.now())) {
                    throw new IllegalArgumentException("Ngày bắt đầu sự nghiệp không được lớn hơn ngày hiện tại.");
                }
                if (careerDate.isAfter(LocalDate.now().minusYears(1))) {
                    throw new IllegalArgumentException("Kinh nghiệm làm việc của PT phải tối thiểu từ 1 năm trở lên.");
                }
                if (careerDate.isBefore(LocalDate.now().minusYears(25))) {
                    throw new IllegalArgumentException("Kinh nghiệm làm việc của PT không được vượt quá 25 năm.");
                }
                pt.setCareerStartDate(careerDate);
            }

            boolean isSuccess = personalTrainerService.updatePersonalTrainer(pt);

            if (isSuccess) {
                req.getSession().setAttribute("toastMsg", "Cập nhật hồ sơ PT thành công!");
                resp.sendRedirect(req.getContextPath() + "/pt/list");
            } else {
                throw new Exception("Lỗi khi lưu vào CSDL");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            
            // Tái cấu trúc thông tin PT để trả lại giao diện khi có lỗi xảy ra
            try {
                int ptId = Integer.parseInt(req.getParameter("ptId"));
                int userId = Integer.parseInt(req.getParameter("userId"));
                PersonalTrainer pt = new PersonalTrainer();
                pt.setPtId(ptId);
                pt.setUserId(userId);
                pt.setFullName(req.getParameter("fullName"));
                pt.setPhone(req.getParameter("phone"));
                pt.setDisplayName(req.getParameter("displayName"));
                pt.setDescription(req.getParameter("description"));
                pt.setStatus(req.getParameter("status"));
                pt.setAvatarPath(avatarPath);
                pt.setCertificateFilePath(certPath);
                pt.setCertificateFileName(certName);
                
                if (specializations != null && specializations.length > 0) {
                    pt.setSpecialization(String.join(", ", specializations));
                    req.setAttribute("selectedSpecs", java.util.List.of(specializations));
                } else {
                    req.setAttribute("selectedSpecs", java.util.List.of());
                }
                
                String careerStartDate = req.getParameter("careerStartDate");
                if (careerStartDate != null && !careerStartDate.isEmpty()) {
                    pt.setCareerStartDate(LocalDate.parse(careerStartDate));
                }
                req.setAttribute("pt", pt);
            } catch (Exception ex) {
                // Bỏ qua lỗi tái cấu trúc
            }
            
            // Trả lại về form doGet
            doGet(req, resp);
        }
    }

    private UploadedFile saveUploadedFile(HttpServletRequest request, String partName,
                                          String uploadDirectory, String[] allowedExtensions)
            throws IOException, ServletException {
        Part part = request.getPart(partName);

        if (part == null || part.getSize() == 0) {
            return new UploadedFile(null, null);
        }

        // Bổ sung kiểm tra kích thước tối đa của file (5MB) từ nhánh phund/...
        long maxFileSize = 5 * 1024 * 1024; // 5MB
        if (part.getSize() > maxFileSize) {
            String fieldLabel = "avatarFile".equals(partName) ? "Ảnh đại diện" : "Chứng chỉ";
            throw new IllegalArgumentException(fieldLabel + " vượt quá kích thước giới hạn cho phép (tối đa 5MB).");
        }

        String originalFileName = Paths.get(part.getSubmittedFileName())
                .getFileName()
                .toString();

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
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    private boolean isAllowedExtension(String extension, String[] allowedExtensions) {
        for (String allowedExtension : allowedExtensions) {
            if (allowedExtension.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }

    // Hàm đếm số lượng từ phục vụ validate độ dài phần mô tả giới thiệu
    private int countWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        return text.trim().split("\\s+").length;
    }

    private static class UploadedFile {
        private final String originalFileName;
        private final String filePath;

        private UploadedFile(String originalFileName, String filePath) {
            this.originalFileName = originalFileName;
            this.filePath = filePath;
        }
    }
}
