<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>B&#225;o c&#225;o Thi&#7871;t b&#7883;</title>
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
            <a class="sub" href="${pageContext.request.contextPath}/equipment-issues?action=list">&gt; S&#7921; c&#7889; thi&#7871;t b&#7883;</a>
            <a class="sub active" href="${pageContext.request.contextPath}/equipment-reports">&gt; B&#225;o c&#225;o thi&#7871;t b&#7883;</a>
            <a class="sub" href="#">&gt; L&#7883;ch b&#7843;o tr&#236;</a>
            <a href="#"><span class="nav-icon">!</span>Qu&#7843;n l&#253; th&#244;ng b&#225;o</a>
            <a href="#"><span class="nav-icon">%</span>B&#225;o c&#225;o &amp; th&#7889;ng k&#234;</a>
            <a href="#"><span class="nav-icon">[]</span>B&#224;i vi&#7871;t &amp; ch&#237;nh s&#225;ch</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">T&#7893;ng quan / <strong>B&#225;o c&#225;o thi&#7871;t b&#7883;</strong></div>
            <div class="top-user"><span class="bell">!</span><span class="user-photo"></span><strong>Qu&#7843;n tr&#7883; vi&#234;n</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>B&#225;o c&#225;o thi&#7871;t b&#7883;</h1>
                    <p class="muted">T&#7893;ng h&#7907;p t&#236;nh tr&#7841;ng thi&#7871;t b&#7883;, s&#7921; c&#7889; v&#224; hi&#7879;u su&#7845;t v&#7853;n h&#224;nh.</p>
                </div>
                <a class="button" href="${pageContext.request.contextPath}/equipment?action=list">Xem danh s&#225;ch</a>
            </div>

            <c:if test="${not empty error}"><div class="message">${error}</div></c:if>

            <div class="cards">
                <div class="card"><div class="card-label">T&#7893;ng thi&#7871;t b&#7883;</div><div class="card-value">${report.totalEquipment}</div></div>
                <div class="card metric-card">
                    <div class="card-label">T&#7927; l&#7879; ho&#7841;t &#273;&#7897;ng</div>
                    <div class="card-value metric-value">${report.activeRateDisplay}%</div>
                    <div class="metric-track"><span style="width: ${report.activeRatePercent}%"></span></div>
                </div>
                <div class="card"><div class="card-label">T&#7893;ng s&#7921; c&#7889;</div><div class="card-value">${report.totalIssues}</div></div>
                <div class="card"><div class="card-label">Thi&#7871;t b&#7883; h&#7887;ng</div><div class="card-value">${report.broken}</div></div>
            </div>

            <div class="report-grid">
                <section class="panel chart-card">
                    <h2>Th&#7889;ng k&#234; s&#7921; c&#7889;</h2>
                    <p class="muted">S&#7889; l&#432;&#7907;ng s&#7921; c&#7889; theo tr&#7841;ng th&#225;i x&#7917; l&#253; hi&#7879;n t&#7841;i.</p>
                    <div class="bars">
                        <span class="bar yellow" style="height: ${report.pendingIssues == 0 ? 24 : report.pendingIssues * 24}px"></span>
                        <span class="bar" style="height: ${report.inProgressIssues == 0 ? 24 : report.inProgressIssues * 24}px"></span>
                        <span class="bar green" style="height: ${report.resolvedIssues == 0 ? 24 : report.resolvedIssues * 24}px"></span>
                    </div>
                    <div class="bar-labels"><span>Ch&#7901; x&#7917; l&#253;</span><span>&#272;ang x&#7917; l&#253;</span><span>&#272;&#227; kh&#7855;c ph&#7909;c</span></div>
                </section>

                <section class="panel chart-card">
                    <h2>Th&#7889;ng k&#234; tr&#7841;ng th&#225;i thi&#7871;t b&#7883;</h2>
                    <p class="muted">T&#7893;ng h&#7907;p thi&#7871;t b&#7883; ho&#7841;t &#273;&#7897;ng, b&#7843;o tr&#236; v&#224; h&#7887;ng.</p>
                    <div class="bars">
                        <span class="bar green" style="height: ${report.available == 0 ? 24 : report.available * 24}px"></span>
                        <span class="bar yellow" style="height: ${report.maintenance == 0 ? 24 : report.maintenance * 24}px"></span>
                        <span class="bar red" style="height: ${report.broken == 0 ? 24 : report.broken * 24}px"></span>
                    </div>
                    <div class="bar-labels"><span>Ho&#7841;t &#273;&#7897;ng</span><span>B&#7843;o tr&#236;</span><span>H&#7887;ng</span></div>
                </section>
            </div>

            <h2>B&#225;o c&#225;o t&#236;nh tr&#7841;ng thi&#7871;t b&#7883;</h2>
            <div class="panel table-panel">
                <table>
                    <thead>
                    <tr>
                        <th>M&#227; TB</th>
                        <th>T&#234;n thi&#7871;t b&#7883;</th>
                        <th>Lo&#7841;i</th>
                        <th>S&#7889; l&#7847;n s&#7921; c&#7889;</th>
                        <th>C&#7853;p nh&#7853;t g&#7847;n nh&#7845;t</th>
                        <th>Tr&#7841;ng th&#225;i</th>
                        <th>Ch&#7881; s&#7889;</th>
                        <th>Chi ti&#7871;t</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${report.equipments}">
                        <tr>
                            <td>#${item.equipmentCode}</td>
                            <td>${item.equipmentName}</td>
                            <td><span class="type-label">${item.equipmentTypeDisplay}</span></td>
                            <td>${item.issueCount}</td>
                            <td>${item.updatedDate}</td>
                            <td><span class="badge ${item.status}"><c:choose><c:when test="${item.status == 'Available'}">Ho&#7841;t &#273;&#7897;ng</c:when><c:when test="${item.status == 'Maintenance'}">B&#7843;o tr&#236;</c:when><c:when test="${item.status == 'Broken'}">H&#7887;ng</c:when><c:otherwise>${item.status}</c:otherwise></c:choose></span></td>
                            <td>${item.status == 'Available' ? '100%' : item.status == 'Maintenance' ? '60%' : '0%'}</td>
                            <td><a class="button small action-view" href="${pageContext.request.contextPath}/equipment?action=detail&id=${item.equipmentId}">Xem</a></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty report.equipments}">
                        <tr><td colspan="8">Ch&#432;a c&#243; thi&#7871;t b&#7883;.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <c:if test="${showPagination}">
                <div class="pagination">
                    <div class="pagination-left">
                        <div class="pagination-summary">
                            Hi&#7875;n th&#7883; ${startItem} - ${endItem} trong t&#7893;ng s&#7889; ${totalItems} thi&#7871;t b&#7883;
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
