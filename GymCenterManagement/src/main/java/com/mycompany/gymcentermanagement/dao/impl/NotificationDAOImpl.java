package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.NotificationDAO;
import com.mycompany.gymcentermanagement.model.entity.Notification;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAOImpl extends BaseDAO implements NotificationDAO {

    public NotificationDAOImpl() {
        super();
    }

    public NotificationDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private Notification mapResultSetToNotification(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setNotificationId(rs.getInt("NotificationID"));
        notification.setTitle(rs.getString("Title"));
        notification.setContent(rs.getString("Content"));
        notification.setCreatedBy(rs.getInt("CreatedBy"));
        notification.setTargetRole(rs.getString("TargetRole"));
        notification.setCreatedByRole(rs.getString("CreatedByRole"));

        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            notification.setCreatedDate(createdTs.toLocalDateTime());
        }

        notification.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            notification.setUpdatedDate(updatedTs.toLocalDateTime());
        }

        Timestamp publishTs = rs.getTimestamp("PublishDate");
        if (publishTs != null) {
            notification.setPublishDate(publishTs.toLocalDateTime());
        }

        Timestamp expiryTs = rs.getTimestamp("ExpiryDate");
        if (expiryTs != null) {
            notification.setExpiryDate(expiryTs.toLocalDateTime());
        }

        notification.setNotificationImageUrl(rs.getString("NotificationImageURL"));

        notification.setDeleted(rs.getBoolean("IsDeleted"));
        return notification;
    }

    @Override
    public List<Notification> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Notification> list = new ArrayList<>();

        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM Notifications WHERE IsDeleted = 0 ORDER BY PublishDate DESC, NotificationID DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToNotification(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public List<Notification> findAllPaginated(int offset, int limit) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Notification> list = new ArrayList<>();

        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM Notifications WHERE IsDeleted = 0 "
                    + "ORDER BY PublishDate DESC, NotificationID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Math.max(0, offset));
            stmt.setInt(2, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToNotification(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    @Override
    public Notification findById(int notificationId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            String sql = "SELECT * FROM Notifications WHERE NotificationID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, notificationId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToNotification(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return null;
    }

    @Override
    public boolean insert(Notification notification) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = getActiveConnection();
            String sql = "INSERT INTO Notifications "
                    + "(Title, Content, CreatedBy, TargetRole, CreatedByRole, CreatedDate, PublishDate, ExpiryDate, NotificationImageURL, IsDeleted) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, notification.getTitle());
            stmt.setString(2, notification.getContent());
            stmt.setInt(3, notification.getCreatedBy());
            stmt.setString(4, notification.getTargetRole());
            stmt.setString(5, notification.getCreatedByRole());
            stmt.setTimestamp(6, notification.getCreatedDate() != null
                    ? Timestamp.valueOf(notification.getCreatedDate())
                    : new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(7, notification.getPublishDate() != null
                    ? Timestamp.valueOf(notification.getPublishDate())
                    : new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(8, notification.getExpiryDate() != null
                    ? Timestamp.valueOf(notification.getExpiryDate())
                    : null);
            stmt.setString(9, notification.getNotificationImageUrl());

            boolean success = stmt.executeUpdate() > 0;
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    notification.setNotificationId(generatedKeys.getInt(1));
                }
            }
            return success;
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
    }

    @Override
    public boolean update(Notification notification) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();
            String sql = "UPDATE Notifications SET Title = ?, Content = ?, TargetRole = ?, UpdatedBy = ?, UpdatedDate = ?, "
                    + "PublishDate = ?, ExpiryDate = ?, NotificationImageURL = ? "
                    + "WHERE NotificationID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, notification.getTitle());
            stmt.setString(2, notification.getContent());
            stmt.setString(3, notification.getTargetRole());
            stmt.setString(4, notification.getUpdatedBy());
            stmt.setTimestamp(5, notification.getUpdatedDate() != null
                    ? Timestamp.valueOf(notification.getUpdatedDate())
                    : new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(6, notification.getPublishDate() != null
                    ? Timestamp.valueOf(notification.getPublishDate())
                    : new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(7, notification.getExpiryDate() != null
                    ? Timestamp.valueOf(notification.getExpiryDate())
                    : null);
            stmt.setString(8, notification.getNotificationImageUrl());
            stmt.setInt(9, notification.getNotificationId());
            return stmt.executeUpdate() > 0;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public boolean delete(int notificationId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getActiveConnection();
            String sql = "UPDATE Notifications SET IsDeleted = 1 WHERE NotificationID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, notificationId);
            return stmt.executeUpdate() > 0;
        } finally {
            closeResource(conn, stmt, null);
        }
    }

    @Override
    public int countAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            String sql = "SELECT COUNT(*) FROM Notifications WHERE IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return 0;
    }
}
