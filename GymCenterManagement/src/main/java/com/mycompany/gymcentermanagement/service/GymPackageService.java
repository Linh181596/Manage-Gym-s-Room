/**
 * =========================================================================
 * @file          : GymPackageService.java
 * @description   : Interface dinh nghia cac dich vu nghiep vu quan ly goi tap gym
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import java.sql.SQLException;
import java.util.List;

public interface GymPackageService {
    List<GymPackage> getAllPackages() throws SQLException;
    List<GymPackage> getActivePackages() throws SQLException;
    GymPackage getPackageById(int id) throws SQLException;
    boolean createPackage(GymPackage pkg) throws SQLException;
    boolean updatePackage(GymPackage pkg) throws SQLException;
    boolean deletePackage(int id) throws SQLException;
    boolean isPackageNameExists(String name, int excludeId) throws SQLException;
    int getPackagesCount() throws SQLException;
    List<GymPackage> getPackagesPaginated(int offset, int limit) throws SQLException;
}
