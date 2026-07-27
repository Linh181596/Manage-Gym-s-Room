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
            Arrays.asList("All", "Staff", "Member", "PT", "Specific"));

    private final NotificationDAO notificationDAO = new NotificationDAOImpl();

    /**
     * Chuyển yêu cầu lấy toàn bộ thông báo chưa bị xóa xuống DAO.
     */
    @Override
    public List<Notification> getAllNotifications() throws SQLException {
        return notificationDAO.findAll();
    }

    /**
     * Chuyển yêu cầu lấy một trang thông báo xuống DAO.
     */
    @Override
    public List<Notification> getNotificationsPaginated(int offset, int limit) throws SQLException {
        return notificationDAO.findAllPaginated(offset, limit);
    }

    /**
     * Lấy một thông báo theo mã để phục vụ chỉnh sửa hoặc kiểm tra tồn tại.
     */
    @Override
    public Notification getNotificationById(int id) throws SQLException {
        return notificationDAO.findById(id);
    }

    /**
     * Tạo mới một thông báo.
     * Luồng nghiệp vụ:
     * 1. Set CreatedDate và PublishDate nếu chưa có.
     * 2. Insert vào DB.
     * 
     * @param notification Thông báo
     * @return true nếu thành công
     * @throws SQLException 
     */
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

    /**
     * Cập nhật thông báo.
     * Luồng nghiệp vụ:
     * 1. Set UpdatedDate.
     * 2. [BR-CONS-13]: Các thông báo được tạo tự động bởi hệ thống không được phép sửa (cần validate ở Controller).
     * 
     * @param notification Thông báo
     * @return true nếu thành công
     * @throws SQLException 
     */
    @Override
    public boolean updateNotification(Notification notification) throws SQLException {
        notification.setUpdatedDate(LocalDateTime.now());
        return notificationDAO.update(notification);
    }

    /**
     * Xóa thông báo (xóa mềm).
     * Luồng nghiệp vụ:
     * 1. [BR-CONS-13]: Các thông báo tự động (system-generated) không được phép xóa (cần validate ở Controller).
     * 
     * @param id ID thông báo
     * @return true nếu thành công
     * @throws SQLException 
     */
    @Override
    public boolean deleteNotification(int id) throws SQLException {
        return notificationDAO.delete(id);
    }

    /**
     * Đếm số thông báo chưa bị xóa để controller thiết lập phân trang.
     */
    @Override
    public int getNotificationsCount() throws SQLException {
        return notificationDAO.countAll();
    }

    /**
     * Kiểm tra role người nhận có hợp lệ theo các lựa chọn All, Staff, Member, PT hoặc Specific.
     */
    @Override
    public boolean isValidTargetRole(String targetRole) {
        return targetRole != null && VALID_TARGET_ROLES.contains(targetRole.trim());
    }

    /**
     * Kiểm tra người nhận cụ thể còn tồn tại trước khi lưu thông báo.
     */
    @Override
    public boolean userExists(int userId) throws SQLException {
        return notificationDAO.userExists(userId);
    }
}
