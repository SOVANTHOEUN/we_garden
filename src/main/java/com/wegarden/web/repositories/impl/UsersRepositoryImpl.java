package com.wegarden.web.repositories.impl;


import com.wegarden.web.model.user.User;
import com.wegarden.web.repositories.UsersRepository;
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
    public List<User> getUsersList(int limit, int page, String srch_wd, String userUuid) {
        List<User> userList = new ArrayList<>();
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_read_users", User.class )
                .registerStoredProcedureParameter("_en_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_page", Integer.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_limit", Integer.class, ParameterMode.IN)
                .setParameter("_en_name", srch_wd)
                .setParameter("_user_uuid", userUuid)
                .setParameter("_status", "")
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
    public int countUsers(String user_uuid, String srch_wd, String _status) {
        int countUsers = 0;
        String name;
        Query storedProcedureQuery = entityManager.createNativeQuery("SELECT COUNT(*)\n" +
                "FROM \"user\".user u\n" +
                "  LEFT JOIN \"user\".team\n" +
                "    ON u.team_id = team.id\n" +
                "  LEFT JOIN \"user\".department\n" +
                "    ON team.department_id = department.id\n" +
                "  INNER JOIN \"user\".employment_status\n" +
                "    ON u.employment_status = employment_status.id\n" +
                "  INNER JOIN \"user\".position p\n" +
                "    ON u.position = p.id\n" +
                "  WHERE u.status != (\n" +
                "    SELECT CASE\n" +
                "       WHEN '"+_status+"' = '0' THEN '1'\n" +
                "       WHEN '"+_status+"' = '1' THEN '0'\n" +
                "  ELSE ''\n" +
                "    END\n" +
                "  )" +
                "AND LOWER(u.en_name) LIKE '%' || LOWER('"+srch_wd+"') || '%'\n");
//                "  AND \"user\".team = '"+srch_wd+"'");

        countUsers = ((BigInteger) storedProcedureQuery.getSingleResult()).intValue();
        entityManager.clear();
        return countUsers;
    }


}
