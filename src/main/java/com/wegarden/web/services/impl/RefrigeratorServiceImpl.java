package com.wegarden.web.services.impl;

import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.repositories.RefrigeratorRepository;
import com.wegarden.web.repositories.StockRepository;
import com.wegarden.web.services.RefrigeratorService;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RefrigeratorServiceImpl implements RefrigeratorService {

    @Autowired
    private RefrigeratorRepository refrigeratorRepository;

    @Override
    public List<Stock> getRefrigeratorList(String srch_wd, String status, String pro_uuid) {
        return refrigeratorRepository.getRefrigeratorList(srch_wd, status, pro_uuid);
    }
}
