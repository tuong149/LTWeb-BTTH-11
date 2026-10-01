package vn.iotstar.dao;

import vn.iotstar.entity.Category_24110375;
import java.util.List;

public interface ICategoryDao_24110375 {
    List<Category_24110375> findAll();
    Category_24110375 findById(Integer id);
}

