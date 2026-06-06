/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.dao;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: UserDAO.java
 * Description: Lớp quản lý tương tác dữ liệu trực tiếp với bảng [Users] trong SQL Server.
 * Chứa các hàm nghiệp vụ then chốt như kiểm tra tồn tại Email, xác thực thông tin tài khoản, 
 * nạp thông tin Session đa vai trò khi đăng nhập (UC-01) và tạo tài khoản lõi mới (UC-02).
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Xây dựng các câu lệnh tương tác thực thể Users & Login.
 */
import com.gcms.model.Role;
import com.gcms.util.DBContext;
import com.gcms.model.User;
import com.gcms.model.UserToken;
import java.sql.*;

public class UserDAO{
    
    // Khởi tạo đối tượng DBContext để gọi phương thức instance getConnection()
    private final DBContext dbContext = new DBContext();

    /**
     * Lấy thông tin User và tên quyền (RoleName) bằng Email để xác thực đăng nhập.
     * Sử dụng INNER JOIN qua bảng trung gian UserRoles đúng theo thiết kế DB.
     * @param email Email người dùng nhập vào
     * @return Đối tượng User đầy đủ thông tin hoặc null nếu không tồn tại
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT u.*, r.RoleID, r.RoleName, r.RoleLevel FROM dbo.Users u " +
                     "INNER JOIN dbo.UserRoles ur ON u.UserID = ur.UserID " +
                     "INNER JOIN dbo.Roles r ON ur.RoleID = r.RoleID " +
                     "WHERE u.Email = ? AND u.IsDeleted = 0";
        
        User user = null;
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                // Sử dụng vòng lặp WHILE để gom hết tất cả các Role của User đó
                while (rs.next()) {
                    // Nếu là dòng kết quả đầu tiên, khởi tạo thực thể User
                    if (user == null) {
                        user = new User();
                        user.setUserID(rs.getInt("UserID"));
                        user.setEmail(rs.getString("Email"));
                        user.setPasswordHash(rs.getString("PasswordHash"));
                        user.setDisplayName(rs.getString("DisplayName"));
                        user.setStatus(rs.getString("Status"));
                        user.setMustChangePassword(rs.getBoolean("MustChangePassword"));
                    }
                    
                    // Với mỗi dòng dữ liệu trả về, tạo thực thể Role con tương ứng
                    Role role = new Role();
                    role.setRoleID(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    role.setRoleLevel(rs.getInt("RoleLevel"));
                    
                    // Thêm role vừa bốc được vào danh sách List<Role> của User
                    user.getRoles().add(role);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user; // Trả về đối tượng User đã được gom đủ List quyền
    }

    /**
     * Lưu thực thể Token "Remember Me" vào bảng User_Tokens khi người dùng chọn ghi nhớ đăng nhập.
     * Tuân thủ mô hình MVC nghiêm ngặt bằng việc nhận vào một thực thể Model UserToken.
     * @param token Thực thể đối tượng UserToken chứa các tham số an toàn
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean saveRememberMeToken(UserToken token) {
        String sql = "INSERT INTO [dbo].[User_Tokens] (UserID, TokenValue, TokenType, ExpiresAt, IsUsed) " +
                     "VALUES (?, ?, ?, ?, 0)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, token.getUserID());
            ps.setString(2, token.getTokenValue());
            ps.setString(3, token.getTokenType());
            ps.setTimestamp(4, token.getExpiresAt()); // DATETIME2 khớp với trường java.sql.Timestamp
            
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm kiếm thông tin User dựa trên giá trị Token ghi nhớ để xử lý tự động đăng nhập (Alternative Flow A1).
     * Ràng buộc token chưa bị sử dụng, chưa hết hạn và tài khoản chưa bị xóa logic.
     * @param tokenValue Chuỗi mã bí mật UUID lấy từ Cookie trình duyệt
     * @return Đối tượng User tương ứng nếu token hợp lệ, ngược lại trả về null
     */
    public User getUserByRememberMeToken(String tokenValue) {
        String sql = "SELECT u.*, r.RoleID, r.RoleName, r.RoleLevel FROM dbo.User_Tokens t " +
                     "INNER JOIN dbo.Users u ON t.UserID = u.UserID " +
                     "INNER JOIN dbo.UserRoles ur ON u.UserID = ur.UserID " +
                     "INNER JOIN dbo.Roles r ON ur.RoleID = r.RoleID " +
                     "WHERE t.TokenValue = ? AND t.TokenType = 'REMEMBER_ME' " +
                     "AND t.IsUsed = 0 AND t.ExpiresAt > SYSDATETIME() AND u.IsDeleted = 0";
        
        User user = null;
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tokenValue);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (user == null) {
                        user = new User();
                        user.setUserID(rs.getInt("UserID"));
                        user.setEmail(rs.getString("Email"));
                        user.setDisplayName(rs.getString("DisplayName"));
                        user.setStatus(rs.getString("Status"));
                        user.setMustChangePassword(rs.getBoolean("MustChangePassword"));
                    }
                    Role role = new Role();
                    role.setRoleID(rs.getInt("RoleID"));
                    role.setRoleName(rs.getString("RoleName"));
                    role.setRoleLevel(rs.getInt("RoleLevel"));
                    
                    user.getRoles().add(role);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * Thu hồi/Xóa bỏ Token "Remember Me" khỏi CSDL khi người dùng chủ động đăng xuất (Business Rule BR-03).
     * @param tokenValue Mã token cần hủy bỏ
     * @return true nếu xóa thành công, ngược lại là false
     */
    public boolean deleteRememberMeToken(String tokenValue) {
        String sql = "DELETE FROM [dbo].[User_Tokens] WHERE [TokenValue] = ? AND [TokenType] = 'REMEMBER_ME'";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tokenValue);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}
