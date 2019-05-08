package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.repositories.OrderRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.util.ArrayList;
import java.util.List;

@Repository
public class OrderRepositoryImpl implements OrderRepository {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Order> getOrderList() {
        List<Order> orderReportList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"user\".fn_report_user_in_debt", Order.class);

        try{
            orderReportList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return orderReportList;
    }

    @Override
    public List<UserOrder> getUserOrderList(String userUuid) {
        List<UserOrder> userOrderList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_report_debt_order_by_user", UserOrder.class)
                .registerStoredProcedureParameter("_user_uuid", String.class, ParameterMode.IN)
                .setParameter("_user_uuid", userUuid);
        try{
            userOrderList = storedProcedureQuery.getResultList();
            System.out.println("USER_UUID:: " +userUuid);
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return userOrderList;
    }
}