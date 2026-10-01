<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${video.title}</title>
</head>
<body>
    <div class="hero-card" style="padding: 20px; text-align: left; display: flex; gap: 30px; max-width: 1000px; margin: 0 auto;">
        
        <div style="flex: 1;">
            <c:choose>
                <c:when test="${not empty video.poster}">
                    <c:choose>
                        <c:when test="${fn:startsWith(video.poster, 'http') || fn:startsWith(video.poster, '/')}">
                            <img src="${video.poster}" alt="${video.title}" style="width: 100%; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.5);">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/uploads/${video.poster}" alt="${video.title}" style="width: 100%; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.5);">
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div style="width: 100%; height: 400px; background: var(--navy-dark); border-radius: 12px; display:flex; align-items:center; justify-content:center; color: var(--text-muted);">
                        [Không có ảnh Poster]
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div style="flex: 1.5; display: flex; flex-direction: column; justify-content: space-between;">
            <div>
                <h1 style="color: var(--text-bright); margin-top: 0; font-size: 2rem; border-bottom: 2px solid var(--navy-hover); padding-bottom: 10px;">
                    ${video.title}
                </h1>
                
                <p style="font-size: 1.1rem; margin: 5px 0;">
                    <b style="color: var(--accent-teal);">Mã video:</b> ${video.videoId}
                </p>
                <p style="font-size: 1.1rem; margin: 5px 0;">
                    <b style="color: var(--accent-teal);">Danh mục:</b> ${video.category.categoryname}
                </p>
                <p style="font-size: 1.1rem; margin: 5px 0;">
                    <b style="color: var(--accent-teal);">Lượt xem:</b> ${video.views}
                </p>
                
                <div style="display: flex; gap: 20px; margin: 20px 0;">
                    <span style="background: var(--navy-dark); padding: 8px 15px; border-radius: 20px; font-weight: bold; color: #ff6b6b; border: 1px solid var(--navy-hover);">
                        ❤️ Like (${likeCount})
                    </span>
                    <span style="background: var(--navy-dark); padding: 8px 15px; border-radius: 20px; font-weight: bold; color: #3b82f6; border: 1px solid var(--navy-hover);">
                        🔗 Share (${shareCount})
                    </span>
                </div>

                <c:set var="cartItem" value="${sessionScope.cart[video.videoId]}" />
                <c:set var="isInCart" value="${not empty cartItem && cartItem.quantity > 0}" />
                <div id="detail-in-cart-box" style="margin: 15px 0 5px 0; padding: 10px 16px; background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.4); border-radius: 8px; color: #64ffda; display: ${isInCart ? 'flex' : 'none'}; align-items: center; gap: 8px; font-weight: 600;">
                    <span style="font-size: 1.1rem;">✓</span>
                    <span>Khóa học này đã có trong giỏ hàng (Số lượng: <b id="detail-cart-qty">${isInCart ? cartItem.quantity : 0}</b>/10)</span>
                </div>

                <div style="margin: 15px 0; display:flex; gap: 15px; align-items:center;">
                    <!-- NÚT THÊM VÀO GIỎ BAN ĐẦU -->
                    <a href="${pageContext.request.contextPath}/cart/add?id=${video.videoId}&redirect=detail" 
                       class="btn-submit btn-add-cart btn-add-cart-init" 
                       id="btn-add-cart-${video.videoId}"
                       data-video-id="${video.videoId}"
                       style="display: ${isInCart ? 'none' : 'inline-block'}; width: auto; padding: 12px 25px; font-size: 1rem; background: var(--accent-teal); color: var(--navy-dark); font-weight: bold; text-decoration: none; border-radius: 6px;">
                        🛒 Thêm vào giỏ hàng
                    </a>

                    <!-- BỘ ĐIỀU KHIỂN TĂNG GIẢM SỐ LƯỢNG KHI ĐÃ CÓ TRONG GIỎ -->
                    <div class="cart-qty-control" id="cart-qty-control-${video.videoId}" style="display: ${isInCart ? 'flex' : 'none'}; width: auto; min-width: 170px;">
                        <button type="button" class="btn-qty-action btn-qty-minus" data-video-id="${video.videoId}" title="Giảm số lượng">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                        </button>
                        <div class="qty-display" style="padding: 0 16px;">
                            <span class="qty-num" id="card-qty-num-${video.videoId}">${isInCart ? cartItem.quantity : 1}</span>
                            <span class="qty-label">trong giỏ</span>
                        </div>
                        <button type="button" class="btn-qty-action btn-qty-plus" data-video-id="${video.videoId}" title="Tăng số lượng" ${isInCart && cartItem.quantity >= 10 ? 'disabled' : ''}>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                        </button>
                    </div>

                    <a href="${pageContext.request.contextPath}/cart" 
                       class="btn-submit" 
                       style="display: inline-block; width: auto; padding: 12px 20px; font-size: 1rem; background: var(--navy-hover); color: white; text-decoration: none; border-radius: 6px;">
                        Xem giỏ hàng
                    </a>
                </div>
            </div>
            
            <div style="background: var(--navy-dark); padding: 20px; border-radius: 8px; border: 1px solid var(--navy-hover);">
                <h3 style="margin-top: 0; color: var(--text-bright);">Description</h3>
                <p style="color: var(--text-muted); line-height: 1.6; margin-bottom: 0;">
                    ${empty video.description ? 'Chưa có mô tả cho video này.' : video.description}
                </p>
            </div>
        </div>
        
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/home" class="btn-submit" style="display: inline-block; width: auto; padding: 10px 30px;">⬅ Quay lại Trang chủ</a>
    </div>
</body>
</html>

