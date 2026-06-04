package dao;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MemberDAO {

    // LẤY DỮ LIỆU TỪ DATABASE
    public List<Map<String, String>> getAllMembers() {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Phone, m.MembershipType, u.Status " +
                     "FROM [dbo].[Users] u " +
                     "INNER JOIN [dbo].[Members] m ON u.UserID = m.UserID";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("userId", String.valueOf(rs.getInt("UserID")));
                map.put("fullName", rs.getString("FullName"));
                map.put("email", rs.getString("Email") != null ? rs.getString("Email") : "");
                map.put("phone", rs.getString("Phone") != null ? rs.getString("Phone") : "");
                map.put("membershipType", rs.getString("MembershipType") != null ? rs.getString("MembershipType") : "Thường");
                map.put("status", rs.getString("Status"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // THÊM DỮ LIỆU VÀO DATABASE (Dùng Transaction cho 2 bảng)
    public boolean addMember(String fullName, String email, String phone, String membershipType) {
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psMember = null;
        ResultSet rs = null;
        
        String sqlUser = "INSERT INTO [dbo].[Users] (Username, Password, DisplayName, Email,"
                + " Phone, RoleID, Status, IsDeleted) VALUES (?, ?, ?, ?, ?, ?, 'Active', 0)";
        String sqlMember = "INSERT INTO [dbo].[Members] (UserID, MembershipStatus, IsDeleted,"
                + " CreatedDate) VALUES (?, ?, 0, GETDATE())";

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Bật transaction

            // 1. Thêm vào bảng Users trước
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            // Tạo tạm username bằng cách viết liền chữ thường không dấu
            String username = fullName.toLowerCase().replaceAll("\\s+", ""); 
            psUser.setString(1, username);
            psUser.setString(2, "123456"); // Mật khẩu mặc định
            psUser.setString(3, fullName);
            psUser.setString(4, email);
            psUser.setString(5, phone);
            psUser.executeUpdate();

            // Lấy ID tự tăng vừa được sinh ra từ bảng Users
            rs = psUser.getGeneratedKeys();
            int newUserId = 0;
            if (rs.next()) {
                newUserId = rs.getInt(1);
            }

            // 2. Thêm vào bảng Members dựa trên UserID vừa lấy
            if (newUserId > 0) {
                psMember = conn.prepareStatement(sqlMember);
                psMember.setInt(1, newUserId);
                psMember.setString(2, membershipType);
                psMember.executeUpdate();
                
                conn.commit(); // Thành công hết thì Lưu lại
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psUser != null) psUser.close();
                if (psMember != null) psMember.close();
                if (conn != null) conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return false;
    }
}