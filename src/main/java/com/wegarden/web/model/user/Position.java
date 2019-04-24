package com.wegarden.web.model.user;

public class Position {

    private int id;
    private String position;
    private String type;
    private String uuid;

    public Position(int id, String position, String type, String uuid) {
        this.id = id;
        this.position = position;
        this.type = type;
        this.uuid = uuid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Override
    public String toString() {
        return "Position{" +
                "id=" + id +
                ", position='" + position + '\'' +
                ", type='" + type + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
