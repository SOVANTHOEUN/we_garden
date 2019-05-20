package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.model.stock.StockReportOut;
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
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return userOrderList;
    }

    @Override
    public List<OrderDetail> getOrderDetailList(String orderUuid) {
        List<OrderDetail> orderDetailsList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_read_order_detail", OrderDetail.class)
                .registerStoredProcedureParameter("_order_uuid", String.class, ParameterMode.IN)
                .setParameter("_order_uuid", orderUuid);
        try{
            orderDetailsList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return orderDetailsList;
    }

    @Override
    public String payOrderItem(String orderUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"order\".fn_return_debt_money")
                .registerStoredProcedureParameter("_order_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_order_uuid", orderUuid);

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
    public List<StockReportOut> getReportStockOutList(String sDate, String eDate) {
        List<StockReportOut> stockReportList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_report_order_by_date", StockReportOut.class)
                .registerStoredProcedureParameter("_from_date", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_to_date", String.class, ParameterMode.IN)
                .setParameter("_from_date", sDate)
                .setParameter("_to_date", eDate);

        try{
            stockReportList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return stockReportList;
    }
}