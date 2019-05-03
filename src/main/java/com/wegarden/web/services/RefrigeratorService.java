package com.wegarden.web.services;

import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface RefrigeratorService {
    List<Stock> getRefrigeratorList(String srch_wd, String status, String pro_uuid);
}
