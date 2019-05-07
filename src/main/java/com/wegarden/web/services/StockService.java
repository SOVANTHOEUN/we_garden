package com.wegarden.web.services;

import com.wegarden.web.model.stock.StockReport;
import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface StockService {
    List<Stock> getStockList(String srch_wd, String status, String pro_uuid);
    List<StockReport> getReportStockList(String sDate, String eDate);
    String saveProductAmt(String proUuid, Integer quantity, Double proPrice);
    String saveRefrigeratorAmt(String proUuid, Integer quantity);
}
