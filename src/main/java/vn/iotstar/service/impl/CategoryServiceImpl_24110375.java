package vn.iotstar.service.impl;

import vn.iotstar.dao.ICategoryDao_24110375;
import vn.iotstar.dao.impl.CategoryDaoImpl_24110375;
import vn.iotstar.entity.Category_24110375;
import vn.iotstar.service.ICategoryService_24110375;
import java.util.List;

public class CategoryServiceImpl_24110375 implements ICategoryService_24110375 {
    private ICategoryDao_24110375 categoryDao = new CategoryDaoImpl_24110375();

    @Override
    public List<Category_24110375> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public Category_24110375 findById(Integer id) {
        return categoryDao.findById(id);
    }
}

