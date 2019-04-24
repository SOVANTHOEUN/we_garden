package com.wegarden.web.repositories;

import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface StockRepository {
    List<Stock> getStockList(String srch_wd, String status);
}
