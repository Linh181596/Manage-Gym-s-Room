<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>GCMS - ${contentType == 'BLOG' ? 'Blog luyện tập' : 'Chính sách phòng tập'}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        :root {
            --home-primary: #009cff;
            --home-primary-dark: #0078c4;
            --home-ink: #191c24;
            --home-muted: #6c7293;
            --home-soft: #f3f6f9;
            --home-line: #dce6ef;
            --home-success: #12b886;
        }

        body {
            font-family: "Heebo", sans-serif;
            color: var(--home-ink);
            background: #ffffff;
        }

        .home-topbar {
            position: sticky;
            top: 0;
            z-index: 1030;
            background: rgba(255, 255, 255, 0.96);
            border-bottom: 1px solid var(--home-line);
            backdrop-filter: blur(14px);
        }

        .brand-mark {
            width: 44px;
            height: 44px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            background: var(--home-primary);
            border-radius: 8px;
        }

        .brand-title {
            color: var(--home-ink);
            font-weight: 800;
            line-height: 1;
            letter-spacing: 0;
        }

        .home-nav a {
            color: var(--home-muted);
            font-weight: 600;
            text-decoration: none;
            padding: 10px 12px;
        }

        .home-nav a:hover,
        .home-nav a.active {
            color: var(--home-primary);
        }

        .page-hero {
            background: var(--home-soft);
            border-bottom: 1px solid var(--home-line);
            padding: 56px 0;
        }

        .badge-soft {
            color: var(--home-primary-dark);
            background: rgba(0, 156, 255, 0.12);
            border-radius: 999px;
            padding: 6px 10px;
            font-weight: 700;
            font-size: 0.84rem;
        }

        .content-card {
            height: 100%;
            border: 1px solid var(--home-line);
            border-radius: 8px;
            background: #ffffff;
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
        }

        .content-card:hover {
            transform: translateY(-4px);
            border-color: rgba(0, 156, 255, 0.35);
            box-shadow: 0 16px 34px rgba(25, 28, 36, 0.1);
        }

        .content-card img {
            width: 100%;
            aspect-ratio: 16 / 10;
            object-fit: cover;
            background: var(--home-soft);
        }

        .muted-copy {
            color: var(--home-muted);
        }

        .blog-filter {
            border: 1px solid var(--home-line);
            border-radius: 8px;
            background: #ffffff;
            padding: 18px;
            margin-bottom: 28px;
        }

        .blog-filter .form-control,
        .blog-filter .form-select {
            min-height: 46px;
        }

        .blog-pagination .page-link {
            color: var(--home-primary);
            border-color: var(--home-line);
            min-width: 42px;
            text-align: center;
            font-weight: 700;
        }

        .blog-pagination .active .page-link {
            color: #ffffff;
            background: var(--home-primary);
            border-color: var(--home-primary);
        }

        .policy-sidebar {
            position: sticky;
            top: 96px;
            border: 1px solid var(--home-line);
            border-radius: 8px;
            background: #ffffff;
            padding: 24px;
        }

        .policy-sidebar a {
            display: block;
            color: var(--home-muted);
            text-decoration: none;
            padding: 10px 0;
            border-bottom: 1px solid var(--home-line);
            font-weight: 600;
        }

        .policy-sidebar a:last-child {
            border-bottom: 0;
        }

        .policy-sidebar a:hover {
            color: var(--home-primary);
        }

        .footer-home {
            color: rgba(255, 255, 255, 0.72);
            background: var(--home-ink);
        }

        .footer-home a {
            color: rgba(255, 255, 255, 0.82);
            text-decoration: none;
        }

        .footer-home a:hover {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <header class="home-topbar">
        <nav class="container py-3">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <a href="${pageContext.request.contextPath}/home" class="d-inline-flex align-items-center gap-2 text-decoration-none">
                    <span class="brand-mark"><i class="fa fa-dumbbell"></i></span>
                    <span class="brand-title">GCMS<br><small class="fw-semibold text-primary">Phòng tập hiện đại</small></span>
                </a>

                <div class="home-nav d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/home#gioi-thieu">Giới thiệu</a>
                    <a href="${pageContext.request.contextPath}/pt/list">Danh sách PT</a>
                    <a href="${pageContext.request.contextPath}/home#goi-tap">Gói tập</a>
                    <a href="${pageContext.request.contextPath}/home#bmi">Tính BMI</a>
                    <a href="${pageContext.request.contextPath}/blogs" class="${contentType == 'BLOG' ? 'active' : ''}">Blog</a>
                    <a href="${pageContext.request.contextPath}/policies" class="${contentType == 'POLICY' ? 'active' : ''}">Chính sách</a>
                    <a href="${pageContext.request.contextPath}/home#tien-ich">Tiện ích</a>
                    <a href="${pageContext.request.contextPath}/home#lien-he">Liên hệ</a>
                </div>

                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary">
                    <i class="fa fa-arrow-left me-1"></i>Quay về trang chủ
                </a>
            </div>
        </nav>
    </header>

    <main>
        <section class="page-hero">
            <div class="container">
                <div class="d-flex flex-column flex-lg-row justify-content-between gap-3">
                    <div>
                        <span class="badge-soft">${contentType == 'BLOG' ? 'Blog luyện tập' : 'Chính sách phòng tập'}</span>
                        <h1 class="fw-bold mt-3 mb-3">${contentType == 'BLOG' ? 'Góc kiến thức luyện tập' : 'Chính sách và quy định'}</h1>
                        <p class="muted-copy mb-0">
                            ${contentType == 'BLOG'
                                ? 'Các bài viết ngắn giúp hội viên chuẩn bị tốt hơn cho hành trình tập luyện.'
                                : 'Thông tin cần biết về hoàn tiền, hủy gói, bảo lưu, chuyển nhượng và nội quy hội viên.'}
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-5">
            <div class="container">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>

                <c:choose>
                    <c:when test="${contentType == 'POLICY'}">
                        <div class="row g-4 align-items-start">
                            <aside class="col-lg-4">
                                <div class="policy-sidebar">
                                    <span class="badge-soft">Danh mục chính sách</span>
                                    <h4 class="fw-bold mt-3 mb-3">Chính sách</h4>
                                    <c:choose>
                                        <c:when test="${empty contents}">
                                            <p class="muted-copy mb-0">Chưa có chính sách được đăng.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="item" items="${contents}">
                                                <a class="${not empty selectedPolicy and selectedPolicy.contentId == item.contentId ? 'active' : ''}" href="${pageContext.request.contextPath}/policies?id=${item.contentId}">
                                                    <span class="policy-item-title"><c:out value="${item.title}" /></span>
                                                    <span class="policy-item-category"><c:out value="${item.category}" /></span>
                                                </a>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </aside>
                            <div class="col-lg-8">
                                <c:choose>
                                    <c:when test="${empty selectedPolicy}">
                                        <div class="text-center text-muted py-5">
                                            <i class="fa fa-file-alt fa-3x mb-3 d-block"></i>
                                            Chưa có chính sách được đăng.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <article class="policy-article">
                                            <div class="text-muted small fw-bold mb-2"><c:out value="${selectedPolicy.category}" /></div>
                                            <h2 class="fw-bold mb-3"><c:out value="${selectedPolicy.title}" /></h2>
                                            <c:if test="${not empty selectedPolicy.summary}">
                                                <p class="muted-copy fs-5 mb-4"><c:out value="${selectedPolicy.summary}" /></p>
                                            </c:if>
                                            <div class="policy-body"><c:out value="${selectedPolicy.body}" /></div>
                                        </article>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- Form tìm kiếm và lọc danh sách blog (GET) --%>
                        <form class="blog-filter" method="get" action="${pageContext.request.contextPath}/blogs">
                            <div class="row g-3 align-items-center">
                                <div class="col-lg-6">
                                    <label for="blogSearch" class="form-label fw-bold mb-2">Tìm kiếm bài viết</label>
                                    <input id="blogSearch" name="q" class="form-control"
                                           value="${fn:escapeXml(keyword)}" placeholder="Nhập tiêu đề hoặc mô tả ngắn">
                                </div>
                                <div class="col-lg-3">
                                    <label for="blogCategory" class="form-label fw-bold mb-2">Danh mục</label>
                                    <select id="blogCategory" name="category" class="form-select">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="category" items="${blogCategories}">
                                            <option value="${fn:escapeXml(category)}" ${selectedCategory == category ? 'selected' : ''}>
                                                <c:out value="${category}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-lg-3 d-flex gap-2 align-self-end">
                                    <button type="submit" class="btn btn-primary flex-fill">
                                        <i class="fa fa-search me-1"></i>Tìm
                                    </button>
                                    <c:if test="${not empty keyword or not empty selectedCategory}">
                                        <a href="${pageContext.request.contextPath}/blogs" class="btn btn-outline-secondary">
                                            Xóa
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </form>

                        <div class="row g-4">
                            <c:choose>
                                <c:when test="${empty contents}">
                                    <div class="col-12 text-center text-muted py-5">
                                        <i class="fa fa-file-alt fa-3x mb-3 d-block"></i>
                                        Chưa có bài viết được đăng.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="item" items="${contents}">
                                        <div class="col-md-6 col-lg-4">
                                            <article class="content-card">
                                                <c:if test="${not empty item.thumbnailUrl}">
                                                    <img src="${pageContext.request.contextPath}/${item.thumbnailUrl}" alt="${item.title}">
                                                </c:if>
                                                <div class="p-4">
                                                    <div class="text-muted small fw-bold mb-2"><c:out value="${item.category}" /></div>
                                                    <h5 class="fw-bold"><c:out value="${item.title}" /></h5>
                                                    <p class="muted-copy"><c:out value="${item.summary}" /></p>
                                                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/blogs?id=${item.contentId}">
                                                        Đọc tiếp
                                                    </a>
                                                </div>
                                            </article>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${totalPages > 1}">
                            <%-- Phân trang danh sách bài viết blog --%>
                            <nav class="blog-pagination mt-5" aria-label="Phân trang blog">
                                <ul class="pagination justify-content-center flex-wrap gap-1">
                                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                        <c:url var="prevPageUrl" value="/blogs">
                                            <c:param name="page" value="${currentPage - 1}" />
                                            <c:if test="${not empty keyword}">
                                                <c:param name="q" value="${keyword}" />
                                            </c:if>
                                            <c:if test="${not empty selectedCategory}">
                                                <c:param name="category" value="${selectedCategory}" />
                                            </c:if>
                                        </c:url>
                                        <a class="page-link" href="${prevPageUrl}" aria-label="Trang trước">&laquo;</a>
                                    </li>
                                    <c:forEach var="pageNumber" begin="1" end="${totalPages}">
                                        <c:url var="pageUrl" value="/blogs">
                                            <c:param name="page" value="${pageNumber}" />
                                            <c:if test="${not empty keyword}">
                                                <c:param name="q" value="${keyword}" />
                                            </c:if>
                                            <c:if test="${not empty selectedCategory}">
                                                <c:param name="category" value="${selectedCategory}" />
                                            </c:if>
                                        </c:url>
                                        <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="${pageUrl}">${pageNumber}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                        <c:url var="nextPageUrl" value="/blogs">
                                            <c:param name="page" value="${currentPage + 1}" />
                                            <c:if test="${not empty keyword}">
                                                <c:param name="q" value="${keyword}" />
                                            </c:if>
                                            <c:if test="${not empty selectedCategory}">
                                                <c:param name="category" value="${selectedCategory}" />
                                            </c:if>
                                        </c:url>
                                        <a class="page-link" href="${nextPageUrl}" aria-label="Trang sau">&raquo;</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <footer id="lien-he" class="footer-home py-5">
        <div class="container">
            <div class="row g-4 align-items-start text-start">
                <div class="col-lg-5">
                    <div class="d-inline-flex align-items-center gap-2 mb-3">
                        <span class="brand-mark bg-primary text-white"><i class="fa fa-dumbbell"></i></span>
                        <strong class="fs-4 text-white">GCMS</strong>
                    </div>
                    <p class="mb-0 text-muted">Không gian quản lý và tập luyện dành cho phòng gym hiện đại, rõ ràng và thân thiện với người dùng Việt.</p>
                </div>
                <div class="col-6 col-lg-2">
                    <h6 class="text-white fw-bold">Truy cập nhanh</h6>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/home#gioi-thieu" class="text-muted text-decoration-none small">Giới thiệu</a>
                        <a href="${pageContext.request.contextPath}/pt/list" class="text-muted text-decoration-none small">Danh sách PT</a>
                        <a href="${pageContext.request.contextPath}/home#goi-tap" class="text-muted text-decoration-none small">Danh mục</a>
                        <a href="${pageContext.request.contextPath}/blogs" class="text-muted text-decoration-none small">Blog</a>
                        <a href="${pageContext.request.contextPath}/policies" class="text-muted text-decoration-none small">Chính sách</a>
                    </div>
                </div>
                <div class="col-6 col-lg-2">
                    <h6 class="text-white fw-bold">Tài khoản</h6>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="text-muted text-decoration-none small">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none small">Đăng ký thành viên</a>
                    </div>
                </div>
                <div class="col-lg-3">
                    <h6 class="text-white fw-bold">Liên hệ phòng tập</h6>
                    <p class="mb-2 text-muted"><i class="fa fa-map-marker-alt me-2 text-primary"></i>QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội</p>
                    <p class="mb-2 text-muted"><i class="fa fa-phone me-2 text-primary"></i>(+84) 987-654-321</p>
                    <p class="mb-0 text-muted"><i class="fa fa-envelope me-2 text-primary"></i>support@gcms.com</p>
                </div>
            </div>
            <div class="border-top border-secondary mt-4 pt-4 d-flex flex-wrap justify-content-between gap-2 text-muted small">
                <span>© 2026 Hệ thống quản lý phòng tập GCMS.</span>
                <span>Thiết kế cho trải nghiệm thuần Việt.</span>
            </div>
        </div>
    </footer>
</body>
</html>
