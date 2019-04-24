package com.wegarden.web.model.stock;

public class Product {

    private int id;
    private String name;
    private Double price;
    private String status;
    private String uuid;
    private int category_id;
    private int image_id;

    public Product(int id, String name, Double price, String status, String uuid, int category_id, int image_id) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.status = status;
        this.uuid = uuid;
        this.category_id = category_id;
        this.image_id = image_id;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
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

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getImage_id() {
        return image_id;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                ", category_id=" + category_id +
                ", image_id=" + image_id +
                '}';
    }
}
