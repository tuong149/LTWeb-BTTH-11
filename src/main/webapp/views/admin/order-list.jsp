<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Quản lý Đơn hàng (COD)</title>
    <style>
        .table-wrapper {
            background: var(--navy-light);
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }
        .header-action {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--navy-hover);
            padding-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 14px;
            text-align: left;
            border-bottom: 1px solid var(--navy-hover);
            color: var(--text-main);
            vertical-align: middle;
            font-size: 0.92rem;
        }
        th {
            background-color: var(--navy-hover);
            color: var(--text-bright);
            font-weight: 600;
        }
        .badge-status {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.78rem;
            font-weight: 700;
            display: inline-block;
        }
        .badge-status.PENDING {
            background: rgba(245, 158, 11, 0.2);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.4);
        }
        .badge-status.CONFIRMED {
            background: rgba(37, 99, 235, 0.2);
            color: #60a5fa;
            border: 1px solid rgba(37, 99, 235, 0.4);
        }
        .badge-status.SHIPPING {
            background: rgba(168, 85, 247, 0.2);
            color: #c084fc;
            border: 1px solid rgba(168, 85, 247, 0.4);
        }
        .badge-status.DELIVERED {
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.4);
        }
        .badge-status.CANCELLED {
            background: rgba(239, 68, 68, 0.2);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.4);
        }
        .badge-pay {
            font-size: 0.75rem;
            padding: 2px 7px;
            border-radius: 4px;
            font-weight: 600;
        }
        .badge-pay.UNPAID {
            background: rgba(245, 158, 11, 0.15);
            color: #fbbf24;
        }
        .badge-pay.PAID {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
        }
        .status-select {
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
            color: white;
            padding: 6px 10px;
            border-radius: 5px;
            font-size: 0.85rem;
            cursor: pointer;
        }
        .status-select:focus {
            outline: none;
            border-color: var(--accent-teal);
        }
        .btn-update-status {
            background: var(--accent-teal);
            color: var(--navy-dark);
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s;
            margin-left: 6px;
        }
        .btn-update-status:hover {
            background: #4cd6b3;
        }
        .items-detail-list {
            margin: 0;
            padding-left: 16px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
    </style>
</head>
<body>
<div class="table-wrapper">
    <div class="header-action">
        <h2 style="color: var(--accent-teal); margin: 0;">🚚 Quản lý Đơn hàng (COD)</h2>
        <span style="color: var(--text-muted); font-size: 0.95rem;">
            Tổng số đơn: <b style="color: var(--text-bright);">${fn:length(orders)}</b>
        </span>
    </div>

    <c:if test="${not empty sessionScope.msg}">
        <div style="background: rgba(16, 185, 129, 0.2); border: 1px solid #10b981; color: #34d399; padding: 10px 16px; border-radius: 6px; margin-bottom: 20px;">
            ✅ ${sessionScope.msg}
        </div>
        <c:remove var="msg" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div style="background: rgba(220, 53, 69, 0.2); border: 1px solid #dc3545; color: #ff6b6b; padding: 10px 16px; border-radius: 6px; margin-bottom: 20px;">
            ⚠️ ${sessionScope.error}
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <p style="text-align: center; color: var(--text-muted); padding: 40px 0;">
                Hiện tại chưa có đơn đặt hàng nào trong hệ thống.
            </p>
        </c:when>

        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th style="width: 14%;">Mã Đơn / Ngày</th>
                        <th style="width: 18%;">Người Nhận / Địa Chỉ</th>
                        <th style="width: 24%;">Chi Tiết Khóa Học</th>
                        <th style="width: 14%;">Tổng Tiền (COD)</th>
                        <th style="width: 10%;">Thanh Toán</th>
                        <th style="width: 20%;">Cập Nhật Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>
                                <div style="font-weight: 700; color: var(--accent-teal); font-family: monospace;">#${order.orderId}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted); margin-top: 4px;">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                                <div style="font-size: 0.78rem; color: #8892b0; margin-top: 2px;">
                                    Tài khoản: <b>${order.user.username}</b>
                                </div>
                            </td>

                            <td>
                                <div style="font-weight: 600; color: var(--text-bright);">${order.recipientName}</div>
                                <div style="font-size: 0.85rem; color: #64ffda;">📞 ${order.phone}</div>
                                <div style="font-size: 0.82rem; color: var(--text-muted); margin-top: 3px; line-height: 1.3;">
                                    📍 ${order.address}
                                </div>
                                <c:if test="${not empty order.note}">
                                    <div style="font-size: 0.78rem; color: #a8b2d1; margin-top: 2px;">
                                        <i>Note: ${order.note}</i>
                                    </div>
                                </c:if>
                            </td>

                            <td>
                                <ul class="items-detail-list">
                                    <c:forEach var="detail" items="${order.orderDetails}">
                                        <li>
                                            <b>${detail.video.title}</b> 
                                            (SL: ${detail.quantity} &times; <fmt:formatNumber value="${detail.price}" type="number" /> đ)
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>

                            <td>
                                <div style="font-weight: 700; color: #69db7c; font-size: 1.05rem;">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> đ
                                </div>
                                <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">
                                    Hình thức: <b>COD</b>
                                </div>
                            </td>

                            <td>
                                <span class="badge-pay ${order.paymentStatus}">
                                    ${order.paymentStatus eq 'PAID' ? 'ĐÃ TT' : 'CHƯA TT'}
                                </span>
                            </td>

                            <td>
                                <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" style="display: flex; align-items: center; margin: 0;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <select name="status" class="status-select">
                                        <option value="PENDING" ${order.orderStatus eq 'PENDING' ? 'selected' : ''}>🕒 PENDING</option>
                                        <option value="CONFIRMED" ${order.orderStatus eq 'CONFIRMED' ? 'selected' : ''}>📋 CONFIRMED</option>
                                        <option value="SHIPPING" ${order.orderStatus eq 'SHIPPING' ? 'selected' : ''}>🚚 SHIPPING</option>
                                        <option value="DELIVERED" ${order.orderStatus eq 'DELIVERED' ? 'selected' : ''}>✅ DELIVERED</option>
                                        <option value="CANCELLED" ${order.orderStatus eq 'CANCELLED' ? 'selected' : ''}>❌ CANCELLED</option>
                                    </select>
                                    <button type="submit" class="btn-update-status" title="Cập nhật trạng thái">Lưu</button>
                                </form>
                                <div style="margin-top: 6px;">
                                    <span class="badge-status ${order.orderStatus}">
                                        ${order.orderStatus}
                                    </span>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
