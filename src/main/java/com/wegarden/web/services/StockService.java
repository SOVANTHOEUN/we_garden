package com.wegarden.web.services;

import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface StockService {
    List<Stock> getStocksList(String srch_wd,String status);
}
