package com.wegarden.web.model.order;

public class OrderType {

    private int id;
    private String order_type;

    public OrderType(int id, String order_type) {
        this.id = id;
        this.order_type = order_type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrder_type() {
        return order_type;
    }

    public void setOrder_type(String order_type) {
        this.order_type = order_type;
    }

    @Override
    public String toString() {
        return "OrderType{" +
                "id=" + id +
                ", order_type='" + order_type + '\'' +
                '}';
    }
}
