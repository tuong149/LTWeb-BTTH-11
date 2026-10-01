<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title' /> - UTEVideo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
    <style>
        /* ==============================================================
           TOAST NOTIFICATION (CỐ ĐỊNH GÓC TRÊN CÙNG BÊN PHẢI)
           ============================================================== */
        #toast-container {
            position: fixed !important;
            top: 24px !important;
            right: 24px !important;
            z-index: 9999999 !important;
            display: flex !important;
            flex-direction: column !important;
            gap: 12px !important;
            pointer-events: none !important;
        }

        .toast-item {
            pointer-events: auto !important;
            min-width: 320px !important;
            max-width: 420px !important;
            background: rgba(17, 34, 64, 0.96) !important;
            backdrop-filter: blur(12px) !important;
            -webkit-backdrop-filter: blur(12px) !important;
            border-radius: 12px !important;
            padding: 14px 16px !important;
            display: flex !important;
            align-items: center !important;
            gap: 14px !important;
            box-shadow: 0 12px 35px rgba(2, 12, 27, 0.6), 0 0 1px rgba(255, 255, 255, 0.15) !important;
            border: 1px solid rgba(255, 255, 255, 0.08) !important;
            border-left: 5px solid #64ffda !important;
            color: #e6f1ff !important;
            position: relative !important;
            overflow: hidden !important;
            animation: toastSlideIn 0.35s cubic-bezier(0.16, 1, 0.3, 1) forwards !important;
            transition: all 0.3s ease !important;
        }

        .toast-item.toast-success {
            border-left-color: #64ffda !important;
        }
        .toast-item.toast-warning {
            border-left-color: #ffd166 !important;
        }
        .toast-item.toast-error {
            border-left-color: #ff6b6b !important;
        }

        .toast-item.hide {
            animation: toastSlideOut 0.35s forwards !important;
        }

        .toast-icon {
            width: 36px !important;
            height: 36px !important;
            border-radius: 50% !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            flex-shrink: 0 !important;
            background: rgba(100, 255, 218, 0.12) !important;
            color: #64ffda !important;
        }
        .toast-item.toast-warning .toast-icon {
            background: rgba(255, 209, 102, 0.15) !important;
            color: #ffd166 !important;
        }
        .toast-item.toast-error .toast-icon {
            background: rgba(255, 107, 107, 0.15) !important;
            color: #ff6b6b !important;
        }

        .toast-content {
            flex: 1 !important;
            text-align: left !important;
        }

        .toast-title {
            font-weight: 700 !important;
            font-size: 0.95rem !important;
            margin-bottom: 2px !important;
            color: #ffffff !important;
            letter-spacing: -0.2px !important;
        }

        .toast-desc {
            font-size: 0.85rem !important;
            color: #a8b2d1 !important;
            line-height: 1.4 !important;
        }

        .toast-close {
            background: transparent !important;
            border: none !important;
            color: #8892b0 !important;
            font-size: 1.1rem !important;
            cursor: pointer !important;
            padding: 4px 6px !important;
            line-height: 1 !important;
            border-radius: 4px !important;
            transition: all 0.2s !important;
        }
        .toast-close:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.1) !important;
        }

        .toast-progress {
            position: absolute !important;
            bottom: 0 !important;
            left: 0 !important;
            height: 3px !important;
            background: #64ffda !important;
            width: 100% !important;
            animation: toastProgress 3.5s linear forwards !important;
        }
        .toast-item.toast-warning .toast-progress {
            background: #ffd166 !important;
        }
        .toast-item.toast-error .toast-progress {
            background: #ff6b6b !important;
        }

        @keyframes toastSlideIn {
            from {
                opacity: 0;
                transform: translateX(110%);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes toastSlideOut {
            from {
                opacity: 1;
                transform: translateX(0);
            }
            to {
                opacity: 0;
                transform: translateX(110%);
            }
        }

        @keyframes toastProgress {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* ==============================================================
           MODAL POPUP YÊU CẦU ĐĂNG NHẬP (PREMIUM GLASS DIALOG)
           ============================================================== */
        .auth-modal-overlay {
            position: fixed !important;
            inset: 0 !important;
            background: rgba(5, 12, 24, 0.82) !important;
            backdrop-filter: blur(8px) !important;
            -webkit-backdrop-filter: blur(8px) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            z-index: 10000000 !important;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.25s ease, visibility 0.25s ease !important;
        }

        .auth-modal-overlay.active {
            opacity: 1 !important;
            visibility: visible !important;
        }

        .auth-modal-card {
            background: linear-gradient(150deg, #132743, #0a192f) !important;
            border: 1px solid rgba(100, 255, 218, 0.25) !important;
            border-radius: 20px !important;
            padding: 36px 32px !important;
            width: 440px !important;
            max-width: 90vw !important;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.75), 0 0 35px rgba(100, 255, 218, 0.12) !important;
            text-align: center !important;
            position: relative !important;
            transform: scale(0.92) translateY(15px);
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275) !important;
        }

        .auth-modal-overlay.active .auth-modal-card {
            transform: scale(1) translateY(0) !important;
        }

        .auth-modal-close {
            position: absolute !important;
            top: 16px !important;
            right: 18px !important;
            background: transparent !important;
            border: none !important;
            color: #8892b0 !important;
            font-size: 18px !important;
            cursor: pointer !important;
            width: 32px !important;
            height: 32px !important;
            border-radius: 50% !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            transition: all 0.2s !important;
        }
        .auth-modal-close:hover {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.1) !important;
        }

        .auth-modal-badge {
            width: 70px !important;
            height: 70px !important;
            margin: 0 auto 18px !important;
            background: rgba(100, 255, 218, 0.1) !important;
            border: 2px solid #64ffda !important;
            border-radius: 50% !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            box-shadow: 0 0 25px rgba(100, 255, 218, 0.25) !important;
        }

        .auth-modal-title {
            font-size: 1.4rem !important;
            font-weight: 700 !important;
            color: #ffffff !important;
            margin: 0 0 8px 0 !important;
            letter-spacing: -0.3px !important;
        }

        .auth-modal-text {
            font-size: 0.95rem !important;
            color: #8892b0 !important;
            line-height: 1.6 !important;
            margin: 0 0 26px 0 !important;
        }

        .auth-modal-actions {
            display: flex !important;
            gap: 12px !important;
            justify-content: center !important;
        }

        .auth-modal-btn-primary {
            background: linear-gradient(135deg, #64ffda, #00b4d8) !important;
            color: #0a192f !important;
            font-weight: 700 !important;
            font-size: 0.95rem !important;
            padding: 12px 24px !important;
            border-radius: 10px !important;
            border: none !important;
            text-decoration: none !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
            box-shadow: 0 8px 20px rgba(100, 255, 218, 0.25) !important;
            cursor: pointer !important;
            flex: 1 !important;
            transition: all 0.2s ease !important;
        }
        .auth-modal-btn-primary:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 12px 25px rgba(100, 255, 218, 0.4) !important;
            filter: brightness(1.08) !important;
        }

        .auth-modal-btn-secondary {
            background: rgba(255, 255, 255, 0.06) !important;
            color: #ccd6f6 !important;
            font-weight: 500 !important;
            font-size: 0.95rem !important;
            padding: 12px 20px !important;
            border-radius: 10px !important;
            border: 1px solid rgba(255, 255, 255, 0.12) !important;
            cursor: pointer !important;
            transition: all 0.2s ease !important;
        }
        .auth-modal-btn-secondary:hover {
            background: rgba(255, 255, 255, 0.12) !important;
            color: #ffffff !important;
        }

        /* ==============================================================
           DẤU HIỆU NHẬN BIẾT SẢN PHẨM TRONG GIỎ HÀNG (CARD & BUTTON)
           ============================================================== */
        .video-card.in-cart {
            border-color: rgba(100, 255, 218, 0.5) !important;
            box-shadow: 0 8px 25px rgba(100, 255, 218, 0.15) !important;
        }

        .poster-container {
            position: relative !important;
            width: 100% !important;
            height: 200px !important;
            overflow: hidden !important;
        }

        .cart-indicator-badge {
            display: none !important;
            position: absolute !important;
            top: 10px !important;
            right: 10px !important;
            background: linear-gradient(135deg, #059669, #10b981) !important;
            color: #ffffff !important;
            font-size: 0.8rem !important;
            font-weight: 700 !important;
            padding: 5px 12px !important;
            border-radius: 20px !important;
            align-items: center !important;
            gap: 6px !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.6), 0 0 12px rgba(16, 185, 129, 0.4) !important;
            border: 1px solid rgba(255, 255, 255, 0.25) !important;
            z-index: 5 !important;
            transition: transform 0.2s ease !important;
        }

        .video-card.in-cart .cart-indicator-badge {
            display: flex !important;
        }

        /* Nút thêm vào giỏ và Bộ điều khiển tăng giảm số lượng (+ / -) */
        .btn-add-cart-init {
            display: block !important;
        }
        .cart-qty-control {
            display: none !important;
            align-items: center !important;
            justify-content: space-between !important;
            background: #112240 !important;
            border: 1px solid rgba(100, 255, 218, 0.4) !important;
            border-radius: 8px !important;
            padding: 4px !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4) !important;
        }
        .video-card.in-cart .btn-add-cart-init {
            display: none !important;
        }
        .video-card.in-cart .cart-qty-control {
            display: flex !important;
        }

        .btn-qty-action {
            width: 36px !important;
            height: 36px !important;
            border-radius: 6px !important;
            background: #1e3a5f !important;
            color: #64ffda !important;
            border: 1px solid rgba(100, 255, 218, 0.3) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            transition: all 0.2s ease !important;
        }
        .btn-qty-action:hover:not(:disabled) {
            background: #64ffda !important;
            color: #0a192f !important;
            transform: scale(1.05) !important;
        }
        .btn-qty-minus {
            color: #ff6b6b !important;
            border-color: rgba(255, 107, 107, 0.3) !important;
        }
        .btn-qty-minus:hover:not(:disabled) {
            background: #ff6b6b !important;
            color: #ffffff !important;
        }
        .btn-qty-action:disabled {
            opacity: 0.35 !important;
            cursor: not-allowed !important;
            transform: none !important;
        }

        .qty-display {
            display: flex !important;
            flex-direction: column !important;
            align-items: center !important;
            justify-content: center !important;
            padding: 0 8px !important;
            user-select: none !important;
        }
        .qty-num {
            font-size: 1.15rem !important;
            font-weight: 700 !important;
            color: #ffffff !important;
            line-height: 1.1 !important;
        }
        .qty-label {
            font-size: 0.65rem !important;
            color: #8892b0 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
        }
    </style>
    <sitemesh:write property='head' />
</head>
<body>
    <!-- TOAST NOTIFICATION CONTAINER (GÓC TRÊN CÙNG BÊN PHẢI) -->
    <div id="toast-container">
        <c:if test="${not empty sessionScope.cartSuccess}">
            <div class="toast-item toast-success">
                <div class="toast-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                    </svg>
                </div>
                <div class="toast-content">
                    <div class="toast-title">Thành công!</div>
                    <div class="toast-desc">${sessionScope.cartSuccess}</div>
                </div>
                <button class="toast-close" onclick="this.parentElement.remove()">✕</button>
                <div class="toast-progress"></div>
            </div>
            <% session.removeAttribute("cartSuccess"); %>
        </c:if>
        <c:if test="${not empty sessionScope.cartMessage}">
            <div class="toast-item toast-warning">
                <div class="toast-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                        <line x1="12" y1="9" x2="12" y2="13"></line>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                </div>
                <div class="toast-content">
                    <div class="toast-title">Thông báo</div>
                    <div class="toast-desc">${sessionScope.cartMessage}</div>
                </div>
                <button class="toast-close" onclick="this.parentElement.remove()">✕</button>
                <div class="toast-progress"></div>
            </div>
            <% session.removeAttribute("cartMessage"); %>
        </c:if>
    </div>

    <!-- AUTH REQUIRED MODAL DIALOG (HIỂN THỊ KHI CHƯA ĐĂNG NHẬP) -->
    <div id="auth-modal" class="auth-modal-overlay" onclick="if(event.target===this) closeAuthModal();">
        <div class="auth-modal-card">
            <button type="button" class="auth-modal-close" onclick="closeAuthModal()" title="Đóng">✕</button>
            <div class="auth-modal-badge">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#64ffda" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
            </div>
            <h3 class="auth-modal-title">Yêu cầu đăng nhập</h3>
            <p class="auth-modal-text" id="auth-modal-msg">
                Bạn cần đăng nhập tài khoản UTEVideo để có thể thêm khóa học vào giỏ hàng và thanh toán!
            </p>
            <div class="auth-modal-actions">
                <a href="${pageContext.request.contextPath}/login" class="auth-modal-btn-primary" id="auth-modal-login-btn">
                    🔑 Đăng nhập ngay
                </a>
                <button type="button" class="auth-modal-btn-secondary" onclick="closeAuthModal()">
                    Để sau
                </button>
            </div>
        </div>
    </div>

    <!-- CONFIRMATION MODAL DIALOG (XÁC NHẬN XÓA ĐƠN HÀNG CỰC ĐẸP) -->
    <div id="confirm-modal" class="auth-modal-overlay" onclick="if(event.target===this) closeConfirmModal();">
        <div class="auth-modal-card" style="border-color: rgba(255, 107, 107, 0.35); box-shadow: 0 25px 60px rgba(0, 0, 0, 0.75), 0 0 35px rgba(255, 107, 107, 0.15);">
            <button type="button" class="auth-modal-close" onclick="closeConfirmModal()" title="Đóng">✕</button>
            <div class="auth-modal-badge" style="background: rgba(255, 107, 107, 0.12); border-color: #ff6b6b; box-shadow: 0 0 25px rgba(255, 107, 107, 0.25);">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#ff6b6b" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                </svg>
            </div>
            <h3 class="auth-modal-title" id="confirm-modal-title">Xác nhận xóa</h3>
            <p class="auth-modal-text" id="confirm-modal-msg">
                Bạn có chắc chắn muốn bỏ khóa học này khỏi giỏ hàng?
            </p>
            <div class="auth-modal-actions">
                <a href="#" class="auth-modal-btn-primary" id="confirm-modal-btn" style="background: linear-gradient(135deg, #ef4444, #dc2626); color: white; box-shadow: 0 8px 20px rgba(239, 68, 68, 0.35);">
                    🗑️ Xác nhận xóa
                </a>
                <button type="button" class="auth-modal-btn-secondary" onclick="closeConfirmModal()">
                    Hủy bỏ
                </button>
            </div>
        </div>
    </div>

    <header>
        <div class="brand">🚀 UTEVideo</div>
        <nav>
            <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/cart" style="position: relative;" id="cart-nav-link">
                🛒 Giỏ hàng
                <span id="cart-badge" style="background: #ff6b6b; color: white; border-radius: 10px; padding: 2px 7px; font-size: 0.75rem; font-weight: bold; margin-left: 3px; display: ${not empty sessionScope.cartCount && sessionScope.cartCount > 0 ? 'inline-block' : 'none'};">
                    ${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}
                </span>
            </a>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/orders">📦 Đơn hàng</a>
                    <span class="nav-user">Xin chào, <b>${sessionScope.user.fullname}</b></span>
                    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>

                    <c:if test="${sessionScope.user.admin}">
                        <a href="${pageContext.request.contextPath}/admin/home" class="btn-admin">💻 Quản trị</a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" style="background:var(--accent-blue);color:white;">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <main>
        <sitemesh:write property='body' />
    </main>

    <footer>
        <p>Họ tên: Nguyễn Đặng Cao Tường | MSSV: 24110375 | Mã đề: 03</p>
    </footer>

    <!-- POPUP & TOAST JAVASCRIPT LOGIC -->
    <script>
        // Hiển thị toast notification góc trên cùng bên phải
        function showToast(type, title, message) {
            var container = document.getElementById('toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'toast-container';
                document.body.appendChild(container);
            }

            var toast = document.createElement('div');
            toast.className = 'toast-item toast-' + (type || 'success');

            var iconSvg = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>';
            if (type === 'error') {
                iconSvg = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>';
            } else if (type === 'warning') {
                iconSvg = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>';
            }

            toast.innerHTML = 
                '<div class="toast-icon">' + iconSvg + '</div>' +
                '<div class="toast-content">' +
                    '<div class="toast-title">' + title + '</div>' +
                    '<div class="toast-desc">' + message + '</div>' +
                '</div>' +
                '<button type="button" class="toast-close" onclick="this.parentElement.remove()">✕</button>' +
                '<div class="toast-progress"></div>';

            container.appendChild(toast);

            setTimeout(function() {
                toast.classList.add('hide');
                setTimeout(function() { toast.remove(); }, 350);
            }, 3500);
        }

        // Quản lý Modal Đăng nhập đẹp mắt
        function openAuthModal(message, redirectUrl) {
            var modal = document.getElementById('auth-modal');
            if (modal) {
                if (message) {
                    var msgEl = document.getElementById('auth-modal-msg');
                    if (msgEl) msgEl.textContent = message;
                }
                if (redirectUrl) {
                    var btn = document.getElementById('auth-modal-login-btn');
                    if (btn) btn.href = redirectUrl;
                }
                modal.classList.add('active');
            }
        }

        function closeAuthModal() {
            var modal = document.getElementById('auth-modal');
            if (modal) {
                modal.classList.remove('active');
            }
        }

        // Quản lý Modal Xác nhận Xóa sang trọng
        function showConfirmModal(url, title, message) {
            var modal = document.getElementById('confirm-modal');
            if (modal) {
                if (title) {
                    var tEl = document.getElementById('confirm-modal-title');
                    if (tEl) tEl.textContent = title;
                }
                if (message) {
                    var mEl = document.getElementById('confirm-modal-msg');
                    if (mEl) mEl.textContent = message;
                }
                var btn = document.getElementById('confirm-modal-btn');
                if (btn && url) {
                    btn.href = url;
                }
                modal.classList.add('active');
            }
        }

        function closeConfirmModal() {
            var modal = document.getElementById('confirm-modal');
            if (modal) {
                modal.classList.remove('active');
            }
        }

        // Phím ESC đóng modal
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' || e.keyCode === 27) {
                closeAuthModal();
                closeConfirmModal();
            }
        });

        // Tự động ẩn các toast sinh ra từ server sau 3.5s
        setTimeout(function() {
            var items = document.querySelectorAll('#toast-container .toast-item');
            for (var i = 0; i < items.length; i++) {
                (function(el) {
                    el.classList.add('hide');
                    setTimeout(function() { el.remove(); }, 350);
                })(items[i]);
            }
        }, 3500);

        // Bắt sự kiện click các nút thêm vào giỏ hàng (.btn-add-cart)
        document.addEventListener('DOMContentLoaded', function() {
            document.body.addEventListener('click', function(e) {
                var btn = e.target.closest ? e.target.closest('.btn-add-cart') : null;
                if (!btn && e.target.classList && e.target.classList.contains('btn-add-cart')) {
                    btn = e.target;
                }
                if (btn) {
                    e.preventDefault();
                    var url = btn.getAttribute('href');
                    var ajaxUrl = url + (url.indexOf('?') !== -1 ? '&' : '?') + 'ajax=true';

                    fetch(ajaxUrl, {
                        headers: { 'X-Requested-With': 'XMLHttpRequest' }
                    })
                    .then(function(res) { return res.json(); })
                    .then(function(data) {
                        if (data.status === 'unauthenticated') {
                            // Mở modal đăng nhập cực đẹp mắt ở giữa màn hình
                            openAuthModal(data.message, data.redirect || '${pageContext.request.contextPath}/login');
                            // Đồng thời hiện thông báo toast nhẹ nhàng góc trên cùng bên phải
                            showToast('warning', 'Yêu cầu đăng nhập', data.message || 'Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
                        } else if (data.status === 'warning') {
                            showToast('warning', 'Thông báo', data.message);
                            if (typeof data.cartCount !== 'undefined') {
                                updateCartBadge(data.cartCount);
                            }
                            if (data.videoId && typeof data.itemQty !== 'undefined') {
                                updateItemInCartState(data.videoId, data.itemQty);
                            }
                        } else {
                            showToast('success', 'Giỏ hàng', data.message || 'Đã thêm khóa học vào giỏ hàng thành công!');
                            if (typeof data.cartCount !== 'undefined') {
                                updateCartBadge(data.cartCount);
                            }
                            if (data.videoId && typeof data.itemQty !== 'undefined') {
                                updateItemInCartState(data.videoId, data.itemQty);
                            }
                        }
                    })
                    .catch(function(err) {
                        window.location.href = url;
                    });
                }
            });

            // Bắt sự kiện click các nút tăng giảm số lượng (+ / -) trên thẻ khóa học
            document.body.addEventListener('click', function(e) {
                var qtyBtn = e.target.closest ? e.target.closest('.btn-qty-action') : null;
                if (!qtyBtn && e.target.classList && e.target.classList.contains('btn-qty-action')) {
                    qtyBtn = e.target;
                }
                if (qtyBtn) {
                    e.preventDefault();
                    if (qtyBtn.disabled) return;

                    var videoId = qtyBtn.getAttribute('data-video-id');
                    var isPlus = qtyBtn.classList.contains('btn-qty-plus');
                    var action = isPlus ? 'increase' : 'decrease';
                    var url = '${pageContext.request.contextPath}/cart/update?id=' + encodeURIComponent(videoId) + '&action=' + action + '&ajax=true';

                    fetch(url, {
                        headers: { 'X-Requested-With': 'XMLHttpRequest' }
                    })
                    .then(function(res) { return res.json(); })
                    .then(function(data) {
                        if (data.status === 'unauthenticated') {
                            openAuthModal(data.message, data.redirect || '${pageContext.request.contextPath}/login');
                            showToast('warning', 'Yêu cầu đăng nhập', data.message);
                        } else if (data.status === 'warning') {
                            showToast('warning', 'Thông báo', data.message);
                            if (typeof data.cartCount !== 'undefined') updateCartBadge(data.cartCount);
                            if (data.videoId && typeof data.itemQty !== 'undefined') {
                                updateItemInCartState(data.videoId, data.itemQty);
                            }
                        } else {
                            showToast('success', 'Giỏ hàng', data.message);
                            if (typeof data.cartCount !== 'undefined') updateCartBadge(data.cartCount);
                            if (data.videoId && typeof data.itemQty !== 'undefined') {
                                updateItemInCartState(data.videoId, data.itemQty);
                            }
                        }
                    })
                    .catch(function(err) {
                        console.error('Lỗi cập nhật số lượng:', err);
                    });
                }
            });

            function updateCartBadge(count) {
                var badge = document.getElementById('cart-badge');
                if (badge) {
                    badge.textContent = count;
                    badge.style.display = count > 0 ? 'inline-block' : 'none';
                }
            }

            function updateItemInCartState(videoId, qty) {
                // 1. Cập nhật thẻ khóa học trên trang chủ (home.jsp)
                var card = document.getElementById('video-card-' + videoId);
                var indicator = document.getElementById('cart-indicator-' + videoId);
                var qtyEl = document.getElementById('cart-qty-' + videoId);
                var cardQtyNum = document.getElementById('card-qty-num-' + videoId);
                var btnPlus = document.querySelector('#cart-qty-control-' + videoId + ' .btn-qty-plus');

                if (qty > 0) {
                    if (card) card.classList.add('in-cart');
                    if (indicator) {
                        indicator.style.display = 'flex';
                        indicator.style.transform = 'scale(1.2)';
                        setTimeout(function() { indicator.style.transform = 'scale(1)'; }, 200);
                    }
                    if (qtyEl) qtyEl.textContent = qty;
                    if (cardQtyNum) cardQtyNum.textContent = qty;
                    if (btnPlus) {
                        btnPlus.disabled = (qty >= 10);
                    }
                } else {
                    // Khi số lượng về 0: Xóa khỏi giỏ hàng, ẩn badge và trở lại nút "Thêm vào giỏ"
                    if (card) card.classList.remove('in-cart');
                    if (indicator) {
                        indicator.style.display = 'none';
                    }
                    if (qtyEl) qtyEl.textContent = '0';
                    if (cardQtyNum) cardQtyNum.textContent = '1';
                }

                // 2. Cập nhật trang chi tiết video (video-detail.jsp nếu đang ở trang đó)
                var detailBox = document.getElementById('detail-in-cart-box');
                var detailQty = document.getElementById('detail-cart-qty');
                var detailBtnAdd = document.getElementById('btn-add-cart-' + videoId);
                var detailQtyControl = document.getElementById('cart-qty-control-' + videoId);

                if (detailBox) {
                    detailBox.style.display = qty > 0 ? 'flex' : 'none';
                }
                if (detailQty) {
                    detailQty.textContent = qty;
                }
                if (detailBtnAdd && detailQtyControl && !card) {
                    // Nếu ở trang chi tiết (không có thẻ .video-card bao quanh)
                    if (qty > 0) {
                        detailBtnAdd.style.display = 'none';
                        detailQtyControl.style.display = 'flex';
                    } else {
                        detailBtnAdd.style.display = 'inline-block';
                        detailQtyControl.style.display = 'none';
                    }
                }
            }
        });
    </script>
</body>
</html>
