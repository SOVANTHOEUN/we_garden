package com.wegarden.web.model.stock;

public class Image {

    private int id;
    private String name;
    private String type;
    private String status;
    private String uuid;

    public Image(int id, String name, String type, String status, String uuid) {
        this.id = id;
        this.name = name;
        this.type = type;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
        return "Image{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
