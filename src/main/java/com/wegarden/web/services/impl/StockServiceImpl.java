package com.wegarden.web.services.impl;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Image;
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
    public List<Stock> getStocksList(String srch_wd, String status, String pro_uuid) {
        return stockRepository.getStockList(srch_wd, status, pro_uuid);
    }

    @Override
    public List<Category> getCategoryList(String status) {
        return stockRepository.getCategoryList(status);
    }
    @Override
    public String saveProImg(String img_nm, String img_type) {
        return stockRepository.saveProImg(img_nm, img_type);
    }

    @Override
    public String saveProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid) {
        return stockRepository.saveProductData(pro_nm, pro_price, cate_uuid, img_uuid);
    }

    @Override
    public String updateProductData(String pro_nm, Double pro_price, String cate_uuid, String img_uuid, String pro_uuid) {
        return stockRepository.updateProductData(pro_nm, pro_price, cate_uuid, img_uuid, pro_uuid);
    }

    @Override
    public String saveProductAmt(String proUuid, Integer quantity) {
        return stockRepository.saveProductAmt(proUuid, quantity);
    }
    @Override
    public String saveRefrigeratorAmt(String proUuid, Integer quantity) {
        return stockRepository.saveRefrigeratorAmt(proUuid, quantity);
    }

    @Override
    public String deleteProduct(String proUuid) {
        return stockRepository.deleteProduct(proUuid);
    }
}
