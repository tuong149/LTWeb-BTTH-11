<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Xác thực OTP</title>
</head>
<body>
    <div class="form-container">
        <h2>Xác thực Email</h2>
        
        <div class="msg-success" style="font-size: 0.9rem;">
            Một mã OTP (6 số) đã được gửi tới Email:<br>
            <b>${sessionScope.registerUser.email}</b>
        </div>
        
        <c:if test="${not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <div class="form-group">
                <label>Nhập mã OTP:</label>
                <input type="text" name="otp" required maxlength="6" pattern="\d{6}" title="Mã OTP phải gồm 6 chữ số" style="text-align: center; letter-spacing: 5px; font-size: 1.2rem; font-weight: bold;">
            </div>
            
            <button type="submit" class="btn-submit">Xác nhận OTP</button>
        </form>
        
        <div class="form-footer">
            Chưa nhận được? <a href="${pageContext.request.contextPath}/register">Đăng ký lại</a>
        </div>
    </div>
</body>
</html>

