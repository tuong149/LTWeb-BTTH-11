package vn.iotstar.service;

import vn.iotstar.entity.Video_24110375;
import java.util.List;

public interface IVideoService_24110375 {
    List<Video_24110375> findAll(int page, int pageSize);
    int countAll();
    Video_24110375 findById(String id);
    void insert(Video_24110375 video);
    void update(Video_24110375 video);
    void delete(String id);
    int countFavorites(String videoId);
    int countShares(String videoId);
    List<Video_24110375> findByCategory(Integer categoryId, int page, int pageSize);
    int countByCategory(Integer categoryId);
}

