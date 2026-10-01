package vn.iotstar.controller;

import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.IVideoService_24110375;
import vn.iotstar.service.impl.VideoServiceImpl_24110375;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/video/detail")
public class VideoDetailController_24110375 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IVideoService_24110375 videoService = new VideoServiceImpl_24110375();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null || id.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        Video_24110375 video = videoService.findById(id);
        if (video == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Video không tồn tại!");
            return;
        }

        video.setViews(video.getViews() + 1);
        videoService.update(video);

        int likeCount = videoService.countFavorites(id);
        int shareCount = videoService.countShares(id);

        req.setAttribute("video", video);
        req.setAttribute("likeCount", likeCount);
        req.setAttribute("shareCount", shareCount);

        req.getRequestDispatcher("/views/user/video-detail.jsp").forward(req, resp);
    }
}

