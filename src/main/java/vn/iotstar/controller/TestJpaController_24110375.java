package vn.iotstar.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vn.iotstar.config.JpaConfig_24110375;
import vn.iotstar.entity.Category_24110375;
import javax.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/test-jpa"})
public class TestJpaController_24110375 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            List<Category_24110375> list = em.createQuery("SELECT c FROM Category_24110375 c", Category_24110375.class).getResultList();
            
            resp.getWriter().println("<h1>Kết nối Database SQL Server qua JPA thành công!</h1>");
            resp.getWriter().println("<h3>Số lượng danh mục trong DB: " + list.size() + "</h3>");
            for(Category_24110375 c : list) {
                resp.getWriter().println("<p>- " + c.getCategoryname() + "</p>");
            }
        } catch (Exception e) {
            resp.getWriter().println("<h1>Lỗi kết nối JPA: " + e.getMessage() + "</h1>");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}

