package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.model.entity.User;
import java.sql.SQLException;
import java.util.List;

public interface PublicContentService {

    List<PublicContent> getFeaturedPublished(ContentType type, int limit) throws SQLException;

    List<PublicContent> getPublishedByType(ContentType type) throws SQLException;

    List<PublicContent> getPublishedByType(ContentType type, String keyword, String category, int page, int pageSize) throws SQLException;

    int countPublishedByType(ContentType type, String keyword, String category) throws SQLException;

    PublicContent getPublishedById(int contentId, ContentType type) throws SQLException;

    List<PublicContent> getManagementList() throws SQLException;

    PublicContent getById(int contentId) throws SQLException;

    void save(PublicContent content, User currentUser) throws SQLException;

    void delete(int contentId, User currentUser) throws SQLException;
}
