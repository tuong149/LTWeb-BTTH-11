<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Admin -
                <sitemesh:write property='title' />
            </title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            <sitemesh:write property='head' />
        </head>

        <body>
            <header style="background-color: #050d1a;">
                <div class="brand" style="color: #ff6b6b;">⚡ Admin Dashboard</div>
                <nav>
                    <span class="nav-user">Vai trò: <b>${sessionScope.user.fullname}</b></span>
                    <a href="${pageContext.request.contextPath}/home">Về Website</a>
                    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                </nav>
            </header>

            <div class="admin-layout">
                <div class="admin-sidebar">
                    <h3>Danh mục quản lý</h3>
                    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                        <c:set var="currentUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
                        <c:if test="${empty currentUrl}">
                            <c:set var="currentUrl" value="${pageContext.request.requestURI}" />
                        </c:if>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/admin/home"
                                    class="${fn:contains(currentUrl, '/admin/home') ? 'active' : ''}">Bảng điều
                                    khiển</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/videos"
                                    class="${fn:contains(currentUrl, '/admin/videos') ? 'active' : ''}">Quản lý
                                    Video</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/orders"
                                    class="${fn:contains(currentUrl, '/admin/orders') ? 'active' : ''}">Quản lý
                                    Đơn hàng (COD)</a></li>
                        </ul>
                </div>
                <div class="admin-content">
                    <sitemesh:write property='body' />
                </div>
            </div>

            <footer>
                <p>Hệ thống Quản Trị - Họ tên: Nguyễn Đặng Cao Tường | MSSV: 24110375 | Mã đề: 03</p>
            </footer>
        </body>

        </html>
