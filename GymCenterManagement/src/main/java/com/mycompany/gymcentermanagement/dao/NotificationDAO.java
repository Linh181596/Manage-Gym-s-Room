package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.Notification;
import java.sql.SQLException;
import java.util.List;

public interface NotificationDAO {
    /** Lấy tất cả thông báo chưa bị xóa. */
    List<Notification> findAll() throws SQLException;
    /** Lấy thông báo chưa bị xóa theo khoảng phân trang. */
    List<Notification> findAllPaginated(int offset, int limit) throws SQLException;
    /** Lấy thông báo chưa bị xóa theo mã. */
    Notification findById(int notificationId) throws SQLException;
    /** Thêm thông báo và người nhận cụ thể nếu có. */
    boolean insert(Notification notification) throws SQLException;
    /** Cập nhật thông báo và đồng bộ lại người nhận cụ thể nếu có. */
    boolean update(Notification notification) throws SQLException;
    /** Xóa mềm thông báo bằng cách đánh dấu IsDeleted. */
    boolean delete(int notificationId) throws SQLException;
    /** Đếm tổng số thông báo chưa bị xóa. */
    int countAll() throws SQLException;
    /** Kiểm tra Users có tồn tại và chưa bị xóa theo mã người dùng. */
    boolean userExists(int userId) throws SQLException;
}
