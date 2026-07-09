package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.sql.SQLException;
import java.util.List;

public interface NotificationService {
    List<Notification> getAllNotifications() throws SQLException;
    List<Notification> getNotificationsPaginated(int offset, int limit) throws SQLException;
    Notification getNotificationById(int id) throws SQLException;
    boolean createNotification(Notification notification) throws SQLException;
    boolean updateNotification(Notification notification) throws SQLException;
    boolean deleteNotification(int id) throws SQLException;
    int getNotificationsCount() throws SQLException;
    boolean isValidTargetRole(String targetRole);
    boolean userExists(int userId) throws SQLException;
}
