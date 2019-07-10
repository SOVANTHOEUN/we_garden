package com.wegarden.web.repositories.impl;


import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.model.user.BronzeMasterUsage;
import com.wegarden.web.repositories.BronzeMasterRepository;
import com.wegarden.web.repositories.TeaTimeRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BronzeMasterRepositoryImpl implements BronzeMasterRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<BronzeMasterUsage> getListReportBronzeMasterUsage(String sDate) {
        List<BronzeMasterUsage> bronzeMasterUsages = new ArrayList<>();
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_report_bronze_master_usage", BronzeMasterUsage.class )
                .registerStoredProcedureParameter("_date",String.class, ParameterMode.IN)
                .setParameter("_date", sDate);

        try{
            bronzeMasterUsages = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error....proned");
            e.printStackTrace();
        }
        entityManager.clear();
        return bronzeMasterUsages;
    }

}
