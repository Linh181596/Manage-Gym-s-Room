/**
 * =========================================================================
 * @file          : MemberPackageDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể MemberPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.MemberPackageDAO;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.sql.Timestamp;

public class MemberPackageDAOImpl extends BaseDAO implements MemberPackageDAO {

    public MemberPackageDAOImpl() {
        super();
    }

    public MemberPackageDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private MemberPackage mapResultSetToMemberPackage(ResultSet rs) throws SQLException {
        MemberPackage mp = new MemberPackage();
        mp.setMemberPackageId(rs.getInt("MemberPackageID"));
        mp.setMemberId(rs.getInt("MemberID"));
        mp.setPackageId(rs.getInt("PackageID"));
        
        Date start = rs.getDate("StartDate");
        if (start != null) {
            mp.setStartDate(start.toLocalDate());
        }
        
        Date end = rs.getDate("EndDate");
        if (end != null) {
            mp.setEndDate(end.toLocalDate());
        }
        
        mp.setStatus(rs.getString("Status"));
        mp.setCreatedBy(rs.getString("CreatedBy"));
        
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            mp.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        mp.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            mp.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        mp.setDeleted(rs.getBoolean("IsDeleted"));

        // Attempt mapping linked details if present in ResultSet
        try {
            GymPackage gp = new GymPackage();
            gp.setPackageId(rs.getInt("PackageID"));
            gp.setPackageName(rs.getString("PackageName"));
            gp.setPrice(rs.getBigDecimal("Price"));
            gp.setDurationMonths(rs.getInt("DurationMonths"));
            mp.setGymPackage(gp);
            
            Member m = new Member();
            m.setMemberId(rs.getInt("MemberID"));
            User u = new User();
            u.setFullName(rs.getString("DisplayName"));
            u.setEmail(rs.getString("Email"));
            m.setUserDetails(u);
            mp.setMember(m);
        } catch (SQLException ex) {
            // Ignore if columns not in query
        }

        return mp;
    }

    /**
     * Lấy thông tin chi tiết một gói tập của hội viên (MemberPackage) dựa trên ID.
     * Luồng nghiệp vụ: Truy vấn bảng MemberPackages join với GymPackages, Members và Users để lấy đầy đủ thông tin hiển thị.
     * Chỉ trả về dữ liệu nếu bản ghi chưa bị xóa (IsDeleted = 0).
     * 
     * @param memberPackageId ID của gói tập hội viên
     * @return MemberPackage nếu tìm thấy, ngược lại null
     * @throws SQLException nếu có lỗi truy vấn
     */
    @Override
    public MemberPackage findById(int memberPackageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MemberPackage mp = null;
        
        try {
            conn = getActiveConnection();
            // SQL: Join MemberPackages với GymPackages và Users để lấy đầy đủ tên gói, giá và tên hội viên
            String sql = "SELECT mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberPackageID = ? AND mp.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberPackageId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mp = mapResultSetToMemberPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return mp;
    }

    /**
     * Thêm mới một đăng ký gói tập cho hội viên.
     * Luồng nghiệp vụ: Insert thông tin gói vào bảng MemberPackages với trạng thái ban đầu thường là Pending.
     * Lấy khóa tự tăng sau khi lưu thành công gán lại cho object.
     * 
     * @param mp Đối tượng đăng ký gói tập
     * @return true nếu lưu thành công
     * @throws SQLException nếu có lỗi kết nối
     */
    @Override
    public boolean insert(MemberPackage mp) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Thêm mới đăng ký gói tập vào hệ thống
            String sql = "INSERT INTO MemberPackages (MemberID, PackageID, StartDate, EndDate, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, mp.getMemberId());
            stmt.setInt(2, mp.getPackageId());
            stmt.setDate(3, Date.valueOf(mp.getStartDate()));
            stmt.setDate(4, Date.valueOf(mp.getEndDate()));
            stmt.setString(5, mp.getStatus());
            stmt.setString(6, mp.getCreatedBy());
            stmt.setTimestamp(7, mp.getCreatedDate() != null ? Timestamp.valueOf(mp.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    mp.setMemberPackageId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    /**
     * Cập nhật thông tin đăng ký gói tập hội viên.
     * Luồng nghiệp vụ: Update các thay đổi (Status, StartDate, EndDate) dựa trên ID.
     * Thường gọi khi thanh toán thành công chuyển từ Pending -> Active.
     * 
     * @param mp Đối tượng MemberPackage
     * @return true nếu cập nhật thành công
     * @throws SQLException nếu có lỗi
     */
    @Override
    public boolean update(MemberPackage mp) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Cập nhật thông tin ngày tháng, trạng thái của bản ghi gói tập
            String sql = "UPDATE MemberPackages SET MemberID = ?, PackageID = ?, StartDate = ?, EndDate = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE MemberPackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, mp.getMemberId());
            stmt.setInt(2, mp.getPackageId());
            stmt.setDate(3, Date.valueOf(mp.getStartDate()));
            stmt.setDate(4, Date.valueOf(mp.getEndDate()));
            stmt.setString(5, mp.getStatus());
            stmt.setString(6, mp.getUpdatedBy());
            stmt.setTimestamp(7, mp.getUpdatedDate() != null ? Timestamp.valueOf(mp.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, mp.getMemberPackageId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    /**
     * Xóa mềm đăng ký gói tập.
     * Luồng nghiệp vụ: Cập nhật cờ IsDeleted = 1 để xóa (Soft Delete).
     * 
     * @param memberPackageId ID cần xóa
     * @return true nếu thành công
     * @throws SQLException
     */
    @Override
    public boolean delete(int memberPackageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Xóa mềm gói tập của thành viên bằng cách set IsDeleted = 1
            String sql = "UPDATE MemberPackages SET IsDeleted = 1 WHERE MemberPackageID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberPackageId);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    /**
     * Tìm gói tập mới nhất của hội viên (bất kể trạng thái).
     * Luồng nghiệp vụ: Truy vấn bản ghi có thời hạn kết thúc (EndDate) trễ nhất.
     * Dùng để xác định gói tập mà hội viên có thể gia hạn.
     * 
     * @param memberId ID của hội viên
     * @return MemberPackage mới nhất, nếu không có thì null
     * @throws SQLException
     */
    @Override
    public MemberPackage findLatestByMemberId(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MemberPackage mp = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT TOP 1 mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberID = ? AND mp.IsDeleted = 0 " +
                         "ORDER BY mp.EndDate DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mp = mapResultSetToMemberPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return mp;
    }

    /**
     * Tìm gói tập Active hiện tại (hoặc mới nhất) của hội viên.
     * Luồng nghiệp vụ: Truy vấn các bản ghi Active, thời hạn chưa kết thúc, lấy 1 bản ghi có hạn lâu nhất (nếu có chồng).
     * Dùng để kiểm tra cộng dồn thời gian (Nối ngày).
     * 
     * @param memberId ID của hội viên
     * @return MemberPackage đang hoạt động, nếu không có thì null
     * @throws SQLException
     */
    @Override
    public MemberPackage findActiveByMemberId(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MemberPackage mp = null;
        
        try {
            conn = getActiveConnection();
            // SQL: Chọn gói tập của hội viên đang hoạt động, chưa hết hạn, và lấy cái có thời hạn kết thúc trễ nhất
            String sql = "SELECT TOP 1 mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberID = ? AND mp.Status = 'Active' AND mp.IsDeleted = 0 " +
                         "AND mp.EndDate >= CAST(GETDATE() AS date) " +
                         "ORDER BY mp.EndDate DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mp = mapResultSetToMemberPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return mp;
    }

    /**
     * Lấy tất cả các gói tập Active của một hội viên.
     * Luồng nghiệp vụ: Truy vấn danh sách các gói đang được đăng ký (Active) và còn hạn sử dụng.
     * 
     * @param memberId ID của hội viên
     * @return Danh sách các gói đang hoạt động của hội viên
     * @throws SQLException
     */
    @Override
    public java.util.List<MemberPackage> findAllActiveByMemberId(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        java.util.List<MemberPackage> list = new java.util.ArrayList<>();
        
        try {
            conn = getActiveConnection();
            // SQL: Lấy tất cả gói tập đang kích hoạt của member, sắp xếp theo thời gian kết thúc tăng dần
            String sql = "SELECT mp.*, gp.PackageName, gp.Price, gp.DurationMonths, u.DisplayName, u.Email " +
                         "FROM MemberPackages mp " +
                         "INNER JOIN GymPackages gp ON mp.PackageID = gp.PackageID " +
                         "INNER JOIN Members m ON mp.MemberID = m.MemberID " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE mp.MemberID = ? AND mp.Status = 'Active' AND mp.IsDeleted = 0 " +
                         "AND mp.EndDate >= CAST(GETDATE() AS date) " +
                         "ORDER BY mp.EndDate ASC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMemberPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
