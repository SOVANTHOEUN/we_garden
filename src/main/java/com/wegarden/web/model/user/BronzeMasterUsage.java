package com.wegarden.web.model.user;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class BronzeMasterUsage {
    @Id
    @JsonProperty("user_uuid")
    private String userUuid;

    @JsonProperty("user_name")
    private String userName;

    @JsonProperty("user_image")
    private String userImage;

    @JsonProperty("tea_time_usage")
    private Boolean teaTimeUsage;

    @JsonProperty("product_uuid")
    private String productUuid;

    @JsonProperty("product_name")
    private String productName;

    @JsonProperty("product_price")
    private Double productPrice;

    @JsonProperty("product_image")
    private String productImage;

    public BronzeMasterUsage(){  }

    public BronzeMasterUsage(String userUuid, String userName, String userImage, Boolean teaTimeUsage, String productUuid, String productName, Double productPrice, String productImage) {
        this.userUuid = userUuid;
        this.userName = userName;
        this.userImage = userImage;
        this.teaTimeUsage = teaTimeUsage;
        this.productUuid = productUuid;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
    }

    public String getUserUuid() {
        return userUuid;
    }

    public void setUserUuid(String userUuid) {
        this.userUuid = userUuid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public Boolean getTeaTimeUsage() {
        return teaTimeUsage;
    }

    public void setTeaTimeUsage(Boolean teaTimeUsage) {
        this.teaTimeUsage = teaTimeUsage;
    }

    public String getProductUuid() {
        return productUuid;
    }

    public void setProductUuid(String productUuid) {
        this.productUuid = productUuid;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    @Override
    public String toString() {
        return "BronzeMasterUsage{" +
                "userUuid='" + userUuid + '\'' +
                ", userName='" + userName + '\'' +
                ", userImage='" + userImage + '\'' +
                ", teaTimeUsage=" + teaTimeUsage +
                ", productUuid='" + productUuid + '\'' +
                ", productName='" + productName + '\'' +
                ", productPrice=" + productPrice +
                ", productImage='" + productImage + '\'' +
                '}';
    }
}
