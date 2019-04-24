package com.wegarden.web.services.impl;

import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.repositories.StockRepository;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockServiceImpl implements StockService {

    @Autowired
    private StockRepository stockRepository;

    @Override
    public List<Stock> getStocksList(String srch_wd, String status) {
        return stockRepository.getStockList(srch_wd, status);
    }

}
