package com.wegarden.web.services;

import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface RefrigeratorService {
    List<Refrigerator> getRefrigeratorList(String srch_wd, String status, String pro_uuid);
    String saveQty(String proUuid, Integer quantity);
    //List<Refrigerator> getReportRefrigerator(String sDate, String eDate);
}
