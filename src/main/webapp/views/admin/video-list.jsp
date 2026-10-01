<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <html>

            <head>
                <title>Quản lý Video</title>
                <style>
                    .table-wrapper {
                        background: var(--navy-light);
                        border-radius: 8px;
                        padding: 20px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
                    }

                    .header-action {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .btn-add {
                        background: var(--accent-teal);
                        color: var(--navy-dark);
                        padding: 10px 20px;
                        border-radius: 5px;
                        font-weight: bold;
                    }

                    .btn-add:hover {
                        background: #4cd6b3;
                        color: var(--navy-dark);
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    th,
                    td {
                        padding: 12px 15px;
                        text-align: left;
                        border-bottom: 1px solid var(--navy-hover);
                        color: var(--text-main);
                    }

                    th {
                        background-color: var(--navy-hover);
                        color: var(--text-bright);
                    }

                    .btn-sm {
                        padding: 5px 10px;
                        border-radius: 4px;
                        font-size: 0.85rem;
                        margin-right: 5px;
                    }

                    .btn-edit {
                        background: var(--accent-blue);
                        color: white;
                    }

                    .btn-delete {
                        background: #dc3545;
                        color: white;
                    }

                    .pagination {
                        display: flex;
                        justify-content: center;
                        gap: 10px;
                        margin-top: 20px;
                    }

                    .pagination a {
                        padding: 8px 12px;
                        background: var(--navy-hover);
                        border-radius: 4px;
                        color: var(--text-main);
                    }

                    .pagination a.active {
                        background: var(--accent-blue);
                        color: white;
                        font-weight: bold;
                    }
                </style>
            </head>

            <body>
                <div class="table-wrapper">
                    <div class="header-action">
                        <h2 style="margin:0; color: var(--accent-teal);">Danh sách Video</h2>
                        
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <form action="${pageContext.request.contextPath}/admin/videos" method="GET" style="margin:0; display: flex; align-items: center; gap: 10px;">
                                <select name="categoryId" onchange="this.form.submit()" style="padding: 8px 15px; border-radius: 5px; background: var(--navy-dark); color: var(--text-main); border: 1px solid var(--navy-hover);">
                                    <option value="all">Tất cả danh mục</option>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.categoryId}" ${c.categoryId == currentCategoryId ? 'selected' : ''}>${c.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </form>
                            <a href="${pageContext.request.contextPath}/admin/videos/add" class="btn-add">+ Thêm Video mới</a>
                        </div>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Mã Video</th>
                                <th>Tiêu đề</th>
                                <th>Poster</th>
                                <th>Lượt xem</th>
                                <th>Danh mục</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="v" items="${videos}">
                                <tr>
                                    <td>${v.videoId}</td>
                                    <td>${v.title}</td>
                                    <td>
                                        <c:if test="${not empty v.poster}">
                                            <c:choose>
                                                <c:when
                                                    test="${fn:startsWith(v.poster, 'http') || fn:startsWith(v.poster, '/')}">
                                                    <img src="${v.poster}" alt="poster" width="60"
                                                        style="border-radius:4px; max-height:80px; object-fit:cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/uploads/${v.poster}"
                                                        alt="poster" width="60"
                                                        style="border-radius:4px; max-height:80px; object-fit:cover;">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </td>
                                    <td>${v.views}</td>
                                    <td>${v.category.categoryname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${v.active}"><span style="color: #69db7c;">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise><span style="color: #ff6b6b;">Tạm ẩn</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/videos/edit?id=${v.videoId}"
                                            class="btn-sm btn-edit">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/videos/delete?id=${v.videoId}"
                                            class="btn-sm btn-delete"
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty videos}">
                                <tr>
                                    <td colspan="7" style="text-align:center;">Chưa có video nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>

                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </body>

            </html>
