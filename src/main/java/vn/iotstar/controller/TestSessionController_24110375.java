package vn.iotstar.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vn.iotstar.entity.User_24110375;
import java.io.IOException;

@WebServlet(urlPatterns = {"/test-session"})
public class TestSessionController_24110375 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String role = req.getParameter("role");
        HttpSession session = req.getSession();
        
        if ("admin".equals(role)) {
            User_24110375 fakeAdmin = new User_24110375();
            fakeAdmin.setFullname("Quản Trị Viên");
            fakeAdmin.setAdmin(true);
            session.setAttribute("user", fakeAdmin);
        } else {
            session.removeAttribute("user");
        }
        
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}

