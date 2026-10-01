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

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24110375 extends HttpServlet {
    
    private IUserService_24110375 userService = new UserServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("registerUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.getRequestDispatcher("/views/user/verify_otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String inputOtp = req.getParameter("otp");
        HttpSession session = req.getSession();
        
        String sessionOtp = (String) session.getAttribute("otpCode");
        User_24110375 user = (User_24110375) session.getAttribute("registerUser");
        
        if (sessionOtp != null && sessionOtp.equals(inputOtp)) {
            userService.register(user);
            
            session.removeAttribute("otpCode");
            session.removeAttribute("registerUser");
            
            req.setAttribute("message", "Đăng ký thành công! Hãy đăng nhập.");
            req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không chính xác!");
            req.getRequestDispatcher("/views/user/verify_otp.jsp").forward(req, resp);
        }
    }
}

