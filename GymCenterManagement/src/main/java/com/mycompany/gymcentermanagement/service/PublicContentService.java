package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.model.entity.User;
import java.sql.SQLException;
import java.util.List;

public interface PublicContentService {

    /**
     * Lấy danh sách nội dung đã đăng nổi bật theo loại nội dung và giới hạn số lượng.
     */
    List<PublicContent> getFeaturedPublished(ContentType type, int limit) throws SQLException;

    /**
     * Lấy toàn bộ nội dung đã đăng theo loại Blog hoặc Policy.
     */
    List<PublicContent> getPublishedByType(ContentType type) throws SQLException;

    /**
     * Lấy nội dung đã đăng theo loại, từ khóa, danh mục và phân trang.
     */
    List<PublicContent> getPublishedByType(ContentType type, String keyword, String category, int page, int pageSize) throws SQLException;

    /**
     * Đếm số nội dung đã đăng theo loại, từ khóa và danh mục để tính phân trang.
     */
    int countPublishedByType(ContentType type, String keyword, String category) throws SQLException;

    /**
     * Lấy chi tiết một nội dung đã đăng theo id và loại nội dung.
     */
    PublicContent getPublishedById(int contentId, ContentType type) throws SQLException;

    /**
     * Lấy danh sách nội dung cho màn quản lý nội bộ.
     */
    List<PublicContent> getManagementList() throws SQLException;

    /**
     * Lấy chi tiết một nội dung chưa bị xóa mềm theo id.
     */
    PublicContent getById(int contentId) throws SQLException;

    /**
     * Lưu nội dung công khai, tự quyết định tạo mới hoặc cập nhật theo contentId.
     */
    void save(PublicContent content, User currentUser) throws SQLException;

    /**
     * Xóa mềm nội dung công khai theo id.
     */
    void delete(int contentId, User currentUser) throws SQLException;
}
