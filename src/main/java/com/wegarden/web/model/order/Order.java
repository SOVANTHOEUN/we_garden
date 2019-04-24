package com.wegarden.web.model.order;

import java.util.Date;

public class Order {

    private int id;
    private String order_type;
    private Double subtotal;
    private Double total;
    private Date date;
    private String remark;
    private String uuid;
    private Date return_date;
    private int user_id;

    public Order(int id, String order_type, Double subtotal, Double total, Date date, String remark, String uuid, Date return_date, int user_id) {
        this.id = id;
        this.order_type = order_type;
        this.subtotal = subtotal;
        this.total = total;
        this.date = date;
        this.remark = remark;
        this.uuid = uuid;
        this.return_date = return_date;
        this.user_id = user_id;
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

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Date getReturn_date() {
        return return_date;
    }

    public void setReturn_date(Date return_date) {
        this.return_date = return_date;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", order_type='" + order_type + '\'' +
                ", subtotal=" + subtotal +
                ", total=" + total +
                ", date=" + date +
                ", remark='" + remark + '\'' +
                ", uuid='" + uuid + '\'' +
                ", return_date=" + return_date +
                ", user_id=" + user_id +
                '}';
    }
}
