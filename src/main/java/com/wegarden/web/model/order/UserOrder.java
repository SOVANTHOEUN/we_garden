package com.wegarden.web.model.order;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class UserOrder {

    @Id
    @JsonProperty("order_date")
    private String orderDate;

    @JsonProperty("order_subtotal")
    private String orderSubtotal;

    @JsonProperty("order_total")
    private String orderTotal;

    @JsonProperty("product_count")
    private String productCount;

    @JsonProperty("order_remark")
    private String orderRemark;

    @JsonProperty("order_uuid")
    private String orderUuid;

    public UserOrder(){

    }

    public UserOrder(String orderDate, String orderSubtotal, String orderTotal, String productCount, String orderRemark, String orderUuid) {
        this.orderDate = orderDate;
        this.orderSubtotal = orderSubtotal;
        this.orderTotal = orderTotal;
        this.productCount = productCount;
        this.orderRemark = orderRemark;
        this.orderUuid = orderUuid;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderSubtotal() {
        return orderSubtotal;
    }

    public void setOrderSubtotal(String orderSubtotal) {
        this.orderSubtotal = orderSubtotal;
    }

    public String getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(String orderTotal) {
        this.orderTotal = orderTotal;
    }

    public String getProductCount() {
        return productCount;
    }

    public void setProductCount(String productCount) {
        this.productCount = productCount;
    }

    public String getOrderRemark() {
        return orderRemark;
    }

    public void setOrderRemark(String orderRemark) {
        this.orderRemark = orderRemark;
    }

    public String getOrderUuid() {
        return orderUuid;
    }

    public void setOrderUuid(String orderUuid) {
        this.orderUuid = orderUuid;
    }
}