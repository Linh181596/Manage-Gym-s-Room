package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.sql.SQLException;
import java.util.List;

public interface NotificationDAO {
    List<Notification> findAll() throws SQLException;
    List<Notification> findAllPaginated(int offset, int limit) throws SQLException;
    Notification findById(int notificationId) throws SQLException;
    boolean insert(Notification notification) throws SQLException;
    boolean update(Notification notification) throws SQLException;
    boolean delete(int notificationId) throws SQLException;
    int countAll() throws SQLException;
    boolean userExists(int userId) throws SQLException;
}
