package vn.iotstar.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import vn.iotstar.entity.Category_24110375;
import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.ICategoryService_24110375;
import vn.iotstar.service.IVideoService_24110375;
import vn.iotstar.service.impl.CategoryServiceImpl_24110375;
import vn.iotstar.service.impl.VideoServiceImpl_24110375;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/home"})
public class HomeController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICategoryService_24110375 categoryService = new CategoryServiceImpl_24110375();
    private IVideoService_24110375 videoService = new VideoServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24110375> categories = categoryService.findAll();
        
        Map<Integer, Integer> categoryCounts = new HashMap<>();
        for (Category_24110375 c : categories) {
            categoryCounts.put(c.getCategoryId(), videoService.countByCategory(c.getCategoryId()));
        }
        
        String catIdParam = req.getParameter("categoryId");
        Integer currentCategoryId = null;
        if (catIdParam != null && !catIdParam.isEmpty()) {
            try {
                currentCategoryId = Integer.parseInt(catIdParam);
                req.getSession().setAttribute("homeCategoryId", currentCategoryId);
            } catch (NumberFormatException e) {
            }
        } else {
            currentCategoryId = (Integer) req.getSession().getAttribute("homeCategoryId");
        }
        
        if (currentCategoryId == null && !categories.isEmpty()) {
            currentCategoryId = categories.get(0).getCategoryId();
        }
        
        int page = 1;
        int pageSize = 3;
        
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        List<Video_24110375> videos = null;
        int totalItems = 0;
        String currentCategoryName = "Chưa có danh mục";
        
        if (currentCategoryId != null) {
            videos = videoService.findByCategory(currentCategoryId, page, pageSize);
            totalItems = videoService.countByCategory(currentCategoryId);
            
            for (Category_24110375 c : categories) {
                if (c.getCategoryId().equals(currentCategoryId)) {
                    currentCategoryName = c.getCategoryname();
                    break;
                }
            }
        }
        
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        Map<String, Integer> likeCounts = new HashMap<>();
        Map<String, Integer> shareCounts = new HashMap<>();
        if (videos != null) {
            for (Video_24110375 v : videos) {
                likeCounts.put(v.getVideoId(), videoService.countFavorites(v.getVideoId()));
                shareCounts.put(v.getVideoId(), videoService.countShares(v.getVideoId()));
            }
        }
        
        req.setAttribute("categories", categories);
        req.setAttribute("categoryCounts", categoryCounts);
        req.setAttribute("currentCategoryId", currentCategoryId);
        req.setAttribute("currentCategoryName", currentCategoryName);
        req.setAttribute("totalItems", totalItems);
        
        req.setAttribute("videos", videos);
        req.setAttribute("likeCounts", likeCounts);
        req.setAttribute("shareCounts", shareCounts);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}

