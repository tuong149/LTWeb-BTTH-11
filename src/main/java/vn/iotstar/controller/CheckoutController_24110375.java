package vn.iotstar.controller;

import vn.iotstar.entity.CartItem_24110375;
import vn.iotstar.entity.Order_24110375;
import vn.iotstar.entity.User_24110375;
import vn.iotstar.service.IOrderService_24110375;
import vn.iotstar.service.impl.OrderServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

@WebServlet(urlPatterns = {"/checkout", "/checkout/*"})
public class CheckoutController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24110375 orderService = new OrderServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110375 currentUser = (User_24110375) session.getAttribute("user");

        if (currentUser == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để tiến hành đặt hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/success".equals(path)) {
            String orderId = req.getParameter("orderId");
            if (orderId != null && !orderId.trim().isEmpty()) {
                Order_24110375 order = orderService.getOrderById(orderId);
                if (order != null && order.getUser() != null && order.getUser().getUsername().equals(currentUser.getUsername())) {
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/views/user/order-success.jsp").forward(req, resp);
                    return;
                }
            }
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        // Kiểm tra giỏ hàng
        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110375> cart = (Map<String, CartItem_24110375>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartError", "Giỏ hàng của bạn đang trống! Hãy chọn khóa học trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // Chuyển sang trang checkout
        req.setAttribute("cartItems", cart.values());
        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User_24110375 currentUser = (User_24110375) session.getAttribute("user");

        if (currentUser == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để tiến hành đặt hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110375> cart = (Map<String, CartItem_24110375>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartError", "Giỏ hàng của bạn đang trống!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String recipientName = req.getParameter("recipientName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");

        if (recipientName == null || recipientName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ Họ tên, Số điện thoại và Địa chỉ nhận hàng!");
            req.setAttribute("cartItems", cart.values());
            req.setAttribute("recipientName", recipientName);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.setAttribute("note", note);
            req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
            return;
        }

        try {
            Order_24110375 order = orderService.createOrderCOD(
                currentUser,
                recipientName.trim(),
                phone.trim(),
                address.trim(),
                note != null ? note.trim() : "",
                new ArrayList<>(cart.values())
            );

            // Làm sạch giỏ hàng sau khi đặt thành công
            cart.clear();
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);
            session.setAttribute("cartGrandTotal", 0.0);

            session.setAttribute("cartSuccess", "Đặt hàng thành công! Đơn hàng " + order.getOrderId() + " đã được lưu vào hệ thống.");
            resp.sendRedirect(req.getContextPath() + "/checkout/success?orderId=" + order.getOrderId());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi xử lý đơn hàng: " + e.getMessage());
            req.setAttribute("cartItems", cart.values());
            req.getRequestDispatcher("/views/user/checkout.jsp").forward(req, resp);
        }
    }
}
