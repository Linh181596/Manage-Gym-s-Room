package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import java.sql.SQLException;
import java.util.List;

public interface PublicContentDAO {

    /**
     * Tìm nội dung đã đăng nổi bật theo loại nội dung và giới hạn số lượng.
     */
    List<PublicContent> findFeaturedPublished(ContentType type, int limit) throws SQLException;

    /**
     * Tìm toàn bộ nội dung đã đăng theo loại Blog hoặc Policy.
     */
    List<PublicContent> findPublishedByType(ContentType type) throws SQLException;

    /**
     * Tìm nội dung đã đăng theo loại, từ khóa, danh mục và phân trang.
     */
    List<PublicContent> findPublishedByType(ContentType type, String keyword, String category, int offset, int limit) throws SQLException;

    /**
     * Đếm nội dung đã đăng theo bộ lọc để phục vụ phân trang.
     */
    int countPublishedByType(ContentType type, String keyword, String category) throws SQLException;

    /**
     * Tìm chi tiết nội dung đã đăng theo id và loại nội dung.
     */
    PublicContent findPublishedById(int contentId, ContentType type) throws SQLException;

    /**
     * Tìm tất cả nội dung chưa bị xóa mềm cho màn quản lý.
     */
    List<PublicContent> findAllForManagement() throws SQLException;

    /**
     * Tìm chi tiết nội dung chưa bị xóa mềm theo id.
     */
    PublicContent findById(int contentId) throws SQLException;

    /**
     * Thêm mới nội dung công khai.
     */
    boolean insert(PublicContent content) throws SQLException;

    /**
     * Cập nhật nội dung công khai.
     */
    boolean update(PublicContent content) throws SQLException;

    /**
     * Xóa mềm nội dung công khai theo id.
     */
    boolean softDelete(int contentId) throws SQLException;
}
