package com.wegarden.web.repositories;

import com.wegarden.web.model.stock.*;

import java.util.List;

public interface StockRepository {
    List<Stock> getStockList(String srch_wd, String status, String pro_uuid);
    List<StockReport> getReportStockInList(String sDate, String eDate);
    List<StockReportOut> getReportStockOutList(String sDate, String eDate);
    List<Category> getCategoryList(String status);
    String saveProImg(String img_nm, String img_type);
    String saveProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid);
    String updateProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid, String pro_uuid);
    String saveProductAmt(String proUuid, Double quantity, Double proPrice);
    String saveRefrigeratorAmt(String proUuid, Integer quantity);
    String deleteProduct(String proUuid);
}
