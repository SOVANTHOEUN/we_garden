package com.wegarden.web.model.stock;

import java.util.Date;

public class Refrigerator {

    private int id;
    private int stock_in;
    private int stock_out;
    private int quantity;
    private Date updated_date;
    private int product_id;
    private int order_id;

    public Refrigerator(int id, int stock_in, int stock_out, int quantity, Date updated_date, int product_id, int order_id) {
        this.id = id;
        this.stock_in = stock_in;
        this.stock_out = stock_out;
        this.quantity = quantity;
        this.updated_date = updated_date;
        this.product_id = product_id;
        this.order_id = order_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStock_in() {
        return stock_in;
    }

    public void setStock_in(int stock_in) {
        this.stock_in = stock_in;
    }

    public int getStock_out() {
        return stock_out;
    }

    public void setStock_out(int stock_out) {
        this.stock_out = stock_out;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(Date updated_date) {
        this.updated_date = updated_date;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    @Override
    public String toString() {
        return "Refrigerator{" +
                "id=" + id +
                ", stock_in=" + stock_in +
                ", stock_out=" + stock_out +
                ", quantity=" + quantity +
                ", updated_date=" + updated_date +
                ", product_id=" + product_id +
                ", order_id=" + order_id +
                '}';
    }
}
