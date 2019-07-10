package com.wegarden.web.repositories.impl;


import com.wegarden.web.model.user.ReadTeam;
import com.wegarden.web.model.user.Team;
import com.wegarden.web.model.user.User;
import com.wegarden.web.repositories.UsersRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UsersRepositoryImpl implements UsersRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<User> getUsersList(String userUuid, String teamUuid, String srch_wd, int page, int limit) {
        List<User> userList = new ArrayList<>();
        String paramkey       = "";
        String paramValue     = "";
        String paramProcedure = "";

        if(StringUtils.isNotEmpty(teamUuid)){
            paramkey       = "_team_uuid";
            paramValue     = teamUuid;
            paramProcedure = "\"user\".fn_read_users_by_team";
        }else{
            paramkey       = "_user_uuid";
            paramValue     = userUuid;
            paramProcedure = "\"user\".fn_read_users";
        }

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery(paramProcedure, User.class )
                .registerStoredProcedureParameter("_en_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter(paramkey, String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_page", Integer.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_limit", Integer.class, ParameterMode.IN)
                .setParameter("_en_name", srch_wd)
                .setParameter(paramkey, paramValue)
                .setParameter("_status", "1")
                .setParameter("_page", page)
                .setParameter("_limit", limit);

        try{
            userList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error....proned");
            e.printStackTrace();
        }
        entityManager.clear();

        return userList;
    }

    @Override
    public int countUsers(String user_uuid, String teamUuid, String srch_wd, String status) {
        int countUsers = 0;

        if(srch_wd == "" || srch_wd == null || srch_wd.length() == 0){
            srch_wd = user_uuid;
        }

        StringBuilder sqlStrinng = new StringBuilder(
                " SELECT COUNT(*)\n" +
                " FROM \"user\".user u\n" +
                "   LEFT JOIN \"user\".team          ON u.team_id = team.id\n" +
                "   LEFT JOIN \"user\".department    ON team.department_id = department.id\n" +
                "  INNER JOIN \"user\".employment_status    ON u.employment_status = employment_status.id\n" +
                "  INNER JOIN \"user\".position p   ON u.position = p.id\n" +
                "WHERE u.status != (                                    \n" +
                "                  SELECT CASE                          \n" +
                "                      WHEN '"+status+"' = '0' THEN '1' \n" +
                "                      WHEN '"+status+"' = '1' THEN '0' \n" +
                "                      ELSE ''                          \n" +
                "                  END )                                \n" +
                "  AND (LOWER(u.en_name) LIKE '%' || LOWER('"+srch_wd+"') || '%' OR u.uuid LIKE '%' || '"+srch_wd+"' || '%') \n");


        if(StringUtils.isNotEmpty(teamUuid)){
            sqlStrinng.append("AND team.uuid = '"+teamUuid+"'");
        }

        Query storedProcedureQuery = entityManager.createNativeQuery(sqlStrinng.toString());

        countUsers = ((BigInteger) storedProcedureQuery.getSingleResult()).intValue();
        entityManager.clear();
        return countUsers;
    }

    @Override
    public String userUpdateBalance(String userUuid, String transactionType, Double transactionAmount) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_update_balance")
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_transaction_type", String .class, ParameterMode.IN)
                .registerStoredProcedureParameter("_transaction_amount", Double .class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_user_uuid", userUuid)
                .setParameter("_transaction_type", transactionType)
                .setParameter("_transaction_amount", transactionAmount);
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
    public String updateUserRole(String roleId, String userUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_update_user_role")
                .registerStoredProcedureParameter("_roles_id", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_user_uuid", String .class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)

                .setParameter("_roles_id", roleId)
                .setParameter("_user_uuid", userUuid);

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
    public List<ReadTeam> readTeam(String status) {
        List<ReadTeam> team = new ArrayList<>();
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_read_teams", ReadTeam.class )
                .registerStoredProcedureParameter("_status",String.class, ParameterMode.IN)
                .setParameter("_status", status);

        try{
            team = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error....proned");
            e.printStackTrace();
        }
        entityManager.clear();
        return team;
    }
    @Override
    public String updateUserTeam(String teamUuid,String userUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_update_user_team",ReadTeam.class)
                .registerStoredProcedureParameter("_team_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_user_uuid", String .class, ParameterMode.IN)

                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)

                .setParameter("_team_uuid",teamUuid)
                .setParameter("_user_uuid",userUuid);
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
    public Double getUserTotalCredit() {
        Double countUsers = 0.0;
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_report_total_remaining_credit")
                .registerStoredProcedureParameter("remaining_credit", Double.class, ParameterMode.OUT);
        try{
            countUsers = (Double) storedProcedureQuery.getOutputParameterValue("remaining_credit");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return countUsers;
    }
}
