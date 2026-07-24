package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.PublicContentDAO;
import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentStatus;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PublicContentDAOImpl extends BaseDAO implements PublicContentDAO {

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private PublicContent mapContent(ResultSet rs) throws SQLException {
        PublicContent content = new PublicContent();
        content.setContentId(rs.getInt("ContentID"));
        content.setTitle(rs.getString("Title"));
        content.setSummary(rs.getString("Summary"));
        content.setBody(rs.getString("Body"));
        content.setContentType(ContentType.valueOf(rs.getString("ContentType")));
        content.setCategory(rs.getString("Category"));
        content.setThumbnailUrl(rs.getString("ThumbnailURL"));
        content.setStatus(ContentStatus.valueOf(rs.getString("Status")));
        Timestamp publishedAt = rs.getTimestamp("PublishedAt");
        if (publishedAt != null) {
            content.setPublishedAt(publishedAt.toLocalDateTime());
        }
        content.setCreatedBy(rs.getString("CreatedBy"));
        Timestamp createdAt = rs.getTimestamp("CreatedAt");
        if (createdAt != null) {
            content.setCreatedAt(createdAt.toLocalDateTime());
        }
        content.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
        if (updatedAt != null) {
            content.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        content.setDeleted(rs.getBoolean("IsDeleted"));
        return content;
    }

    /**
     * Tìm danh sách nội dung nổi bật (Featured).
     * Luồng nghiệp vụ: Lấy các nội dung mới nhất đã được Publish để hiển thị (ví dụ: Trang chủ).
     * 
     * @param type Loại nội dung
     * @param limit Số lượng muốn lấy
     * @return Danh sách nội dung
     * @throws SQLException 
     */
    @Override
    public List<PublicContent> findFeaturedPublished(ContentType type, int limit) throws SQLException {
        // SQL: Lấy TOP(limit) nội dung có trạng thái Published, ưu tiên ngày PublishedAt
        String sql = """
                SELECT TOP (?) *
                FROM PublicContents
                WHERE ContentType = ? AND Status = 'Published' AND IsDeleted = 0
                ORDER BY COALESCE(PublishedAt, CreatedAt) DESC, ContentID DESC
                """;
        return queryList(sql, stmt -> {
            stmt.setInt(1, Math.max(1, limit));
            stmt.setString(2, type.name());
        });
    }

    @Override
    public List<PublicContent> findPublishedByType(ContentType type) throws SQLException {
        String sql = """
                SELECT *
                FROM PublicContents
                WHERE ContentType = ? AND Status = 'Published' AND IsDeleted = 0
                ORDER BY COALESCE(PublishedAt, CreatedAt) DESC, ContentID DESC
                """;
        return queryList(sql, stmt -> stmt.setString(1, type.name()));
    }

    @Override
    public List<PublicContent> findPublishedByType(ContentType type, String keyword, String category, int offset, int limit) throws SQLException {
        String searchPattern = toSearchPattern(keyword);
        String sql = """
                SELECT *
                FROM PublicContents
                WHERE ContentType = ? AND Status = 'Published' AND IsDeleted = 0
                  AND (? IS NULL OR Title LIKE ? OR Summary LIKE ?)
                  AND (? IS NULL OR Category = ?)
                ORDER BY COALESCE(PublishedAt, CreatedAt) DESC, ContentID DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;
        return queryList(sql, stmt -> {
            stmt.setString(1, type.name());
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, trimToNull(category));
            stmt.setString(6, trimToNull(category));
            stmt.setInt(7, Math.max(0, offset));
            stmt.setInt(8, Math.max(1, limit));
        });
    }

    @Override
    public int countPublishedByType(ContentType type, String keyword, String category) throws SQLException {
        String searchPattern = toSearchPattern(keyword);
        String sql = """
                SELECT COUNT(*)
                FROM PublicContents
                WHERE ContentType = ? AND Status = 'Published' AND IsDeleted = 0
                  AND (? IS NULL OR Title LIKE ? OR Summary LIKE ?)
                  AND (? IS NULL OR Category = ?)
                """;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, type.name());
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, trimToNull(category));
            stmt.setString(6, trimToNull(category));
            rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            closeResource(conn, stmt, rs);
        }
    }

    @Override
    public PublicContent findPublishedById(int contentId, ContentType type) throws SQLException {
        String sql = """
                SELECT *
                FROM PublicContents
                WHERE ContentID = ? AND ContentType = ? AND Status = 'Published' AND IsDeleted = 0
                """;
        return queryOne(sql, stmt -> {
            stmt.setInt(1, contentId);
            stmt.setString(2, type.name());
        });
    }

    @Override
    public List<PublicContent> findAllForManagement() throws SQLException {
        String sql = """
                SELECT *
                FROM PublicContents
                WHERE IsDeleted = 0
                ORDER BY ContentType, ContentID DESC
                """;
        return queryList(sql, stmt -> {
        });
    }

    @Override
    public PublicContent findById(int contentId) throws SQLException {
        String sql = "SELECT * FROM PublicContents WHERE ContentID = ? AND IsDeleted = 0";
        return queryOne(sql, stmt -> stmt.setInt(1, contentId));
    }

    private String toSearchPattern(String keyword) {
        String normalized = trimToNull(keyword);
        if (normalized == null) {
            return null;
        }
        return "%" + normalized + "%";
    }

    private String trimToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    @Override
    public boolean insert(PublicContent content) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet keys = null;
        try {
            conn = getActiveConnection();
            String sql = """
                    INSERT INTO PublicContents
                    (Title, Summary, Body, ContentType, Category, ThumbnailURL, Status, PublishedAt, CreatedBy, CreatedAt, IsDeleted)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)
                    """;
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            bindContentForSave(stmt, content);
            stmt.setString(9, content.getCreatedBy());
            boolean success = stmt.executeUpdate() > 0;
            if (success) {
                keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    content.setContentId(keys.getInt(1));
                }
            }
            return success;
        } finally {
            closeResource(conn, stmt, keys);
        }
    }

    @Override
    public boolean update(PublicContent content) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = getActiveConnection();
            String sql = """
                    UPDATE PublicContents
                    SET Title = ?, Summary = ?, Body = ?, ContentType = ?, Category = ?, ThumbnailURL = ?,
                        Status = ?, PublishedAt = ?, UpdatedBy = ?, UpdatedAt = SYSDATETIME()
                    WHERE ContentID = ? AND IsDeleted = 0
                    """;
            stmt = conn.prepareStatement(sql);
            bindContentForSave(stmt, content);
            stmt.setString(9, content.getUpdatedBy());
            stmt.setInt(10, content.getContentId());
            return stmt.executeUpdate() > 0;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    /**
     * Xóa mềm một nội dung.
     * Luồng nghiệp vụ:
     * 1. [BR-COMP-55]: Nội dung khi xóa sẽ không mất khỏi DB mà được đánh dấu 'IsDeleted = 1'.
     * 
     * @param contentId ID
     * @return true nếu thành công
     * @throws SQLException 
     */
    @Override
    public boolean softDelete(int contentId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = getActiveConnection();
            // SQL: Đánh dấu IsDeleted = 1 để xóa mềm
            stmt = conn.prepareStatement("UPDATE PublicContents SET IsDeleted = 1, UpdatedAt = SYSDATETIME() WHERE ContentID = ?");
            stmt.setInt(1, contentId);
            return stmt.executeUpdate() > 0;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    private void bindContentForSave(PreparedStatement stmt, PublicContent content) throws SQLException {
        stmt.setString(1, content.getTitle());
        stmt.setString(2, content.getSummary());
        stmt.setString(3, content.getBody());
        stmt.setString(4, content.getContentType().name());
        stmt.setString(5, content.getCategory());
        stmt.setString(6, content.getThumbnailUrl());
        stmt.setString(7, content.getStatus().name());
        stmt.setTimestamp(8, content.getPublishedAt() == null ? null : Timestamp.valueOf(content.getPublishedAt()));
    }

    private PublicContent queryOne(String sql, StatementBinder binder) throws SQLException {
        List<PublicContent> items = queryList(sql, binder);
        return items.isEmpty() ? null : items.get(0);
    }

    private List<PublicContent> queryList(String sql, StatementBinder binder) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PublicContent> items = new ArrayList<>();
        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            binder.bind(stmt);
            rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(mapContent(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return items;
    }

    @FunctionalInterface
    private interface StatementBinder {
        void bind(PreparedStatement stmt) throws SQLException;
    }
}
