/**
 * =========================================================================
 * @file          : MemberDAOImpl.java
 * @description   : Lớp triển khai các thao tác cơ sở dữ liệu với thực thể Member
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MemberDAOImpl extends BaseDAO implements MemberDAO {

    public MemberDAOImpl() {
        super();
    }

    public MemberDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    private Member mapResultSetToMember(ResultSet rs) throws SQLException {
        Member m = new Member();
        m.setMemberId(rs.getInt("MemberID"));
        m.setUserId(rs.getInt("UserID"));
        m.setGender(rs.getString("Gender"));
        
        Date dob = rs.getDate("DateOfBirth");
        if (dob != null) {
            m.setDateOfBirth(dob.toLocalDate());
        }
        
        m.setCreatedBy(rs.getString("CreatedBy"));
        Timestamp createdTs = rs.getTimestamp("CreatedDate");
        if (createdTs != null) {
            m.setCreatedDate(createdTs.toLocalDateTime());
        }
        
        m.setUpdatedBy(rs.getString("UpdatedBy"));
        Timestamp updatedTs = rs.getTimestamp("UpdatedDate");
        if (updatedTs != null) {
            m.setUpdatedDate(updatedTs.toLocalDateTime());
        }
        
        m.setDeleted(rs.getBoolean("IsDeleted"));
        
        // Map related user info if it exists in the result set
        try {
            User u = new User();
            u.setUserId(rs.getInt("UserID"));
            u.setEmail(rs.getString("Email"));
            u.setFullName(rs.getString("DisplayName"));
            u.setPhoneNumber(rs.getString("Phone"));
            m.setUserDetails(u);
        } catch (SQLException ex) {
            // Joined columns might not be present in basic query, ignore
        }
        
        return m;
    }

    @Override
    public Member findById(int memberId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Member m = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT m.*, u.Email, u.DisplayName, u.Phone FROM Members m " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE m.MemberID = ? AND m.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                m = mapResultSetToMember(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return m;
    }

    @Override
    public Member findByUserId(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Member m = null;
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT m.*, u.Email, u.DisplayName, u.Phone FROM Members m " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE m.UserID = ? AND m.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                m = mapResultSetToMember(rs);
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return m;
    }

    @Override
    public List<Member> findAllActive() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Member> list = new ArrayList<>();
        
        try {
            conn = getActiveConnection();
            String sql = "SELECT m.*, u.Email, u.DisplayName, u.Phone FROM Members m " +
                         "INNER JOIN Users u ON m.UserID = u.UserID " +
                         "WHERE m.IsDeleted = 0 AND u.IsDeleted = 0";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMember(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return list;
    }
}
