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
}
