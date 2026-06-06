/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.dao;

import com.gcms.dto.*;
import com.gcms.util.DBContext;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: ProfileDAO.java
 * Description: Lớp xử lý dữ liệu phức hợp cho phân hệ hồ sơ người dùng (UC-03).
 * Thực hiện các câu lệnh INNER JOIN động giữa bảng Users và các bảng thông tin chức năng
 * (Members, Staffs, PersonalTrainers) để truy vấn và cập nhật dữ liệu an toàn dưới Database.
 * Author: duongnd - he187234
 * Created Date: 05/06/2026
 * Version: 1.0
 *
 * History:
 * Date          Author          Version        Description
 * -------------------------------------------------------------------------
 * 05/06/2026    duongnd         1.0            Viết các hàm JDBC lấy thông tin đa bảng và cập nhật Profile.
 */
public class ProfileDAO {
    
    private final DBContext dbContext = new DBContext();

    /**
     * Lấy vai trò có cấp bậc cao nhất dựa trên RoleLevel (Số càng nhỏ quyền càng cao)
     */
    public String getHighestPriorityRole(int userId) {
        String sql = "SELECT TOP 1 r.RoleName FROM UserRoles ur " +
                     "INNER JOIN Roles r ON ur.RoleID = r.RoleID " +
                     "WHERE ur.UserID = ? " +
                     "ORDER BY r.RoleLevel ASC"; 
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("RoleName");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Đọc thông tin hồ sơ cá nhân chi tiết dựa vào UserId và phân hệ quyền.
     */
    public UserProfileBaseDTO getUserProfileById(int userId) {
        String roleName = getHighestPriorityRole(userId);
        if (roleName == null) return null;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            
            if ("Admin".equalsIgnoreCase(roleName)) {
                String sql = "SELECT UserID, Email, DisplayName, Phone FROM Users " +
                             "WHERE UserID = ? AND IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    UserProfileBaseDTO adminProfile = new UserProfileBaseDTO();
                    setBaseProfileData(adminProfile, rs, roleName);
                    return adminProfile;
                }
            }
            else if ("Member".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, m.Gender, m.DateOfBirth, m.Address, m.MembershipStatus " +
                             "FROM Users u INNER JOIN Members m ON u.UserID = m.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND m.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    MemberProfileDTO member = new MemberProfileDTO();
                    setBaseProfileData(member, rs, roleName);
                    member.setGender(rs.getString("Gender"));
                    member.setDateOfBirth(rs.getDate("DateOfBirth"));
                    member.setAddress(rs.getString("Address"));
                    member.setMembershipStatus(rs.getString("MembershipStatus"));
                    return member;
                }
            } 
            else if ("PT".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, pt.FullName, pt.Specialization, pt.Description, " +
                             "pt.CareerStartDate, pt.AvatarPath, pt.CertificateFileName, pt.CertificateFilePath " +
                             "FROM Users u INNER JOIN PersonalTrainers pt ON u.UserID = pt.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND pt.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    PTProfileDTO pt = new PTProfileDTO();
                    setBaseProfileData(pt, rs, roleName);
                    pt.setFullName(rs.getString("FullName")); 
                    pt.setSpecialization(rs.getString("Specialization"));
                    pt.setDescription(rs.getString("Description"));
                    pt.setAvatarPath(rs.getString("AvatarPath"));
                    pt.setCertificateFileName(rs.getString("CertificateFileName"));
                    pt.setCertificateFilePath(rs.getString("CertificateFilePath"));
                    
                    Date startDateSql = rs.getDate("CareerStartDate");
                    if (startDateSql != null) {
                        LocalDate startDate = startDateSql.toLocalDate();
                        LocalDate currentDate = LocalDate.now();
                        long years = ChronoUnit.YEARS.between(startDate, currentDate);
                        pt.setExperienceYears((int) years);
                    }
                    return pt;
                }
            } 
            else if ("Staff".equalsIgnoreCase(roleName)) {
                String sql = "SELECT u.UserID, u.Email, u.DisplayName, u.Phone, s.Position " +
                             "FROM Users u INNER JOIN Staffs s ON u.UserID = s.UserID " +
                             "WHERE u.UserID = ? AND u.IsDeleted = 0 AND s.IsDeleted = 0";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    StaffProfileDTO staff = new StaffProfileDTO();
                    setBaseProfileData(staff, rs, roleName);
                    staff.setPosition(rs.getString("Position"));
                    return staff;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return null;
    }

    /**
     * Cập nhật thông tin hồ sơ cá nhân đa bảng có kiểm soát Transaction.
     * ĐÃ CẬP NHẬT: Thêm từ khóa throws và thực hiện ném trả lỗi gốc (throw e) ra ngoài.
     */
    public boolean updateUserProfile(UserProfileBaseDTO profileDto, String roleName) 
            throws SQLException, ClassNotFoundException {
        
        String sqlUser = "UPDATE Users SET DisplayName = ?, Phone = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psSub = null;

        try {
            conn = dbContext.getConnection();
            conn.setAutoCommit(false); // Kích hoạt cô lập Transaction

            // 1. Cập nhật dữ liệu cốt lõi vào bảng Users chính
            psUser = conn.prepareStatement(sqlUser);
            psUser.setString(1, profileDto.getDisplayName());
            psUser.setString(2, profileDto.getPhone());
            psUser.setInt(3, profileDto.getUserId());
            int userRows = psUser.executeUpdate();

            int subRows = 1; // Mặc định hợp lệ cho trường hợp Admin

            // 2. Rẽ nhánh cập nhật dữ liệu đặc thù phụ thuộc theo vai trò
            if ("Member".equalsIgnoreCase(roleName) && profileDto instanceof MemberProfileDTO) {
                MemberProfileDTO memberDto = (MemberProfileDTO) profileDto;
                String sqlMember = "UPDATE Members SET Gender = ?, DateOfBirth = ?, Address = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlMember);
                psSub.setString(1, memberDto.getGender());
                psSub.setDate(2, memberDto.getDateOfBirth());
                psSub.setString(3, memberDto.getAddress());
                psSub.setInt(4, memberDto.getUserId());
                subRows = psSub.executeUpdate();
            } 
            else if ("PT".equalsIgnoreCase(roleName) && profileDto instanceof PTProfileDTO) {
                PTProfileDTO ptDto = (PTProfileDTO) profileDto;
                String sqlPT = "UPDATE PersonalTrainers SET FullName = ?, Description = ?, AvatarPath = ?, " +
                               "CertificateFileName = ?, CertificateFilePath = ?, UpdatedDate = SYSDATETIME() WHERE UserID = ?";
                psSub = conn.prepareStatement(sqlPT);
                psSub.setString(1, ptDto.getFullName());
                psSub.setString(2, ptDto.getDescription());
                psSub.setString(3, ptDto.getAvatarPath());
                psSub.setString(4, ptDto.getCertificateFileName());
                psSub.setString(5, ptDto.getCertificateFilePath());
                psSub.setInt(6, ptDto.getUserId());
                subRows = psSub.executeUpdate();
            }

            // 3. Xác nhận lưu dữ liệu thành công nếu cả 2 khối lệnh thực thi trơn tru
            if (userRows > 0 && subRows > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Đảm bảo rollback ngay lập tức nếu xuất hiện bất kỳ sự cố gián đoạn nào
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            // 🌟 QUAN TRỌNG: Ghi log console đồng thời ném lỗi gốc ngược lên tầng Servlet đón nhận
            e.printStackTrace();
            throw e; 
        } finally {
            try {
                if (psUser != null) psUser.close();
                if (psSub != null) psSub.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void setBaseProfileData(UserProfileBaseDTO dto, ResultSet rs, String roleName) throws SQLException {
        dto.setUserId(rs.getInt("UserID"));
        dto.setEmail(rs.getString("Email"));
        dto.setDisplayName(rs.getString("DisplayName"));
        dto.setPhone(rs.getString("Phone"));
        dto.setRoleName(roleName);
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}