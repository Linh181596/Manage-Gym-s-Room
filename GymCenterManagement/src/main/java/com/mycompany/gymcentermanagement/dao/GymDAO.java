package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GymDAO {

    /**
     * Lấy toàn bộ danh sách hội viên bằng cách gọi lại hàm lấy hội viên không
     * có bộ lọc.
     */
    public List<Map<String, String>> getAllMembers() {
        return getMembers(null, null);
    }

    /**
     * Lấy danh sách hội viên theo từ khóa và loại gói mà không giới hạn phân
     * trang.
     */
    public List<Map<String, String>> getMembers(String keyword, String memberType) {
        return getMembers(keyword, memberType, 0, Integer.MAX_VALUE);
    }

    /**
     * SQL đếm số hội viên từ Users, Members, MemberPackages và GymPackages theo
     * từ khóa/loại gói để tính phân trang cho màn hình quản lý hội viên.
     */
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

    /**
     * SQL lấy danh sách hội viên từ Users và Members, kèm gói tập active mới
     * nhất nếu có, rồi áp dụng tìm kiếm, lọc loại gói và phân trang.
     */
    public List<Map<String, String>> getMembers(String keyword, String memberType, int offset, int limit) {
        List<Map<String, String>> list = new ArrayList<>();
        // When offset is 0 and limit is Integer.MAX_VALUE, we can skip the OFFSET/FETCH
        // NEXT to avoid SQL syntax issue or pagination overhead
        boolean usePagination = (limit != Integer.MAX_VALUE);

        String sql = """
                SELECT u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                       m.MemberID, m.MembershipStatus, m.CreatedDate,
                       COALESCE(MAX(CASE WHEN mp.Status = 'Active' AND mp.EndDate >= CAST(GETDATE() AS date) THEN gp.PackageName END), m.MembershipStatus) AS MembershipType,
                       MAX(CASE WHEN mp.Status = 'Active' AND mp.EndDate >= CAST(GETDATE() AS date) THEN 1 ELSE 0 END) AS HasActivePackage
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
                """
                + (usePagination ? " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY" : "");

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
                    map.put("hasActivePackage", String.valueOf(rs.getInt("HasActivePackage") > 0));
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

    /**
     * SQL tạo hội viên mới theo transaction: kiểm tra trùng Users, thêm Users,
     * thêm Members, gán role Member và tạo MemberPackages nếu chọn được gói tập.
     */
    public boolean addMember(String fullName, String email, String phone, String membershipType) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            String sqlCheckEmail = "SELECT COUNT(*) FROM [dbo].[Users] WHERE Email = ? AND IsDeleted = 0";
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheckEmail)) {
                psCheck.setString(1, email);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false;
                    }
                }
            }

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
                try (PreparedStatement psPackage = conn.prepareStatement(
                        """
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

    /**
     * SQL xóa mềm hội viên bằng cách cập nhật IsDeleted ở Members và Users sau
     * khi kiểm tra hội viên không còn gói tập active.
     */
    public boolean deleteMember(int userId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            if (hasActiveMemberGymPackage(conn, userId)) {
                conn.rollback();
                return false;
            }

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

    /**
     * SQL lấy hồ sơ hội viên từ Users/Members và gói tập mới nhất từ
     * MemberPackages/GymPackages để hiển thị trang portal.
     */
    public Map<String, String> getMemberProfile(int userId) {
        Map<String, String> profile = new HashMap<>();
        String sql = """
                SELECT TOP 1 u.UserID, u.DisplayName, u.Email, u.Phone, u.Status,
                       m.MemberID, m.MembershipStatus, m.CreatedDate,
                       gp.PackageName, mp.StartDate, mp.EndDate, mp.Status AS PackageStatus
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
                    Date startDate = rs.getDate("StartDate");
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

                    // Thêm thông tin ngày bắt đầu và kết thúc
                    if (startDate != null && endDate != null && "Active".equalsIgnoreCase(packageStatus)) {
                        profile.put("packageStartDate", String.valueOf(startDate));
                        profile.put("packageEndDate", String.valueOf(endDate));
                    } else {
                        profile.put("packageStartDate", "");
                        profile.put("packageEndDate", "");
                    }

                    profile.put("status", safe(rs.getString("Status")));
                    profile.put("date", String.valueOf(rs.getTimestamp("CreatedDate")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profile;
    }

    /**
     * SQL lấy lịch sử giao dịch của hội viên từ Invoices để hiển thị trong portal.
     * Hiển thị Tên dịch vụ là 'Gói hội viên' hoặc 'Gói tập PT'.
     * Tính toán Loại giao dịch dựa trên CreatedBy và loại package.
     */
    public List<Map<String, String>> getMemberServices(int userId) {
        List<Map<String, String>> services = new ArrayList<>();
        String sql = """
                SELECT i.InvoiceID, i.Amount, i.PaymentDate, i.CreatedDate, i.Status, i.CreatedBy,
                       i.MemberPackageID, i.PtRegistrationId
                FROM [dbo].[Invoices] i
                INNER JOIN [dbo].[Members] m ON i.MemberID = m.MemberID
                WHERE m.UserID = ? AND i.IsDeleted = 0
                ORDER BY COALESCE(i.PaymentDate, i.CreatedDate) DESC
                """;
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    int invoiceId = rs.getInt("InvoiceID");
                    String createdBy = rs.getString("CreatedBy");
                    Integer memberPkgId = (Integer) rs.getObject("MemberPackageID");
                    Integer ptRegId = (Integer) rs.getObject("PtRegistrationId");

                    String serviceName = "Dịch vụ khác";
                    String transactionType = "Thanh toán";

                    if (ptRegId != null) {
                        serviceName = "Gói tập PT";
                        transactionType = "Đăng ký Gói tập PT";
                    } else if (memberPkgId != null) {
                        serviceName = "Gói hội viên";
                        if (createdBy != null && createdBy.startsWith("Transfer")) {
                            transactionType = "Chuyển nhượng";
                        } else {
                            transactionType = "Đăng ký / Gia hạn";
                        }
                    }

                    java.sql.Timestamp date = rs.getTimestamp("PaymentDate");
                    if (date == null)
                        date = rs.getTimestamp("CreatedDate");

                    map.put("invoiceId", String.valueOf(invoiceId));
                    map.put("serviceName", serviceName);
                    map.put("transactionType", transactionType);
                    map.put("transactionDate", date != null ? String.valueOf(date) : "");
                    map.put("status", safe(rs.getString("Status")));
                    map.put("amount", String.valueOf(rs.getBigDecimal("Amount")));

                    services.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }

    /**
     * SQL cập nhật trạng thái tài khoản trong Users; khi khóa tài khoản thì kiểm
     * tra trước hội viên không còn gói tập active.
     */
    public boolean updateMemberStatus(int userId, String status) {
        if (!"Active".equals(status) && !"Locked".equals(status) && !"Inactive".equals(status)) {
            return false;
        }
        String sql = """
                UPDATE [dbo].[Users]
                SET Status = ?, UpdatedBy = 'System', UpdatedDate = SYSDATETIME()
                WHERE UserID = ? AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection()) {
            if ("Locked".equals(status) && hasActiveMemberGymPackage(conn, userId)) {
                return false;
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, userId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Kiểm tra hội viên có gói tập active còn hạn hay không bằng connection mới
     * từ DBContext.
     */
    public boolean hasActiveMemberGymPackage(int userId) {
        try (Connection conn = DBContext.getConnection()) {
            return hasActiveMemberGymPackage(conn, userId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * SQL kiểm tra Members và MemberPackages để xác định hội viên có gói tập
     * active còn hạn tại ngày hiện tại hay không.
     */
    private boolean hasActiveMemberGymPackage(Connection conn, int userId) throws SQLException {
        String sql = """
                SELECT 1
                FROM [dbo].[Members] m
                INNER JOIN [dbo].[MemberPackages] mp ON m.MemberID = mp.MemberID
                WHERE m.UserID = ?
                  AND m.IsDeleted = 0
                  AND mp.IsDeleted = 0
                  AND mp.Status = 'Active'
                  AND mp.EndDate >= CAST(GETDATE() AS date)
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * SQL thêm thông báo chung vào Notifications cho một vai trò hoặc toàn bộ
     * người dùng.
     */
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

    /**
     * SQL tạo thông báo gửi riêng cho một hội viên: thêm Notifications và thêm
     * dòng NotificationRecipients trong cùng transaction.
     */
    public boolean createNotificationForUser(int createdByUserId, String title, String content, int recipientUserId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            if (!isActiveMemberUser(conn, recipientUserId)) {
                conn.rollback();
                return false;
            }

            String notificationSql = """
                    INSERT INTO [dbo].[Notifications]
                    (Title, Content, CreatedBy, TargetRole, CreatedByRole, IsDeleted)
                    VALUES (?, ?, ?, 'Specific', 'Staff', 0)
                    """;
            int notificationId;
            try (PreparedStatement ps = conn.prepareStatement(notificationSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, title);
                ps.setString(2, content);
                ps.setInt(3, createdByUserId);
                if (ps.executeUpdate() <= 0) {
                    conn.rollback();
                    return false;
                }
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (!rs.next()) {
                        conn.rollback();
                        return false;
                    }
                    notificationId = rs.getInt(1);
                }
            }

            String recipientSql = """
                    INSERT INTO [dbo].[NotificationRecipients]
                    (NotificationID, UserID, IsRead, CreatedDate)
                    VALUES (?, ?, 0, SYSDATETIME())
                    """;
            try (PreparedStatement ps = conn.prepareStatement(recipientSql)) {
                ps.setInt(1, notificationId);
                ps.setInt(2, recipientUserId);
                ps.executeUpdate();
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

    /**
     * SQL kiểm tra userId có tồn tại trong Users và Members chưa bị xóa trước
     * khi gửi thông báo riêng.
     */
    private boolean isActiveMemberUser(Connection conn, int userId) throws SQLException {
        String sql = """
                SELECT 1
                FROM [dbo].[Users] u
                INNER JOIN [dbo].[Members] m ON m.UserID = u.UserID
                WHERE u.UserID = ?
                  AND u.IsDeleted = 0
                  AND m.IsDeleted = 0
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * SQL lấy các thông báo còn hiệu lực mà người dùng được phép xem theo role,
     * TargetRole hoặc NotificationRecipients, kèm trạng thái đã đọc.
     */
    public List<Map<String, String>> getNotifications(int userId) {
        List<Map<String, String>> list = new ArrayList<>();
        String role = getUserRole(userId);
        String sql = """
                SELECT DISTINCT n.NotificationID, n.Title, n.Content, n.CreatedDate, n.PublishDate, n.NotificationImageURL,
                       COALESCE(nr.IsRead, 0) AS IsRead
                FROM [dbo].[Notifications] n
                LEFT JOIN [dbo].[NotificationRecipients] nr
                    ON nr.NotificationID = n.NotificationID AND nr.UserID = ?
                WHERE n.IsDeleted = 0
                  AND n.PublishDate <= SYSDATETIME()
                  AND (n.ExpiryDate IS NULL OR n.ExpiryDate > SYSDATETIME())
                  AND (
                      n.TargetRole = ?
                      OR n.TargetRole = 'All'
                      OR nr.UserID IS NOT NULL
                  )
                ORDER BY n.PublishDate DESC
                """;
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, role);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id", String.valueOf(rs.getInt("NotificationID")));
                    map.put("title", safe(rs.getString("Title")));
                    map.put("content", safe(rs.getString("Content")));
                    map.put("isRead", String.valueOf(rs.getBoolean("IsRead")));
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

    /**
     * Lấy chi tiết thông báo theo mã thông báo với phạm vi mặc định là Member.
     */
    public Map<String, String> getNotificationById(int notificationId) {
        return getNotificationById(notificationId, "Member");
    }

    /**
     * Lấy chi tiết thông báo theo mã thông báo và userId, tự xác định role của
     * người dùng để kiểm tra quyền xem.
     */
    public Map<String, String> getNotificationById(int notificationId, int userId) {
        return getNotificationById(notificationId, userId, getUserRole(userId));
    }

    /**
     * Lấy chi tiết thông báo theo mã thông báo và role mục tiêu.
     */
    private Map<String, String> getNotificationById(int notificationId, String targetRole) {
        return getNotificationById(notificationId, 0, targetRole);
    }

    /**
     * SQL lấy chi tiết một thông báo còn hiệu lực nếu người dùng có quyền xem
     * qua TargetRole, All hoặc NotificationRecipients.
     */
    private Map<String, String> getNotificationById(int notificationId, int userId, String targetRole) {
        String sql = """
                SELECT n.NotificationID, n.Title, n.Content, n.CreatedDate, n.PublishDate, n.NotificationImageURL
                FROM [dbo].[Notifications] n
                LEFT JOIN [dbo].[NotificationRecipients] nr
                    ON nr.NotificationID = n.NotificationID AND nr.UserID = ?
                WHERE n.NotificationID = ?
                  AND n.IsDeleted = 0
                  AND n.PublishDate <= SYSDATETIME()
                  AND (n.ExpiryDate IS NULL OR n.ExpiryDate > SYSDATETIME())
                  AND (
                      n.TargetRole = ?
                      OR n.TargetRole = 'All'
                      OR nr.UserID IS NOT NULL
                  )
                """;
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, notificationId);
            ps.setString(3, targetRole);
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

    /**
     * SQL MERGE NotificationRecipients để đánh dấu một thông báo là đã đọc; nếu
     * chưa có dòng recipient thì tạo mới dòng đã đọc.
     */
    public void markAsRead(int notificationId, int userId) {
        String sql = """
                MERGE [dbo].[NotificationRecipients] AS target
                USING (
                    SELECT ? AS NotificationID, ? AS UserID
                ) AS source
                ON target.NotificationID = source.NotificationID
                   AND target.UserID = source.UserID
                WHEN MATCHED THEN
                    UPDATE SET IsRead = 1, ReadAt = SYSDATETIME()
                WHEN NOT MATCHED THEN
                    INSERT (NotificationID, UserID, IsRead, ReadAt, CreatedDate)
                    VALUES (source.NotificationID, source.UserID, 1, SYSDATETIME(), SYSDATETIME());
                """;
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Đánh dấu toàn bộ thông báo đang hiển thị với người dùng là đã đọc.
     */
    public boolean markAllNotificationsAsRead(int userId) {
        return markVisibleNotificationsAsRead(userId, null);
    }

    /**
     * Đánh dấu một nhóm thông báo được chọn là đã đọc nếu người dùng có quyền
     * xem các thông báo đó.
     */
    public boolean markNotificationsAsRead(int userId, List<Integer> notificationIds) {
        return markVisibleNotificationsAsRead(userId, notificationIds);
    }

    /**
     * SQL MERGE các thông báo còn hiệu lực và được phép xem vào
     * NotificationRecipients để cập nhật trạng thái đã đọc hàng loạt.
     */
    private boolean markVisibleNotificationsAsRead(int userId, List<Integer> notificationIds) {
        List<Integer> validIds = new ArrayList<>();
        if (notificationIds != null) {
            for (Integer notificationId : notificationIds) {
                if (notificationId != null && notificationId > 0 && !validIds.contains(notificationId)) {
                    validIds.add(notificationId);
                }
            }
            if (validIds.isEmpty()) {
                return false;
            }
        }

        String role = getUserRole(userId);
        String notificationFilter = "";
        if (notificationIds != null) {
            StringBuilder placeholders = new StringBuilder();
            for (int i = 0; i < validIds.size(); i++) {
                if (i > 0) {
                    placeholders.append(", ");
                }
                placeholders.append("?");
            }
            notificationFilter = " AND n.NotificationID IN (" + placeholders + ")";
        }

        String sql = """
                MERGE [dbo].[NotificationRecipients] AS target
                USING (
                    SELECT DISTINCT n.NotificationID, ? AS UserID
                    FROM [dbo].[Notifications] n
                    LEFT JOIN [dbo].[NotificationRecipients] existingRecipient
                        ON existingRecipient.NotificationID = n.NotificationID
                        AND existingRecipient.UserID = ?
                    WHERE n.IsDeleted = 0
                      AND n.PublishDate <= SYSDATETIME()
                      AND (n.ExpiryDate IS NULL OR n.ExpiryDate > SYSDATETIME())
                      AND (
                          n.TargetRole = ?
                          OR n.TargetRole = 'All'
                          OR existingRecipient.UserID IS NOT NULL
                      )
                """ + notificationFilter + """
                ) AS source
                ON target.NotificationID = source.NotificationID
                   AND target.UserID = source.UserID
                WHEN MATCHED AND target.IsRead = 0 THEN
                    UPDATE SET IsRead = 1, ReadAt = SYSDATETIME()
                WHEN NOT MATCHED THEN
                    INSERT (NotificationID, UserID, IsRead, ReadAt, CreatedDate)
                    VALUES (source.NotificationID, source.UserID, 1, SYSDATETIME(), SYSDATETIME());
                """;

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setString(3, role);
            for (int i = 0; i < validIds.size(); i++) {
                ps.setInt(4 + i, validIds.get(i));
            }
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * SQL lấy role ưu tiên cao nhất của người dùng từ UserRoles và Roles.
     */
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

    /**
     * SQL tìm RoleID theo RoleName để gán role cho hội viên mới.
     */
    private Integer findRoleId(Connection conn, String roleName) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT RoleID FROM [dbo].[Roles] WHERE RoleName = ? AND IsDeleted = 0")) {
            ps.setString(1, roleName);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("RoleID") : null;
            }
        }
    }

    /**
     * SQL tìm MemberID theo UserID sau khi tạo hội viên để liên kết gói tập.
     */
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

    /**
     * Chuẩn hóa chuỗi null hoặc rỗng thành null, ngược lại trả về chuỗi đã trim.
     */
    private String blankToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    /**
     * Chuẩn hóa chuỗi null thành chuỗi rỗng để tránh lỗi khi đưa dữ liệu lên JSP.
     */
    private String safe(String value) {
        return value == null ? "" : value;
    }

    /**
     * Chọn chuỗi đầu tiên nếu có giá trị, nếu không thì dùng chuỗi dự phòng.
     */
    private String coalesce(String first, String second) {
        return first == null || first.isBlank() ? safe(second) : first;
    }

    /**
     * Trả về hash mật khẩu mặc định dùng khi Staff tạo tài khoản hội viên mới.
     */
    private String defaultPasswordHash() {
        return "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92";
    }
}
