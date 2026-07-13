package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import java.sql.SQLException;
import java.util.List;

public interface PublicContentDAO {

    List<PublicContent> findFeaturedPublished(ContentType type, int limit) throws SQLException;

    List<PublicContent> findPublishedByType(ContentType type) throws SQLException;

    List<PublicContent> findPublishedByType(ContentType type, String keyword, String category, int offset, int limit) throws SQLException;

    int countPublishedByType(ContentType type, String keyword, String category) throws SQLException;

    PublicContent findPublishedById(int contentId, ContentType type) throws SQLException;

    List<PublicContent> findAllForManagement() throws SQLException;

    PublicContent findById(int contentId) throws SQLException;

    boolean insert(PublicContent content) throws SQLException;

    boolean update(PublicContent content) throws SQLException;

    boolean softDelete(int contentId) throws SQLException;
}
