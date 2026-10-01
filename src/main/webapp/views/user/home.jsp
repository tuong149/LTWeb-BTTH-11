<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Trang Chủ Người Dùng</title>
    <style>
        .category-nav {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            overflow-x: auto;
            padding-bottom: 10px;
        }
        .category-tab {
            padding: 10px 20px;
            background: var(--navy-light);
            border: 1px solid var(--navy-hover);
            border-radius: 20px;
            color: var(--text-main);
            white-space: nowrap;
        }
        .category-tab.active {
            background: var(--accent-blue);
            color: white;
            border-color: var(--accent-blue);
            font-weight: bold;
        }
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        .video-card {
            background: var(--navy-light);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            border: 1px solid var(--navy-hover);
            transition: transform 0.2s;
        }
        .video-card:hover {
            transform: translateY(-5px);
        }
        .video-poster {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: var(--navy-dark);
        }
        .video-info {
            padding: 15px;
        }
        .video-info h3 {
            margin: 0 0 10px 0;
            color: var(--accent-teal);
            font-size: 1.2rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .video-info p {
            margin: 5px 0;
            font-size: 0.95rem;
            color: var(--text-main);
        }
        .video-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid var(--navy-hover);
            font-size: 0.9rem;
        }
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
        }
        .pagination a {
            padding: 5px 12px;
            color: var(--text-main);
        }
        .pagination a.active {
            font-weight: bold;
            color: var(--accent-teal);
            border-bottom: 2px solid var(--accent-teal);
        }
        .video-card.in-cart {
            border-color: rgba(100, 255, 218, 0.5) !important;
            box-shadow: 0 8px 25px rgba(100, 255, 218, 0.15) !important;
        }
        .poster-container {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
        }
        .cart-indicator-badge {
            display: none !important;
            position: absolute;
            top: 10px;
            right: 10px;
            background: linear-gradient(135deg, #059669, #10b981);
            color: #ffffff;
            font-size: 0.8rem;
            font-weight: 700;
            padding: 5px 12px;
            border-radius: 20px;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.6), 0 0 12px rgba(16, 185, 129, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.25);
            z-index: 5;
            transition: transform 0.2s ease;
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
            align-items: center;
            justify-content: space-between;
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
</head>
<body>
    <div class="category-nav">
        <c:forEach var="c" items="${categories}">
            <a href="?categoryId=${c.categoryId}" class="category-tab ${c.categoryId == currentCategoryId ? 'active' : ''}">
                ${c.categoryname} (${categoryCounts[c.categoryId]})
            </a>
        </c:forEach>
    </div>

    <h2 style="border-left: 5px solid var(--accent-teal); padding-left: 15px; color: var(--text-bright);">
        ${currentCategoryName} (${totalItems})
    </h2>

    <div class="video-grid">
        <c:forEach var="v" items="${videos}">
            <c:set var="cartItem" value="${sessionScope.cart[v.videoId]}" />
            <c:set var="isInCart" value="${not empty cartItem && cartItem.quantity > 0}" />
            <div class="video-card ${isInCart ? 'in-cart' : ''}" id="video-card-${v.videoId}">
                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" style="text-decoration: none; display: block;">
                    <div class="poster-container">
                        <c:choose>
                            <c:when test="${not empty v.poster}">
                                <c:choose>
                                    <c:when test="${fn:startsWith(v.poster, 'http') || fn:startsWith(v.poster, '/')}">
                                        <img src="${v.poster}" alt="${v.title}" class="video-poster">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/uploads/${v.poster}" alt="${v.title}" class="video-poster">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <div class="video-poster" style="display:flex; align-items:center; justify-content:center; color:#555;">No Image</div>
                            </c:otherwise>
                        </c:choose>

                        <!-- HUY HIỆU ĐÃ TRONG GIỎ HÀNG TRÊN ẢNH BÌA (CHỈ HIỂN THỊ KHI ĐÃ CÓ TRONG GIỎ) -->
                        <div class="cart-indicator-badge" id="cart-indicator-${v.videoId}">
                            <span>✓ Trong giỏ:</span>
                            <span class="cart-indicator-qty" id="cart-qty-${v.videoId}">${isInCart ? cartItem.quantity : 0}</span>
                        </div>
                    </div>
                    
                    <div class="video-info" style="padding-bottom: 5px;">
                        <h3 title="${v.title}">${v.title}</h3>
                        <p><b>Mã video:</b> ${v.videoId}</p>
                        <p><b>Danh mục:</b> ${v.category.categoryname}</p>
                        <p><b>Lượt xem:</b> ${v.views}</p>
                    </div>
                </a>

                <div style="padding: 0 15px 15px 15px;">
                    <div class="video-stats" style="margin-top: 5px; padding-top: 10px;">
                        <span style="color: #ff6b6b;">❤️ Like(${likeCounts[v.videoId]})</span>
                        <span style="color: #3b82f6;">🔗 Share(${shareCounts[v.videoId]})</span>
                    </div>
                    <div style="margin-top: 12px;">
                        <!-- NÚT THÊM VÀO GIỎ BAN ĐẦU -->
                        <a href="${pageContext.request.contextPath}/cart/add?id=${v.videoId}&redirect=home" 
                           class="btn-submit btn-add-cart btn-add-cart-init" 
                           id="btn-add-cart-${v.videoId}"
                           data-video-id="${v.videoId}"
                           style="text-align: center; padding: 10px; font-size: 0.95rem; text-decoration: none; border-radius: 8px;">
                            🛒 Thêm vào giỏ
                        </a>

                        <!-- BỘ ĐIỀU KHIỂN TĂNG GIẢM SỐ LƯỢNG (HIỆN KHI ĐÃ CÓ TRONG GIỎ) -->
                        <div class="cart-qty-control" id="cart-qty-control-${v.videoId}">
                            <button type="button" class="btn-qty-action btn-qty-minus" data-video-id="${v.videoId}" title="Giảm số lượng">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            </button>
                            <div class="qty-display">
                                <span class="qty-num" id="card-qty-num-${v.videoId}">${isInCart ? cartItem.quantity : 1}</span>
                                <span class="qty-label">trong giỏ</span>
                            </div>
                            <button type="button" class="btn-qty-action btn-qty-plus" data-video-id="${v.videoId}" title="Tăng số lượng" ${isInCart && cartItem.quantity >= 10 ? 'disabled' : ''}>
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty videos}">
            <p style="color: var(--text-muted);">Không có video nào trong danh mục này.</p>
        </c:if>
    </div>

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?categoryId=${currentCategoryId}&page=${currentPage - 1}">&lt;&lt;</a>
            </c:if>
            
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="?categoryId=${currentCategoryId}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <a href="?categoryId=${currentCategoryId}&page=${currentPage + 1}">&gt;&gt;</a>
            </c:if>
        </div>
    </c:if>
</body>
</html>

