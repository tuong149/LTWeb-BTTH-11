<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${action == 'add' ? 'Thêm Video' : 'Sửa Video'}</title>
</head>
<body>
    <div class="form-container" style="max-width: 600px; margin: 0;">
        <h2 style="color: var(--accent-teal); text-align: left;">
            ${action == 'add' ? 'Tạo Video Mới' : 'Cập Nhật Video'}
        </h2>
        
        <c:if test="${not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/videos/${action}" method="post" enctype="multipart/form-data">
            <c:if test="${action == 'edit'}">
                <div class="form-group">
                    <label>Mã Video (ID):</label>
                    <input type="text" name="videoId" value="${video.videoId}" readonly style="opacity:0.7">
                </div>
            </c:if>
            
            <div class="form-group">
                <label>Tiêu đề Video:</label>
                <input type="text" name="title" value="${video.title}" required>
            </div>
            
            <div class="form-group">
                <label>Ảnh Poster (Tải lên từ máy tính):</label>
                <c:if test="${action == 'edit' && not empty video.poster}">
                    <div style="margin-bottom: 10px;">
                        <c:choose>
                            <c:when test="${fn:startsWith(video.poster, 'http') || fn:startsWith(video.poster, '/')}">
                                <img src="${video.poster}" alt="Current Poster" width="100" style="border-radius: 8px;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/uploads/${video.poster}" alt="Current Poster" width="100" style="border-radius: 8px;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <input type="file" name="posterFile" accept="image/*" ${action == 'add' ? 'required' : ''}>
                <input type="hidden" name="oldPoster" value="${video.poster}">
            </div>
            
            <div class="form-group">
                <label>Danh mục (Category):</label>
                <select name="categoryId" required style="width: 100%; padding: 12px; background-color: var(--navy-dark); border: 1px solid var(--navy-hover); border-radius: 6px; color: white; font-size: 1rem;">
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.categoryId}" ${video.category.categoryId == c.categoryId ? 'selected' : ''}>
                            ${c.categoryname}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>Mô tả chi tiết:</label>
                <textarea name="description" rows="4" style="width: 100%; padding: 12px; background-color: var(--navy-dark); border: 1px solid var(--navy-hover); border-radius: 6px; color: white; font-size: 1rem;">${video.description}</textarea>
            </div>
            
            <div class="form-group" style="display:flex; align-items:center; gap: 10px;">
                <input type="checkbox" name="active" value="true" ${video.active == null || video.active ? 'checked' : ''} style="width:20px; height:20px;">
                <label style="margin:0;">Kích hoạt (Hiển thị cho User)</label>
            </div>
            
            <div style="margin-top: 30px; display:flex; gap: 10px;">
                <button type="submit" class="btn-submit" style="flex:1;">Lưu Dữ Liệu</button>
                <a href="${pageContext.request.contextPath}/admin/videos" class="btn-submit" style="background:#6c757d; text-align:center; flex:1; padding-top: 10px;">Hủy bỏ</a>
            </div>
        </form>
    </div>
</body>
</html>

