<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập hệ thống</title>
</head>
<body>
    <div class="form-container">
        <h2>Đăng nhập</h2>
        
        <c:if test="${not empty message}">
            <div class="msg-success">${message}</div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="msg-error">${sessionScope.error}</div>
            <% session.removeAttribute("error"); %>
        </c:if>
        <c:if test="${empty sessionScope.error && not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Tên đăng nhập:</label>
                <input type="text" name="username" required>
            </div>
            
            <div class="form-group">
                <label>Mật khẩu:</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-submit">Đăng nhập</button>
        </form>
        
        <div class="form-footer">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a><br><br>
            Bạn là Quản trị viên? <a href="${pageContext.request.contextPath}/admin-login" style="color: #ff6b6b; font-weight: bold;">Đăng nhập Admin</a>
        </div>
    </div>
</body>
</html>

