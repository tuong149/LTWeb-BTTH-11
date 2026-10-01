<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập Quản trị viên</title>
</head>
<body>
    <div class="form-container" style="border-top: 5px solid #ff6b6b; box-shadow: 0 10px 25px rgba(255, 107, 107, 0.2);">
        <h2 style="color: #ff6b6b; text-align: center; margin-bottom: 25px;">🔒 Đăng nhập Admin</h2>
        
        <c:if test="${not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin-login" method="post">
            <div class="form-group">
                <label>Tên đăng nhập Admin:</label>
                <input type="text" name="username" required>
            </div>
            
            <div class="form-group">
                <label>Mật khẩu:</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-submit" style="background: #ff6b6b; border: none; font-size: 1.1rem;">Truy cập Hệ thống</button>
        </form>
        
        <div class="form-footer" style="margin-top: 20px;">
            Bạn là người dùng bình thường? <a href="${pageContext.request.contextPath}/login" style="color: var(--accent-teal);">Đăng nhập tại đây</a>
        </div>
    </div>
</body>
</html>
