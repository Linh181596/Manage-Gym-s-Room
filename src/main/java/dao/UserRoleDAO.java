/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author phuga
 */
/*
assignRoleToUser(): thêm UserID và RoleID vào bảng UserRoles.
 */
public class UserRoleDAO extends DBContext {

    /**
     * Assigns a role to a user account.
     *
     * @param userId user ID
     * @param roleId role ID
     * @return true if insert succeeds, otherwise false
     */
    public boolean assignRoleToUser(int userId, int roleId) {
        String sql = """
            INSERT INTO UserRoles (
                UserID,
                RoleID
            )
            VALUES (?, ?)
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, roleId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
