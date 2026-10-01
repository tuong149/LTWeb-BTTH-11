<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bảo trì hệ thống</title>
    <style>
        .error-container {
            text-align: center;
            padding: 80px 20px;
            background: var(--navy-light);
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            margin-top: 40px;
        }
        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
            animation: bounce 2s infinite ease-in-out;
        }
        .error-title {
            color: var(--accent-teal);
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        .error-message {
            color: var(--text-muted);
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .btn-home {
            display: inline-block;
            padding: 12px 30px;
            background: var(--accent-blue);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            background: #3b82f6;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">🚧</div>
        <h1 class="error-title">Trang đang được xây dựng</h1>
        <p class="error-message">Xin lỗi sự bất tiện này! Trang "Sản phẩm" hiện đang trong quá trình phát triển và hoàn thiện tính năng.<br>Vui lòng quay lại thử lại sau nhé!</p>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">⬅ Về Trang Chủ</a>
    </div>
</body>
</html>
