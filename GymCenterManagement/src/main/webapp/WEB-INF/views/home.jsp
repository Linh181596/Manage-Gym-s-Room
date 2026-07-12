<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>GCMS - Trang chủ phòng tập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="phòng tập, gói tập, huấn luyện viên cá nhân, GCMS">
    <meta name="description" content="Trang chủ hệ thống quản lý phòng tập GCMS">

    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
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
            --home-warm: #ffb703;
        }

        html {
            scroll-behavior: smooth;
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
        .home-nav a:focus {
            color: var(--home-primary);
        }
        
        .home-user-pill {
            min-height: 42px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--home-ink);
            background: #ffffff;
            border: 1px solid var(--home-line);
            border-radius: 8px;
            padding: 8px 12px;
            font-weight: 700;
            max-width: 220px;
        }
        
        .home-user-pill img {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            object-fit: cover;
            flex: 0 0 auto;
        }
        
        .home-user-pill span {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .hero-section {
            min-height: calc(100vh - 78px);
            display: flex;
            align-items: center;
            background:
                linear-gradient(120deg, rgba(0, 156, 255, 0.12), rgba(18, 184, 134, 0.08)),
                var(--home-soft);
            border-bottom: 1px solid var(--home-line);
            padding: 72px 0 46px;
        }

        .hero-copy {
            max-width: 650px;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--home-primary-dark);
            background: rgba(0, 156, 255, 0.11);
            border: 1px solid rgba(0, 156, 255, 0.18);
            border-radius: 8px;
            padding: 8px 12px;
            font-weight: 700;
        }

        .hero-title {
            color: var(--home-ink);
            font-size: clamp(2.3rem, 6vw, 4.8rem);
            line-height: 1.02;
            font-weight: 800;
            letter-spacing: 0;
        }

        .hero-text {
            color: var(--home-muted);
            font-size: 1.12rem;
            max-width: 590px;
        }

        .hero-panel {
            border-radius: 8px;
            background: #ffffff;
            border: 1px solid var(--home-line);
            box-shadow: 0 18px 46px rgba(25, 28, 36, 0.12);
            overflow: hidden;
        }

        .trainer-mosaic {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1px;
            background: var(--home-line);
        }

        .trainer-mosaic img {
            width: 100%;
            aspect-ratio: 1 / 1;
            object-fit: cover;
            background: var(--home-soft);
        }

        .hero-metric {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1px;
            background: var(--home-line);
        }

        .hero-metric div {
            background: #ffffff;
            padding: 20px 16px;
            text-align: center;
        }

        .metric-number {
            display: block;
            color: var(--home-primary);
            font-size: 1.75rem;
            font-weight: 800;
        }

        .metric-label {
            color: var(--home-muted);
            font-size: 0.9rem;
        }

        .section-space {
            padding: 80px 0;
        }

        .section-space-sm {
            padding: 40px 0;
        }

        .section-heading {
            max-width: 760px;
            margin-bottom: 34px;
        }

        .section-heading h2 {
            font-weight: 800;
            letter-spacing: 0;
        }

        .section-heading p {
            color: var(--home-muted);
            margin: 0;
        }

        .feature-card,
        .trainer-card,
        .package-card,
        .path-card,
        .bmi-card,
        .blog-card {
            height: 100%;
            border: 1px solid var(--home-line);
            border-radius: 8px;
            background: #ffffff;
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
        }

        .feature-card:hover,
        .trainer-card:hover,
        .package-card:hover,
        .path-card:hover,
        .blog-card:hover {
            transform: translateY(-4px);
            border-color: rgba(0, 156, 255, 0.35);
            box-shadow: 0 16px 34px rgba(25, 28, 36, 0.1);
        }

        .feature-icon,
        .path-icon {
            width: 48px;
            height: 48px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            background: var(--home-primary);
            border-radius: 8px;
            font-size: 1.2rem;
        }

        .muted-copy {
            color: var(--home-muted);
        }

        .trainer-photo {
            width: 96px;
            height: 96px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #ffffff;
            box-shadow: 0 8px 22px rgba(25, 28, 36, 0.14);
        }

        .trainer-band {
            height: 70px;
            border-radius: 8px 8px 0 0;
            background: linear-gradient(135deg, var(--home-primary), var(--home-success));
        }

        .badge-soft {
            color: var(--home-primary-dark);
            background: rgba(0, 156, 255, 0.12);
            border-radius: 999px;
            padding: 6px 10px;
            font-weight: 700;
            font-size: 0.84rem;
        }

        .package-card {
            display: flex;
            flex-direction: column;
            padding: 28px;
        }

        .package-price {
            color: var(--home-primary);
            font-size: 2.15rem;
            font-weight: 800;
        }

        .package-list {
            list-style: none;
            padding: 0;
            margin: 22px 0;
        }

        .package-list li {
            display: flex;
            gap: 10px;
            margin-bottom: 12px;
            color: var(--home-muted);
        }

        .package-list i {
            color: var(--home-success);
            margin-top: 4px;
        }

        .soft-band {
            background: var(--home-soft);
            border-top: 1px solid var(--home-line);
            border-bottom: 1px solid var(--home-line);
        }
        
        .bmi-card {
            box-shadow: 0 16px 34px rgba(25, 28, 36, 0.08);
        }
        
        .bmi-card label {
            color: var(--home-ink);
            font-weight: 700;
        }
        
        .bmi-card .form-control {
            min-height: 48px;
            border-radius: 8px;
            border-color: var(--home-line);
        }
        
        .bmi-result {
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: rgba(0, 156, 255, 0.08);
            border: 1px solid rgba(0, 156, 255, 0.18);
            border-radius: 8px;
            padding: 22px;
        }
        
        .bmi-result strong {
            color: var(--home-primary);
            font-size: 3rem;
            line-height: 1;
            font-weight: 800;
        }
        
        .bmi-range {
            display: grid;
            gap: 10px;
        }
        
        .bmi-range-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            background: #ffffff;
            border: 1px solid var(--home-line);
            border-radius: 8px;
            padding: 12px 14px;
        }
        
        .bmi-range-row strong {
            color: var(--home-ink);
        }
        
        .blog-card {
            overflow: hidden;
        }
        
        .blog-card img {
            width: 100%;
            aspect-ratio: 16 / 10;
            object-fit: cover;
            background: var(--home-soft);
        }
        
        .blog-meta {
            color: var(--home-muted);
            font-size: 0.88rem;
            font-weight: 700;
        }
        
        .join-band {
            color: #ffffff;
            background:
                linear-gradient(135deg, rgba(25, 28, 36, 0.92), rgba(0, 120, 196, 0.88)),
                url("${pageContext.request.contextPath}/img/user.jpg") center/cover;
        }

        .join-band .muted-copy {
            color: rgba(255, 255, 255, 0.78);
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

        @media (max-width: 991.98px) {
            .home-nav {
                order: 3;
                width: 100%;
                overflow-x: auto;
                padding-top: 12px;
                white-space: nowrap;
            }

            .hero-section {
                min-height: auto;
                padding-top: 46px;
            }
        }

        @media (max-width: 575.98px) {
            .hero-metric {
                grid-template-columns: 1fr;
            }

            .trainer-mosaic {
                grid-template-columns: repeat(2, 1fr);
            }

            .home-actions {
                width: 100%;
            }

            .home-actions .btn {
                flex: 1 1 auto;
            }
        }
    </style>
</head>
<body>
    <header class="home-topbar">
        <nav class="container py-3">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <a href="${pageContext.request.contextPath}/" class="d-inline-flex align-items-center gap-2 text-decoration-none">
                    <span class="brand-mark"><i class="fa fa-dumbbell"></i></span>
                    <span class="brand-title">GCMS<br><small class="fw-semibold text-primary">Phòng tập hiện đại</small></span>
                </a>

                <div class="home-nav d-flex justify-content-center">
                    <a href="#gioi-thieu">Giới thiệu</a>
                    <a href="${pageContext.request.contextPath}/pt/list">Danh sách PT</a>
                    <a href="#goi-tap">Gói tập</a>
                    <a href="#bmi">Tính BMI</a>
                    <a href="${pageContext.request.contextPath}/blogs">Blog</a>
                    <a href="${pageContext.request.contextPath}/policies">Chính sách</a>
                    <a href="#tien-ich">Tiện ích</a>
                    <a href="#lien-he">Liên hệ</a>
                </div>

                <div class="home-actions d-flex align-items-center gap-2 flex-wrap justify-content-end">
                    <c:choose>
                        <c:when test="${not empty homeUser}">
                            <span class="home-user-pill">
                                <img src="${pageContext.request.contextPath}/${not empty homeUser.avatarPath ? homeUser.avatarPath : 'img/user.jpg'}" alt="${homeUser.fullName}">
                                <span>${homeUser.fullName}</span>
                            </span>
                            <a href="${pageContext.request.contextPath}${dashboardPath}" class="btn btn-primary">
                                <i class="fa fa-tachometer-alt me-1"></i>Bảng điều khiển
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">
                                <i class="fa fa-sign-out-alt me-1"></i>Đăng xuất
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                                <i class="fa fa-sign-in-alt me-1"></i>Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                                <i class="fa fa-user-plus me-1"></i>Đăng ký thành viên
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center g-5">
                    <div class="col-lg-7">
                        <div class="hero-copy">
                            <span class="eyebrow"><i class="fa fa-bolt"></i> Không gian tập luyện cho mọi mục tiêu</span>
                            <h1 class="hero-title mt-4 mb-4">Tập luyện thông minh hơn cùng GCMS</h1>
                            <p class="hero-text mb-4">
                                Khám phá đội ngũ huấn luyện viên cá nhân, lựa chọn gói tập phù hợp và bắt đầu hành trình rèn luyện với trải nghiệm rõ ràng, nhanh gọn, dễ theo dõi.
                            </p>
                            <div class="d-flex flex-wrap gap-3">
                                <c:choose>
                                    <c:when test="${not empty homeUser}">
                                        <a href="${pageContext.request.contextPath}${dashboardPath}" class="btn btn-primary btn-lg px-4">
                                            Vào bảng điều khiển
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-lg px-4">
                                            Bắt đầu đăng ký
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="#goi-tap" class="btn btn-outline-dark btn-lg px-4">
                                    Xem gói tập
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="hero-panel">
                            <div class="trainer-mosaic">
                                <img src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/coach_huy_dd.png" alt="Huấn luyện viên dinh dưỡng">
                                <img src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/le_anh_khoa_cardio.png" alt="Huấn luyện viên cardio">
                                <img src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/vu_duc_long_boxing.png" alt="Huấn luyện viên boxing">
                            </div>
                            <div class="p-4">
                                <h5 class="fw-bold mb-2">Đội ngũ PT đang sẵn sàng đồng hành</h5>
                                <p class="muted-copy mb-0">Tư vấn theo thể trạng, theo dõi tiến độ và điều chỉnh giáo án theo từng giai đoạn tập luyện.</p>
                            </div>
                            <div class="hero-metric">
                                <div>
                                    <span class="metric-number">7+</span>
                                    <span class="metric-label">Chuyên môn</span>
                                </div>
                                <div>
                                    <span class="metric-number">24/7</span>
                                    <span class="metric-label">Theo dõi</span>
                                </div>
                                <div>
                                    <span class="metric-number">3</span>
                                    <span class="metric-label">Gói nổi bật</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="gioi-thieu" class="section-space">
            <div class="container">
                <div class="section-heading">
                    <span class="badge-soft">Giới thiệu</span>
                    <h2 class="mt-3 mb-3">Một điểm đến cho lịch tập, PT và gói hội viên</h2>
                    <p>GCMS giúp phòng tập vận hành mạch lạc hơn, đồng thời giúp hội viên dễ tiếp cận thông tin quan trọng trước khi đăng ký.</p>
                </div>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="feature-card p-4">
                            <span class="feature-icon mb-4"><i class="fa fa-calendar-check"></i></span>
                            <h5 class="fw-bold">Lộ trình rõ ràng</h5>
                            <p class="muted-copy mb-0">Từ người mới bắt đầu đến người tập lâu năm đều có thể chọn lộ trình phù hợp với sức khỏe và mục tiêu cá nhân.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card p-4">
                            <span class="feature-icon mb-4"><i class="fa fa-user-shield"></i></span>
                            <h5 class="fw-bold">Đội ngũ đáng tin cậy</h5>
                            <p class="muted-copy mb-0">Các PT được phân theo chuyên môn như tăng cơ, giảm mỡ, cardio, boxing, yoga và dinh dưỡng.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card p-4">
                            <span class="feature-icon mb-4"><i class="fa fa-chart-line"></i></span>
                            <h5 class="fw-bold">Theo dõi tiến độ</h5>
                            <p class="muted-copy mb-0">Hệ thống hỗ trợ quản lý hồ sơ, gói tập và thanh toán để trải nghiệm tại phòng tập liền mạch hơn.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="pt-hien-tai" class="section-space soft-band">
            <div class="container">
                <div class="d-flex align-items-end justify-content-between flex-wrap gap-3 mb-4">
                    <div class="section-heading mb-0">
                        <span class="badge-soft">PT hiện tại</span>
                        <h2 class="mt-3 mb-3">Huấn luyện viên tiêu biểu</h2>
                        <p>Những gương mặt đại diện cho các hướng tập luyện phổ biến tại phòng tập.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/pt/list" class="btn btn-outline-primary">
                        Xem danh sách PT
                    </a>
                </div>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="trainer-card overflow-hidden text-center">
                            <div class="trainer-band"></div>
                            <div class="px-4 pb-4" style="margin-top: -48px;">
                                <img class="trainer-photo mb-3" src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/coach_huy_dd.png" alt="PT Huy dinh dưỡng">
                                <h5 class="fw-bold mb-1">PT Huy</h5>
                                <span class="badge-soft">Dinh dưỡng</span>
                                <p class="muted-copy mt-3 mb-0">Đồng hành xây dựng chế độ ăn và thói quen tập luyện bền vững.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="trainer-card overflow-hidden text-center">
                            <div class="trainer-band"></div>
                            <div class="px-4 pb-4" style="margin-top: -48px;">
                                <img class="trainer-photo mb-3" src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/le_anh_khoa_cardio.png" alt="PT Anh Khoa cardio">
                                <h5 class="fw-bold mb-1">PT Anh Khoa</h5>
                                <span class="badge-soft">Cardio</span>
                                <p class="muted-copy mt-3 mb-0">Tối ưu sức bền, nhịp tim và khả năng vận động cho lịch tập năng động.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="trainer-card overflow-hidden text-center">
                            <div class="trainer-band"></div>
                            <div class="px-4 pb-4" style="margin-top: -48px;">
                                <img class="trainer-photo mb-3" src="${pageContext.request.contextPath}/assets/uploads/pt-avatar/vu_duc_long_boxing.png" alt="PT Đức Long boxing">
                                <h5 class="fw-bold mb-1">PT Đức Long</h5>
                                <span class="badge-soft">Boxing</span>
                                <p class="muted-copy mt-3 mb-0">Tăng phản xạ, sức mạnh toàn thân và tinh thần kỷ luật trong từng buổi tập.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="goi-tap" class="section-space">
            <div class="container">
                <div class="section-heading">
                    <span class="badge-soft">Danh sách gói tập</span>
                    <h2 class="mt-3 mb-3">Chọn gói phù hợp với nhịp sống của bạn</h2>
                    <p>Các gói bên dưới được đồng bộ trực tiếp từ hệ thống dữ liệu GCMS.</p>
                </div>
                <div class="row g-4">
                    <c:choose>
                        <c:when test="${empty activePackages}">
                            <div class="col-12 text-center text-muted py-5">
                                <i class="fa fa-box-open fa-3x mb-3 text-secondary"></i>
                                <p class="mb-0">Hiện tại chưa có gói tập nào đang hoạt động trong hệ thống.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="pkg" items="${activePackages}">
                                <div class="col-lg-4">
                                    <div class="package-card h-100 d-flex flex-column ${pkg.durationMonths == 3 ? 'border-primary shadow-sm' : ''}">
                                        <div class="d-flex align-items-center justify-content-between mb-3">
                                            <h4 class="fw-bold mb-0">${pkg.packageName}</h4>
                                            <span class="badge ${pkg.durationMonths == 3 ? 'bg-primary' : 'bg-light text-primary border'}">${pkg.durationMonths} tháng</span>
                                        </div>
                                        <div class="package-price mb-3">
                                            <fmt:formatNumber value="${pkg.price}" type="number" maxFractionDigits="0"/> đ
                                        </div>
                                        <p class="muted-copy mb-4">${pkg.description}</p>
                                        <ul class="package-list mb-4 mt-auto">
                                            <li><i class="fa fa-check"></i><span>Vào phòng tập trong giờ hoạt động</span></li>
                                            <li><i class="fa fa-check"></i><span>Hỗ trợ theo dõi hồ sơ hội viên</span></li>
                                            <c:if test="${pkg.durationMonths >= 3}">
                                                <li><i class="fa fa-check"></i><span>Theo dõi tiến độ định kỳ</span></li>
                                            </c:if>
                                        </ul>
                                        <c:choose>
                                            <c:when test="${not empty homeUser}">
                                                <a href="${pageContext.request.contextPath}${dashboardPath}" class="btn ${pkg.durationMonths == 3 ? 'btn-primary' : 'btn-outline-primary'} mt-auto w-100 py-2">
                                                    Vào tài khoản
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/register" class="btn ${pkg.durationMonths == 3 ? 'btn-primary' : 'btn-outline-primary'} mt-auto w-100 py-2">
                                                    Đăng ký ngay
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
        
        <section id="bmi" class="section-space soft-band">
            <div class="container">
                <div class="row g-4 align-items-stretch">
                    <div class="col-lg-5">
                        <div class="section-heading mb-4">
                            <span class="badge-soft">Tính BMI</span>
                            <h2 class="mt-3 mb-3">Kiểm tra nhanh chỉ số cơ thể trước buổi tập</h2>
                            <p>BMI giúp bạn có điểm tham chiếu ban đầu để chọn mục tiêu tăng cơ, giảm mỡ hoặc duy trì thể trạng cùng PT.</p>
                        </div>
                        <div class="bmi-range">
                            <div class="bmi-range-row">
                                <strong>Dưới 18.5</strong>
                                <span class="muted-copy">Thiếu cân</span>
                            </div>
                            <div class="bmi-range-row">
                                <strong>18.5 - 24.9</strong>
                                <span class="muted-copy">Cân đối</span>
                            </div>
                            <div class="bmi-range-row">
                                <strong>25 - 29.9</strong>
                                <span class="muted-copy">Thừa cân</span>
                            </div>
                            <div class="bmi-range-row">
                                <strong>Từ 30</strong>
                                <span class="muted-copy">Béo phì</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="bmi-card p-4 p-lg-5">
                            <form id="bmiForm" novalidate>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="bmiHeight" class="form-label">Chiều cao (cm)</label>
                                        <input id="bmiHeight" class="form-control" type="number" min="80" max="230" step="0.1" placeholder="Ví dụ: 170">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="bmiWeight" class="form-label">Cân nặng (kg)</label>
                                        <input id="bmiWeight" class="form-control" type="number" min="25" max="250" step="0.1" placeholder="Ví dụ: 65">
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary px-4">
                                            <i class="fa fa-calculator me-2"></i>Tính BMI
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <div class="bmi-result mt-4" aria-live="polite">
                                <span class="blog-meta mb-2">Chỉ số BMI của bạn</span>
                                <strong id="bmiValue">--</strong>
                                <p id="bmiMessage" class="muted-copy mb-0 mt-3">Nhập chiều cao và cân nặng để xem kết quả.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section id="tien-ich" class="section-space soft-band">
            <div class="container">
                <div class="section-heading">
                    <span class="badge-soft">Tiện ích</span>
                    <h2 class="mt-3 mb-3">Trải nghiệm gọn gàng từ lúc đăng ký</h2>
                    <p>Trang chủ kết nối nhanh đến các luồng quan trọng, giúp khách mới và hội viên hiện tại tiếp cận đúng nơi cần đến.</p>
                </div>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="path-card p-4">
                            <span class="path-icon mb-4"><i class="fa fa-id-card"></i></span>
                            <h5 class="fw-bold">Tạo tài khoản</h5>
                            <p class="muted-copy mb-0">Đăng ký hội viên và xác minh thông tin theo luồng có sẵn của hệ thống.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="path-card p-4">
                            <span class="path-icon mb-4"><i class="fa fa-running"></i></span>
                            <h5 class="fw-bold">Chọn mục tiêu</h5>
                            <p class="muted-copy mb-0">Tăng cơ, giảm mỡ, phục hồi thể lực, cardio, boxing hoặc yoga.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="path-card p-4">
                            <span class="path-icon mb-4"><i class="fa fa-handshake"></i></span>
                            <h5 class="fw-bold">Ghép PT</h5>
                            <p class="muted-copy mb-0">Xem danh sách huấn luyện viên và chọn người phù hợp với lộ trình.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="path-card p-4">
                            <span class="path-icon mb-4"><i class="fa fa-receipt"></i></span>
                            <h5 class="fw-bold">Quản lý gói</h5>
                            <p class="muted-copy mb-0">Thông tin gói tập, hóa đơn và trạng thái được nhân viên cập nhật trong hệ thống.</p>
                        </div>
                    </div>
                </div>
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
                        <a href="#gioi-thieu" class="text-muted text-decoration-none small">Giới thiệu</a>
                        <a href="${pageContext.request.contextPath}/pt/list" class="text-muted text-decoration-none small">Danh sách PT</a>
                        <a href="#goi-tap" class="text-muted text-decoration-none small">Gói tập</a>
                        <a href="#bmi" class="text-muted text-decoration-none small">Tính BMI</a>
                        <a href="#goi-tap" class="text-muted text-decoration-none small">Danh mục</a>
                        <a href="${pageContext.request.contextPath}/policies" class="text-muted text-decoration-none small">Chính sách</a>
                    </div>
                </div>
                <div class="col-6 col-lg-2">
                    <h6 class="text-white fw-bold">Tài khoản</h6>
                    <div class="d-grid gap-2">
                        <c:choose>
                            <c:when test="${not empty homeUser}">
                                <a href="${pageContext.request.contextPath}${dashboardPath}" class="text-muted text-decoration-none small">Bảng điều khiển</a>
                                <a href="${pageContext.request.contextPath}${profilePath}" class="text-muted text-decoration-none small">Hồ sơ cá nhân</a>
                                <a href="${pageContext.request.contextPath}/logout" class="text-muted text-decoration-none small">Đăng xuất</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="text-muted text-decoration-none small">Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none small">Đăng ký thành viên</a>
                            </c:otherwise>
                        </c:choose>
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
    <jsp:include page="common/chatbot.jsp" />
    <script>
        (function () {
            const form = document.getElementById("bmiForm");
            const heightInput = document.getElementById("bmiHeight");
            const weightInput = document.getElementById("bmiWeight");
            const bmiValue = document.getElementById("bmiValue");
            const bmiMessage = document.getElementById("bmiMessage");
            
            if (!form || !heightInput || !weightInput || !bmiValue || !bmiMessage) {
                return;
            }
            
            function getBmiStatus(bmi) {
                if (bmi < 18.5) {
                    return "Bạn đang ở nhóm thiếu cân. Hãy ưu tiên dinh dưỡng đầy đủ và lịch tập tăng sức mạnh.";
                }
                
                if (bmi < 25) {
                    return "Bạn đang ở nhóm cân đối. Duy trì lịch tập đều và theo dõi tiến độ định kỳ.";
                }
                
                if (bmi < 30) {
                    return "Bạn đang ở nhóm thừa cân. Cardio vừa sức kết hợp tập kháng lực sẽ là hướng phù hợp.";
                }
                
                return "Bạn đang ở nhóm béo phì. Nên bắt đầu với cường độ an toàn và trao đổi thêm với PT.";
            }
            
            function calculateBmi() {
                const height = Number.parseFloat(heightInput.value);
                const weight = Number.parseFloat(weightInput.value);
                
                if (!Number.isFinite(height) || !Number.isFinite(weight)) {
                    bmiValue.textContent = "--";
                    bmiMessage.textContent = "Nhập chiều cao và cân nặng để xem kết quả.";
                    return;
                }
                
                if (height <= 0 || weight <= 0) {
                    bmiValue.textContent = "--";
                    bmiMessage.textContent = "Chiều cao và cân nặng cần lớn hơn 0.";
                    return;
                }
                
                const heightInMeters = height / 100;
                const bmi = weight / (heightInMeters * heightInMeters);
                bmiValue.textContent = bmi.toFixed(1);
                bmiMessage.textContent = getBmiStatus(bmi);
            }
            
            form.addEventListener("submit", function (event) {
                event.preventDefault();
                calculateBmi();
            });
            heightInput.addEventListener("input", calculateBmi);
            weightInput.addEventListener("input", calculateBmi);
        })();
    </script>
</body>
</html>
