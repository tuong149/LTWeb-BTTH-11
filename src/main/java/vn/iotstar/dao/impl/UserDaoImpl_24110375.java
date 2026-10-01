package vn.iotstar.dao.impl;

import vn.iotstar.config.JpaConfig_24110375;
import vn.iotstar.dao.IUserDao_24110375;
import vn.iotstar.entity.User_24110375;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class UserDaoImpl_24110375 implements IUserDao_24110375 {

    @Override
    public User_24110375 findByUsername(String username) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            return em.find(User_24110375.class, username);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public User_24110375 findByEmail(String email) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT u FROM User_24110375 u WHERE u.email = :email";
            TypedQuery<User_24110375> query = em.createQuery(jpql, User_24110375.class);
            query.setParameter("email", email);
            List<User_24110375> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void insert(User_24110375 user) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void update(User_24110375 user) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }
}

