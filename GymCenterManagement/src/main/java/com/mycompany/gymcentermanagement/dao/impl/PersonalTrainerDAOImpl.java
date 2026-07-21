/**
 * =========================================================================
 * @file          : PersonalTrainerDAOImpl.java
 * @description   : Lớp truy cập dữ liệu để quản lý hồ sơ Huấn luyện viên cá nhân (PT).
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonalTrainerDAOImpl extends BaseDAO implements PersonalTrainerDAO {

    public PersonalTrainerDAOImpl() {
        super();
    }

    public PersonalTrainerDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    /**
     * Maps a ResultSet row to a PersonalTrainer object.
     */
    private PersonalTrainer mapPersonalTrainer(ResultSet rs) throws SQLException {
        PersonalTrainer trainer = new PersonalTrainer();

        trainer.setPtId(rs.getInt("PTID"));
        trainer.setUserId(rs.getInt("UserID"));
        trainer.setFullName(rs.getString("FullName"));
        trainer.setDisplayName(rs.getString("DisplayName"));
        trainer.setSpecialization(rs.getString("Specialization"));

        Date careerStartDate = rs.getDate("CareerStartDate");
        if (careerStartDate != null) {
            trainer.setCareerStartDate(careerStartDate.toLocalDate());
        }

        trainer.setCertificateFileName(rs.getString("CertificateFileName"));
        trainer.setCertificateFilePath(rs.getString("CertificateFilePath"));
        trainer.setDescription(rs.getString("Description"));
        trainer.setAvatarPath(rs.getString("AvatarPath"));
        trainer.setStatus(rs.getString("Status"));

        trainer.setCreatedBy(rs.getString("CreatedBy"));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null) {
            trainer.setCreatedDate(createdDate.toLocalDateTime());
        }

        trainer.setUpdatedBy(rs.getString("UpdatedBy"));

        Timestamp updatedDate = rs.getTimestamp("UpdatedDate");
        if (updatedDate != null) {
            trainer.setUpdatedDate(updatedDate.toLocalDateTime());
        }

        trainer.setDeleted(rs.getBoolean("IsDeleted"));

        // Joined fields from Users table
        trainer.setEmail(rs.getString("Email"));
        trainer.setPhone(rs.getString("Phone"));
        trainer.setAccountStatus(rs.getString("AccountStatus"));
        trainer.setMustChangePassword(rs.getBoolean("MustChangePassword"));

        return trainer;
    }

    /**
     * Lấy danh sách tất cả các Huấn luyện viên đang hoạt động (Active).
     * Luồng nghiệp vụ: Truy vấn bảng PersonalTrainers join với bảng Users. Lọc các PT và User có trạng thái Active và chưa bị xóa mềm.
     * Dùng cho trang danh sách PT công khai.
     * 
     * @return Danh sách PersonalTrainer
     */
    @Override
    public List<PersonalTrainer> findActiveTrainers() {
        // SQL: Join PersonalTrainers với Users, lọc các tài khoản Active và chưa bị xóa, sắp xếp theo tên
        String sql = """
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.Status = 'Active'
                      AND u.Status = 'Active'
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                    ORDER BY pt.FullName
                """;

        List<PersonalTrainer> trainers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Lấy danh sách các Huấn luyện viên đang hoạt động theo danh sách chuyên môn (Multiple specializations).
     * Luồng nghiệp vụ: Truy vấn bảng PersonalTrainers join Users. 
     * Linh động tạo điều kiện OR cho từng chuyên môn trong danh sách.
     * 
     * @param specializations Danh sách chuyên môn cần lọc
     * @return Danh sách PersonalTrainer
     */
    @Override
    public List<PersonalTrainer> findActiveTrainersBySpecializations(List<String> specializations) {
        if (specializations == null || specializations.isEmpty()) {
            return findActiveTrainers();
        }

        List<PersonalTrainer> trainers = new ArrayList<>();

        StringBuilder conditions = new StringBuilder();
        for (int i = 0; i < specializations.size(); i++) {
            conditions.append("pt.Specialization LIKE ?");
            if (i < specializations.size() - 1) {
                conditions.append(" OR ");
            }
        }

        // SQL: Truy vấn PT active kèm theo các điều kiện lọc LIKE OR theo từng chuyên môn
        String sql = """
                SELECT
                    pt.PTID,
                    pt.UserID,
                    pt.FullName,
                    pt.DisplayName,
                    pt.Specialization,
                    pt.CareerStartDate,
                    pt.CertificateFileName,
                    pt.CertificateFilePath,
                    pt.Description,
                    pt.AvatarPath,
                    pt.Status,
                    pt.CreatedBy,
                    pt.CreatedDate,
                    pt.UpdatedBy,
                    pt.UpdatedDate,
                    pt.IsDeleted,
                    u.Email,
                    u.Phone,
                    u.Status AS AccountStatus,
                    u.MustChangePassword
                FROM PersonalTrainers pt
                INNER JOIN Users u ON pt.UserID = u.UserID
                WHERE pt.Status = 'Active'
                  AND u.Status = 'Active'
                  AND pt.IsDeleted = 0
                  AND u.IsDeleted = 0
                  AND (
                """ + conditions + """
                      )
                    ORDER BY pt.FullName
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);

            for (int i = 0; i < specializations.size(); i++) {
                ps.setString(i + 1, "%" + specializations.get(i) + "%");
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách PT active", e);
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Tìm thông tin chi tiết một Huấn luyện viên theo PTID.
     * Luồng nghiệp vụ: Truy vấn join lấy dữ liệu PT và User theo ID, bỏ qua các bản ghi bị xóa.
     * 
     * @param ptId PTID
     * @return PersonalTrainer nếu tìm thấy
     */
    @Override
    public PersonalTrainer findById(int ptId) {
        // SQL: Join PersonalTrainers với Users theo PTID
        String sql = """
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.PTID = ?
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapPersonalTrainer(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return null;
    }

    /**
     * Tìm thông tin Huấn luyện viên dựa trên UserID.
     * Luồng nghiệp vụ: Dùng để lấy thông tin PT khi họ đăng nhập (liên kết UserID).
     * 
     * @param userId UserID
     * @return PersonalTrainer
     */
    @Override
    public PersonalTrainer findPTByUserId(int userId) {
        // SQL: Tìm PT liên kết với tài khoản UserID
        String sql = """
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.UserID = ?
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapPersonalTrainer(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return null;
    }

    /**
     * Lấy tất cả hồ sơ Huấn luyện viên cho màn hình quản lý của Staff/Admin.
     * Luồng nghiệp vụ: Lấy tất cả trạng thái (Active, Inactive), chỉ loại bỏ các bản ghi đã xóa mềm (IsDeleted = 1).
     * 
     * @return Danh sách PersonalTrainer
     */
    @Override
    public List<PersonalTrainer> findAllForManagement() {
        List<PersonalTrainer> trainers = new ArrayList<>();

        // SQL: Lấy tất cả PT chưa bị xóa, sắp xếp theo thời gian tạo mới nhất
        String sql = """
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                    ORDER BY pt.CreatedDate DESC
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Tìm kiếm PT đang hoạt động theo từ khóa và 1 chuyên môn cụ thể.
     * Luồng nghiệp vụ: Tìm kiếm linh hoạt trên nhiều trường (Tên, Hiển thị, Chuyên môn, Email...).
     * 
     * @param keyword Từ khóa tìm kiếm
     * @param specialization Chuyên môn cụ thể
     * @return Danh sách PersonalTrainer
     */
    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, String specialization) {
        List<PersonalTrainer> trainers = new ArrayList<>();

        // SQL: Truy vấn tìm kiếm LIKE OR trên các trường, lọc theo Active
        String sql = """
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.Status = 'Active'
                      AND u.Status = 'Active'
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                      AND (
                            ? IS NULL
                            OR pt.FullName LIKE ?
                            OR pt.DisplayName LIKE ?
                            OR pt.Specialization LIKE ?
                            OR pt.Description LIKE ?
                          )
                      AND (
                            ? IS NULL
                            OR pt.Specialization LIKE ?
                          )
                    ORDER BY pt.FullName
                """;

        String searchValue = null;
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchValue = "%" + keyword.trim() + "%";
        }

        String specializationValue = null;
        if (specialization != null && !specialization.trim().isEmpty()) {
            specializationValue = "%" + specialization.trim() + "%";
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);
            ps.setString(4, searchValue);
            ps.setString(5, searchValue);

            if (specialization == null || specialization.trim().isEmpty()) {
                ps.setString(6, null);
                ps.setString(7, null);
            } else {
                ps.setString(6, specialization.trim());
                ps.setString(7, specializationValue);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Tìm kiếm PT đang hoạt động theo từ khóa và nhiều chuyên môn.
     * Luồng nghiệp vụ: Tương tự như trên nhưng build chuỗi SQL động để xử lý list specializations bằng OR.
     * 
     * @param keyword Từ khóa
     * @param specializations Danh sách chuyên môn
     * @return Danh sách PT
     */
    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations) {
        List<PersonalTrainer> trainers = new ArrayList<>();

        // SQL: Base query cho việc tìm kiếm
        StringBuilder sql = new StringBuilder("""
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.Status = 'Active'
                      AND u.Status = 'Active'
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                """);

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasSpecializations = specializations != null && !specializations.isEmpty();

        if (hasKeyword) {
            sql.append("""
                        AND (
                            pt.FullName LIKE ?
                            OR pt.DisplayName LIKE ?
                            OR pt.Specialization LIKE ?
                            OR pt.Description LIKE ?
                            OR u.Email LIKE ?
                        )
                    """);
        }

        if (hasSpecializations) {
            sql.append(" AND (");

            for (int i = 0; i < specializations.size(); i++) {
                sql.append("pt.Specialization LIKE ?");

                if (i < specializations.size() - 1) {
                    sql.append(" OR ");
                }
            }

            sql.append(") ");
        }

        sql.append(" ORDER BY pt.FullName ");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql.toString());

            int index = 1;

            if (hasKeyword) {
                String searchValue = "%" + keyword.trim() + "%";

                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
            }

            if (hasSpecializations) {
                for (String specialization : specializations) {
                    ps.setString(index++, "%" + specialization + "%");
                }
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Tìm kiếm PT cho màn hình quản lý (có bộ lọc Trạng thái).
     * Luồng nghiệp vụ: Dựa vào đầu vào để append các điều kiện SQL động (Status, Keyword, Specializations).
     * 
     * @param keyword Từ khóa
     * @param specializations Chuyên môn
     * @param status Trạng thái lọc (Active, Inactive, Locked, All)
     * @return Danh sách PT
     */
    @Override
    public List<PersonalTrainer> searchTrainersForManagement(String keyword, List<String> specializations, String status) {
        List<PersonalTrainer> trainers = new ArrayList<>();

        // SQL: Base query cho việc tìm kiếm màn hình quản lý (Không lọc Status ban đầu)
        StringBuilder sql = new StringBuilder("""
                    SELECT
                        pt.PTID,
                        pt.UserID,
                        pt.FullName,
                        pt.DisplayName,
                        pt.Specialization,
                        pt.CareerStartDate,
                        pt.CertificateFileName,
                        pt.CertificateFilePath,
                        pt.Description,
                        pt.AvatarPath,
                        pt.Status,
                        pt.CreatedBy,
                        pt.CreatedDate,
                        pt.UpdatedBy,
                        pt.UpdatedDate,
                        pt.IsDeleted,
                        u.Email,
                        u.Phone,
                        u.Status AS AccountStatus,
                        u.MustChangePassword
                    FROM PersonalTrainers pt
                    INNER JOIN Users u ON pt.UserID = u.UserID
                    WHERE pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                """);

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasSpecializations = specializations != null && !specializations.isEmpty();
        boolean hasStatus = status != null && !status.trim().isEmpty() && !"All".equalsIgnoreCase(status);

        if (hasKeyword) {
            sql.append("""
                        AND (
                            pt.FullName LIKE ?
                            OR pt.DisplayName LIKE ?
                            OR pt.Specialization LIKE ?
                            OR pt.Description LIKE ?
                            OR u.Email LIKE ?
                        )
                    """);
        }

        if (hasSpecializations) {
            sql.append(" AND (");
            for (int i = 0; i < specializations.size(); i++) {
                sql.append("pt.Specialization LIKE ?");
                if (i < specializations.size() - 1) {
                    sql.append(" OR ");
                }
            }
            sql.append(") ");
        }

        if (hasStatus) {
            if ("Active".equalsIgnoreCase(status)) {
                sql.append(" AND pt.Status = 'Active' AND u.Status = 'Active' ");
            } else if ("Inactive".equalsIgnoreCase(status)) {
                sql.append(" AND pt.Status = 'Inactive' ");
            } else if ("Locked".equalsIgnoreCase(status)) {
                sql.append(" AND u.Status = 'Locked' ");
            }
        }

        sql.append(" ORDER BY pt.CreatedDate DESC ");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (hasKeyword) {
                String searchLike = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
            }

            if (hasSpecializations) {
                for (String spec : specializations) {
                    ps.setString(paramIndex++, "%" + spec.trim() + "%");
                }
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource(conn, ps, rs);
        }

        return trainers;
    }

    /**
     * Thêm mới một hồ sơ Huấn luyện viên chính thức.
     * Luồng nghiệp vụ: Gắn với UserID đã có. Các trường cơ bản được truyền vào, trạng thái IsDeleted mặc định = 0.
     * 
     * @param trainer Thông tin PT
     * @return true nếu thêm thành công
     */
    @Override
    public boolean insertPersonalTrainer(PersonalTrainer trainer) {
        // SQL: Insert thông tin PT
        String sql = """
                    INSERT INTO PersonalTrainers (
                        UserID,
                        FullName,
                        DisplayName,
                        Specialization,
                        CareerStartDate,
                        CertificateFileName,
                        CertificateFilePath,
                        Description,
                        AvatarPath,
                        Status,
                        CreatedBy,
                        CreatedDate,
                        IsDeleted
                    )
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 0)
                """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, trainer.getUserId());
            ps.setString(2, trainer.getFullName());
            ps.setString(3, trainer.getDisplayName());
            ps.setString(4, trainer.getSpecialization());

            if (trainer.getCareerStartDate() != null) {
                ps.setDate(5, Date.valueOf(trainer.getCareerStartDate()));
            } else {
                ps.setNull(5, Types.DATE);
            }

            ps.setString(6, trainer.getCertificateFileName());
            ps.setString(7, trainer.getCertificateFilePath());
            ps.setString(8, trainer.getDescription());
            ps.setString(9, trainer.getAvatarPath());
            String status = trainer.getStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }
            ps.setString(10, status);
            ps.setString(11, trainer.getCreatedBy());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    /**
     * Cập nhật thông tin công khai và đã xác minh của PT.
     * Luồng nghiệp vụ: Update các trường thông tin PT dựa trên PTID. Không cho phép đổi UserID liên kết.
     * 
     * @param trainer Thông tin cần cập nhật
     * @return true nếu cập nhật thành công
     */
    @Override
    public boolean updatePersonalTrainer(PersonalTrainer trainer) {
        // SQL: Cập nhật thông tin PT
        String sqlPT = """
                    UPDATE PersonalTrainers
                    SET FullName = ?,
                        DisplayName = ?,
                        Specialization = ?,
                        CareerStartDate = ?,
                        CertificateFileName = ?,
                        CertificateFilePath = ?,
                        Description = ?,
                        AvatarPath = ?,
                        Status = ?,
                        UpdatedBy = ?,
                        UpdatedDate = GETDATE()
                    WHERE PTID = ?
                      AND IsDeleted = 0
                """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sqlPT);
            ps.setString(1, trainer.getFullName());
            ps.setString(2, trainer.getDisplayName());
            ps.setString(3, trainer.getSpecialization());

            if (trainer.getCareerStartDate() != null) {
                ps.setDate(4, Date.valueOf(trainer.getCareerStartDate()));
            } else {
                ps.setNull(4, Types.DATE);
            }

            ps.setString(5, trainer.getCertificateFileName());
            ps.setString(6, trainer.getCertificateFilePath());
            ps.setString(7, trainer.getDescription());
            ps.setString(8, trainer.getAvatarPath());

            String status = trainer.getStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }
            ps.setString(9, status);
            ps.setString(10, trainer.getUpdatedBy());
            ps.setInt(11, trainer.getPtId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    /**
     * Cập nhật trạng thái làm việc của Huấn luyện viên.
     * Luồng nghiệp vụ: Chỉ cập nhật cờ Status ('Active' / 'Inactive') của PT. 
     * Gọi từ service khi đồng bộ trạng thái.
     * 
     * @param ptId ID của PT
     * @param status Trạng thái mới
     * @param updatedBy Người thực hiện
     * @return true nếu thành công
     */
    @Override
    public boolean updateTrainerStatus(int ptId, String status, String updatedBy) {
        // SQL: Cập nhật trường Status trong bảng PersonalTrainers
        String sqlPT = """
                    UPDATE PersonalTrainers
                    SET Status = ?,
                        UpdatedBy = ?,
                        UpdatedDate = GETDATE()
                    WHERE PTID = ?
                      AND IsDeleted = 0
                """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sqlPT);
            ps.setString(1, status);
            ps.setString(2, updatedBy);
            ps.setInt(3, ptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    /**
     * Xóa mềm hồ sơ Huấn luyện viên.
     * Luồng nghiệp vụ: Set cờ IsDeleted = 1.
     * 
     * @param ptId ID PT
     * @param updatedBy Người xóa
     * @return true nếu xóa thành công
     */
    @Override
    public boolean softDeletePersonalTrainer(int ptId, String updatedBy) {
        // SQL: Đánh dấu xóa (soft delete) cho PT
        String sql = """
                    UPDATE PersonalTrainers
                    SET IsDeleted = 1,
                        UpdatedBy = ?,
                        UpdatedDate = GETDATE()
                    WHERE PTID = ?
                """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, updatedBy);
            ps.setInt(2, ptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResource(conn, ps, null);
        }
    }

    /**
     * Cập nhật hồ sơ công khai của PT (chức năng cho PT tự thực hiện).
     * Luồng nghiệp vụ: Cho phép PT đổi Avatar, Mô tả và Tên hiển thị công khai.
     * [BR-ACT-44]: Personal Trainers can update their public profile, including their avatar, description, and specialization.
     * 
     * @param pt Đối tượng PT chứa thông tin cập nhật
     * @return true nếu cập nhật thành công
     * @throws SQLException
     */
    @Override
    public boolean updateProfile(PersonalTrainer pt) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = getActiveConnection();
            // SQL: Cập nhật các trường DisplayName, Description, AvatarPath do PT tự điều chỉnh
            String sql = "UPDATE PersonalTrainers SET "
                    + "DisplayName = ?, "
                    + "Description = ?, "
                    + "AvatarPath = ?, "
                    + "UpdatedBy = ?, "
                    + "UpdatedDate = GETDATE() "
                    + "WHERE PTID = ? AND IsDeleted = 0";

            stm = conn.prepareStatement(sql);

            stm.setString(1, pt.getDisplayName());
            stm.setString(2, pt.getDescription());
            stm.setString(3, pt.getAvatarPath());
            stm.setString(4, pt.getUpdatedBy());
            stm.setInt(5, pt.getPtId());

            int rowAffected = stm.executeUpdate();
            return (rowAffected > 0);
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi update profile: " + e.getMessage());
            throw e;
        } finally {
            closeResource(conn, stm, null);
        }
    }

    /**
     * Lấy danh sách các hội viên đang theo học PT (Dành cho PT).
     * Luồng nghiệp vụ: Truy vấn bảng PTRegistrations join Members, PTServicePrices để lấy học viên của PT.
     * Lấy số buổi đã mua, số buổi đã hoàn thành, số buổi đã hủy và lịch học.
     * 
     * @param ptId PTID
     * @return Danh sách PTMemberDTO
     */
    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPT(int ptId) {
        List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> list = new ArrayList<>();
        // SQL: Join để lấy danh sách học viên Active, đếm số buổi học, và dùng STRING_AGG để tạo chuỗi ngày giờ học (SQL Server syntax)
        String sql = """
                SELECT 
                    r.PTRegistrationID,
                    u.DisplayName AS MemberName,
                    u.Phone AS MemberPhone,
                    p.PackageName,
                    r.StartDate,
                    r.EndDate,
                    r.PurchasedSessions AS TotalSessions,
                    (SELECT COUNT(*) FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND SessionStatus = 'Completed' AND IsDeleted = 0) AS CompletedSessions,
                    (SELECT COUNT(*) FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND SessionStatus = 'Cancelled' AND IsDeleted = 0) AS CancelledSessions,
                    (SELECT STRING_AGG(
                        CASE wd
                            WHEN 2 THEN N'T2' WHEN 3 THEN N'T3' WHEN 4 THEN N'T4'
                            WHEN 5 THEN N'T5' WHEN 6 THEN N'T6' WHEN 7 THEN N'T7' WHEN 1 THEN N'CN'
                        END, ', ') WITHIN GROUP (ORDER BY wd ASC)
                     FROM (SELECT DISTINCT DATEPART(weekday, SessionDate) AS wd FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND IsDeleted = 0) AS sub) AS DaysOfWeek,
                    (SELECT STRING_AGG(
                        CASE wd
                            WHEN 2 THEN N'T2' WHEN 3 THEN N'T3' WHEN 4 THEN N'T4'
                            WHEN 5 THEN N'T5' WHEN 6 THEN N'T6' WHEN 7 THEN N'T7' WHEN 1 THEN N'CN'
                        END + ': ' + CONVERT(varchar(5), StartTime, 108) + '-' + CONVERT(varchar(5), EndTime, 108), ', ') WITHIN GROUP (ORDER BY wd ASC)
                     FROM (SELECT DISTINCT DATEPART(weekday, SessionDate) AS wd, StartTime, EndTime FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND IsDeleted = 0) AS sub) AS TimeSlot
                FROM PTRegistrations r
                INNER JOIN Members m ON r.MemberID = m.MemberID
                INNER JOIN Users u ON m.UserID = u.UserID
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                WHERE sp.PTID = ? AND r.Status = 'Active' AND r.IsDeleted = 0
                ORDER BY r.StartDate DESC
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            while (rs.next()) {
                com.mycompany.gymcentermanagement.dto.PTMemberDTO dto = new com.mycompany.gymcentermanagement.dto.PTMemberDTO();
                dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                dto.setMemberName(rs.getString("MemberName"));
                dto.setMemberPhone(rs.getString("MemberPhone"));
                dto.setPackageName(rs.getString("PackageName"));
                dto.setStartDate(rs.getDate("StartDate") != null ? rs.getDate("StartDate").toLocalDate() : null);
                dto.setEndDate(rs.getDate("EndDate") != null ? rs.getDate("EndDate").toLocalDate() : null);
                dto.setTotalSessions(rs.getInt("TotalSessions"));
                dto.setCompletedSessions(rs.getInt("CompletedSessions"));
                dto.setCancelledSessions(rs.getInt("CancelledSessions"));
                dto.setDaysOfWeek(rs.getString("DaysOfWeek"));
                dto.setTimeSlot(rs.getString("TimeSlot"));
                list.add(dto);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi getActiveMembersForPT: " + e.getMessage());
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }

    /**
     * Lấy tổng số học viên đang theo học PT (dành cho phân trang/thống kê).
     * 
     * @param ptId PTID
     * @return Số lượng học viên
     */
    @Override
    public int getActiveMembersForPTCount(int ptId) {
        // SQL: Đếm số lượng học viên Active của PT
        String sql = """
                SELECT COUNT(*)
                FROM PTRegistrations r
                INNER JOIN Members m ON r.MemberID = m.MemberID
                INNER JOIN Users u ON m.UserID = u.UserID
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                WHERE sp.PTID = ? AND r.Status = 'Active' AND r.IsDeleted = 0
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi getActiveMembersForPTCount: " + e.getMessage());
        } finally {
            closeResource(conn, ps, rs);
        }
        return 0;
    }

    /**
     * Lấy danh sách hội viên đang theo học PT, có phân trang.
     * Luồng nghiệp vụ: Tương tự như hàm trên nhưng dùng OFFSET FETCH để phân trang.
     * 
     * @param ptId PTID
     * @param offset Điểm bắt đầu
     * @param limit Số lượng
     * @return Danh sách PTMemberDTO
     */
    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPTPaginated(int ptId, int offset, int limit) {
        List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> list = new ArrayList<>();
        // SQL: Phân trang học viên bằng OFFSET và FETCH NEXT (SQL Server)
        String sql = """
                SELECT 
                    r.PTRegistrationID,
                    u.DisplayName AS MemberName,
                    u.Phone AS MemberPhone,
                    p.PackageName,
                    r.StartDate,
                    r.EndDate,
                    r.PurchasedSessions AS TotalSessions,
                    (SELECT COUNT(*) FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND SessionStatus = 'Completed' AND IsDeleted = 0) AS CompletedSessions,
                    (SELECT COUNT(*) FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND SessionStatus = 'Cancelled' AND IsDeleted = 0) AS CancelledSessions,
                    (SELECT STRING_AGG(
                        CASE wd
                            WHEN 2 THEN N'T2' WHEN 3 THEN N'T3' WHEN 4 THEN N'T4'
                            WHEN 5 THEN N'T5' WHEN 6 THEN N'T6' WHEN 7 THEN N'T7' WHEN 1 THEN N'CN'
                        END, ', ') WITHIN GROUP (ORDER BY wd ASC)
                     FROM (SELECT DISTINCT DATEPART(weekday, SessionDate) AS wd FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND IsDeleted = 0) AS sub) AS DaysOfWeek,
                    (SELECT STRING_AGG(
                        CASE wd
                            WHEN 2 THEN N'T2' WHEN 3 THEN N'T3' WHEN 4 THEN N'T4'
                            WHEN 5 THEN N'T5' WHEN 6 THEN N'T6' WHEN 7 THEN N'T7' WHEN 1 THEN N'CN'
                        END + ': ' + CONVERT(varchar(5), StartTime, 108) + '-' + CONVERT(varchar(5), EndTime, 108), ', ') WITHIN GROUP (ORDER BY wd ASC)
                     FROM (SELECT DISTINCT DATEPART(weekday, SessionDate) AS wd, StartTime, EndTime FROM PTSchedules WHERE PTRegistrationID = r.PTRegistrationID AND IsDeleted = 0) AS sub) AS TimeSlot
                FROM PTRegistrations r
                INNER JOIN Members m ON r.MemberID = m.MemberID
                INNER JOIN Users u ON m.UserID = u.UserID
                INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                INNER JOIN PTPackageTypes p ON sp.PTPackageTypeID = p.PTPackageTypeID
                WHERE sp.PTID = ? AND r.Status = 'Active' AND r.IsDeleted = 0
                ORDER BY r.StartDate DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ptId);
            ps.setInt(2, Math.max(0, offset));
            ps.setInt(3, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                com.mycompany.gymcentermanagement.dto.PTMemberDTO dto = new com.mycompany.gymcentermanagement.dto.PTMemberDTO();
                dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                dto.setMemberName(rs.getString("MemberName"));
                dto.setMemberPhone(rs.getString("MemberPhone"));
                dto.setPackageName(rs.getString("PackageName"));
                dto.setStartDate(rs.getDate("StartDate") != null ? rs.getDate("StartDate").toLocalDate() : null);
                dto.setEndDate(rs.getDate("EndDate") != null ? rs.getDate("EndDate").toLocalDate() : null);
                dto.setTotalSessions(rs.getInt("TotalSessions"));
                dto.setCompletedSessions(rs.getInt("CompletedSessions"));
                dto.setCancelledSessions(rs.getInt("CancelledSessions"));
                dto.setDaysOfWeek(rs.getString("DaysOfWeek"));
                dto.setTimeSlot(rs.getString("TimeSlot"));
                list.add(dto);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi getActiveMembersForPTPaginated: " + e.getMessage());
        } finally {
            closeResource(conn, ps, rs);
        }
        return list;
    }
}
