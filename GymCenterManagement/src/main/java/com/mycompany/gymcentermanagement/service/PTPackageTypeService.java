package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import java.sql.SQLException;
import java.util.List;

public interface PTPackageTypeService {
    List<PTPackageType> getAllPackages() throws SQLException;
    List<PTPackageType> getActivePackages() throws SQLException;
    List<PTPackageType> getPackagesByStatus(String status) throws SQLException;
    PTPackageType getPackageById(int id) throws SQLException;
    boolean createPackage(PTPackageType pkg) throws SQLException;
    boolean updatePackage(PTPackageType pkg) throws SQLException;
    boolean deletePackage(int id) throws SQLException;
    boolean isPackageNameExists(String name, int excludeId) throws SQLException;
}
