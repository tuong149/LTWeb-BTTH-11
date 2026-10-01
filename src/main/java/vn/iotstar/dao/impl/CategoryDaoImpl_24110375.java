package vn.iotstar.dao.impl;

import vn.iotstar.config.JpaConfig_24110375;
import vn.iotstar.dao.ICategoryDao_24110375;
import vn.iotstar.entity.Category_24110375;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class CategoryDaoImpl_24110375 implements ICategoryDao_24110375 {
    @Override
    public List<Category_24110375> findAll() {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            TypedQuery<Category_24110375> query = em.createQuery("SELECT c FROM Category_24110375 c", Category_24110375.class);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public Category_24110375 findById(Integer id) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            return em.find(Category_24110375.class, id);
        } finally {
            if (em != null) em.close();
        }
    }
}

