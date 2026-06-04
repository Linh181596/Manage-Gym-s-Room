<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${issue.issueId > 0 ? 'C&#7853;p nh&#7853;t s&#7921; c&#7889;' : 'B&#225;o c&#225;o s&#7921; c&#7889;'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/equipment.css">
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <div class="brand"><span>▮▮</span> GCMS</div>
        <div class="profile"><div class="avatar">AD</div><div><strong>Demo Admin</strong><div class="muted">Qu&#7843;n tr&#7883; vi&#234;n</div></div></div>
        <nav class="nav">
            <a href="#"><span class="nav-icon">▣</span>T&#7893;ng quan</a>
            <a href="#"><span class="nav-icon">●</span>Qu&#7843;n l&#253; T&#224;i kho&#7843;n</a>
            <a href="#"><span class="nav-icon">▮</span>Qu&#7843;n l&#253; G&#243;i t&#7853;p</a>
            <a href="#"><span class="nav-icon">✓</span>Duy&#7879;t h&#7891; s&#417; PT</a>
            <a class="nav-parent" href="${pageContext.request.contextPath}/equipment?action=list"><span class="nav-icon">⚙</span>Qu&#7843;n l&#253; Thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment?action=list">› Qu&#7843;n l&#253; Thi&#7871;t b&#7883;</a>
            <a class="sub active" href="${pageContext.request.contextPath}/equipment-issues?action=list">› Qu&#7843;n l&#253; S&#7921; c&#7889; Thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-reports">› Xem B&#225;o c&#225;o Thi&#7871;t b&#7883;</a>
            <a class="sub" href="#">› Qu&#7843;n l&#253; L&#7883;ch B&#7843;o tr&#236;</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">Dashboard / <strong>${issue.issueId > 0 ? 'C&#7853;p nh&#7853;t s&#7921; c&#7889;' : 'B&#225;o c&#225;o s&#7921; c&#7889;'}</strong></div>
            <div class="top-user"><span class="bell">♧</span><span class="user-photo"></span><strong>Administrator</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>${issue.issueId > 0 ? 'C&#7853;p nh&#7853;t s&#7921; c&#7889;' : 'B&#225;o c&#225;o s&#7921; c&#7889;'}</h1>
                    <p class="muted">S&#7921; c&#7889; m&#7899;i m&#7863;c &#273;&#7883;nh Pending. C&#7853;p nh&#7853;t tr&#7841;ng th&#225;i s&#7869; &#273;&#7893;i tr&#7841;ng th&#225;i thi&#7871;t b&#7883; li&#234;n quan.</p>
                </div>
                <a class="button secondary" href="${pageContext.request.contextPath}/equipment-issues?action=list">Quay l&#7841;i</a>
            </div>

            <c:if test="${not empty error}"><div class="message">${error}</div></c:if>

            <form class="panel form-card" method="post" action="${pageContext.request.contextPath}/equipment-issues?action=${issue.issueId > 0 ? 'edit' : 'create'}" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${issue.issueId}">
                <input type="hidden" name="currentIssueImageUrl" value="${issue.issueImageUrl}">
                <div class="form-grid">
                    <div class="field">
                        <label>Thi&#7871;t b&#7883;</label>
                        <select name="equipmentId" required>
                            <option value="">Ch&#7885;n thi&#7871;t b&#7883;</option>
                            <c:forEach var="equipment" items="${equipments}">
                                <option value="${equipment.equipmentId}" ${equipment.equipmentId == issue.equipmentId ? 'selected' : ''}>
                                    ${equipment.equipmentCode} - ${equipment.equipmentName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="field">
                        <label>Ng&#432;&#7901;i b&#225;o c&#225;o</label>
                        <input name="reportedByName" value="${issue.createdBy}" placeholder="Nh&#7853;p t&#234;n ng&#432;&#7901;i b&#225;o c&#225;o" required maxlength="50">
                    </div>
                    <div class="field">
                        <label>Lo&#7841;i s&#7921; c&#7889;</label>
                        <select name="issueType" required>
                            <option value="">Ch&#7885;n lo&#7841;i s&#7921; c&#7889;</option>
                            <option value="Hu hong" ${issue.issueType == 'Hu hong' ? 'selected' : ''}>H&#432; h&#7887;ng</option>
                            <option value="Bao tri" ${issue.issueType == 'Bao tri' ? 'selected' : ''}>B&#7843;o tr&#236;</option>
                            <option value="An toan" ${issue.issueType == 'An toan' ? 'selected' : ''}>An to&#224;n</option>
                            <option value="Khac" ${issue.issueType == 'Khac' ? 'selected' : ''}>Kh&#225;c</option>
                        </select>
                    </div>
                    <div class="field">
                        <label>Tr&#7841;ng th&#225;i x&#7917; l&#253;</label>
                        <select name="status" ${issue.issueId > 0 ? '' : 'disabled'}>
                            <option value="Pending" ${issue.status == 'Pending' || empty issue.status ? 'selected' : ''}>Ch&#7901; x&#7917; l&#253;</option>
                            <option value="InProgress" ${issue.status == 'InProgress' ? 'selected' : ''}>&#272;ang x&#7917; l&#253;</option>
                            <option value="Resolved" ${issue.status == 'Resolved' ? 'selected' : ''}>&#272;&#227; kh&#7855;c ph&#7909;c</option>
                        </select>
                    </div>
                    <div class="field full">
                        <label>M&#244; t&#7843; s&#7921; c&#7889;</label>
                        <textarea name="description" required>${issue.description}</textarea>
                    </div>
                    <div class="field full">
                        <label>&#7842;nh s&#7921; c&#7889;</label>
                        <input type="file" name="issueImageFile" accept="image/*">
                        <c:if test="${not empty issue.issueImageUrl}">
                            <p class="muted">&#7842;nh hi&#7879;n t&#7841;i: ${issue.issueImageUrl}</p>
                            <span class="thumb"><img src="${issue.issueImageUrl}" alt=""></span>
                        </c:if>
                    </div>
                </div>
                <div class="form-actions">
                    <a class="button secondary" href="${pageContext.request.contextPath}/equipment-issues?action=list">H&#7911;y</a>
                    <button class="button" type="submit">${issue.issueId > 0 ? 'C&#7853;p nh&#7853;t s&#7921; c&#7889;' : 'L&#432;u b&#225;o c&#225;o'}</button>
                </div>
            </form>
        </section>
    </main>
</div>
</body>
</html>
