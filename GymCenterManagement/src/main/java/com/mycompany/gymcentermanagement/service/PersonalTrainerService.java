package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public interface PersonalTrainerService {
    PersonalTrainer getPersonalTrainerById(int id);
    boolean updateProfile(PersonalTrainer pt) throws SQLException;
    PersonalTrainer getPTByUserId(int userId);
}
