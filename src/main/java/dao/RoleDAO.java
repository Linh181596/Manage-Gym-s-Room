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
public class RoleDAO extends DBContext {

    /**
     * Finds a role ID by role name.
     *
     * @param roleName role name, such as PT, Staff, Admin, or Member
     * @return RoleID if found, otherwise -1
     */
    public int findRoleIdByName(String roleName) {
        String sql = """
            SELECT RoleID
            FROM Roles
            WHERE RoleName = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roleName);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("RoleID");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
}
