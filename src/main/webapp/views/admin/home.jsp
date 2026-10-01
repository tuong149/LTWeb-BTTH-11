<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bảng điều khiển Admin</title>
    <style>
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: var(--navy-light);
            border-radius: 12px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            border-top: 4px solid var(--accent-teal);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 {
            color: var(--text-muted);
            font-size: 1.2rem;
            margin-bottom: 15px;
        }
        .card .number {
            font-size: 3.5rem;
            font-weight: bold;
            color: var(--accent-teal);
            margin: 0;
        }
        .welcome-header {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--navy-hover);
        }
    </style>
</head>
<body>
    <div class="welcome-header">
        <h1 style="color: var(--accent-teal); margin-bottom: 10px;">Bảng Điều Khiển (Dashboard)</h1>
        <p style="color: var(--text-muted);">Chào mừng trở lại, <b>${sessionScope.user.fullname}</b>. Dưới đây là tổng quan tình trạng hệ thống.</p>
    </div>

    <div class="dashboard-cards" style="grid-template-columns: repeat(auto-fit, minmax(250px, 300px));">
        <a href="${pageContext.request.contextPath}/admin/videos" style="text-decoration: none;">
            <div class="card" style="cursor: pointer;">
                <h3>Tổng số Video</h3>
                <p class="number">${totalVideos}</p>
                <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 15px;">👉 Click để quản lý</p>
            </div>
        </a>
    </div>
</body>
</html>

