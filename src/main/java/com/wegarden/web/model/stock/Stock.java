package com.wegarden.web.model.stock;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class Stock {
    @Id
    @JsonProperty("product_uuid")
    private String productUuid;

    @JsonProperty("product_name")
    private String productName;

    @JsonProperty("product_price")
    private String productPrice;

    @JsonProperty("product_image_name")
    private String productImageName;

    @JsonProperty("product_status")
    private String productStatus;

    @JsonProperty("category_uuid")
    private String categoryUuid;

    @JsonProperty("category_name")
    private String categoryName;

    @JsonProperty("category_remark")
    private String categoryStatus;

    @JsonProperty("stock_quantity")
    private String stockQuantity;

    @JsonProperty("refrigerator_quantity")
    private String refrigeratorQuantity;

    public Stock(){

    }

    public Stock(String productUuid, String productName, String productPrice, String imagePath, String productStatus, String categoryUuid, String categoryName, String categoryStatus) {
        this.productUuid = productUuid;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImageName = productImageName;
        this.productStatus = productStatus;
        this.categoryUuid = categoryUuid;
        this.categoryName = categoryName;
        this.categoryStatus = categoryStatus;
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

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
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

    public String getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(String categoryStatus) {
        this.categoryStatus = categoryStatus;
    }

    public String getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(String stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getRefrigeratorQuantity() {
        return refrigeratorQuantity;
    }

    public void setRefrigeratorQuantity(String refrigeratorQuantity) {
        this.refrigeratorQuantity = refrigeratorQuantity;
    }
}
