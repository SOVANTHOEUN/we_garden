package com.wegarden.web.model.order;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class OrderDetail {

    @Id
    @JsonProperty("product_uuid")
    private String productUuid;

    @JsonProperty("product_name")
    private String productName;

    @JsonProperty("product_image_name")
    private String productImageName;

    @JsonProperty("product_status")
    private String productStatus;

    @JsonProperty("product_price")
    private Double productPrice;

    @JsonProperty("order_quantity")
    private Integer orderQuantity;

    public OrderDetail(){

    }

    public OrderDetail(String productUuid, String productName, String productImageName, String productStatus, Double productPrice, Integer orderQuantity) {
        this.productUuid = productUuid;
        this.productName = productName;
        this.productImageName = productImageName;
        this.productStatus = productStatus;
        this.productPrice = productPrice;
        this.orderQuantity = orderQuantity;
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

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(Integer orderQuantity) {
        this.orderQuantity = orderQuantity;
    }
}