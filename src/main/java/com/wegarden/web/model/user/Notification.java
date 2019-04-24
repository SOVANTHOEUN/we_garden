package com.wegarden.web.model.user;

public class Notification {

    private int id;
    private String key_id;
    private String title;
    private String message;
    private int user_id;

    public Notification(int id, String key_id, String title, String message, int user_id) {
        this.id = id;
        this.key_id = key_id;
        this.title = title;
        this.message = message;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKey_id() {
        return key_id;
    }

    public void setKey_id(String key_id) {
        this.key_id = key_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "id=" + id +
                ", key_id='" + key_id + '\'' +
                ", title='" + title + '\'' +
                ", message='" + message + '\'' +
                ", user_id=" + user_id +
                '}';
    }
}
