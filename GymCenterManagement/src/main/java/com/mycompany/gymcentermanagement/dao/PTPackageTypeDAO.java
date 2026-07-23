package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import java.sql.SQLException;
import java.util.List;

public interface PTPackageTypeDAO {
    List<PTPackageType> findAllActive() throws SQLException;
    List<PTPackageType> findAll() throws SQLException;
    List<PTPackageType> findByStatus(String status) throws SQLException;
    PTPackageType findById(int ptPackageTypeId) throws SQLException;
    PTPackageType findByName(String packageName) throws SQLException;
    boolean insert(PTPackageType pkg) throws SQLException;
    boolean update(PTPackageType pkg) throws SQLException;
    boolean delete(int ptPackageTypeId) throws SQLException;
}
