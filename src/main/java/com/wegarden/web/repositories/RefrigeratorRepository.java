package com.wegarden.web.repositories;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Stock;

import java.util.List;

public interface RefrigeratorRepository {
    List<Stock> getRefrigeratorList(String srch_wd, String status, String pro_uuid);
}
