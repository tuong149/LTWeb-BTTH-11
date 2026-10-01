package vn.iotstar.entity;

import java.io.Serializable;

public class CartItem_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final int MIN_QUANTITY = 1;
    public static final int MAX_QUANTITY = 10;

    private String videoId;
    private String title;
    private String poster;
    private double price;
    private int quantity;

    public CartItem_24110375() {
        this.quantity = 1;
        this.price = 150000.0; // Giá mặc định 150.000 VNĐ cho mỗi khóa học / video
    }

    public CartItem_24110375(String videoId, String title, String poster, double price, int quantity) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.price = price;
        setQuantity(quantity);
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < MIN_QUANTITY) {
            this.quantity = MIN_QUANTITY;
        } else if (quantity > MAX_QUANTITY) {
            this.quantity = MAX_QUANTITY;
        } else {
            this.quantity = quantity;
        }
    }

    public double getTotalPrice() {
        return this.price * this.quantity;
    }
}
