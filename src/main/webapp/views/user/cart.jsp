<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
    <style>
        .cart-container {
            max-width: 1100px;
            margin: 0 auto;
        }
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--navy-hover);
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .cart-header h1 {
            margin: 0;
            color: var(--accent-teal);
            font-size: 1.8rem;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--navy-light);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            margin-bottom: 30px;
        }
        .cart-table th, .cart-table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid var(--navy-hover);
            color: var(--text-main);
            vertical-align: middle;
        }
        .cart-table th {
            background-color: var(--navy-hover);
            color: var(--text-bright);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        .item-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .item-img {
            width: 75px;
            height: 55px;
            object-fit: cover;
            border-radius: 6px;
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
        }
        .item-title {
            font-weight: 600;
            color: var(--text-bright);
            margin-bottom: 4px;
        }
        .item-id {
            font-size: 0.8rem;
            color: var(--text-muted);
        }
        .qty-control {
            display: inline-flex;
            align-items: center;
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
            border-radius: 6px;
            overflow: hidden;
        }
        .btn-qty {
            background: transparent;
            color: var(--text-bright);
            border: none;
            width: 32px;
            height: 34px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-qty:hover:not(:disabled) {
            background: var(--accent-blue);
            color: white;
        }
        .btn-qty:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }
        .qty-input {
            width: 45px;
            height: 34px;
            text-align: center;
            background: transparent;
            border: none;
            border-left: 1px solid var(--navy-hover);
            border-right: 1px solid var(--navy-hover);
            color: white;
            font-weight: bold;
            font-size: 0.95rem;
        }
        .qty-input:focus {
            outline: none;
            background: rgba(100, 255, 218, 0.05);
        }
        .btn-save-qty {
            padding: 5px 8px;
            margin-left: 8px;
            background: var(--navy-hover);
            border: 1px solid var(--accent-teal);
            color: var(--accent-teal);
            border-radius: 4px;
            font-size: 0.75rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-save-qty:hover {
            background: var(--accent-teal);
            color: var(--navy-dark);
        }
        .btn-del {
            background: rgba(220, 53, 69, 0.15);
            color: #ff6b6b;
            border: 1px solid #ff6b6b;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-del:hover {
            background: #dc3545;
            color: white;
        }
        .cart-summary {
            background: var(--navy-light);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .summary-info {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        .summary-total {
            font-size: 1.5rem;
            color: var(--text-bright);
        }
        .summary-total b {
            color: var(--accent-teal);
            font-size: 1.8rem;
        }
        .cart-actions {
            display: flex;
            gap: 12px;
        }
        .btn-clear {
            background: rgba(255, 107, 107, 0.15);
            color: #ff6b6b;
            border: 1px solid #ff6b6b;
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-clear:hover {
            background: #ff6b6b;
            color: white;
        }
        .btn-continue {
            background: var(--navy-hover);
            color: var(--text-main);
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-continue:hover {
            background: #2f456c;
            color: white;
        }
        .btn-checkout {
            background: var(--accent-blue);
            color: white;
            padding: 10px 25px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.05rem;
            border: none;
            cursor: pointer;
        }
        .btn-checkout:hover {
            background: #2563eb;
        }
        .empty-cart {
            text-align: center;
            padding: 70px 20px;
            background: var(--navy-light);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
        .empty-cart .icon {
            font-size: 70px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="cart-container">
    <div class="cart-header">
        <h1>🛒 Giỏ Hàng Của Bạn</h1>
        <span style="color: var(--text-muted); font-size: 0.95rem;">
            Giới hạn số lượng mỗi món: <b>1 - 10</b> sản phẩm
        </span>
    </div>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-cart">
                <div class="icon">🛒</div>
                <h2 style="color: var(--text-bright); margin-bottom: 10px;">Giỏ hàng của bạn đang trống!</h2>
                <p style="color: var(--text-muted); margin-bottom: 30px; font-size: 1.1rem;">
                    Bạn chưa chọn khóa học nào. Hãy khám phá danh sách bài học và thêm vào giỏ nhé.
                </p>
                <a href="${pageContext.request.contextPath}/home" class="btn-submit" style="display: inline-block; width: auto; padding: 12px 30px;">
                    👉 Khám phá khóa học ngay
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th style="width: 40%;">Khóa học / Video</th>
                        <th style="width: 15%;">Đơn giá</th>
                        <th style="width: 25%;">Số lượng (Min: 1 - Max: 10)</th>
                        <th style="width: 12%;">Thành tiền</th>
                        <th style="width: 8%; text-align: center;">Xóa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>
                                <div class="item-info">
                                    <c:choose>
                                        <c:when test="${not empty item.poster}">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(item.poster, 'http') || fn:startsWith(item.poster, '/')}">
                                                    <img src="${item.poster}" alt="${item.title}" class="item-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/uploads/${item.poster}" alt="${item.title}" class="item-img">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="item-img" style="display:flex;align-items:center;justify-content:center;font-size:0.7rem;color:#777;">No img</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <div class="item-title">${item.title}</div>
                                        <div class="item-id">Mã: ${item.videoId}</div>
                                    </div>
                                </div>
                            </td>

                            <td style="color: var(--accent-teal); font-weight: 600;">
                                <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" /> đ
                            </td>

                            <td>
                                <div style="display: flex; align-items: center;">
                                    <%-- Nút giảm (-) --%>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" style="margin:0; display:inline;">
                                        <input type="hidden" name="id" value="${item.videoId}">
                                        <input type="hidden" name="action" value="decrease">
                                        <button type="submit" class="btn-qty" style="border-radius: 6px 0 0 6px; background: var(--navy-dark); border: 1px solid var(--navy-hover);" ${item.quantity <= 1 ? 'disabled title=\"Số lượng tối thiểu là 1\"' : ''}>-</button>
                                    </form>

                                    <%-- Ô nhập trực tiếp số lượng --%>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" style="margin:0; display:flex; align-items:center;">
                                        <input type="hidden" name="id" value="${item.videoId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="10" class="qty-input" style="border: 1px solid var(--navy-hover); border-left:none; border-right:none;" required>
                                        
                                        <%-- Nút tăng (+) --%>
                                        <button type="submit" name="action" value="increase" class="btn-qty" style="border-radius: 0 6px 6px 0; background: var(--navy-dark); border: 1px solid var(--navy-hover);" ${item.quantity >= 10 ? 'disabled title=\"Số lượng tối đa là 10\"' : ''}>+</button>

                                        <button type="submit" class="btn-save-qty" title="Lưu số lượng nhập">Lưu</button>
                                    </form>
                                </div>
                            </td>

                            <td style="color: #69db7c; font-weight: bold; font-size: 1.05rem;">
                                <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true" /> đ
                            </td>

                            <td style="text-align: center;">
                                <a href="javascript:void(0);" 
                                   class="btn-del" 
                                   onclick="showConfirmModal('${pageContext.request.contextPath}/cart/delete?id=${item.videoId}', 'Xác nhận xóa khóa học', 'Bạn có chắc chắn muốn bỏ khóa học &quot;${fn:escapeXml(item.title)}&quot; khỏi giỏ hàng?');" 
                                   title="Xóa món này">✕</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <%-- Tổng kết giỏ hàng --%>
            <div class="cart-summary">
                <div class="summary-info">
                    <span style="color: var(--text-muted); font-size: 1.05rem;">
                        Số lượng: <b style="color: var(--text-bright); font-size: 1.2rem;">${sessionScope.cartCount}</b> món
                    </span>
                    <span class="summary-total">
                        Tổng thanh toán: <b><fmt:formatNumber value="${sessionScope.cartGrandTotal}" type="number" groupingUsed="true" /> đ</b>
                    </span>
                </div>

                <div class="cart-actions">
                    <a href="javascript:void(0);" 
                       class="btn-clear" 
                       onclick="showConfirmModal('${pageContext.request.contextPath}/cart/clear', 'Xác nhận xóa toàn bộ', 'Bạn có chắc chắn muốn xóa TOÀN BỘ khóa học trong giỏ hàng không?');">
                        🗑️ Xóa tất cả
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="btn-continue">
                        ⬅ Xem thêm khóa học
                    </a>
                    <button type="button" class="btn-checkout" onclick="showToast('success', 'Thanh toán thành công', 'Đơn hàng của bạn đã được ghi nhận thành công! Tổng tiền: <fmt:formatNumber value="${sessionScope.cartGrandTotal}" type="number" groupingUsed="true" /> đ');">
                        💳 Thanh toán ngay
                    </button>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
