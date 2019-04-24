package com.wegarden.web.model.stock;

public class Category {

    private int id;
    private String name;
    private String remark;
    private String status;
    private String uuid;

    public Category(int id, String name, String remark, String status, String uuid) {
        this.id = id;
        this.name = name;
        this.remark = remark;
        this.status = status;
        this.uuid = uuid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() { return remark; }

    public void setRemark(String remark) { this.remark = remark; }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", remark='" + remark + '\'' +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
