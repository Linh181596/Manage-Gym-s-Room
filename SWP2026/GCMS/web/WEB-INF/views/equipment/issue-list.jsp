<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Qu&#7843;n l&#253; S&#7921; c&#7889; Thi&#7871;t b&#7883;</title>
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
            <a href="#"><span class="nav-icon">!</span>Qu&#7843;n l&#253; th&#244;ng b&#225;o</a>
            <a href="#"><span class="nav-icon">%</span>B&#225;o c&#225;o &amp; th&#7889;ng k&#234;</a>
            <a href="#"><span class="nav-icon">[]</span>B&#224;i vi&#7871;t &amp; ch&#237;nh s&#225;ch</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">T&#7893;ng quan / <strong>Qu&#7843;n l&#253; s&#7921; c&#7889; thi&#7871;t b&#7883;</strong></div>
            <div class="top-user"><span class="bell">!</span><span class="user-photo"></span><strong>Qu&#7843;n tr&#7883; vi&#234;n</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>Qu&#7843;n l&#253; s&#7921; c&#7889; thi&#7871;t b&#7883;</h1>
                    <p class="muted">Theo d&#245;i v&#224; c&#7853;p nh&#7853;t tr&#7841;ng th&#225;i x&#7917; l&#253; s&#7921; c&#7889; thi&#7871;t b&#7883;.</p>
                </div>
                <a class="button issue-primary" href="${pageContext.request.contextPath}/equipment-issues?action=create">+ B&#225;o c&#225;o s&#7921; c&#7889;</a>
            </div>

            <c:if test="${not empty error}"><div class="message">${error}</div></c:if>

            <div class="cards">
                <div class="card"><div class="card-label">T&#7893;ng s&#7921; c&#7889;</div><div class="card-value">${counts.totalIssues}</div></div>
                <div class="card"><div class="card-label">Ch&#7901; x&#7917; l&#253;</div><div class="card-value">${counts.pendingIssues}</div></div>
                <div class="card"><div class="card-label">&#272;ang x&#7917; l&#253;</div><div class="card-value">${counts.inProgressIssues}</div></div>
                <div class="card"><div class="card-label">&#272;&#227; kh&#7855;c ph&#7909;c</div><div class="card-value">${counts.resolvedIssues}</div></div>
            </div>

            <form class="panel filters" method="get" action="${pageContext.request.contextPath}/equipment-issues">
                <input type="hidden" name="action" value="list">
                <div class="search-wrap"><input name="keyword" value="${keyword}" placeholder="T&#236;m theo thi&#7871;t b&#7883; ho&#7863;c m&#244; t&#7843;..."></div>
                <select name="status">
                    <option value="">T&#7845;t c&#7843; tr&#7841;ng th&#225;i</option>
                    <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Ch&#7901; x&#7917; l&#253;</option>
                    <option value="InProgress" ${status == 'InProgress' ? 'selected' : ''}>&#272;ang x&#7917; l&#253;</option>
                    <option value="Resolved" ${status == 'Resolved' ? 'selected' : ''}>&#272;&#227; kh&#7855;c ph&#7909;c</option>
                </select>
                <button class="button secondary" type="submit">L&#7885;c</button>
            </form>

            <h2>Danh s&#225;ch s&#7921; c&#7889;</h2>
            <div class="panel table-panel">
                <table>
                    <thead>
                    <tr>
                        <th>M&#227; SC</th>
                        <th>Thi&#7871;t b&#7883;</th>
                        <th>M&#244; t&#7843;</th>
                        <th>Lo&#7841;i s&#7921; c&#7889;</th>
                        <th>Ng&#432;&#7901;i b&#225;o c&#225;o</th>
                        <th>&#7842;nh</th>
                        <th>Ng&#224;y b&#225;o c&#225;o</th>
                        <th>Tr&#7841;ng th&#225;i</th>
                        <th class="actions-col">Thao t&#225;c</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${issues}">
                        <tr>
                            <td>#IS-${item.issueId}</td>
                            <td><div class="equipment-cell"><span class="thumb"></span><strong>${item.equipmentName}</strong></div></td>
                            <td>${item.description}</td>
                            <td><span class="badge type">${item.issueTypeDisplay}</span></td>
                            <td>${item.reporterName}</td>
                            <td><c:if test="${not empty item.issueImageUrl}"><span class="thumb"><img src="${item.issueImageUrl}" alt=""></span></c:if></td>
                            <td>${item.reportedAtDisplay}</td>
                            <td><span class="badge ${item.status}">${item.statusDisplay}</span></td>
                            <td class="actions actions-nowrap">
                                <a class="button small action-view" href="${pageContext.request.contextPath}/equipment-issues?action=detail&id=${item.issueId}">Xem</a>
                                <a class="button small action-edit" href="${pageContext.request.contextPath}/equipment-issues?action=edit&id=${item.issueId}">C&#7853;p nh&#7853;t</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty issues}">
                        <tr><td colspan="9">Kh&#244;ng c&#243; s&#7921; c&#7889; ph&#249; h&#7907;p.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <c:if test="${showPagination}">
                <div class="pagination">
                    <div class="pagination-left">
                        <div class="pagination-summary">
                            Hi&#7875;n th&#7883; ${startItem} - ${endItem} trong t&#7893;ng s&#7889; ${totalItems} s&#7921; c&#7889;
                        </div>
                    </div>
                    <div class="pagination-actions">
                        <c:choose>
                            <c:when test="${hasPrevious}">
                                <a class="page-button page-arrow" href="${queryBase}page=${previousPage}">&#8249;</a>
                            </c:when>
                            <c:otherwise>
                                <span class="page-button page-arrow disabled">&#8249;</span>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
                            <c:choose>
                                <c:when test="${pageNumber == page}">
                                    <span class="page-button active">${pageNumber}</span>
                                </c:when>
                                <c:otherwise>
                                    <a class="page-button" href="${queryBase}page=${pageNumber}">${pageNumber}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${hasNext}">
                                <a class="page-button page-arrow" href="${queryBase}page=${nextPage}">&#8250;</a>
                            </c:when>
                            <c:otherwise>
                                <span class="page-button page-arrow disabled">&#8250;</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>
        </section>
    </main>
</div>
</body>
</html>
