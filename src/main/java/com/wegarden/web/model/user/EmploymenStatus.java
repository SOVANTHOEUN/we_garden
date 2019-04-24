package com.wegarden.web.model.user;

public class EmploymenStatus {

    private int id;
    private String status;
    private String uuid;

    public EmploymenStatus(int id, String status, String uuid) {
        this.id = id;
        this.status = status;
        this.uuid = uuid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
        return "EmploymenStatus{" +
                "id=" + id +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}