package vn.iotstar.controller;

import vn.iotstar.entity.CartItem_24110375;
import vn.iotstar.entity.User_24110375;
import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.IVideoService_24110375;
import vn.iotstar.service.impl.VideoServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/cart", "/cart/*"})
public class CartController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IVideoService_24110375 videoService = new VideoServiceImpl_24110375();

    private boolean checkLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User_24110375 currentUser = (User_24110375) session.getAttribute("user");
        if (currentUser == null) {
            String isAjax = req.getParameter("ajax");
            if ("true".equals(isAjax)) {
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"status\":\"unauthenticated\",\"message\":\"Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!\",\"redirect\":\"" + req.getContextPath() + "/login\"}");
                return false;
            }
            session.setAttribute("error", "Vui lòng đăng nhập tài khoản để sử dụng tính năng giỏ hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkLogin(req, resp)) return;

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            viewCart(req, resp);
        } else if (path.equals("/add")) {
            addToCart(req, resp);
        } else if (path.equals("/update")) {
            updateCartQuantity(req, resp);
        } else if (path.equals("/delete")) {
            deleteFromCart(req, resp);
        } else if (path.equals("/clear")) {
            clearCart(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkLogin(req, resp)) return;
        String path = req.getPathInfo();
        if (path != null && path.equals("/update")) {
            updateCartQuantity(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private Map<String, CartItem_24110375> getCartSession(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<String, CartItem_24110375> cart = (Map<String, CartItem_24110375>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void updateCartSummary(HttpSession session, Map<String, CartItem_24110375> cart) {
        int totalQuantity = 0;
        double grandTotal = 0;
        for (CartItem_24110375 item : cart.values()) {
            totalQuantity += item.getQuantity();
            grandTotal += item.getTotalPrice();
        }
        session.setAttribute("cartCount", totalQuantity);
        session.setAttribute("cartGrandTotal", grandTotal);
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<String, CartItem_24110375> cart = getCartSession(session);
        updateCartSummary(session, cart);

        req.setAttribute("cartItems", cart.values());
        req.getRequestDispatcher("/views/user/cart.jsp").forward(req, resp);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        int addQty = 1;
        String qtyParam = req.getParameter("quantity");
        if (qtyParam != null && !qtyParam.isEmpty()) {
            try {
                addQty = Integer.parseInt(qtyParam);
            } catch (NumberFormatException e) {
                addQty = 1;
            }
        }

        HttpSession session = req.getSession();
        Map<String, CartItem_24110375> cart = getCartSession(session);

        if (cart.containsKey(id)) {
            CartItem_24110375 existingItem = cart.get(id);
            int newQty = existingItem.getQuantity() + addQty;
            if (newQty > CartItem_24110375.MAX_QUANTITY) {
                existingItem.setQuantity(CartItem_24110375.MAX_QUANTITY);
                session.setAttribute("cartMessage", "Đã đạt số lượng tối đa (" + CartItem_24110375.MAX_QUANTITY + ") cho khóa học này!");
            } else {
                existingItem.setQuantity(newQty);
                session.setAttribute("cartSuccess", "Đã cập nhật thêm số lượng vào giỏ hàng!");
            }
        } else {
            Video_24110375 video = videoService.findById(id);
            if (video != null) {
                // Giá tượng trưng cho mỗi video/khóa học dựa trên views hoặc mặc định 199.000 VNĐ
                double price = (video.getViews() != null && video.getViews() > 2000) ? 299000.0 : 199000.0;
                CartItem_24110375 newItem = new CartItem_24110375(video.getVideoId(), video.getTitle(), video.getPoster(), price, addQty);
                cart.put(id, newItem);
                session.setAttribute("cartSuccess", "Đã thêm khóa học \"" + video.getTitle() + "\" vào giỏ hàng thành công!");
            }
        }

        updateCartSummary(session, cart);

        String isAjax = req.getParameter("ajax");
        if ("true".equals(isAjax)) {
            resp.setContentType("application/json;charset=UTF-8");
            String successMsg = (String) session.getAttribute("cartSuccess");
            String warnMsg = (String) session.getAttribute("cartMessage");
            String msg = (successMsg != null) ? successMsg : (warnMsg != null ? warnMsg : "Đã cập nhật giỏ hàng!");
            String status = (warnMsg != null) ? "warning" : "success";

            session.removeAttribute("cartSuccess");
            session.removeAttribute("cartMessage");

            int cartCount = (session.getAttribute("cartCount") != null) ? (Integer) session.getAttribute("cartCount") : 0;
            CartItem_24110375 currentItem = cart.get(id);
            int itemQty = (currentItem != null) ? currentItem.getQuantity() : 0;
            resp.getWriter().write("{\"status\":\"" + status + "\",\"message\":\"" + msg.replace("\"", "\\\"") + "\",\"cartCount\":" + cartCount + ",\"videoId\":\"" + id + "\",\"itemQty\":" + itemQty + "}");
            return;
        }

        String redirect = req.getParameter("redirect");
        if ("detail".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/video/detail?id=" + id);
        } else if ("home".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void updateCartQuantity(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String action = req.getParameter("action");
        String qtyParam = req.getParameter("quantity");

        HttpSession session = req.getSession();
        Map<String, CartItem_24110375> cart = getCartSession(session);

        if (id != null && cart.containsKey(id)) {
            CartItem_24110375 item = cart.get(id);

            if ("increase".equalsIgnoreCase(action)) {
                if (item.getQuantity() < CartItem_24110375.MAX_QUANTITY) {
                    item.setQuantity(item.getQuantity() + 1);
                    session.setAttribute("cartSuccess", "Đã tăng số lượng thành " + item.getQuantity());
                } else {
                    session.setAttribute("cartMessage", "Số lượng tối đa cho phép là " + CartItem_24110375.MAX_QUANTITY + " sản phẩm!");
                }
            } else if ("decrease".equalsIgnoreCase(action)) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                    session.setAttribute("cartSuccess", "Đã giảm số lượng thành " + item.getQuantity());
                } else {
                    cart.remove(id);
                    session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
                }
            } else if (qtyParam != null) {
                // Người dùng nhập trực tiếp vào ô input
                try {
                    int inputQty = Integer.parseInt(qtyParam.trim());
                    if (inputQty < CartItem_24110375.MIN_QUANTITY) {
                        item.setQuantity(CartItem_24110375.MIN_QUANTITY);
                        session.setAttribute("cartMessage", "Số lượng không được nhỏ hơn " + CartItem_24110375.MIN_QUANTITY + ". Đã tự động điều chỉnh về 1!");
                    } else if (inputQty > CartItem_24110375.MAX_QUANTITY) {
                        item.setQuantity(CartItem_24110375.MAX_QUANTITY);
                        session.setAttribute("cartMessage", "Số lượng vượt quá giới hạn " + CartItem_24110375.MAX_QUANTITY + ". Đã điều chỉnh về 10!");
                    } else {
                        item.setQuantity(inputQty);
                        session.setAttribute("cartSuccess", "Cập nhật số lượng thành công!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("cartMessage", "Giá trị số lượng không hợp lệ! Vui lòng chỉ nhập số nguyên từ 1 đến 10.");
                }
            }
        }

        updateCartSummary(session, cart);

        String isAjax = req.getParameter("ajax");
        if ("true".equals(isAjax)) {
            resp.setContentType("application/json;charset=UTF-8");
            String successMsg = (String) session.getAttribute("cartSuccess");
            String warnMsg = (String) session.getAttribute("cartMessage");
            String msg = (successMsg != null) ? successMsg : (warnMsg != null ? warnMsg : "Đã cập nhật giỏ hàng!");
            String status = (warnMsg != null) ? "warning" : "success";

            session.removeAttribute("cartSuccess");
            session.removeAttribute("cartMessage");

            int cartCount = (session.getAttribute("cartCount") != null) ? (Integer) session.getAttribute("cartCount") : 0;
            CartItem_24110375 currentItem = (id != null) ? cart.get(id) : null;
            int itemQty = (currentItem != null) ? currentItem.getQuantity() : 0;
            resp.getWriter().write("{\"status\":\"" + status + "\",\"message\":\"" + msg.replace("\"", "\\\"") + "\",\"cartCount\":" + cartCount + ",\"videoId\":\"" + id + "\",\"itemQty\":" + itemQty + "}");
            return;
        }

        String redirect = req.getParameter("redirect");
        if ("home".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void deleteFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        HttpSession session = req.getSession();
        Map<String, CartItem_24110375> cart = getCartSession(session);

        if (id != null && cart.containsKey(id)) {
            CartItem_24110375 removed = cart.remove(id);
            session.setAttribute("cartSuccess", "Đã xóa \"" + removed.getTitle() + "\" khỏi giỏ hàng!");
        }

        updateCartSummary(session, cart);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void clearCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Map<String, CartItem_24110375> cart = getCartSession(session);
        cart.clear();
        updateCartSummary(session, cart);
        session.setAttribute("cartSuccess", "Đã xóa sạch toàn bộ giỏ hàng!");
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
