package com.wegarden.web.services.impl;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Image;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReport;
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
    public String saveProductAmt(String proUuid, Integer quantity, Double proPrice) {
        return stockRepository.saveProductAmt(proUuid, quantity, proPrice);
    }
    @Override
    public String saveRefrigeratorAmt(String proUuid, Integer quantity) {
        return stockRepository.saveRefrigeratorAmt(proUuid, quantity);
    }

    @Override
    public List<Stock> getStockList(String srch_wd, String status, String pro_uuid) {
        return stockRepository.getStockList(srch_wd,status,pro_uuid);
    }

    @Override
    public List<StockReport> getReportStockList(String sDate, String eDate) {
        return stockRepository.getReportStockList(sDate,eDate);
    }
}
