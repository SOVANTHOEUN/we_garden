package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.repositories.RefrigeratorRepository;
import com.wegarden.web.repositories.StockRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.util.ArrayList;
import java.util.List;

@Repository
public class RefrigeratorRepositoryImpl implements RefrigeratorRepository {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Refrigerator> getRefrigeratorList(String srch_wd, String status, String pro_uuid) {

        List<Refrigerator> refrigeratorList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_read_products_in_stock_and_refrigerator", Stock.class)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_srch_wd", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .setParameter("_status", status)
                .setParameter("_product_uuid", pro_uuid)
                .setParameter("_srch_wd", srch_wd);

        try{
            refrigeratorList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....refrigeratorList.");
            e.printStackTrace();
        }
        entityManager.clear();
        return refrigeratorList;
    }

    @Override
    public String saveQty(String proUuid, Integer quantity) {
        String actionCode = "";
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_add_to_refrigerator")
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_stock_in_qty", Integer .class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_product_uuid", proUuid)
                .setParameter("_stock_in_qty", quantity);
        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");

        }catch (Exception e){
            System.out.println("Error.....saveQty.");
            e.printStackTrace();
        }
        entityManager.clear();
        return actionCode;
    }

    @Override
    public List<Refrigerator> getReportRefrigerator(String sDate, String eDate) {
        List<Refrigerator> RefrigeratorList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_report_refrigerator_in_by_date",Refrigerator.class)
                .registerStoredProcedureParameter("_from_date", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_to_date", String.class, ParameterMode.IN)
                .setParameter("_from_date", sDate)
                .setParameter("_to_date", eDate);

        try{
            RefrigeratorList = storedProcedureQuery.getResultList();
        }catch (Exception e){

            System.out.println("Error.....Refrigerator.");
            System.out.println("Error.....sDate::: "+sDate);
            System.out.println("Error.....eDate::: "+eDate);
            e.printStackTrace();
        }
        entityManager.clear();
        return RefrigeratorList
                ;
    }

}
