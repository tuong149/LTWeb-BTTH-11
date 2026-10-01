package vn.iotstar.controller;

import vn.iotstar.entity.User_24110375;
import vn.iotstar.service.IUserService_24110375;
import vn.iotstar.service.impl.UserServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin-login", "/admin/login"})
public class AdminLoginController_24110375 extends HttpServlet {
    
    private IUserService_24110375 userService = new UserServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        
        User_24110375 account = userService.login(user, pass);
        
        if (account != null) {
            if (account.getAdmin() != null && account.getAdmin()) {
                HttpSession session = req.getSession();
                session.setAttribute("user", account);
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else {
                req.setAttribute("error", "Tài khoản của bạn không có quyền Quản trị (Admin)!");
                req.getRequestDispatcher("/views/admin/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu Quản trị!");
            req.getRequestDispatcher("/views/admin/login.jsp").forward(req, resp);
        }
    }
}
