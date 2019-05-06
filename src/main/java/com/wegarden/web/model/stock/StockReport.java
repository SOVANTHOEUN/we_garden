package com.wegarden.web.model.stock;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.annotation.Id;

import javax.persistence.Entity;

@Entity
public class Report {
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
    private String categoryRemark;

    @JsonProperty("category_status")
    private String categoryStatus;

    @JsonProperty("stock_in_quantity")
    private String stockInQuantity;

    public Report(String productUuid, String productName, String productPrice, String productImageName, String productStatus, String categoryUuid, String categoryName, String categoryRemark, String categoryStatus, String stockInQuantity) {
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

    public String getStockInQuantity() {
        return stockInQuantity;
    }

    public void setStockInQuantity(String stockInQuantity) {
        this.stockInQuantity = stockInQuantity;
    }
}
