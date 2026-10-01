<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Đăng ký tài khoản</title>
        </head>

        <body>
            <div class="form-container">
                <h2>Đăng ký thành viên mới</h2>

                <c:if test="${not empty error}">
                    <div class="msg-error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-group">
                        <label>Tên đăng nhập:</label>
                        <input type="text" name="username" required autocomplete="off">
                    </div>

                    <div class="form-group">
                        <label>Mật khẩu:</label>
                        <input type="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label>Họ và tên:</label>
                        <input type="text" name="fullname" required autocomplete="off">
                    </div>

                    <div class="form-group">
                        <label>Email (Nhận mã OTP):</label>
                        <input type="email" name="email" required autocomplete="off">
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại:</label>
                        <input type="text" name="phone" autocomplete="off">
                    </div>

                    <button type="submit" class="btn-submit">Đăng ký</button>
                </form>

                <div class="form-footer">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
                </div>
            </div>
        </body>

        </html>
