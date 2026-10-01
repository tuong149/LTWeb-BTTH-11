package vn.iotstar.controller;

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
import java.util.List;

@WebServlet(urlPatterns = {"/orders", "/orders/*"})
public class OrderController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24110375 orderService = new OrderServiceImpl_24110375();

    private boolean checkLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User_24110375 currentUser = (User_24110375) session.getAttribute("user");
        if (currentUser == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để xem lịch sử đơn hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkLogin(req, resp)) return;

        HttpSession session = req.getSession();
        User_24110375 currentUser = (User_24110375) session.getAttribute("user");

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            listUserOrders(req, resp, currentUser);
        } else if (path.equals("/cancel")) {
            cancelUserOrder(req, resp, currentUser);
        } else if (path.equals("/detail")) {
            viewOrderDetail(req, resp, currentUser);
        } else {
            resp.sendRedirect(req.getContextPath() + "/orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void listUserOrders(HttpServletRequest req, HttpServletResponse resp, User_24110375 currentUser) throws ServletException, IOException {
        List<Order_24110375> orders = orderService.getOrdersByUser(currentUser.getUsername());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/user/orders.jsp").forward(req, resp);
    }

    private void viewOrderDetail(HttpServletRequest req, HttpServletResponse resp, User_24110375 currentUser) throws ServletException, IOException {
        String orderId = req.getParameter("id");
        if (orderId != null && !orderId.trim().isEmpty()) {
            Order_24110375 order = orderService.getOrderById(orderId);
            if (order != null && order.getUser() != null && order.getUser().getUsername().equals(currentUser.getUsername())) {
                req.setAttribute("order", order);
                req.getRequestDispatcher("/views/user/order-success.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/orders");
    }

    private void cancelUserOrder(HttpServletRequest req, HttpServletResponse resp, User_24110375 currentUser) throws IOException {
        String orderId = req.getParameter("id");
        HttpSession session = req.getSession();
        if (orderId != null && !orderId.trim().isEmpty()) {
            boolean success = orderService.cancelOrder(orderId, currentUser.getUsername());
            if (success) {
                session.setAttribute("cartSuccess", "Đã hủy đơn hàng #" + orderId + " thành công!");
            } else {
                session.setAttribute("cartError", "Không thể hủy đơn hàng #" + orderId + " (Đơn có thể đã được duyệt hoặc đang giao)!");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/orders");
    }
}
