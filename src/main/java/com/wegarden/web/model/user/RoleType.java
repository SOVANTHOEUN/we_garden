package com.wegarden.web.model.user;

public class RoleType {

    private int id;
    private String role_type;

    public RoleType(int id, String role_type) {
        this.id = id;
        this.role_type = role_type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRole_type() {
        return role_type;
    }

    public void setRole_type(String role_type) {
        this.role_type = role_type;
    }

    @Override
    public String toString() {
        return "RoleType{" +
                "id=" + id +
                ", role_type='" + role_type + '\'' +
                '}';
    }
}
