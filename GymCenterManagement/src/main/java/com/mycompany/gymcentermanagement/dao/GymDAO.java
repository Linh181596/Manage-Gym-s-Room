package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GymDAO {

    public List<Map<String, String>> getAllMembers() {
        return getMembers(null, null);
    }

    public List<Map<String, String>> getMembers(String keyword, String memberType) {
        return getMembers(keyword, memberType, 0, Integer.MAX_VALUE);
    }

    public int getMembersCount(String keyword, String memberType) {
        String sql = """
                SELECT COUNT(*) FROM (
                    SELECT u.UserID
                    FROM [dbo].[Users] u
                    INNER JOIN [dbo].[Members] m ON u.UserID = m.UserID
                    LEFT JOIN [dbo].[MemberPackages] mp ON m.MemberID = mp.MemberID AND mp.IsDeleted = 0
                    LEFT JOIN [dbo].[GymPackages] gp ON mp.PackageID = gp.PackageID AND gp.IsDeleted = 0
                    WHERE u.IsDeleted = 0 AND m.IsDeleted = 0
                      AND (? IS NULL OR u.DisplayName LIKE ? OR u.Email LIKE ? OR u.Phone LIKE ?)
                      AND (? IS NULL OR gp.PackageName LIKE ? OR m.MembershipStatus LIKE ?)
                    GROUP BY u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                             m.MemberID, m.MembershipStatus, m.CreatedDate
                ) AS temp
                """;
        String normalizedKeyword = blankToNull(keyword);
        String keywordPattern = normalizedKeyword == null ? null : "%" + normalizedKeyword + "%";
        String normalizedType = blankToNull(memberType);
        String typePattern = normalizedType == null ? null : "%" + normalizedType + "%";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizedKeyword);
            ps.setString(2, keywordPattern);
            ps.setString(3, keywordPattern);
            ps.setString(4, keywordPattern);
            ps.setString(5, normalizedType);
            ps.setString(6, typePattern);
            ps.setString(7, typePattern);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, String>> getMembers(String keyword, String memberType, int offset, int limit) {
        List<Map<String, String>> list = new ArrayList<>();
        
        // When offset is 0 and limit is Integer.MAX_VALUE, we can skip the OFFSET/FETCH NEXT to avoid SQL syntax issue or pagination overhead
        boolean usePagination = (limit != Integer.MAX_VALUE);
        
        String sql = """
                SELECT u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                       m.MemberID, m.MembershipStatus, m.CreatedDate,
                       COALESCE(MAX(CASE WHEN mp.Status = 'Active' AND mp.EndDate >= CAST(GETDATE() AS date) THEN gp.PackageName END), m.MembershipStatus) AS MembershipType
                FROM [dbo].[Users] u
                INNER JOIN [dbo].[Members] m ON u.UserID = m.UserID
                LEFT JOIN [dbo].[MemberPackages] mp ON m.MemberID = mp.MemberID AND mp.IsDeleted = 0
                LEFT JOIN [dbo].[GymPackages] gp ON mp.PackageID = gp.PackageID AND gp.IsDeleted = 0
                WHERE u.IsDeleted = 0 AND m.IsDeleted = 0
                  AND (? IS NULL OR u.DisplayName LIKE ? OR u.Email LIKE ? OR u.Phone LIKE ?)
                  AND (? IS NULL OR gp.PackageName LIKE ? OR m.MembershipStatus LIKE ?)
                GROUP BY u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                         m.MemberID, m.MembershipStatus, m.CreatedDate
                ORDER BY u.UserID DESC
                """ + (usePagination ? " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY" : "");
                
        String normalizedKeyword = blankToNull(keyword);
        String keywordPattern = normalizedKeyword == null ? null : "%" + normalizedKeyword + "%";
        String normalizedType = blankToNull(memberType);
        String typePattern = normalizedType == null ? null : "%" + normalizedType + "%";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizedKeyword);
            ps.setString(2, keywordPattern);
            ps.setString(3, keywordPattern);
            ps.setString(4, keywordPattern);
            ps.setString(5, normalizedType);
            ps.setString(6, typePattern);
            ps.setString(7, typePattern);
            
            if (usePagination) {
                ps.setInt(8, Math.max(0, offset));
                ps.setInt(9, limit);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("userId", String.valueOf(rs.getInt("UserID")));
                    map.put("memberId", String.valueOf(rs.getInt("MemberID")));
                    map.put("fullName", safe(rs.getString("DisplayName")));
                    map.put("email", safe(rs.getString("Email")));
                    map.put("phone", safe(rs.getString("Phone")));
                    map.put("membershipType", safe(rs.getString("MembershipType")));
                    map.put("membershipStatus", safe(rs.getString("MembershipStatus")));
                    map.put("date", String.valueOf(rs.getTimestamp("CreatedDate")));
                    map.put("status", safe(rs.getString("Status")));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addMember(String fullName, String email, String phone, String membershipType) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Defensive check for duplicate email
            String sqlCheckEmail = "SELECT COUNT(*) FROM [dbo].[Users] WHERE Email = ? AND IsDeleted = 0";
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheckEmail)) {
                psCheck.setString(1, email);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false;
                    }
                }
            }

            // Defensive check for duplicate phone
            if (phone != null && !phone.trim().isEmpty()) {
                String sqlCheckPhone = "SELECT COUNT(*) FROM [dbo].[Users] WHERE Phone = ? AND IsDeleted = 0";
                try (PreparedStatement psCheck = conn.prepareStatement(sqlCheckPhone)) {
                    psCheck.setString(1, phone.trim());
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next() && rs.getInt(1) > 0) {
                            return false;
                        }
                    }
                }
            }

            String sqlUser = """
                    INSERT INTO [dbo].[Users]
                    (Email, PasswordHash, DisplayName, Phone, Status, MustChangePassword, CreatedBy, IsDeleted)
                    VALUES (?, ?, ?, ?, 'Active', 1, 'System', 0)
                    """;
            int userId;
            try (PreparedStatement psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, email);
                psUser.setString(2, defaultPasswordHash());
                psUser.setString(3, fullName);
                psUser.setString(4, phone);
                psUser.executeUpdate();
                try (ResultSet rs = psUser.getGeneratedKeys()) {
                    if (!rs.next()) {
                        conn.rollback();
                        return false;
                    }
                    userId = rs.getInt(1);
                }
            }

            String sqlMember = """
                    INSERT INTO [dbo].[Members]
                    (UserID, MembershipStatus, CreatedBy, IsDeleted)
                    VALUES (?, 'Active', 'System', 0)
                    """;
            try (PreparedStatement psMember = conn.prepareStatement(sqlMember)) {
                psMember.setInt(1, userId);
                psMember.executeUpdate();
            }

            Integer memberRoleId = findRoleId(conn, "Member");
            if (memberRoleId != null) {
                try (PreparedStatement psRole = conn.prepareStatement(
                        "INSERT INTO [dbo].[UserRoles] (UserID, RoleID) VALUES (?, ?)")) {
                    psRole.setInt(1, userId);
                    psRole.setInt(2, memberRoleId);
                    psRole.executeUpdate();
                }
            }

            Integer packageId = null;
            int durationMonths = 1;
            String name = blankToNull(membershipType);
            if (name != null) {
                try (PreparedStatement psPack = conn.prepareStatement("""
                        SELECT TOP 1 PackageID, DurationMonths
                        FROM [dbo].[GymPackages]
                        WHERE IsDeleted = 0 AND Status = 'Active' AND (PackageName = ? OR PackageName LIKE ?)
                        ORDER BY PackageID
                        """)) {
                    psPack.setString(1, name);
                    psPack.setString(2, "%" + name + "%");
                    try (ResultSet rsPack = psPack.executeQuery()) {
                        if (rsPack.next()) {
                            packageId = rsPack.getInt("PackageID");
                            durationMonths = rsPack.getInt("DurationMonths");
                        }
                    }
                }
            }

            if (packageId != null) {
                int memberId = findMemberId(conn, userId);
                try (PreparedStatement psPackage = conn.prepareStatement("""
                        INSERT INTO [dbo].[MemberPackages]
                        (MemberID, PackageID, StartDate, EndDate, Status, CreatedBy, IsDeleted)
                        VALUES (?, ?, CAST(GETDATE() AS date), DATEADD(month, ?, CAST(GETDATE() AS date)), 'Active', 'System', 0)
                        """)) {
                    psPackage.setInt(1, memberId);
                    psPackage.setInt(2, packageId);
                    psPackage.setInt(3, durationMonths);
                    psPackage.executeUpdate();
                }
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public boolean deleteMember(int userId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            String sqlMember = "UPDATE [dbo].[Members] SET IsDeleted = 1, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
            try (PreparedStatement psMember = conn.prepareStatement(sqlMember)) {
                psMember.setInt(1, userId);
                psMember.executeUpdate();
            }

            String sqlUser = "UPDATE [dbo].[Users] SET IsDeleted = 1, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
            try (PreparedStatement psUser = conn.prepareStatement(sqlUser)) {
                psUser.setInt(1, userId);
                psUser.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    public Map<String, String> getMemberProfile(int userId) {
        Map<String, String> profile = new HashMap<>();
        String sql = """
                SELECT TOP 1 u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                       m.MemberID, m.MembershipStatus, m.CreatedDate,
                       gp.PackageName, mp.EndDate, mp.Status AS PackageStatus
                FROM [dbo].[Users] u
                INNER JOIN [dbo].[Members] m ON u.UserID = m.UserID
                LEFT JOIN [dbo].[MemberPackages] mp ON m.MemberID = mp.MemberID AND mp.IsDeleted = 0
                LEFT JOIN [dbo].[GymPackages] gp ON mp.PackageID = gp.PackageID AND gp.IsDeleted = 0
                WHERE u.UserID = ? AND u.IsDeleted = 0 AND m.IsDeleted = 0
                ORDER BY CASE WHEN mp.Status = 'Active' AND mp.EndDate >= CAST(GETDATE() AS date) THEN 1 ELSE 2 END, mp.EndDate DESC
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String packageName = rs.getString("PackageName");
                    Date endDate = rs.getDate("EndDate");
                    String packageStatus = rs.getString("PackageStatus");
                    
                    String type = "Chưa đăng ký gói";
                    if (packageName != null && "Active".equalsIgnoreCase(packageStatus)) {
                        if (endDate != null) {
                            java.time.LocalDate endLd = endDate.toLocalDate();
                            java.time.LocalDate todayLd = java.time.LocalDate.now();
                            if (!endLd.isBefore(todayLd)) {
                                type = packageName;
                            }
                        }
                    }
                    if ("Chưa đăng ký gói".equals(type)) {
                        type = coalesce(null, rs.getString("MembershipStatus"));
                    }

                    profile.put("userId", String.valueOf(rs.getInt("UserID")));
                    profile.put("memberId", String.valueOf(rs.getInt("MemberID")));
                    profile.put("fullName", safe(rs.getString("DisplayName")));
                    profile.put("email", safe(rs.getString("Email")));
                    profile.put("phone", safe(rs.getString("Phone")));
                    profile.put("type", type);
                    profile.put("status", safe(rs.getString("Status")));
                    profile.put("date", String.valueOf(rs.getTimestamp("CreatedDate")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profile;
    }

    public List<Map<String, String>> getMemberServices(int userId) {
        List<Map<String, String>> services = new ArrayList<>();
        String sql = """
                SELECT gp.PackageName, mp.StartDate, mp.EndDate, mp.Status, i.InvoiceID
                FROM [dbo].[MemberPackages] mp
                INNER JOIN [dbo].[GymPackages] gp ON mp.PackageID = gp.PackageID
                INNER JOIN [dbo].[Members] m ON mp.MemberID = m.MemberID
                LEFT JOIN [dbo].[Invoices] i ON mp.MemberPackageID = i.MemberPackageID AND i.IsDeleted = 0
                WHERE m.UserID = ? AND mp.IsDeleted = 0 AND gp.IsDeleted = 0
                ORDER BY mp.EndDate DESC
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("serviceName", safe(rs.getString("PackageName")));
                    map.put("startDate", String.valueOf(rs.getDate("StartDate")));
                    map.put("endDate", String.valueOf(rs.getDate("EndDate")));
                    map.put("status", safe(rs.getString("Status")));
                    int invoiceId = rs.getInt("InvoiceID");
                    map.put("invoiceId", rs.wasNull() ? "" : String.valueOf(invoiceId));
                    services.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }

    public boolean updateMemberStatus(int userId, String status) {
        if (!"Active".equals(status) && !"Locked".equals(status) && !"Inactive".equals(status)) {
            return false;
        }
        String sql = """
                UPDATE [dbo].[Users]
                SET Status = ?, UpdatedBy = 'System', UpdatedDate = SYSDATETIME()
                WHERE UserID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createNotification(int createdByUserId, String title, String content, String targetRole) {
        String sql = """
                INSERT INTO [dbo].[Notifications]
                (Title, Content, CreatedBy, TargetRole, CreatedByRole, IsDeleted)
                VALUES (?, ?, ?, ?, 'Staff', 0)
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, createdByUserId);
            ps.setString(4, targetRole);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Map<String, String>> getNotifications(int userId) {
        List<Map<String, String>> list = new ArrayList<>();
        String role = getUserRole(userId);
        String sql = """
                SELECT NotificationID, Title, Content, CreatedDate, PublishDate, NotificationImageURL
                FROM [dbo].[Notifications]
                WHERE IsDeleted = 0
                  AND PublishDate <= SYSDATETIME()
                  AND (ExpiryDate IS NULL OR ExpiryDate > SYSDATETIME())
                  AND (TargetRole = ? OR TargetRole = 'All')
                ORDER BY PublishDate DESC
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id", String.valueOf(rs.getInt("NotificationID")));
                    map.put("title", safe(rs.getString("Title")));
                    map.put("content", safe(rs.getString("Content")));
                    map.put("isRead", "false");
                    map.put("createdAt", String.valueOf(rs.getTimestamp("PublishDate")));
                    map.put("imageUrl", safe(rs.getString("NotificationImageURL")));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, String> getNotificationById(int notificationId) {
        return getNotificationById(notificationId, "Member");
    }

    public Map<String, String> getNotificationById(int notificationId, int userId) {
        return getNotificationById(notificationId, getUserRole(userId));
    }

    private Map<String, String> getNotificationById(int notificationId, String targetRole) {
        String sql = """
                SELECT NotificationID, Title, Content, CreatedDate, PublishDate, NotificationImageURL
                FROM [dbo].[Notifications]
                WHERE NotificationID = ?
                  AND IsDeleted = 0
                  AND PublishDate <= SYSDATETIME()
                  AND (ExpiryDate IS NULL OR ExpiryDate > SYSDATETIME())
                  AND (TargetRole = ? OR TargetRole = 'All')
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            ps.setString(2, targetRole);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id", String.valueOf(rs.getInt("NotificationID")));
                    map.put("title", safe(rs.getString("Title")));
                    map.put("content", safe(rs.getString("Content")));
                    map.put("createdAt", String.valueOf(rs.getTimestamp("PublishDate")));
                    map.put("imageUrl", safe(rs.getString("NotificationImageURL")));
                    return map;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void markAsRead(int notificationId) {
    }

    private String getUserRole(int userId) {
        String sql = """
                SELECT TOP 1 r.RoleName
                FROM [dbo].[UserRoles] ur
                INNER JOIN [dbo].[Roles] r ON ur.RoleID = r.RoleID
                WHERE ur.UserID = ? AND r.IsDeleted = 0
                ORDER BY r.RoleLevel DESC
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("RoleName");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Member";
    }

    private Integer findRoleId(Connection conn, String roleName) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT RoleID FROM [dbo].[Roles] WHERE RoleName = ? AND IsDeleted = 0")) {
            ps.setString(1, roleName);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("RoleID") : null;
            }
        }
    }



    private int findMemberId(Connection conn, int userId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT MemberID FROM [dbo].[Members] WHERE UserID = ?")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("MemberID");
                }
            }
        }
        throw new SQLException("Member not found for user " + userId);
    }

    private String blankToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }

    private String coalesce(String first, String second) {
        return first == null || first.isBlank() ? safe(second) : first;
    }

    private String defaultPasswordHash() {
        return "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92";
    }
}
