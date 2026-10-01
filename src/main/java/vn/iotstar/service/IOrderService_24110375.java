package vn.iotstar.service;

import vn.iotstar.entity.CartItem_24110375;
import vn.iotstar.entity.Order_24110375;
import vn.iotstar.entity.User_24110375;

import java.util.List;

public interface IOrderService_24110375 {
    Order_24110375 createOrderCOD(User_24110375 user, String recipientName, String phone, String address, String note, List<CartItem_24110375> cartItems);
    Order_24110375 getOrderById(String orderId);
    List<Order_24110375> getOrdersByUser(String username);
    List<Order_24110375> getAllOrders();
    boolean cancelOrder(String orderId, String username);
    boolean updateOrderStatus(String orderId, String newStatus);
}
