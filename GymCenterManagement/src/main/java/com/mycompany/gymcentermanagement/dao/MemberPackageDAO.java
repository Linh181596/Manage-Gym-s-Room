/**
 * =========================================================================
 * @file          : MemberPackageDAO.java
 * @description   : Interface định nghĩa các thao tác dữ liệu với thực thể MemberPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import java.sql.SQLException;
import java.util.List;

public interface MemberPackageDAO {
    MemberPackage findById(int memberPackageId) throws SQLException;
    MemberPackage findActiveByMemberId(int memberId) throws SQLException;
    List<MemberPackage> findAllActiveByMemberId(int memberId) throws SQLException;
    boolean insert(MemberPackage mp) throws SQLException;
    boolean update(MemberPackage mp) throws SQLException;
    boolean delete(int memberPackageId) throws SQLException;
}
