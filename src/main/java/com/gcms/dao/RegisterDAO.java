/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.dao;

import com.gcms.util.DBContext;
import com.gcms.model.Member;
import com.gcms.model.User;
import com.gcms.model.UserToken;
import java.sql.*;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: RegisterDAO.java
 * Description: Lớp chuyên trách xử lý các tác vụ truy xuất dữ liệu liên quan đến luồng Đăng ký (UC-02).
 * Đảm bảo tính toàn vẹn dữ liệu thông qua cơ chế Transaction khi thực hiện thêm mới bản ghi đồng thời
 * vào các bảng [Users] (tài khoản lõi), [Members] (thông tin hội viên) và [UserRoles] (gán quyền mặc định).
 * Đồng thời xử lý hàm cập nhật trạng thái 'Active' của tài khoản sau khi xác thực email thành công.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Khởi tạo các hàm xử lý SQL Transaction cho luồng đăng ký hội viên.
 */
public class RegisterDAO extends DBContext{
    // Thay thế kế thừa bằng việc sử dụng thuộc tính đối tượng (Composition over Inheritance)
    private final DBContext dbContext = new DBContext();

    /**
     * Kiểm tra xem Email đăng ký đã tồn tại trong hệ thống hay chưa.
     * Phục vụ xử lý luồng ngoại lệ E1 (Duplicate Email).
     */
    public boolean checkEmailExists(String email) {
        String sql = "SELECT 1 FROM dbo.Users WHERE Email = ? AND IsDeleted = 0";
        try (Connection conn = dbContext.getConnection(); // Gọi qua đối tượng dbContext
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Trả về true nếu tìm thấy bản ghi (Email trùng)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tạo tài khoản hội viên mới sử dụng cơ chế Transaction (All-or-Nothing).
     * Chèn tuần tự dữ liệu vào: Users -> UserRoles -> Members -> User_Tokens.
     */
    public boolean registerMember(User user, Member member, UserToken token) {
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psRole = null;
        PreparedStatement psMember = null;
        PreparedStatement psToken = null;
        ResultSet rsKeys = null;

        // Chuẩn bị câu lệnh SQL khớp chính xác với cấu trúc cơ sở dữ liệu hệ thống
        String sqlUser = "INSERT INTO dbo.Users (Email, PasswordHash, DisplayName, Phone, Status, "
                       + "MustChangePassword, CreatedBy, CreatedDate, IsDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)";
        
        String sqlRole = "INSERT INTO dbo.UserRoles (UserID, RoleID) VALUES (?, 4)"; // Mặc định RoleID = 4 (Member) theo BR-02
        
        String sqlMember = "INSERT INTO dbo.Members (UserID, Gender, DateOfBirth, Address, "
                         + "MembershipStatus, CreatedDate, IsDeleted) VALUES (?, ?, ?, ?, ?, SYSDATETIME(), 0)";
        
        String sqlToken = "INSERT INTO dbo.User_Tokens (UserID, TokenValue, TokenType, ExpiresAt, IsUsed) VALUES (?, ?, ?, ?, 0)";

        try {
            conn = dbContext.getConnection(); // Lấy kết nối thông qua thuộc tính dbContext
            conn.setAutoCommit(false); // BẮT ĐẦU TRANSACTION: Tắt chế độ tự động lưu dữ liệu

            // 1. Thực hiện chèn dữ liệu vào cốt lõi bảng Users
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getEmail());
            psUser.setString(2, user.getPasswordHash());
            psUser.setString(3, user.getDisplayName());
            psUser.setString(4, user.getPhone());
            psUser.setString(5, user.getStatus()); // Giá trị là "Inactive" theo đặc tả UC-02
            psUser.setBoolean(6, user.isMustChangePassword());
            psUser.setString(7, "Public Registration");

            int affectedRows = psUser.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Quá trình thêm thông tin User thất bại.");
            }

            // Lấy UserID vừa được sinh tự động (IDENTITY) từ SQL Server để làm khóa ngoại
            rsKeys = psUser.getGeneratedKeys();
            int userId = 0;
            if (rsKeys.next()) {
                userId = rsKeys.getInt(1);
            } else {
                throw new SQLException("Không thể lấy ID tự sinh của User.");
            }

            // 2. Phân quyền mặc định cho hội viên vào bảng UserRoles (RoleID = 4)
            psRole = conn.prepareStatement(sqlRole);
            psRole.setInt(1, userId);
            psRole.executeUpdate();

            // 3. Chèn thông tin chi tiết mở rộng vào bảng Members
            psMember = conn.prepareStatement(sqlMember);
            psMember.setInt(1, userId);
            psMember.setString(2, member.getGender());
            psMember.setDate(3, member.getDateOfBirth());
            psMember.setString(4, member.getAddress());
            psMember.setString(5, member.getMembershipStatus()); // Trạng thái "Inactive" hoặc "Pending"
            psMember.executeUpdate();

            // 4. Lưu mã Token xác minh email đăng ký vào bảng User_Tokens
            psToken = conn.prepareStatement(sqlToken);
            psToken.setInt(1, userId);
            psToken.setString(2, token.getTokenValue());
            psToken.setString(3, token.getTokenType()); // Giá trị là "VERIFICATION"
            psToken.setTimestamp(4, token.getExpiresAt()); // Hạn sử dụng 24h (BR-03)
            psToken.executeUpdate();

            conn.commit(); // TOÀN BỘ THÀNH CÔNG: Xác nhận lưu tất cả thay đổi vào CSDL
            return true;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // CÓ LỖI XẢY RA: Hoàn tác (hủy bỏ) toàn bộ tiến trình để tránh rác DB
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            // Đóng tuần tự toàn bộ tài nguyên kết nối nhằm giải phóng bộ nhớ cho hệ thống
            try { if (rsKeys != null) rsKeys.close(); } catch (Exception e) {}
            try { if (psUser != null) psUser.close(); } catch (Exception e) {}
            try { if (psRole != null) psRole.close(); } catch (Exception e) {}
            try { if (psMember != null) psMember.close(); } catch (Exception e) {}
            try { if (psToken != null) psToken.close(); } catch (Exception e) {}
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {}
        }
    }

    /**
     * Xác thực Token kích hoạt từ email. Nếu hợp lệ, chuyển đổi trạng thái tài khoản sang Active.
     * Trả về địa chỉ Email nếu thành công để tự động điền (auto-populate) vào trang Đăng nhập.
     */
    public String verifyAccountAndGetEmail(String tokenValue) {
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpUser = null;
        PreparedStatement psUpMember = null;
        PreparedStatement psUpToken = null;
        ResultSet rs = null;

        // Truy vấn kiểm tra tính hợp lệ của Token bao gồm: Phân loại, Trạng thái sử dụng, và Hạn sử dụng (BR-03)
        String sqlCheck = "SELECT t.UserID, t.TokenID, u.Email FROM dbo.User_Tokens t "
                        + "JOIN dbo.Users u ON t.UserID = u.UserID "
                        + "WHERE t.TokenValue = ? AND t.TokenType = 'VERIFICATION' AND t.IsUsed = 0 AND t.ExpiresAt > SYSDATETIME()";

        String sqlUpUser = "UPDATE dbo.Users SET Status = 'Active' WHERE UserID = ?";
        String sqlUpMember = "UPDATE dbo.Members SET MembershipStatus = 'Active' WHERE UserID = ?";
        String sqlUpToken = "UPDATE dbo.User_Tokens SET IsUsed = 1 WHERE TokenID = ?";

        try {
            conn = dbContext.getConnection(); // Lấy kết nối thông qua thuộc tính dbContext
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, tokenValue);
            rs = psCheck.executeQuery();

            // Nếu tìm thấy Token khớp điều kiện, tiến hành kích hoạt hệ thống tài khoản
            if (rs.next()) {
                int userId = rs.getInt("UserID");
                int tokenId = rs.getInt("TokenID");
                String email = rs.getString("Email");

                conn.setAutoCommit(false); // Bắt đầu cập nhật đồng bộ trạng thái

                // 1. Cập nhật bảng Users sang Active
                psUpUser = conn.prepareStatement(sqlUpUser);
                psUpUser.setInt(1, userId);
                psUpUser.executeUpdate();

                // 2. Cập nhật bảng Members sang Active
                psUpMember = conn.prepareStatement(sqlUpMember);
                psUpMember.setInt(1, userId);
                psUpMember.executeUpdate();

                // 3. Vô hiệu hóa Token (Strict single-use constraint logic - BR-03)
                psUpToken = conn.prepareStatement(sqlUpToken);
                psUpToken.setInt(1, tokenId);
                psUpToken.executeUpdate();

                conn.commit(); // Hoàn thành quy trình kích hoạt tài khoản
                return email; 
            }
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) {}
            }
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psCheck != null) psCheck.close(); } catch (Exception e) {}
            try { if (psUpUser != null) psUpUser.close(); } catch (Exception e) {}
            try { if (psUpMember != null) psUpMember.close(); } catch (Exception e) {}
            try { if (psUpToken != null) psUpToken.close(); } catch (Exception e) {}
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {}
        }
        return null; // Trả về null nếu Token đã hết hạn, sai thông tin hoặc đã sử dụng (E3)
    }
}
