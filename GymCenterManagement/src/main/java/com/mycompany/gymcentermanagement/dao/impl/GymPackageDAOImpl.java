/**
 * =========================================================================
 * @file          : GymPackageDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể GymPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class GymPackageDAOImpl extends BaseDAO implements GymPackageDAO {

    public GymPackageDAOImpl() {
        super();
    }

    public GymPackageDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private GymPackage mapResultSetToGymPackage(ResultSet rs) throws SQLException {
        GymPackage pkg = new GymPackage();
        pkg.setPackageId(rs.getInt("PackageID"));
        pkg.setPackageName(rs.getString("PackageName"));
        pkg.setDurationMonths(rs.getInt("DurationMonths"));
        pkg.setPrice(rs.getBigDecimal("Price"));
        pkg.setDescription(rs.getString("Description"));
        pkg.setStatus(rs.getString("Status"));
        pkg.setCreatedBy(rs.getString("CreatedBy"));
        
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            pkg.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        pkg.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            pkg.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        pkg.setDeleted(rs.getBoolean("IsDeleted"));
        return pkg;
    }

    /**
     * Lấy danh sách tất cả các gói tập đang hoạt động (Active).
     * Luồng nghiệp vụ: Truy vấn bảng GymPackages, chỉ lấy những gói có Status='Active' và IsDeleted=0.
     * Dùng để hiển thị cho Member/Staff khi đăng ký gói.
     * 
     * @return Danh sách các đối tượng GymPackage
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public List<GymPackage> findAllActive() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            // SQL: Truy vấn danh sách gói tập, lọc theo trạng thái Active và chưa bị xóa mềm, sắp xếp theo giá tăng dần
            String sql = "SELECT * FROM GymPackages WHERE Status = 'Active' AND IsDeleted = 0 ORDER BY Price ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    /**
     * Lấy danh sách tất cả gói tập (Active, Inactive) chưa bị xóa.
     * Luồng nghiệp vụ: Truy vấn bảng GymPackages với điều kiện IsDeleted=0.
     * Dùng cho chức năng quản lý của Admin/Staff.
     * 
     * @return Danh sách các đối tượng GymPackage
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public List<GymPackage> findAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            // SQL: Lấy danh sách tất cả gói tập chưa bị xóa (IsDeleted = 0), sắp xếp mới nhất lên đầu
            String sql = "SELECT * FROM GymPackages WHERE IsDeleted = 0 ORDER BY PackageID DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }

    /**
     * Tìm kiếm gói tập theo ID.
     * Luồng nghiệp vụ: Truy vấn tìm một gói tập dựa trên PackageID. Chỉ trả về nếu IsDeleted=0.
     * 
     * @param packageId ID của gói tập
     * @return Đối tượng GymPackage tương ứng, hoặc null nếu không tìm thấy
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public GymPackage findById(int packageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        GymPackage pkg = null;
        
        try {
            conn = getActiveConnection();
            // SQL: Lấy thông tin chi tiết một gói tập dựa trên PackageID
            String sql = "SELECT * FROM GymPackages WHERE PackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, packageId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToGymPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    /**
     * Thêm mới một gói tập.
     * Luồng nghiệp vụ: Insert dữ liệu vào bảng GymPackages. Mặc định IsDeleted=0.
     * Sau khi insert thành công, lấy PackageID (GeneratedKey) gán lại vào object.
     * 
     * @param pkg Đối tượng GymPackage cần thêm
     * @return true nếu thêm thành công
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public boolean insert(GymPackage pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Insert thông tin gói tập mới, IsDeleted mặc định = 0
            String sql = "INSERT INTO GymPackages (PackageName, DurationMonths, Price, Description, Status, CreatedBy, CreatedDate, IsDeleted) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, pkg.getPackageName());
            stmt.setInt(2, pkg.getDurationMonths());
            stmt.setBigDecimal(3, pkg.getPrice());
            stmt.setString(4, pkg.getDescription());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getCreatedBy());
            stmt.setTimestamp(7, pkg.getCreatedDate() != null ? Timestamp.valueOf(pkg.getCreatedDate()) : new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            if (success) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    pkg.setPackageId(generatedKeys.getInt(1));
                }
            }
        } finally {
            closeResource(conn, stmt, generatedKeys);
        }
        return success;
    }

    /**
     * Cập nhật thông tin gói tập.
     * Luồng nghiệp vụ: Update dữ liệu của gói tập (Tên, Giá, Thời gian, Mô tả, Trạng thái) dựa trên PackageID.
     * 
     * @param pkg Đối tượng chứa thông tin mới
     * @return true nếu cập nhật thành công
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public boolean update(GymPackage pkg) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Cập nhật thông tin gói tập, ngoại trừ các trường không cho phép thay đổi như CreatedDate, CreatedBy
            String sql = "UPDATE GymPackages SET PackageName = ?, DurationMonths = ?, Price = ?, Description = ?, Status = ?, UpdatedBy = ?, UpdatedDate = ? " +
                         "WHERE PackageID = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, pkg.getPackageName());
            stmt.setInt(2, pkg.getDurationMonths());
            stmt.setBigDecimal(3, pkg.getPrice());
            stmt.setString(4, pkg.getDescription());
            stmt.setString(5, pkg.getStatus());
            stmt.setString(6, pkg.getUpdatedBy());
            stmt.setTimestamp(7, pkg.getUpdatedDate() != null ? Timestamp.valueOf(pkg.getUpdatedDate()) : new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, pkg.getPackageId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    /**
     * Tìm gói tập theo tên (chính xác).
     * Luồng nghiệp vụ: Dùng để kiểm tra trùng lặp tên gói tập khi tạo/cập nhật.
     * [BR-CONS-57]: Each package type name must be unique in the system.
     * 
     * @param packageName Tên gói tập
     * @return GymPackage nếu tìm thấy, ngược lại null
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public GymPackage findByName(String packageName) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        GymPackage pkg = null;
        
        try {
            conn = getActiveConnection();
            // SQL: Lấy gói tập theo tên để xác minh tính duy nhất
            String sql = "SELECT * FROM GymPackages WHERE PackageName = ? AND IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, packageName);
            rs = stmt.executeQuery();
            if (rs.next()) {
                pkg = mapResultSetToGymPackage(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return pkg;
    }

    /**
     * Xóa mềm một gói tập.
     * Luồng nghiệp vụ: Cập nhật cờ IsDeleted = 1 thay vì xóa vật lý khỏi CSDL.
     * [BR-CONS-59]: Deleting a package type must be executed as a soft delete to preserve historical data.
     * 
     * @param packageId ID gói tập cần xóa
     * @return true nếu xóa mềm thành công
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public boolean delete(int packageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = getActiveConnection();
            // SQL: Soft Delete - Thay vì dùng lệnh DELETE FROM, ta set cờ IsDeleted = 1 
            // Điều này giúp giữ lại dữ liệu lịch sử để tham chiếu (vd: Báo cáo, Lịch sử thanh toán)
            String sql = "UPDATE GymPackages SET IsDeleted = 1 WHERE PackageID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, packageId);
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            closeResource(conn, stmt, null);
        }
        return success;
    }

    /**
     * Đếm tổng số lượng gói tập chưa bị xóa.
     * Luồng nghiệp vụ: Dùng để tính toán phân trang trên giao diện quản lý.
     * 
     * @return Tổng số gói tập
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public int countAll() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            // SQL: Đếm tổng số bản ghi gói tập chưa bị xóa
            String sql = "SELECT COUNT(*) FROM GymPackages WHERE IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return 0;
    }

    /**
     * Lấy danh sách gói tập phân trang.
     * Luồng nghiệp vụ: Truy vấn với OFFSET và FETCH NEXT để lấy một phần danh sách hiển thị trên một trang.
     * 
     * @param offset Điểm bắt đầu
     * @param limit Số lượng bản ghi
     * @return Danh sách gói tập theo trang
     * @throws SQLException nếu có lỗi CSDL
     */
    @Override
    public List<GymPackage> findAllPaginated(int offset, int limit) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<GymPackage> list = new ArrayList<>();
        try {
            conn = getActiveConnection();
            // SQL: Lấy danh sách có phân trang sử dụng OFFSET FETCH
            String sql = "SELECT * FROM GymPackages WHERE IsDeleted = 0 ORDER BY PackageID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Math.max(0, offset));
            stmt.setInt(2, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToGymPackage(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
