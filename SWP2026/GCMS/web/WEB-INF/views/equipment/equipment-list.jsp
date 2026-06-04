<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Qu&#7843;n l&#253; Thi&#7871;t b&#7883;</title>
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
            <a class="sub active" href="${pageContext.request.contextPath}/equipment?action=list">&gt; Danh s&#225;ch thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-issues?action=list">&gt; S&#7921; c&#7889; thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-reports">&gt; B&#225;o c&#225;o thi&#7871;t b&#7883;</a>
            <a class="sub" href="#">&gt; L&#7883;ch b&#7843;o tr&#236;</a>
            <a href="#"><span class="nav-icon">!</span>Qu&#7843;n l&#253; th&#244;ng b&#225;o</a>
            <a href="#"><span class="nav-icon">%</span>B&#225;o c&#225;o &amp; th&#7889;ng k&#234;</a>
            <a href="#"><span class="nav-icon">[]</span>B&#224;i vi&#7871;t &amp; ch&#237;nh s&#225;ch</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">T&#7893;ng quan / <strong>Qu&#7843;n l&#253; thi&#7871;t b&#7883;</strong></div>
            <div class="top-user"><span class="bell">!</span><span class="user-photo"></span><strong>Qu&#7843;n tr&#7883; vi&#234;n</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>Qu&#7843;n l&#253; thi&#7871;t b&#7883;</h1>
                    <p class="muted">Theo d&#245;i, c&#7853;p nh&#7853;t v&#224; qu&#7843;n l&#253; tr&#7841;ng th&#225;i thi&#7871;t b&#7883; ph&#242;ng gym.</p>
                </div>
                <a class="button" href="${pageContext.request.contextPath}/equipment?action=create">+ Th&#234;m thi&#7871;t b&#7883;</a>
            </div>
            <c:if test="${not empty error}"><div class="message">${error}</div></c:if>
            <div class="cards">
                <div class="card"><div class="card-label">T&#7893;ng thi&#7871;t b&#7883;</div><div class="card-value">${counts.totalEquipment}</div></div>
                <div class="card"><div class="card-label">&#272;ang ho&#7841;t &#273;&#7897;ng</div><div class="card-value">${counts.available}</div></div>
                <div class="card"><div class="card-label">&#272;ang b&#7843;o tr&#236;</div><div class="card-value">${counts.maintenance}</div></div>
                <div class="card"><div class="card-label">H&#7887;ng</div><div class="card-value">${counts.broken}</div></div>
            </div>
            <form class="panel filters two-selects" method="get" action="${pageContext.request.contextPath}/equipment">
                <input type="hidden" name="action" value="list">
                <div class="search-wrap"><input name="keyword" value="${keyword}" placeholder="T&#236;m theo m&#227; ho&#7863;c t&#234;n thi&#7871;t b&#7883;..."></div>
                <select name="type">
                    <option value="">T&#7845;t c&#7843; lo&#7841;i</option>
                    <option value="Cardio" ${type == 'Cardio' ? 'selected' : ''}>Cardio</option>
                    <option value="Ta" ${type == 'Ta' ? 'selected' : ''}>T&#7841;</option>
                    <option value="May keo" ${type == 'May keo' ? 'selected' : ''}>M&#225;y k&#233;o</option>
                    <option value="Phu kien" ${type == 'Phu kien' ? 'selected' : ''}>Ph&#7909; ki&#7879;n</option>
                    <option value="Khac" ${type == 'Khac' ? 'selected' : ''}>Kh&#225;c</option>
                </select>
                <select name="status">
                    <option value="">T&#7845;t c&#7843; tr&#7841;ng th&#225;i</option>
                    <option value="Available" ${status == 'Available' ? 'selected' : ''}>Ho&#7841;t &#273;&#7897;ng</option>
                    <option value="Maintenance" ${status == 'Maintenance' ? 'selected' : ''}>B&#7843;o tr&#236;</option>
                    <option value="Broken" ${status == 'Broken' ? 'selected' : ''}>H&#7887;ng</option>
                </select>
                <button class="button secondary" type="submit">L&#7885;c</button>
            </form>
            <h2>Danh s&#225;ch thi&#7871;t b&#7883;</h2>
            <div class="panel table-panel">
                <table>
                    <thead><tr><th>M&#227; TB</th><th>T&#234;n thi&#7871;t b&#7883;</th><th>Lo&#7841;i</th><th>Ng&#224;y mua</th><th>Tr&#7841;ng th&#225;i</th><th>V&#7883; tr&#237;</th><th>Thao t&#225;c</th></tr></thead>
                    <tbody>
                    <c:forEach var="item" items="${equipments}">
                        <tr>
                            <td>#${item.equipmentCode}</td>
                            <td><div class="equipment-cell"><span class="thumb"><c:if test="${not empty item.imageUrl}"><img src="${item.imageUrl}" alt=""></c:if></span><strong>${item.equipmentName}</strong></div></td>
                            <td><span class="type-label">${item.equipmentTypeDisplay}</span></td>
                            <td class="date-cell">${item.purchaseDateDisplay}</td>
                            <td><span class="badge ${item.status}"><c:choose><c:when test="${item.status == 'Available'}">Ho&#7841;t &#273;&#7897;ng</c:when><c:when test="${item.status == 'Maintenance'}">B&#7843;o tr&#236;</c:when><c:when test="${item.status == 'Broken'}">H&#7887;ng</c:when><c:otherwise>${item.status}</c:otherwise></c:choose></span></td>
                            <td>${item.location}</td>
                            <td class="actions actions-nowrap"><a class="button small action-view" href="${pageContext.request.contextPath}/equipment?action=detail&id=${item.equipmentId}">Xem</a><a class="button small action-edit" href="${pageContext.request.contextPath}/equipment?action=edit&id=${item.equipmentId}">C&#7853;p nh&#7853;t</a><a class="button small danger" href="${pageContext.request.contextPath}/equipment?action=delete&id=${item.equipmentId}" onclick="return confirm('X&#243;a thi&#7871;t b&#7883; n&#224;y?')">X&#243;a</a></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty equipments}"><tr><td colspan="7">Kh&#244;ng c&#243; thi&#7871;t b&#7883; ph&#249; h&#7907;p.</td></tr></c:if>
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
