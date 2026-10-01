package vn.iotstar.dao;

import vn.iotstar.entity.Order_24110375;
import java.util.List;

public interface IOrderDao_24110375 {
    void insert(Order_24110375 order);
    void update(Order_24110375 order);
    Order_24110375 findById(String orderId);
    List<Order_24110375> findByUsername(String username);
    List<Order_24110375> findAll();
    boolean updateStatus(String orderId, String orderStatus, String paymentStatus);
}
