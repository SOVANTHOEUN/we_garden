package com.wegarden.web.repositories;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Image;
import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface StockRepository {
    List<Stock> getStockList(String srch_wd, String status, String pro_uuid);
    List<Category> getCategoryList(String status);
    String saveProImg(String img_nm, String img_type);
    String saveProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid);
    String updateProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid, String pro_uuid);
    String saveProductAmt(String proUuid, Integer quantity);
    String saveRefrigeratorAmt(String proUuid, Integer quantity);
    String deleteProduct(String proUuid);
}
