package vn.iotstar.dao.impl;

import vn.iotstar.config.JpaConfig_24110375;
import vn.iotstar.dao.IOrderDao_24110375;
import vn.iotstar.entity.Order_24110375;
import vn.iotstar.entity.OrderDetail_24110375;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class OrderDaoImpl_24110375 implements IOrderDao_24110375 {

    @Override
    public void insert(Order_24110375 order) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();

            em.persist(order);
            if (order.getOrderDetails() != null) {
                for (OrderDetail_24110375 detail : order.getOrderDetails()) {
                    detail.setOrder(order);
                    em.persist(detail);
                }
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
    public void update(Order_24110375 order) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();
            em.merge(order);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public Order_24110375 findById(String orderId) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT DISTINCT o FROM Order_24110375 o " +
                          "LEFT JOIN FETCH o.orderDetails od " +
                          "LEFT JOIN FETCH od.video " +
                          "WHERE o.orderId = :orderId";
            TypedQuery<Order_24110375> query = em.createQuery(jpql, Order_24110375.class);
            query.setParameter("orderId", orderId);
            List<Order_24110375> list = query.getResultList();
            if (!list.isEmpty()) {
                return list.get(0);
            }
            return em.find(Order_24110375.class, orderId);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Order_24110375> findByUsername(String username) {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT o FROM Order_24110375 o WHERE o.user.username = :username ORDER BY o.orderDate DESC";
            TypedQuery<Order_24110375> query = em.createQuery(jpql, Order_24110375.class);
            query.setParameter("username", username);
            List<Order_24110375> list = query.getResultList();
            for (Order_24110375 o : list) {
                if (o.getOrderDetails() != null) {
                    o.getOrderDetails().size(); // touch collection to load
                }
            }
            return list;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<Order_24110375> findAll() {
        EntityManager em = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            String jpql = "SELECT o FROM Order_24110375 o ORDER BY o.orderDate DESC";
            TypedQuery<Order_24110375> query = em.createQuery(jpql, Order_24110375.class);
            List<Order_24110375> list = query.getResultList();
            for (Order_24110375 o : list) {
                if (o.getOrderDetails() != null) {
                    o.getOrderDetails().size();
                }
            }
            return list;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public boolean updateStatus(String orderId, String orderStatus, String paymentStatus) {
        EntityManager em = null;
        EntityTransaction trans = null;
        try {
            em = JpaConfig_24110375.getEntityManager();
            trans = em.getTransaction();
            trans.begin();

            Order_24110375 order = em.find(Order_24110375.class, orderId);
            if (order != null) {
                if (orderStatus != null && !orderStatus.isEmpty()) {
                    order.setOrderStatus(orderStatus);
                }
                if (paymentStatus != null && !paymentStatus.isEmpty()) {
                    order.setPaymentStatus(paymentStatus);
                }
                em.merge(order);
                trans.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (trans != null && trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (em != null) em.close();
        }
    }
}
