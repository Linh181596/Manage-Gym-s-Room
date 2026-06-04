/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author phuga
 */

/*
     * Các hàm trong class này:
     *
     * - isEmailExists(): kiểm tra email đã tồn tại trong hệ thống chưa.
     * - insertUser(): thêm một tài khoản mới vào bảng Users và trả về UserID vừa tạo.
     *
     * Class này hiện được dùng khi Staff/Admin tạo tài khoản cho Personal Trainer.
 */
public class UserDAO extends DBContext {

    /**
     * Checks whether an email is already used by an active user account.
     *
     * @param email email to check
     * @return true if email already exists, otherwise false
     */
    public boolean isEmailExists(String email) {
        String sql = """
            SELECT COUNT(*) AS Total
            FROM Users
            WHERE Email = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Total") > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Inserts a new user account and returns the generated UserID.
     *
     * @param user user account data
     * @return generated UserID, or -1 if insert fails
     */
    public int insertUser(User user) {
        String sql = """
            INSERT INTO Users (
                Email,
                PasswordHash,
                DisplayName,
                Phone,
                Status,
                MustChangePassword,
                CreatedBy,
                CreatedDate,
                IsDeleted
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getDisplayName());
            ps.setString(4, user.getPhone());

            String status = user.getStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }

            ps.setString(5, status);
            ps.setBoolean(6, user.isMustChangePassword());
            ps.setString(7, user.getCreatedBy());

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                return -1;
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
}
