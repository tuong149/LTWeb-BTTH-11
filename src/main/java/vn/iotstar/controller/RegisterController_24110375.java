package vn.iotstar.controller;

import vn.iotstar.entity.User_24110375;
import vn.iotstar.service.IUserService_24110375;
import vn.iotstar.service.impl.UserServiceImpl_24110375;
import vn.iotstar.util.EmailUtil_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24110375 extends HttpServlet {
    
    private IUserService_24110375 userService = new UserServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            
            String username = req.getParameter("username");
            String email = req.getParameter("email");
            
            if (userService.checkExistUsername(username)) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
                return;
            }
            if (userService.checkExistEmail(email)) {
                req.setAttribute("error", "Email đã được sử dụng!");
                req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
                return;
            }

            User_24110375 user = new User_24110375();
            user.setUsername(username);
            user.setPassword(req.getParameter("password"));
            user.setFullname(req.getParameter("fullname"));
            user.setEmail(email);
            user.setPhone(req.getParameter("phone"));
            user.setActive(true);
            user.setAdmin(false);

            String otp = EmailUtil_24110375.generateOTP();
            
            boolean isSent = EmailUtil_24110375.sendOTP(email, otp);
            if (isSent) {
                HttpSession session = req.getSession();
                session.setAttribute("registerUser", user);
                session.setAttribute("otpCode", otp);
                
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
            } else {
                req.setAttribute("error", "Lỗi gửi Email OTP. Vui lòng kiểm tra kết nối mạng hoặc Mật khẩu ứng dụng (.env).");
                req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi máy chủ nghiêm trọng: " + e.getMessage() + " - Hãy xem Log Tomcat.");
            req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
        }
    }
}

