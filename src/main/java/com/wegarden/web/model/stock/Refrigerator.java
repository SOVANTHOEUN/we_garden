package com.wegarden.web.model.stock;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class Refrigerator {
    @Id

    @JsonProperty("product_uuid")
    public String productUuid;

    @JsonProperty("product_name")
    public String productName;

    @JsonProperty("product_price")
    public Double productPrice;

    @JsonProperty("product_image_name")
    public String productImageName;

    @JsonProperty("product_status")
    public String productStatus;

    @JsonProperty("categoryUuid")
    public String categoryUuid;

    @JsonProperty("category_name")
    public String categoryName;

    @JsonProperty("category_remark")
    public String categoryRemark;

    @JsonProperty("category_status")
    public String categoryStatus;

    @JsonProperty("stock_in_quantity")
    public Integer stockInQuantity;

    public Refrigerator(String productUuid, String productName, Double productPrice, String productImageName, String productStatus, String categoryUuid, String categoryName, String categoryRemark, String categoryStatus, Integer stockInQuantity) {
        this.productUuid = productUuid;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImageName = productImageName;
        this.productStatus = productStatus;
        this.categoryUuid = categoryUuid;
        this.categoryName = categoryName;
        this.categoryRemark = categoryRemark;
        this.categoryStatus = categoryStatus;
        this.stockInQuantity = stockInQuantity;
    }

    public Refrigerator() {

    }

    public String getProductUuid() {
        return productUuid;
    }

    public void setProductUuid(String productUuid) {
        this.productUuid = productUuid;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImageName() {
        return productImageName;
    }

    public void setProductImageName(String productImageName) {
        this.productImageName = productImageName;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public String getCategoryUuid() {
        return categoryUuid;
    }

    public void setCategoryUuid(String categoryUuid) {
        this.categoryUuid = categoryUuid;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryRemark() {
        return categoryRemark;
    }

    public void setCategoryRemark(String categoryRemark) {
        this.categoryRemark = categoryRemark;
    }

    public String getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(String categoryStatus) {
        this.categoryStatus = categoryStatus;
    }

    public Integer getStockInQuantity() {
        return stockInQuantity;
    }

    public void setStockInQuantity(Integer stockInQuantity) {
        this.stockInQuantity = stockInQuantity;
    }


    public Refrigerator(String productName, Double productPrice, Integer stockInQuantity) {
        this.productName = productName;
        this.productPrice = productPrice;
        this.stockInQuantity = stockInQuantity;
    }

    @Override
    public String toString() {
        return "Refrigerator{" +
                "productName='" + productName + '\'' +
                ", productPrice=" + productPrice +
                ", stockInQuantity=" + stockInQuantity +
                '}';
    }
}
