<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Đặt hàng thành công! - #${order.orderId}</title>
    <style>
        .success-container {
            max-width: 900px;
            margin: 0 auto;
            text-align: center;
        }
        .success-banner {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(100, 255, 218, 0.05));
            border: 1px solid rgba(16, 185, 129, 0.4);
            border-radius: 16px;
            padding: 40px 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }
        .success-icon-wrap {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(16, 185, 129, 0.2);
            border: 2px solid #10b981;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            box-shadow: 0 0 25px rgba(16, 185, 129, 0.4);
        }
        .success-icon-wrap svg {
            width: 44px;
            height: 44px;
            color: #10b981;
        }
        .success-title {
            color: #10b981;
            font-size: 2rem;
            margin: 0 0 10px 0;
            font-weight: 700;
        }
        .success-subtitle {
            color: var(--text-muted);
            font-size: 1.05rem;
            margin: 0;
        }
        .order-box {
            background: var(--navy-light);
            border: 1px solid var(--navy-hover);
            border-radius: 12px;
            padding: 30px;
            text-align: left;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.35);
            margin-bottom: 30px;
        }
        .order-meta-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            border-bottom: 1px solid var(--navy-hover);
            padding-bottom: 25px;
            margin-bottom: 25px;
        }
        .meta-group label {
            display: block;
            color: var(--text-muted);
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }
        .meta-group span {
            color: var(--text-bright);
            font-size: 1rem;
            font-weight: 600;
        }
        .badge-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }
        .badge-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.4);
        }
        .badge-unpaid {
            background: rgba(245, 158, 11, 0.2);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.4);
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .order-table th, .order-table td {
            padding: 12px 14px;
            border-bottom: 1px solid var(--navy-hover);
            color: var(--text-main);
            font-size: 0.95rem;
        }
        .order-table th {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-transform: uppercase;
            text-align: left;
            background: var(--navy-hover);
        }
        .order-item-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .order-item-img {
            width: 60px;
            height: 45px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid var(--navy-hover);
            background: var(--navy-dark);
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        .btn-order-view {
            background: var(--accent-blue);
            color: white;
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.35);
        }
        .btn-order-view:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }
        .btn-home-back {
            background: var(--navy-hover);
            color: var(--text-bright);
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            border: 1px solid var(--navy-hover);
            transition: all 0.2s;
        }
        .btn-home-back:hover {
            background: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="success-banner">
        <div class="success-icon-wrap">
            <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
        </div>
        <h1 class="success-title">Đặt hàng thành công!</h1>
        <p class="success-subtitle">
            Cảm ơn bạn đã lựa chọn khóa học của UTEVideo. Đơn hàng COD của bạn đang được tiến hành xử lý.
        </p>
    </div>

    <div class="order-box">
        <div class="order-meta-grid">
            <div class="meta-group">
                <label>Mã đơn hàng</label>
                <span style="color: var(--accent-teal); font-family: monospace; font-size: 1.1rem;">#${order.orderId}</span>
            </div>
            <div class="meta-group">
                <label>Thời gian đặt</label>
                <span><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></span>
            </div>
            <div class="meta-group">
                <label>Phương thức thanh toán</label>
                <span>💵 Thanh toán khi nhận (COD)</span>
            </div>
            <div class="meta-group">
                <label>Trạng thái đơn hàng</label>
                <span><span class="badge-status badge-pending">🕒 Chờ xác nhận</span></span>
            </div>
        </div>

        <div style="background: var(--navy-dark); padding: 18px 20px; border-radius: 8px; margin-bottom: 25px; border: 1px solid var(--navy-hover);">
            <h4 style="color: var(--text-bright); margin-top: 0; margin-bottom: 12px; font-size: 1.05rem;">
                📍 Thông tin nhận hàng (COD)
            </h4>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-size: 0.95rem; color: var(--text-main);">
                <div>Người nhận: <b>${order.recipientName}</b></div>
                <div>Điện thoại: <b>${order.phone}</b></div>
                <div style="grid-column: 1 / -1;">Địa chỉ: <b>${order.address}</b></div>
                <c:if test="${not empty order.note}">
                    <div style="grid-column: 1 / -1; color: var(--text-muted);">Ghi chú: <i>${order.note}</i></div>
                </c:if>
            </div>
        </div>

        <h4 style="color: var(--text-bright); margin-bottom: 15px;">📦 Danh sách khóa học đặt mua</h4>
        <table class="order-table">
            <thead>
                <tr>
                    <th>Khóa học</th>
                    <th style="text-align: center;">Số lượng</th>
                    <th style="text-align: right;">Đơn giá</th>
                    <th style="text-align: right;">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detail" items="${order.orderDetails}">
                    <tr>
                        <td>
                            <div class="order-item-wrap">
                                <c:choose>
                                    <c:when test="${not empty detail.video.poster}">
                                        <c:choose>
                                            <c:when test="${fn:startsWith(detail.video.poster, 'http') || fn:startsWith(detail.video.poster, '/')}">
                                                <img src="${detail.video.poster}" alt="${detail.video.title}" class="order-item-img">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/uploads/${detail.video.poster}" alt="${detail.video.title}" class="order-item-img">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="order-item-img" style="display:flex;align-items:center;justify-content:center;font-size:0.6rem;color:#777;">No img</div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div style="font-weight: 600; color: var(--text-bright);">${detail.video.title}</div>
                                    <div style="font-size: 0.8rem; color: var(--text-muted);">Mã: ${detail.video.videoId}</div>
                                </div>
                            </div>
                        </td>
                        <td style="text-align: center; font-weight: bold;">${detail.quantity}</td>
                        <td style="text-align: right;"><fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" /> đ</td>
                        <td style="text-align: right; color: #69db7c; font-weight: 600;">
                            <fmt:formatNumber value="${detail.totalPrice}" type="number" groupingUsed="true" /> đ
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px; margin-top: 15px; border-top: 1px solid var(--navy-hover); padding-top: 15px;">
            <span style="font-size: 1.1rem; color: var(--text-bright); font-weight: 600;">Tổng tiền thu hộ (COD):</span>
            <span style="font-size: 1.5rem; color: var(--accent-teal); font-weight: 700;">
                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> đ
            </span>
        </div>
    </div>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/orders" class="btn-order-view">
            📦 Quản lý đơn hàng của tôi
        </a>
        <a href="${pageContext.request.contextPath}/home" class="btn-home-back">
            🏠 Tiếp tục mua sắm
        </a>
    </div>
</div>
</body>
</html>
