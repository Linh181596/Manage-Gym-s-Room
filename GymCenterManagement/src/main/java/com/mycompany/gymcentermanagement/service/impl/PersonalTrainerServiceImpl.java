package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import java.sql.SQLException;

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
}
