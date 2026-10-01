package vn.iotstar.controller;

import vn.iotstar.entity.Category_24110375;
import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.ICategoryService_24110375;
import vn.iotstar.service.IVideoService_24110375;
import vn.iotstar.service.impl.CategoryServiceImpl_24110375;
import vn.iotstar.service.impl.VideoServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 100)
@WebServlet(urlPatterns = {"/admin/videos", "/admin/videos/*"})
public class AdminVideoController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IVideoService_24110375 videoService = new VideoServiceImpl_24110375();
    private ICategoryService_24110375 categoryService = new CategoryServiceImpl_24110375();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            listVideos(req, resp);
        } else if (path.equals("/add")) {
            showAddForm(req, resp);
        } else if (path.equals("/edit")) {
            showEditForm(req, resp);
        } else if (path.equals("/delete")) {
            deleteVideo(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path != null && path.equals("/add")) {
            insertVideo(req, resp);
        } else if (path != null && path.equals("/edit")) {
            updateVideo(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listVideos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String catIdParam = req.getParameter("categoryId");
        Integer currentCategoryId = null;
        if (catIdParam != null && !catIdParam.isEmpty()) {
            if (catIdParam.equals("all")) {
                req.getSession().removeAttribute("adminCategoryId");
            } else {
                try {
                    currentCategoryId = Integer.parseInt(catIdParam);
                    req.getSession().setAttribute("adminCategoryId", currentCategoryId);
                } catch (NumberFormatException e) {
                }
            }
        } else {
            currentCategoryId = (Integer) req.getSession().getAttribute("adminCategoryId");
        }

        int page = 1;
        int pageSize = 6;
        
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        List<Video_24110375> list;
        int totalItems;
        if (currentCategoryId != null) {
            list = videoService.findByCategory(currentCategoryId, page, pageSize);
            totalItems = videoService.countByCategory(currentCategoryId);
        } else {
            list = videoService.findAll(page, pageSize);
            totalItems = videoService.countAll();
        }
        
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        List<Category_24110375> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        req.setAttribute("currentCategoryId", currentCategoryId);
        
        req.setAttribute("videos", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
    }
    
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24110375> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        req.setAttribute("action", "add");
        req.getRequestDispatcher("/views/admin/video-form.jsp").forward(req, resp);
    }
    
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Video_24110375 video = videoService.findById(id);
        if (video != null) {
            List<Category_24110375> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.setAttribute("video", video);
            req.setAttribute("action", "edit");
            req.getRequestDispatcher("/views/admin/video-form.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }
    
    private void deleteVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        try {
            videoService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }
    
    private void insertVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            Video_24110375 video = new Video_24110375();
            
            String autoId = "VID" + System.currentTimeMillis();
            video.setVideoId(autoId);
            
            video.setTitle(req.getParameter("title"));
            video.setDescription(req.getParameter("description"));
            video.setViews(0);
            video.setActive(req.getParameter("active") != null);
            
            Part part = req.getPart("posterFile");
            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName == null) submittedFileName = "upload.jpg";
                
                String fileName = Paths.get(submittedFileName).getFileName().toString();
                int dotIndex = fileName.lastIndexOf(".");
                String ext = (dotIndex == -1) ? ".jpg" : fileName.substring(dotIndex);
                String newFileName = autoId + ext;
                
                String targetPath = req.getServletContext().getRealPath("/uploads");
                if (targetPath != null) {
                    File uploadDir = new File(targetPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    File destFile = new File(uploadDir, newFileName);
                    try (java.io.InputStream is = part.getInputStream()) {
                        Files.copy(is, destFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    File srcUploadDir = new File("d:/QUỐC KHOA/KTQT/24110375_03/src/main/webapp/uploads");
                    if (srcUploadDir.exists()) {
                        try {
                            Files.copy(destFile.toPath(), Paths.get(srcUploadDir.getAbsolutePath(), newFileName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        } catch (Exception ignored) {}
                    }
                }
                
                video.setPoster(newFileName);
            }
            
            Integer catId = Integer.parseInt(req.getParameter("categoryId"));
            Category_24110375 cat = categoryService.findById(catId);
            video.setCategory(cat);
            
            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Loi he thong: " + e.getMessage());
        }
    }
    
    private void updateVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            String id = req.getParameter("videoId");
            Video_24110375 video = videoService.findById(id);
            if (video != null) {
                video.setTitle(req.getParameter("title"));
                video.setDescription(req.getParameter("description"));
                video.setActive(req.getParameter("active") != null);
                
                Part part = req.getPart("posterFile");
                if (part != null && part.getSize() > 0) {
                    String submittedFileName = part.getSubmittedFileName();
                    if (submittedFileName == null) submittedFileName = "upload.jpg";
                    
                    String fileName = Paths.get(submittedFileName).getFileName().toString();
                    int dotIndex = fileName.lastIndexOf(".");
                    String ext = (dotIndex == -1) ? ".jpg" : fileName.substring(dotIndex);
                    String newFileName = id + "_updated_" + System.currentTimeMillis() + ext;
                    
                    String targetPath = req.getServletContext().getRealPath("/uploads");
                    if (targetPath != null) {
                        File uploadDir = new File(targetPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();
                        File destFile = new File(uploadDir, newFileName);
                        try (java.io.InputStream is = part.getInputStream()) {
                            Files.copy(is, destFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        }
                        
                        File srcUploadDir = new File("d:/QUỐC KHOA/KTQT/24110375_03/src/main/webapp/uploads");
                        if (srcUploadDir.exists()) {
                            try {
                                Files.copy(destFile.toPath(), Paths.get(srcUploadDir.getAbsolutePath(), newFileName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                            } catch (Exception ignored) {}
                        }
                    }
                    
                    video.setPoster(newFileName);
                } else {
                    video.setPoster(req.getParameter("oldPoster"));
                }
                
                Integer catId = Integer.parseInt(req.getParameter("categoryId"));
                Category_24110375 cat = categoryService.findById(catId);
                video.setCategory(cat);
                
                videoService.update(video);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Loi he thong: " + e.getMessage());
        }
    }
}

