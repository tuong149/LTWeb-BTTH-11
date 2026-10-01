package vn.iotstar.controller;

import vn.iotstar.service.ICategoryService_24110375;
import vn.iotstar.service.IVideoService_24110375;
import vn.iotstar.service.impl.CategoryServiceImpl_24110375;
import vn.iotstar.service.impl.VideoServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/home"})
public class AdminHomeController_24110375 extends HttpServlet {
    private IVideoService_24110375 videoService = new VideoServiceImpl_24110375();
    private ICategoryService_24110375 categoryService = new CategoryServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int totalVideos = videoService.countAll();
        int totalCategories = categoryService.findAll().size();
        
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("totalCategories", totalCategories);
        
        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}

