package com.wegarden.web.model.user;

public class Department {

    private int id;
    private String name;
    private int first_manager;
    private int second_manager;
    private String remark;
    private String status;
    private String uuid;

    public Department(int id, String name, int first_manager, int second_manager, String remark, String status, String uuid) {
        this.id = id;
        this.name = name;
        this.first_manager = first_manager;
        this.second_manager = second_manager;
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

    public int getFirst_manager() {
        return first_manager;
    }

    public void setFirst_manager(int first_manager) {
        this.first_manager = first_manager;
    }

    public int getSecond_manager() {
        return second_manager;
    }

    public void setSecond_manager(int second_manager) {
        this.second_manager = second_manager;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

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
        return "Department{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", first_manager=" + first_manager +
                ", second_manager=" + second_manager +
                ", remark='" + remark + '\'' +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
