package com.wegarden.web.model.stock;

public class DownloadRefrig  {

    private String item;
    private String price;
    private String inStock;

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getInStock() {
        return inStock;
    }

    public void setInStock(String inStock) {
        this.inStock = inStock;
    }

    public DownloadRefrig() {
    }

    public DownloadRefrig(String item, String price, String inStock) {
        this.item = item;
        this.price = price;
        this.inStock = inStock;
    }

    @Override
    public String toString() {
        return "DownloadRefrig{" +
                "item='" + item + '\'' +
                ", price='" + price + '\'' +
                ", inStock='" + inStock + '\'' +
                '}';
    }
}
