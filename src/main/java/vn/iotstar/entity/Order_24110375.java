package vn.iotstar.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Orders")
public class Order_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "OrderId", length = 50, nullable = false)
    private String orderId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "OrderDate")
    private Date orderDate = new Date();

    @ManyToOne
    @JoinColumn(name = "Username", nullable = false)
    private User_24110375 user;

    @Column(name = "RecipientName", length = 100, nullable = false)
    private String recipientName;

    @Column(name = "Phone", length = 20, nullable = false)
    private String phone;

    @Column(name = "Address", length = 300, nullable = false)
    private String address;

    @Column(name = "Note", length = 500)
    private String note;

    @Column(name = "TotalAmount", nullable = false)
    private Double totalAmount;

    @Column(name = "PaymentMethod", length = 50)
    private String paymentMethod = "COD";

    @Column(name = "PaymentStatus", length = 50)
    private String paymentStatus = "UNPAID";

    @Column(name = "OrderStatus", length = 50)
    private String orderStatus = "PENDING";

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail_24110375> orderDetails = new ArrayList<>();

    public Order_24110375() {}

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public User_24110375 getUser() {
        return user;
    }

    public void setUser(User_24110375 user) {
        this.user = user;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderDetail_24110375> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail_24110375> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
