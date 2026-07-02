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
    boolean updatePTStatus(int ptId, String status);
    boolean updatePersonalTrainer(PersonalTrainer pt);
    boolean createPersonalTrainer(PersonalTrainer pt);
    List<PersonalTrainer> getActiveTrainers();
    List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations);
    List<PersonalTrainer> searchTrainersForManagement(String keyword, List<String> specializations, String status);
    List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPT(int ptId);
    int getActiveMembersForPTCount(int ptId);
    List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPTPaginated(int ptId, int offset, int limit);
}
