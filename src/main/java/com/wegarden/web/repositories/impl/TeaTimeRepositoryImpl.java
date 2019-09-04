package com.wegarden.web.repositories.impl;


import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.model.order.TeaTimeUserListByTeam;
import com.wegarden.web.repositories.TeaTimeRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TeaTimeRepositoryImpl implements TeaTimeRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year) {
        List<TeaTimeUsage> teaTimeUsages = new ArrayList<>();
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_report_tea_time_team_usage", TeaTimeUsage.class )
                .registerStoredProcedureParameter("_month",String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_year",String.class, ParameterMode.IN)
                .setParameter("_month", month)
                .setParameter("_year", year);

        try{
            teaTimeUsages = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error....proned");
            e.printStackTrace();
        }
        entityManager.clear();
        return teaTimeUsages;
    }

    @Override
    public String saveTeamTeaTime(String teamName){
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_create_team_tea_time")
                .registerStoredProcedureParameter("_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_name", teamName);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return actionCode;
    }

    @Override
    public List<TeaTimeUserListByTeam> getTeamTeaTimeList(String teamUuid) {
        List<TeaTimeUserListByTeam> teaTimeUserListByTeams = new ArrayList<>();
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_read_users_by_tea_time_team", TeaTimeUserListByTeam.class )
                .registerStoredProcedureParameter("_en_name",String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_team_uuid",String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_status",String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_page",Integer.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_limit",Integer.class, ParameterMode.IN)
                .setParameter("_en_name", "")
                .setParameter("_team_uuid", teamUuid)
                .setParameter("_status", "")
                .setParameter("_page", 1)
                .setParameter("_limit", 1000);

        try{
            teaTimeUserListByTeams = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error....proned");
            e.printStackTrace();
        }
        entityManager.clear();
        return teaTimeUserListByTeams;
    }

    @Override
    public String saveTeamMember(String teamUuid, String userUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_add_member_to_tea_time_team")
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_tea_time_team_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_user_uuid", userUuid)
                .setParameter("_tea_time_team_uuid", teamUuid);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        System.out.println("actionCode:: "+actionCode);
        return actionCode;
    }

    @Override
    public String removeTeamMember(String teamUuid, String userUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_remove_member_from_tea_time_team")
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_tea_time_team_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_user_uuid", userUuid)
                .setParameter("_tea_time_team_uuid", teamUuid);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return actionCode;
    }

    @Override
    public String removeTeamTeaTime(String teamUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_disable_team_tea_time")
                .registerStoredProcedureParameter("_team_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_team_uuid", teamUuid);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        System.out.println("actionCode:: "+actionCode);
        return actionCode;
    }

    @Override
    public String updateTeaTimeLeader(String teamUuid, String userUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_update_tea_time_leader")
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_tea_time_team_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_user_uuid", userUuid)
                .setParameter("_tea_time_team_uuid", teamUuid);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        System.out.println("actionCode:: "+actionCode);
        return actionCode;
    }
}
