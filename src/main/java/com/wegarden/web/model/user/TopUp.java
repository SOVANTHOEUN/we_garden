package com.wegarden.web.model.user;

import java.util.Date;

public class TopUp {

    private int id;
    private Double amount;
    private Date date;
    private int user_id;

    public TopUp(int id, Double amount, Date date, int user_id) {
        this.id = id;
        this.amount = amount;
        this.date = date;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "TopUp{" +
                "id=" + id +
                ", amount=" + amount +
                ", date=" + date +
                ", user_id=" + user_id +
                '}';
    }
}
