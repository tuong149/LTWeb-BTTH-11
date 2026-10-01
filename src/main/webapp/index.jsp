<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Tự động chuyển hướng sang trang chủ (Controller /home) ngay khi vừa vào web
    response.sendRedirect(request.getContextPath() + "/home");
%>

