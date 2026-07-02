/**
 * =========================================================================
 * @file          : GymPackageDAO.java
 * @description   : Interface định nghĩa các thao tác dữ liệu với thực thể GymPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import java.sql.SQLException;
import java.util.List;

/**
 * Interface defining database operations for GymPackages.
 */
public interface GymPackageDAO {
    List<GymPackage> findAllActive() throws SQLException;
    List<GymPackage> findAll() throws SQLException;
    GymPackage findById(int packageId) throws SQLException;
    GymPackage findByName(String packageName) throws SQLException;
    boolean insert(GymPackage pkg) throws SQLException;
    boolean update(GymPackage pkg) throws SQLException;
    boolean delete(int packageId) throws SQLException;
    int countAll() throws SQLException;
    List<GymPackage> findAllPaginated(int offset, int limit) throws SQLException;
}
