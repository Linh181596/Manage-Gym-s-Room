<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi ti&#7871;t s&#7921; c&#7889;</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/equipment.css">
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <div class="brand"><span>||</span> GCMS</div>
        <div class="profile"><div class="avatar">AD</div><div><strong>Qu&#7843;n tr&#7883; vi&#234;n</strong><div class="muted">T&#224;i kho&#7843;n qu&#7843;n tr&#7883;</div></div></div>
        <nav class="nav">
            <a href="#"><span class="nav-icon">#</span>T&#7893;ng quan</a>
            <a href="#"><span class="nav-icon">*</span>Qu&#7843;n l&#253; t&#224;i kho&#7843;n</a>
            <a href="#"><span class="nav-icon">+</span>Qu&#7843;n l&#253; g&#243;i t&#7853;p</a>
            <a href="#"><span class="nav-icon">v</span>Duy&#7879;t h&#7891; s&#417; PT</a>
            <a class="nav-parent" href="${pageContext.request.contextPath}/equipment?action=list"><span class="nav-icon">@</span>Qu&#7843;n l&#253; thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment?action=list">&gt; Danh s&#225;ch thi&#7871;t b&#7883;</a>
            <a class="sub active" href="${pageContext.request.contextPath}/equipment-issues?action=list">&gt; S&#7921; c&#7889; thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-reports">&gt; B&#225;o c&#225;o thi&#7871;t b&#7883;</a>
            <a class="sub" href="#">&gt; L&#7883;ch b&#7843;o tr&#236;</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">T&#7893;ng quan / <strong>Chi ti&#7871;t s&#7921; c&#7889;</strong></div>
            <div class="top-user"><span class="bell">!</span><span class="user-photo"></span><strong>Qu&#7843;n tr&#7883; vi&#234;n</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>#IS-${issue.issueId}</h1>
                    <p class="muted">${issue.equipmentCode} - ${issue.equipmentName}</p>
                </div>
                <div class="actions">
                    <a class="button secondary" href="${pageContext.request.contextPath}/equipment-issues?action=list">Quay l&#7841;i</a>
                    <a class="button" href="${pageContext.request.contextPath}/equipment-issues?action=edit&id=${issue.issueId}">C&#7853;p nh&#7853;t</a>
                </div>
            </div>
            <div class="panel detail-grid">
                <div class="detail-item"><span>Thi&#7871;t b&#7883;</span><strong>${issue.equipmentName}</strong></div>
                <div class="detail-item"><span>M&#227; thi&#7871;t b&#7883;</span>${issue.equipmentCode}</div>
                <div class="detail-item"><span>Lo&#7841;i s&#7921; c&#7889;</span><span class="badge type">${issue.issueTypeDisplay}</span></div>
                <div class="detail-item"><span>Ng&#432;&#7901;i b&#225;o c&#225;o</span>${issue.reporterName}</div>
                <div class="detail-item"><span>Ng&#224;y b&#225;o c&#225;o</span>${issue.reportedAtDisplay}</div>
                <div class="detail-item"><span>Tr&#7841;ng th&#225;i</span><span class="badge ${issue.status}">${issue.statusDisplay}</span></div>
                <div class="detail-item"><span>M&#244; t&#7843;</span>${issue.description}</div>
                <div class="detail-item">
                    <span>&#7842;nh s&#7921; c&#7889;</span>
                    <c:if test="${not empty issue.issueImageUrl}">
                        <span class="thumb"><img src="${issue.issueImageUrl}" alt=""></span>
                    </c:if>
                </div>
                <div class="detail-item"><span>C&#7853;p nh&#7853;t g&#7847;n nh&#7845;t</span>${issue.updatedDate}</div>
            </div>
        </section>
    </main>
</div>
</body>
</html>
