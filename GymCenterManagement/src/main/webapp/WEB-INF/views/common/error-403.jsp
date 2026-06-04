<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<div class="error-container">
    <div class="error-code">403</div>
    <div class="error-title">Truy cập bị từ chối</div>
    <p class="error-message">Bạn không có quyền truy cập vào tài nguyên này. Vui lòng xác thực vai trò tài khoản hoặc thử đăng nhập lại.</p>
    <a href="${pageContext.request.contextPath}/login" class="back-btn">Quay lại trang Đăng nhập</a>
</div>

<style>
    .error-container {
        text-align: center;
        max-width: 500px;
        background-color: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 3rem 2rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
    }
    
    .error-code {
        font-size: 6rem;
        font-weight: 800;
        color: var(--danger);
        line-height: 1;
        margin-bottom: 1rem;
    }
    
    .error-title {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }
    
    .error-message {
        color: var(--text-muted);
        margin-bottom: 2rem;
        font-size: 0.95rem;
        line-height: 1.5;
    }
    
    .back-btn {
        display: inline-block;
        background-color: var(--accent);
        color: var(--text-main);
        text-decoration: none;
        padding: 0.75rem 1.5rem;
        border-radius: 6px;
        font-weight: 500;
        transition: background-color 0.2s ease;
    }
    
    .back-btn:hover {
        background-color: var(--accent-hover);
    }
</style>

<jsp:include page="footer.jsp" />
