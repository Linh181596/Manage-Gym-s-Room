/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import dao.PersonalTrainerDAO;
import java.util.List;
import model.PersonalTrainer;

/**
 *
 * @author phuga
 */
public class PersonalTrainerDAOTest {
     public static void main(String[] args) {
        PersonalTrainerDAO dao = new PersonalTrainerDAO();

        List<PersonalTrainer> trainers = dao.findActiveTrainers();

        System.out.println("Size = " + trainers.size());

        for (PersonalTrainer trainer : trainers) {
            System.out.println(trainer.getPtId() + " - " + trainer.getDisplayName());
        }
    }
}
