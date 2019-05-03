package com.wegarden.web.services.impl;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.repositories.ProductRepository;
import com.wegarden.web.repositories.StockRepository;
import com.wegarden.web.services.ProductService;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<Stock> getProductList(String srch_wd, String status, String pro_uuid) {
        return productRepository.getProductList(srch_wd, status, pro_uuid);
    }

    @Override
    public List<Category> getCategoryList(String status) {
        return productRepository.getCategoryList(status);
    }
    @Override
    public String saveProImg(String img_nm, String img_type) {
        return productRepository.saveProImg(img_nm, img_type);
    }

    @Override
    public String saveProductData(String pro_nm, Double pro_price, Integer proQtyBox, String cate_uuid, String img_uuid) {
        return productRepository.saveProductData(pro_nm, pro_price, proQtyBox, cate_uuid, img_uuid);
    }

    @Override
    public String updateProductData(String pro_nm, Double pro_price, Integer proQtyBox, String cate_uuid, String img_uuid, String pro_uuid) {
        return productRepository.updateProductData(pro_nm, pro_price, proQtyBox, cate_uuid, img_uuid, pro_uuid);
    }

    @Override
    public String deleteProduct(String proUuid) {
        return productRepository.deleteProduct(proUuid);
    }
}
