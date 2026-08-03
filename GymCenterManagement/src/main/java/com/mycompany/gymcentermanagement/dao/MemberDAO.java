/**
 * =========================================================================
 * @file          : MemberDAO.java
 * @description   : Interface định nghĩa các thao tác dữ liệu với thực thể Member
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.Member;
import java.sql.SQLException;
import java.util.List;

public interface MemberDAO {
    /**
     * Lấy hội viên theo MemberID.
     */
    Member findById(int memberId) throws SQLException;

    /**
     * Lấy hội viên theo UserID.
     */
    Member findByUserId(int userId) throws SQLException;

    /**
     * Lấy danh sách hội viên chưa bị xóa.
     */
    List<Member> findAllActive() throws SQLException;
}
