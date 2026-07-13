package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PublicContentDAO;
import com.mycompany.gymcentermanagement.dao.impl.PublicContentDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentStatus;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PublicContentService;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class PublicContentServiceImpl implements PublicContentService {

    private final PublicContentDAO publicContentDAO = new PublicContentDAOImpl();

    @Override
    public List<PublicContent> getFeaturedPublished(ContentType type, int limit) throws SQLException {
        return publicContentDAO.findFeaturedPublished(type, limit);
    }

    @Override
    public List<PublicContent> getPublishedByType(ContentType type) throws SQLException {
        return publicContentDAO.findPublishedByType(type);
    }

    @Override
    public List<PublicContent> getPublishedByType(ContentType type, String keyword, String category, int page, int pageSize) throws SQLException {
        int safePage = Math.max(1, page);
        int safePageSize = Math.max(1, pageSize);
        int offset = (safePage - 1) * safePageSize;
        return publicContentDAO.findPublishedByType(type, keyword, category, offset, safePageSize);
    }

    @Override
    public int countPublishedByType(ContentType type, String keyword, String category) throws SQLException {
        return publicContentDAO.countPublishedByType(type, keyword, category);
    }

    @Override
    public PublicContent getPublishedById(int contentId, ContentType type) throws SQLException {
        return publicContentDAO.findPublishedById(contentId, type);
    }

    @Override
    public List<PublicContent> getManagementList() throws SQLException {
        return publicContentDAO.findAllForManagement();
    }

    @Override
    public PublicContent getById(int contentId) throws SQLException {
        return publicContentDAO.findById(contentId);
    }

    @Override
    public void save(PublicContent content, User currentUser) throws SQLException {
        validateContent(content);
        normalizePermissions(content, currentUser);
        applyPublishedAt(content);

        String actorName = currentUser == null ? "System" : currentUser.getFullName();
        if (content.getContentId() <= 0) {
            content.setCreatedBy(actorName);
            publicContentDAO.insert(content);
        } else {
            content.setUpdatedBy(actorName);
            publicContentDAO.update(content);
        }
    }

    @Override
    public void delete(int contentId, User currentUser) throws SQLException {
        requireAdmin(currentUser);
        publicContentDAO.softDelete(contentId);
    }

    private void validateContent(PublicContent content) {
        if (content == null) {
            throw new IllegalArgumentException("Noi dung khong hop le.");
        }
        if (isBlank(content.getTitle())) {
            throw new IllegalArgumentException("Vui long nhap tieu de.");
        }
        if (isBlank(content.getSummary())) {
            throw new IllegalArgumentException("Vui long nhap mo ta ngan.");
        }
        if (isBlank(content.getBody())) {
            throw new IllegalArgumentException("Vui long nhap noi dung chi tiet.");
        }
        if (content.getContentType() == null) {
            throw new IllegalArgumentException("Vui long chon loai noi dung.");
        }
        if (content.getStatus() == null) {
            content.setStatus(ContentStatus.Draft);
        }
        if (content.getContentType() == ContentType.POLICY) {
            content.setThumbnailUrl(null);
        }
    }

    private void normalizePermissions(PublicContent content, User currentUser) {
        if (currentUser == null || (currentUser.getRole() != User.Role.Admin && currentUser.getRole() != User.Role.Staff)) {
            throw new SecurityException("Ban khong co quyen quan ly noi dung.");
        }
        if (currentUser.getRole() == User.Role.Staff) {
            content.setStatus(ContentStatus.Draft);
        }
    }

    private void requireAdmin(User currentUser) {
        if (currentUser == null || currentUser.getRole() != User.Role.Admin) {
            throw new SecurityException("Chi Admin moi duoc xoa noi dung.");
        }
    }

    private void applyPublishedAt(PublicContent content) {
        if (content.getStatus() == ContentStatus.Published && content.getPublishedAt() == null) {
            content.setPublishedAt(LocalDateTime.now());
        }
        if (content.getStatus() != ContentStatus.Published) {
            content.setPublishedAt(null);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
