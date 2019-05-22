package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.repositories.IndexRepository;
import com.wegarden.web.repositories.OrderRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.util.ArrayList;
import java.util.List;

@Repository
public class IndexRepositoryImpl implements IndexRepository {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Integer countOrder(String type) {
        Integer countOrder = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_count_order")
                .registerStoredProcedureParameter("_type", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("order_count", Integer.class, ParameterMode.OUT)
                .setParameter("_type", type);

        try{
            countOrder = (Integer) storedProcedureQuery.getOutputParameterValue("order_count");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countOrder;
    }

    @Override
    public Integer countEmployee(String type) {
        Integer countEmployee = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_count_employee")
                .registerStoredProcedureParameter("_type", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("employee_count", Integer.class, ParameterMode.OUT)
                .setParameter("_type", type);

        try{
            countEmployee = (Integer) storedProcedureQuery.getOutputParameterValue("employee_count");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countEmployee;
    }

    @Override
    public Integer countStock() {
        Integer countStock = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_count_stock")
                .registerStoredProcedureParameter("stock_count", Integer.class, ParameterMode.OUT);

        try{
            countStock = (Integer) storedProcedureQuery.getOutputParameterValue("stock_count");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countStock;
    }

    @Override
    public Integer countRefrigerator() {
        Integer countRefrigerator = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_count_refrigerator")
                .registerStoredProcedureParameter("refrigerator_count", Integer.class, ParameterMode.OUT);

        try{
            countRefrigerator = (Integer) storedProcedureQuery.getOutputParameterValue("refrigerator_count");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countRefrigerator;
    }

    @Override
    public Integer countTeaTimeOrder() {
        Integer countTeaTime = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_count_tea_time_order")
                .registerStoredProcedureParameter("total_order", Integer.class, ParameterMode.OUT);
        try{
            countTeaTime = (Integer) storedProcedureQuery.getOutputParameterValue("total_order");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countTeaTime;
    }

    @Override
    public Integer countBronzeMasterOrder() {
        Integer countBrozneMaster = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_count_bronze_master_order")
                .registerStoredProcedureParameter("total_order", Integer.class, ParameterMode.OUT);
        try{
            countBrozneMaster = (Integer) storedProcedureQuery.getOutputParameterValue("total_order");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countBrozneMaster;
    }

    @Override
    public Integer countTotalIncome() {
        Integer countTotalIncome = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_report_total_income")
                .registerStoredProcedureParameter("total_expend", Integer.class, ParameterMode.OUT);
        try{
            countTotalIncome = (Integer) storedProcedureQuery.getOutputParameterValue("total_expend");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countTotalIncome;
    }

    @Override
    public Integer countTotalExpend() {
        Integer countTotalExpend = 0;

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_sum_total_expend")
                .registerStoredProcedureParameter("total_expend", Integer.class, ParameterMode.OUT);
        try{
            countTotalExpend = (Integer) storedProcedureQuery.getOutputParameterValue("total_expend");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return countTotalExpend;
    }


}