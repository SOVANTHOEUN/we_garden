package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.repositories.StockRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
import java.util.ArrayList;
import java.util.List;

@Repository
public class StockRepositoryImpl implements StockRepository {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Stock> getStockList(String srch_wd, String status) {
        List<Stock> stockList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_read_products_in_stock_and_refrigerator", Stock.class)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_srch_wd", String.class, ParameterMode.IN)
                .setParameter("_status", status)
                .setParameter("_srch_wd", srch_wd);

        try{
            stockList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
            System.out.println("hiiiii; "+ srch_wd);
        }
        entityManager.clear();
        return stockList;
    }

}
