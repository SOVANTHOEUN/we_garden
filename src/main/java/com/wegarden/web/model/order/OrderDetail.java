package com.wegarden.web.model.order;

public class OrderDetail {

    private int id;
    private int quantity;
    private Double unit_price;
    private int order_id;
    private int product_id;

    public OrderDetail(int id, int quantity, Double unit_price, int order_id, int product_id) {
        this.id = id;
        this.quantity = quantity;
        this.unit_price = unit_price;
        this.order_id = order_id;
        this.product_id = product_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(Double unit_price) {
        this.unit_price = unit_price;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + id +
                ", quantity=" + quantity +
                ", unit_price=" + unit_price +
                ", order_id=" + order_id +
                ", product_id=" + product_id +
                '}';
    }
}
