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

@WebServlet(urlPatterns = {"/admin/orders", "/admin/orders/*"})
public class AdminOrderController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24110375 orderService = new OrderServiceImpl_24110375();

    private boolean checkAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User_24110375 user = (User_24110375) session.getAttribute("user");
        if (user == null || user.getAdmin() == null || !user.getAdmin()) {
            session.setAttribute("error", "Vui lòng đăng nhập tài khoản Quản trị viên!");
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            listOrders(req, resp);
        } else if (path.equals("/update-status")) {
            handleStatusUpdate(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdmin(req, resp)) return;
        handleStatusUpdate(req, resp);
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order_24110375> orders = orderService.getAllOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/admin/order-list.jsp").forward(req, resp);
    }

    private void handleStatusUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        String orderId = req.getParameter("orderId");
        String status = req.getParameter("status");
        HttpSession session = req.getSession();

        if (orderId != null && status != null) {
            boolean updated = orderService.updateOrderStatus(orderId.trim(), status.trim());
            if (updated) {
                session.setAttribute("msg", "Đã cập nhật trạng thái đơn hàng #" + orderId + " sang: " + status);
            } else {
                session.setAttribute("error", "Không thể cập nhật trạng thái cho đơn hàng #" + orderId);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }
}
