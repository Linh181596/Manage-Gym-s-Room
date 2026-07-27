package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.sql.SQLException;
import java.util.List;

public interface NotificationService {
    /** Lấy toàn bộ thông báo chưa bị xóa để sử dụng khi không cần phân trang. */
    List<Notification> getAllNotifications() throws SQLException;
    /** Lấy một trang thông báo chưa bị xóa theo vị trí và số lượng bản ghi. */
    List<Notification> getNotificationsPaginated(int offset, int limit) throws SQLException;
    /** Lấy chi tiết thông báo theo mã để hiển thị hoặc cập nhật. */
    Notification getNotificationById(int id) throws SQLException;
    /** Tạo thông báo mới cùng thời điểm tạo và trạng thái mặc định. */
    boolean createNotification(Notification notification) throws SQLException;
    /** Cập nhật nội dung, người nhận, lịch đăng và ảnh của thông báo. */
    boolean updateNotification(Notification notification) throws SQLException;
    /** Xóa mềm thông báo theo mã. */
    boolean deleteNotification(int id) throws SQLException;
    /** Đếm số thông báo chưa bị xóa để tính phân trang. */
    int getNotificationsCount() throws SQLException;
    /** Kiểm tra role đích có thuộc danh sách role được phép nhận thông báo. */
    boolean isValidTargetRole(String targetRole);
    /** Kiểm tra tài khoản nhận thông báo cụ thể có tồn tại và chưa bị xóa. */
    boolean userExists(int userId) throws SQLException;
}
