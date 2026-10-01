package vn.iotstar.dao.impl;

import vn.iotstar.config.JpaConfig_24110375;
import vn.iotstar.dao.IVideoDao_24110375;
import vn.iotstar.entity.Video_24110375;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class VideoDaoImpl_24110375 implements IVideoDao_24110375 {
    @Override
    public List<Video_24110375> findAll(int page, int pageSize) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            TypedQuery<Video_24110375> query = em.createQuery("SELECT v FROM Video_24110375 v ORDER BY v.videoId", Video_24110375.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public int countAll() {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT COUNT(v) FROM Video_24110375 v";
            Long count = em.createQuery(jpql, Long.class).getSingleResult();
            return count.intValue();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public Video_24110375 findById(String id) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            return em.find(Video_24110375.class, id);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void insert(Video_24110375 video) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void update(Video_24110375 video) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            em.merge(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            Video_24110375 video = em.find(Video_24110375.class, id);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public int countFavorites(String videoId) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT COUNT(f) FROM Favorite_24110375 f WHERE f.video.videoId = :vid";
            Long count = em.createQuery(jpql, Long.class).setParameter("vid", videoId).getSingleResult();
            return count.intValue();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public int countShares(String videoId) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT COUNT(s) FROM Share_24110375 s WHERE s.video.videoId = :vid";
            Long count = em.createQuery(jpql, Long.class).setParameter("vid", videoId).getSingleResult();
            return count.intValue();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Video_24110375> findByCategory(Integer categoryId, int page, int pageSize) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT v FROM Video_24110375 v WHERE v.category.categoryId = :catId ORDER BY v.videoId";
            TypedQuery<Video_24110375> query = em.createQuery(jpql, Video_24110375.class);
            query.setParameter("catId", categoryId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public int countByCategory(Integer categoryId) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT COUNT(v) FROM Video_24110375 v WHERE v.category.categoryId = :catId";
            Long count = em.createQuery(jpql, Long.class).setParameter("catId", categoryId).getSingleResult();
            return count.intValue();
        } finally {
            if (em != null) em.close();
        }
    }
}

