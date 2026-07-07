package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.NotificationDAO;
import com.mycompany.gymcentermanagement.dao.impl.NotificationDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Notification;
import com.mycompany.gymcentermanagement.service.NotificationService;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class NotificationServiceImpl implements NotificationService {

    private static final Set<String> VALID_TARGET_ROLES = new HashSet<>(
            Arrays.asList("All", "Admin", "Staff", "Member", "PT"));

    private final NotificationDAO notificationDAO = new NotificationDAOImpl();

    @Override
    public List<Notification> getAllNotifications() throws SQLException {
        return notificationDAO.findAll();
    }

    @Override
    public List<Notification> getNotificationsPaginated(int offset, int limit) throws SQLException {
        return notificationDAO.findAllPaginated(offset, limit);
    }

    @Override
    public Notification getNotificationById(int id) throws SQLException {
        return notificationDAO.findById(id);
    }

    @Override
    public boolean createNotification(Notification notification) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        notification.setCreatedDate(now);
        if (notification.getPublishDate() == null) {
            notification.setPublishDate(now);
        }
        notification.setDeleted(false);
        return notificationDAO.insert(notification);
    }

    @Override
    public boolean updateNotification(Notification notification) throws SQLException {
        notification.setUpdatedDate(LocalDateTime.now());
        return notificationDAO.update(notification);
    }

    @Override
    public boolean deleteNotification(int id) throws SQLException {
        return notificationDAO.delete(id);
    }

    @Override
    public int getNotificationsCount() throws SQLException {
        return notificationDAO.countAll();
    }

    @Override
    public boolean isValidTargetRole(String targetRole) {
        return targetRole != null && VALID_TARGET_ROLES.contains(targetRole.trim());
    }
}
