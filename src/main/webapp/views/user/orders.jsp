<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Đơn Hàng Của Tôi</title>
    <style>
        .orders-container {
            max-width: 1050px;
            margin: 0 auto;
        }
        .orders-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--navy-hover);
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .orders-header h1 {
            margin: 0;
            color: var(--accent-teal);
            font-size: 1.8rem;
        }
        .order-card {
            background: var(--navy-light);
            border: 1px solid var(--navy-hover);
            border-radius: 12px;
            padding: 22px 25px;
            margin-bottom: 22px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .order-card:hover {
            border-color: rgba(100, 255, 218, 0.35);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.45);
        }
        .order-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--navy-hover);
            padding-bottom: 14px;
            margin-bottom: 16px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .order-id-group {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .order-id-text {
            color: var(--accent-teal);
            font-family: monospace;
            font-size: 1.15rem;
            font-weight: 700;
        }
        .order-date-text {
            color: var(--text-muted);
            font-size: 0.88rem;
        }
        .badge-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .badge-status.PENDING {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.4);
        }
        .badge-status.CONFIRMED {
            background: rgba(37, 99, 235, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(37, 99, 235, 0.4);
        }
        .badge-status.SHIPPING {
            background: rgba(168, 85, 247, 0.15);
            color: #c084fc;
            border: 1px solid rgba(168, 85, 247, 0.4);
        }
        .badge-status.DELIVERED {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.4);
        }
        .badge-status.CANCELLED {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.4);
        }
        .order-recipient-bar {
            background: var(--navy-dark);
            border-radius: 8px;
            padding: 10px 16px;
            font-size: 0.9rem;
            color: var(--text-main);
            margin-bottom: 16px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        .order-items-list {
            border-bottom: 1px solid var(--navy-hover);
            padding-bottom: 14px;
            margin-bottom: 16px;
        }
        .order-item-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 0;
            gap: 15px;
        }
        .item-main {
            display: flex;
            align-items: center;
            gap: 12px;
            flex: 1;
            min-width: 0;
        }
        .item-thumb {
            width: 50px;
            height: 38px;
            object-fit: cover;
            border-radius: 6px;
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
            flex-shrink: 0;
        }
        .item-title-col {
            min-width: 0;
        }
        .item-title-name {
            color: var(--text-bright);
            font-size: 0.92rem;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .order-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .total-amount-box {
            font-size: 1rem;
            color: var(--text-muted);
        }
        .total-amount-box b {
            color: #69db7c;
            font-size: 1.25rem;
            margin-left: 5px;
        }
        .order-btn-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-cancel-order {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.4);
            padding: 7px 16px;
            border-radius: 6px;
            font-size: 0.88rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-cancel-order:hover {
            background: #ef4444;
            color: white;
        }
        .btn-detail-order {
            background: var(--navy-hover);
            color: var(--accent-teal);
            border: 1px solid var(--accent-teal);
            padding: 7px 16px;
            border-radius: 6px;
            font-size: 0.88rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-detail-order:hover {
            background: var(--accent-teal);
            color: var(--navy-dark);
        }
        .empty-orders {
            text-align: center;
            padding: 70px 20px;
            background: var(--navy-light);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
<div class="orders-container">
    <div class="orders-header">
        <h1>📦 Lịch Sử Đơn Hàng</h1>
        <a href="${pageContext.request.contextPath}/home" style="color: var(--accent-teal); text-decoration: none; font-size: 0.95rem;">
            ← Về trang chủ
        </a>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <div style="font-size: 70px; margin-bottom: 20px;">📦</div>
                <h2 style="color: var(--text-bright); margin-bottom: 10px;">Bạn chưa có đơn hàng nào!</h2>
                <p style="color: var(--text-muted); margin-bottom: 30px; font-size: 1.1rem;">
                    Các khóa học bạn đặt mua qua hình thức COD sẽ được lưu lại và hiển thị tại đây.
                </p>
                <a href="${pageContext.request.contextPath}/home" class="btn-submit" style="display: inline-block; width: auto; padding: 12px 30px;">
                    👉 Khám phá khóa học ngay
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-card-header">
                        <div class="order-id-group">
                            <span class="order-id-text">#${order.orderId}</span>
                            <span class="order-date-text">
                                • <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                            </span>
                            <span style="background: rgba(100, 255, 218, 0.1); color: var(--accent-teal); font-size: 0.75rem; padding: 2px 8px; border-radius: 4px; font-weight: 600;">
                                COD
                            </span>
                        </div>

                        <div>
                            <span class="badge-status ${order.orderStatus}">
                                <c:choose>
                                    <c:when test="${order.orderStatus eq 'PENDING'}">🕒 Chờ xác nhận</c:when>
                                    <c:when test="${order.orderStatus eq 'CONFIRMED'}">📋 Đã xác nhận</c:when>
                                    <c:when test="${order.orderStatus eq 'SHIPPING'}">🚚 Đang giao hàng</c:when>
                                    <c:when test="${order.orderStatus eq 'DELIVERED'}">✅ Giao thành công</c:when>
                                    <c:when test="${order.orderStatus eq 'CANCELLED'}">❌ Đã hủy</c:when>
                                    <c:otherwise>${order.orderStatus}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>

                    <div class="order-recipient-bar">
                        <span>👤 Người nhận: <b>${order.recipientName}</b></span>
                        <span>📞 SĐT: <b>${order.phone}</b></span>
                        <span>📍 Địa chỉ: <b>${order.address}</b></span>
                        <c:if test="${not empty order.note}">
                            <span>📝 Ghi chú: <i>${order.note}</i></span>
                        </c:if>
                    </div>

                    <div class="order-items-list">
                        <c:forEach var="detail" items="${order.orderDetails}">
                            <div class="order-item-row">
                                <div class="item-main">
                                    <c:choose>
                                        <c:when test="${not empty detail.video.poster}">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(detail.video.poster, 'http') || fn:startsWith(detail.video.poster, '/')}">
                                                    <img src="${detail.video.poster}" alt="${detail.video.title}" class="item-thumb">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/uploads/${detail.video.poster}" alt="${detail.video.title}" class="item-thumb">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="item-thumb" style="display:flex;align-items:center;justify-content:center;font-size:0.6rem;color:#777;">No img</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="item-title-col">
                                        <div class="item-title-name">${detail.video.title}</div>
                                        <div style="font-size: 0.8rem; color: var(--text-muted);">
                                            Số lượng: <b>${detail.quantity}</b> &times; <fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" /> đ
                                        </div>
                                    </div>
                                </div>
                                <div style="color: #69db7c; font-weight: 600; font-size: 0.95rem;">
                                    <fmt:formatNumber value="${detail.totalPrice}" type="number" groupingUsed="true" /> đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="order-card-footer">
                        <div class="total-amount-box">
                            Tổng thanh toán COD:
                            <b><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> đ</b>
                            <span style="margin-left: 10px; font-size: 0.85rem; color: ${order.paymentStatus eq 'PAID' ? '#34d399' : '#fbbf24'};">
                                (${order.paymentStatus eq 'PAID' ? 'Đã thanh toán' : 'Chưa thanh toán'})
                            </span>
                        </div>

                        <div class="order-btn-group">
                            <a href="${pageContext.request.contextPath}/orders/detail?id=${order.orderId}" class="btn-detail-order">
                                🔍 Xem chi tiết
                            </a>

                            <c:if test="${order.orderStatus eq 'PENDING'}">
                                <button type="button" 
                                        class="btn-cancel-order"
                                        onclick="showConfirmModal('${pageContext.request.contextPath}/orders/cancel?id=${order.orderId}', 'Xác nhận hủy đơn hàng', 'Bạn có chắc chắn muốn hủy đơn hàng #${order.orderId}?');">
                                    ✕ Hủy đơn hàng
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
