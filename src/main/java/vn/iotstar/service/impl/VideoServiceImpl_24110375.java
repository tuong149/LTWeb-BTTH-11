package vn.iotstar.service.impl;

import vn.iotstar.dao.IVideoDao_24110375;
import vn.iotstar.dao.impl.VideoDaoImpl_24110375;
import vn.iotstar.entity.Video_24110375;
import vn.iotstar.service.IVideoService_24110375;
import java.util.List;

public class VideoServiceImpl_24110375 implements IVideoService_24110375 {
    private IVideoDao_24110375 videoDao = new VideoDaoImpl_24110375();

    @Override
    public List<Video_24110375> findAll(int page, int pageSize) {
        return videoDao.findAll(page, pageSize);
    }

    @Override
    public int countAll() {
        return videoDao.countAll();
    }

    @Override
    public Video_24110375 findById(String id) {
        return videoDao.findById(id);
    }

    @Override
    public void insert(Video_24110375 video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video_24110375 video) {
        videoDao.update(video);
    }

    @Override
    public void delete(String id) {
        videoDao.delete(id);
    }

    @Override
    public int countFavorites(String videoId) {
        return videoDao.countFavorites(videoId);
    }

    @Override
    public int countShares(String videoId) {
        return videoDao.countShares(videoId);
    }

    @Override
    public List<Video_24110375> findByCategory(Integer categoryId, int page, int pageSize) {
        return videoDao.findByCategory(categoryId, page, pageSize);
    }

    @Override
    public int countByCategory(Integer categoryId) {
        return videoDao.countByCategory(categoryId);
    }
}

