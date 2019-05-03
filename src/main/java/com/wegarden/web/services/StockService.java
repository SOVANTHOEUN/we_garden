package com.wegarden.web.services;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Image;
import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface StockService {
    List<Stock> getStockList(String srch_wd, String status, String pro_uuid);
    String saveProductAmt(String proUuid, Integer quantity);
    String saveRefrigeratorAmt(String proUuid, Integer quantity);
}
