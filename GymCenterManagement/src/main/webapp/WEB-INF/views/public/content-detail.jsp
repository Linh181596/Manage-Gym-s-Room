<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>GCMS - ${content.title}</title>
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
            --home-ink: #191c24;
            --home-muted: #6c7293;
            --home-soft: #f3f6f9;
            --home-line: #dce6ef;
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

        .hero-img {
            display: block;
            width: 100%;
            max-width: 820px;
            height: auto;
            margin-left: auto;
            margin-right: auto;
            border-radius: 8px;
            background: var(--home-soft);
        }

        .content-body {
            white-space: pre-line;
            color: #343a40;
            line-height: 1.75;
        }

        .muted-copy {
            color: var(--home-muted);
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

        @media (max-width: 767.98px) {
            .hero-img {
                height: auto;
            }
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

                <a href="${pageContext.request.contextPath}/${contentType == 'BLOG' ? 'blogs' : 'policies'}" class="btn btn-outline-primary">
                    <i class="fa fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>
        </nav>
    </header>

    <main class="container py-5">
        <article class="mx-auto" style="max-width: 920px;">
            <span class="badge bg-primary"><c:out value="${content.category}" /></span>
            <h1 class="fw-bold mt-3 mb-3"><c:out value="${content.title}" /></h1>
            <p class="muted-copy fs-5"><c:out value="${content.summary}" /></p>
            <c:if test="${not empty content.thumbnailUrl}">
                <img class="hero-img my-4"
                     src="${pageContext.request.contextPath}/${content.thumbnailUrl}"
                     alt="${content.title}">
            </c:if>
            <div class="content-body fs-6"><c:out value="${content.body}" /></div>
            <div class="border-top mt-5 pt-4 d-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Về trang chủ</a>
            </div>
        </article>
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
