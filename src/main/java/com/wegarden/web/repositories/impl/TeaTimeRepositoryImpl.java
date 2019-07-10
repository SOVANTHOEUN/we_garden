package com.wegarden.web.repositories.impl;


import com.wegarden.web.model.order.TeaTimeUsage;
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
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_report_tea_time_usage", TeaTimeUsage.class )
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

}
