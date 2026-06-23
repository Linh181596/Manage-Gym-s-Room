package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import java.sql.SQLException;
import java.util.List;

public class PersonalTrainerServiceImpl implements PersonalTrainerService {
    private final PersonalTrainerDAO personalTrainerDAO = new PersonalTrainerDAOImpl();
    @Override
    public PersonalTrainer getPersonalTrainerById(int id) {
        return personalTrainerDAO.findById(id);
    }

    @Override
    public boolean updateProfile(PersonalTrainer pt) throws SQLException{
        PersonalTrainer oldData = personalTrainerDAO.findById(pt.getPtId());

        if(oldData == null){
            return false;
        }

        if(pt.getAvatarPath() == null || pt.getAvatarPath().trim().isEmpty()){
            pt.setAvatarPath(oldData.getAvatarPath());
        }

        return personalTrainerDAO.updateProfile(pt);
    }

    @Override
    public PersonalTrainer getPTByUserId(int userId) {
        return personalTrainerDAO.findPTByUserId(userId);
    }

    @Override
    public boolean updatePersonalTrainer(PersonalTrainer pt) {
        return personalTrainerDAO.updatePersonalTrainer(pt);
    }

    @Override
    public boolean createPersonalTrainer(PersonalTrainer pt) {
        return personalTrainerDAO.insertPersonalTrainer(pt);
    }

    @Override
    public List<PersonalTrainer> getActiveTrainers() {
        return personalTrainerDAO.findActiveTrainers();
    }

    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations) {
        return personalTrainerDAO.searchActiveTrainers(keyword, specializations);
    }
}
