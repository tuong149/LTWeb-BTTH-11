package vn.iotstar.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "OrderDetails")
public class OrderDetail_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DetailId")
    private Integer detailId;

    @ManyToOne
    @JoinColumn(name = "OrderId", nullable = false)
    private Order_24110375 order;

    @ManyToOne
    @JoinColumn(name = "VideoId", nullable = false)
    private Video_24110375 video;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity = 1;

    @Column(name = "Price", nullable = false)
    private Double price;

    public OrderDetail_24110375() {}

    public OrderDetail_24110375(Order_24110375 order, Video_24110375 video, Integer quantity, Double price) {
        this.order = order;
        this.video = video;
        this.quantity = quantity;
        this.price = price;
    }

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public Order_24110375 getOrder() {
        return order;
    }

    public void setOrder(Order_24110375 order) {
        this.order = order;
    }

    public Video_24110375 getVideo() {
        return video;
    }

    public void setVideo(Video_24110375 video) {
        this.video = video;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getTotalPrice() {
        if (price != null && quantity != null) {
            return price * quantity;
        }
        return 0.0;
    }
}
