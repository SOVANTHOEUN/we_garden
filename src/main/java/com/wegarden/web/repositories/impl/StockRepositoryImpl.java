package com.wegarden.web.repositories.impl;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Image;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReport;
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
    public List<Stock> getStockList(String srch_wd, String status, String pro_uuid) {
        List<Stock> stockList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_read_products_in_stock_and_refrigerator", Stock.class)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_srch_wd", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .setParameter("_status", status)
                .setParameter("_product_uuid", pro_uuid)
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

    @Override
    public List<Category> getCategoryList(String status) {
        List<Category> categoryList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_read_categories", Category.class)
                .registerStoredProcedureParameter("_status", String.class, ParameterMode.IN)
                .setParameter("_status", status);

        try{
            categoryList = storedProcedureQuery.getResultList();
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return categoryList;
    }

    @Override
    public List<StockReport> getReportStockList(String sDate, String eDate) {
        List<StockReport> stockReportList = new ArrayList<>();

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_report_stock_in_by_date", StockReport.class)
                .registerStoredProcedureParameter("_from_date", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_to_date", String.class, ParameterMode.IN)
                .setParameter("_from_date", sDate)
                .setParameter("_to_date", eDate);

        try{
            stockReportList = storedProcedureQuery.getResultList();
        }catch (Exception e){

            System.out.println("Error.....proned.");
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();
        return stockReportList
                ;
    }

    @Override
    public String saveProImg(String img_nm, String img_type) {
        String imageUuid = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_create_image")
                .registerStoredProcedureParameter("_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_type", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .registerStoredProcedureParameter("image_uuid", String.class, ParameterMode.OUT)
                .setParameter("_name", img_nm)
                .setParameter("_type", img_type);

        try{
            imageUuid = (String) storedProcedureQuery.getOutputParameterValue("image_uuid");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return imageUuid;
    }

    @Override
    public String saveProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid) {
        String actionCode = "";
        /*Double dd = new Double();
        String ss = new String();*/
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_create_product")
                .registerStoredProcedureParameter("_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_price", Double .class, ParameterMode.IN)
                .registerStoredProcedureParameter("_category_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_image_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_name", pro_nm)
                .setParameter("_price", pro_price)
                .setParameter("_image_uuid", img_uuid)
                .setParameter("_category_uuid", cate_uuid);
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
    public String updateProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid, String pro_uuid) {
        String actionCode = "";
        /*Double dd = new Double();
        String ss = new String();*/
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_update_product")
                .registerStoredProcedureParameter("_name", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_price", Double .class, ParameterMode.IN)
                .registerStoredProcedureParameter("_image_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_category_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_name", pro_nm)
                .setParameter("_price", pro_price)
                .setParameter("_image_uuid", img_uuid)
                .setParameter("_category_uuid", cate_uuid)
                .setParameter("_product_uuid", pro_uuid);

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
    public String saveProductAmt(String proUuid, Integer quantity) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_add_to_stock")
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("_stock_in_qty", Integer .class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_product_uuid", proUuid)
                .setParameter("_stock_in_qty", quantity);
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
    public String saveRefrigeratorAmt(String proUuid, Integer quantity) {
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
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return actionCode;
    }

    @Override
    public String deleteProduct(String proUuid) {
        String actionCode = "";

        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("\"stock\".fn_disable_product")
                .registerStoredProcedureParameter("_product_uuid", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("action_code", String.class, ParameterMode.OUT)
                .setParameter("_product_uuid", proUuid);

        try{
            actionCode = (String) storedProcedureQuery.getOutputParameterValue("action_code");
        }catch (Exception e){
            System.out.println("Error.....proned.");
            e.printStackTrace();
        }
        entityManager.clear();

        return actionCode;
    }

}
