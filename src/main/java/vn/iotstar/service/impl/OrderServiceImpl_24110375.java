package vn.iotstar.service.impl;

import vn.iotstar.dao.IOrderDao_24110375;
import vn.iotstar.dao.IVideoDao_24110375;
import vn.iotstar.dao.impl.OrderDaoImpl_24110375;
import vn.iotstar.dao.impl.VideoDaoImpl_24110375;
import vn.iotstar.entity.CartItem_24110375;
import vn.iotstar.entity.Order_24110375;
import vn.iotstar.entity.OrderDetail_24110375;
import vn.iotstar.entity.User_24110375;
import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.IOrderService_24110375;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class OrderServiceImpl_24110375 implements IOrderService_24110375 {

    private final IOrderDao_24110375 orderDao = new OrderDaoImpl_24110375();
    private final IVideoDao_24110375 videoDao = new VideoDaoImpl_24110375();

    @Override
    public Order_24110375 createOrderCOD(User_24110375 user, String recipientName, String phone, String address, String note, List<CartItem_24110375> cartItems) {
        if (user == null || cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng trống hoặc người dùng không hợp lệ");
        }

        // Tạo mã đơn hàng độc nhất: ORD-yyyyMMddHHmmss-XXXX
        String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int randomSuffix = new Random().nextInt(9000) + 1000;
        String orderId = "ORD-" + timeStamp + "-" + randomSuffix;

        Order_24110375 order = new Order_24110375();
        order.setOrderId(orderId);
        order.setOrderDate(new Date());
        order.setUser(user);
        order.setRecipientName(recipientName);
        order.setPhone(phone);
        order.setAddress(address);
        order.setNote(note);
        order.setPaymentMethod("COD");
        order.setPaymentStatus("UNPAID");
        order.setOrderStatus("PENDING");

        double totalAmount = 0.0;
        List<OrderDetail_24110375> details = new ArrayList<>();

        for (CartItem_24110375 item : cartItems) {
            Video_24110375 video = videoDao.findById(item.getVideoId());
            if (video != null) {
                OrderDetail_24110375 detail = new OrderDetail_24110375();
                detail.setOrder(order);
                detail.setVideo(video);
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getPrice());
                details.add(detail);

                totalAmount += item.getPrice() * item.getQuantity();
            }
        }

        order.setTotalAmount(totalAmount);
        order.setOrderDetails(details);

        orderDao.insert(order);
        return order;
    }

    @Override
    public Order_24110375 getOrderById(String orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<Order_24110375> getOrdersByUser(String username) {
        return orderDao.findByUsername(username);
    }

    @Override
    public List<Order_24110375> getAllOrders() {
        return orderDao.findAll();
    }

    @Override
    public boolean cancelOrder(String orderId, String username) {
        Order_24110375 order = orderDao.findById(orderId);
        if (order != null && order.getUser() != null && order.getUser().getUsername().equals(username)) {
            if ("PENDING".equalsIgnoreCase(order.getOrderStatus())) {
                return orderDao.updateStatus(orderId, "CANCELLED", null);
            }
        }
        return false;
    }

    @Override
    public boolean updateOrderStatus(String orderId, String newStatus) {
        String paymentStatus = null;
        if ("DELIVERED".equalsIgnoreCase(newStatus)) {
            // Đối với đơn COD, khi giao hàng thành công thì thanh toán hoàn tất
            paymentStatus = "PAID";
        }
        return orderDao.updateStatus(orderId, newStatus, paymentStatus);
    }
}
