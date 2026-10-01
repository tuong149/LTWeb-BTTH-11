<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Đặt hàng & Thanh toán COD</title>
    <style>
        .checkout-container {
            max-width: 1100px;
            margin: 0 auto;
        }
        .checkout-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--navy-hover);
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        .checkout-header h1 {
            margin: 0;
            color: var(--accent-teal);
            font-size: 1.8rem;
        }
        .checkout-grid {
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 30px;
        }
        @media (max-width: 900px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
        }
        .checkout-card {
            background: var(--navy-light);
            border: 1px solid var(--navy-hover);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.35);
            margin-bottom: 25px;
        }
        .card-title {
            color: var(--text-bright);
            font-size: 1.25rem;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid var(--navy-hover);
            padding-bottom: 12px;
        }
        .card-title span.step-num {
            background: var(--accent-blue);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-bright);
            font-size: 0.95rem;
            font-weight: 600;
        }
        .form-group label .req {
            color: #ff6b6b;
        }
        .form-control {
            width: 100%;
            padding: 12px 14px;
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
            border-radius: 8px;
            color: white;
            font-size: 0.95rem;
            box-sizing: border-box;
            transition: all 0.2s;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--accent-teal);
            box-shadow: 0 0 10px rgba(100, 255, 218, 0.25);
            background: #071529;
        }
        textarea.form-control {
            min-height: 80px;
            resize: vertical;
        }
        .payment-method-box {
            border: 2px solid var(--accent-teal);
            background: rgba(100, 255, 218, 0.05);
            border-radius: 10px;
            padding: 16px;
            margin-bottom: 14px;
            display: flex;
            align-items: flex-start;
            gap: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .payment-method-box.disabled {
            border-color: var(--navy-hover);
            background: rgba(255, 255, 255, 0.02);
            opacity: 0.6;
            cursor: not-allowed;
        }
        .radio-indicator {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid var(--accent-teal);
            margin-top: 2px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .radio-indicator::after {
            content: '';
            width: 10px;
            height: 10px;
            background: var(--accent-teal);
            border-radius: 50%;
        }
        .pm-info h4 {
            margin: 0 0 6px 0;
            color: var(--text-bright);
            font-size: 1.05rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .pm-badge {
            background: rgba(100, 255, 218, 0.2);
            color: var(--accent-teal);
            font-size: 0.75rem;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
        }
        .pm-desc {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.88rem;
            line-height: 1.45;
        }
        /* Summary Table */
        .summary-items {
            max-height: 280px;
            overflow-y: auto;
            margin-bottom: 20px;
            padding-right: 5px;
        }
        .summary-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid var(--navy-hover);
        }
        .summary-img {
            width: 55px;
            height: 40px;
            object-fit: cover;
            border-radius: 6px;
            background: var(--navy-dark);
            border: 1px solid var(--navy-hover);
            flex-shrink: 0;
        }
        .summary-info {
            flex: 1;
            min-width: 0;
        }
        .summary-title {
            color: var(--text-bright);
            font-size: 0.9rem;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 3px;
        }
        .summary-qty-price {
            font-size: 0.82rem;
            color: var(--text-muted);
        }
        .summary-line-total {
            color: #69db7c;
            font-weight: 600;
            font-size: 0.92rem;
            white-space: nowrap;
        }
        .cost-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            color: var(--text-muted);
            font-size: 0.95rem;
        }
        .cost-row.total {
            border-top: 2px solid var(--navy-hover);
            margin-top: 10px;
            padding-top: 15px;
            color: var(--text-bright);
            font-size: 1.25rem;
            font-weight: 700;
        }
        .cost-row.total .grand-price {
            color: var(--accent-teal);
            font-size: 1.4rem;
        }
        .btn-order-cod {
            display: block;
            width: 100%;
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 1.15rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.35);
            transition: all 0.25s;
            margin-top: 20px;
            text-align: center;
        }
        .btn-order-cod:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.5);
            filter: brightness(1.1);
        }
        .trust-badge {
            margin-top: 18px;
            padding: 12px;
            background: rgba(100, 255, 218, 0.05);
            border: 1px dashed rgba(100, 255, 218, 0.3);
            border-radius: 8px;
            color: var(--text-muted);
            font-size: 0.85rem;
            line-height: 1.5;
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="checkout-container">
    <div class="checkout-header">
        <h1>🚚 Thanh Toán Đơn Hàng (COD)</h1>
        <a href="${pageContext.request.contextPath}/cart" style="color: var(--accent-teal); text-decoration: none; font-size: 0.95rem;">
            ← Quay lại giỏ hàng
        </a>
    </div>

    <c:if test="${not empty error}">
        <div style="background: rgba(220, 53, 69, 0.2); border: 1px solid #dc3545; color: #ff6b6b; padding: 12px 18px; border-radius: 8px; margin-bottom: 25px;">
            ⚠️ <b>Thông báo:</b> ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkout-form">
        <div class="checkout-grid">
            <!-- Cột trái: Thông tin nhận hàng & Phương thức thanh toán -->
            <div>
                <!-- Bước 1: Thông tin giao hàng -->
                <div class="checkout-card">
                    <h3 class="card-title">
                        <span class="step-num">1</span> Thông tin nhận hàng
                    </h3>

                    <div class="form-group">
                        <label for="recipientName">Họ và tên người nhận <span class="req">*</span></label>
                        <input type="text" id="recipientName" name="recipientName" class="form-control" 
                               value="${not empty recipientName ? recipientName : sessionScope.user.fullname}" 
                               placeholder="VD: Nguyễn Văn A" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại liên hệ <span class="req">*</span></label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="${not empty phone ? phone : sessionScope.user.phone}" 
                               placeholder="VD: 0987654321" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Địa chỉ nhận hàng (Chi tiết) <span class="req">*</span></label>
                        <input type="text" id="address" name="address" class="form-control" 
                               value="${not empty address ? address : ''}" 
                               placeholder="VD: Số 1 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP. HCM" required>
                    </div>

                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="note">Ghi chú cho đơn hàng / Giao hàng</label>
                        <textarea id="note" name="note" class="form-control" 
                                  placeholder="Ghi chú thời gian nhận hàng thuận tiện, chỉ dẫn giao hàng...">${note}</textarea>
                    </div>
                </div>

                <!-- Bước 2: Phương thức thanh toán -->
                <div class="checkout-card">
                    <h3 class="card-title">
                        <span class="step-num">2</span> Phương thức thanh toán
                    </h3>

                    <!-- Phương thức COD -->
                    <div class="payment-method-box">
                        <div class="radio-indicator"></div>
                        <div class="pm-info">
                            <h4>
                                💵 Thanh toán khi nhận hàng (COD)
                                <span class="pm-badge">Khuyên dùng</span>
                            </h4>
                            <p class="pm-desc">
                                Bạn sẽ thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận được giáo trình & mã kích hoạt khóa học tại địa chỉ của bạn.
                            </p>
                        </div>
                    </div>

                    <!-- Phương thức Online (demo disabled) -->
                    <div class="payment-method-box disabled">
                        <div style="width: 20px; height: 20px; border-radius: 50%; border: 2px solid #555; margin-top: 2px;"></div>
                        <div class="pm-info">
                            <h4>
                                💳 Thẻ ATM / Visa / Ví MoMo / VNPay
                                <span style="background: rgba(255, 255, 255, 0.1); color: #8892b0; font-size: 0.75rem; padding: 2px 8px; border-radius: 4px;">Sắp ra mắt</span>
                            </h4>
                            <p class="pm-desc">
                                Cổng thanh toán trực tuyến đang được tích hợp. Vui lòng chọn COD để được phục vụ nhanh nhất!
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cột phải: Tóm tắt đơn hàng -->
            <div>
                <div class="checkout-card" style="position: sticky; top: 20px;">
                    <h3 class="card-title">
                        🛒 Đơn hàng (${sessionScope.cartCount} món)
                    </h3>

                    <div class="summary-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="summary-item">
                                <c:choose>
                                    <c:when test="${not empty item.poster}">
                                        <c:choose>
                                            <c:when test="${fn:startsWith(item.poster, 'http') || fn:startsWith(item.poster, '/')}">
                                                <img src="${item.poster}" alt="${item.title}" class="summary-img">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/uploads/${item.poster}" alt="${item.title}" class="summary-img">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="summary-img" style="display:flex;align-items:center;justify-content:center;font-size:0.6rem;color:#777;">No img</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="summary-info">
                                    <div class="summary-title" title="${item.title}">${item.title}</div>
                                    <div class="summary-qty-price">
                                        SL: <b>${item.quantity}</b> &times; <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" /> đ
                                    </div>
                                </div>
                                <div class="summary-line-total">
                                    <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true" /> đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="cost-row">
                        <span>Tạm tính tiền khóa học:</span>
                        <span style="color: var(--text-bright); font-weight: 600;">
                            <fmt:formatNumber value="${sessionScope.cartGrandTotal}" type="number" groupingUsed="true" /> đ
                        </span>
                    </div>

                    <div class="cost-row">
                        <span>Phí vận chuyển bưu tá (COD):</span>
                        <span style="color: #69db7c; font-weight: 600;">Miễn phí (0 đ)</span>
                    </div>

                    <div class="cost-row total">
                        <span>Tổng thanh toán COD:</span>
                        <span class="grand-price">
                            <fmt:formatNumber value="${sessionScope.cartGrandTotal}" type="number" groupingUsed="true" /> đ
                        </span>
                    </div>

                    <button type="submit" class="btn-order-cod" id="btn-submit-order">
                        🚀 Xác nhận đặt hàng (COD)
                    </button>

                    <div class="trust-badge">
                        <span>🛡️</span>
                        <span>Được kiểm tra tài liệu trước khi thanh toán. Đảm bảo hỗ trợ kỹ thuật và quyền lợi người học.</span>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>
