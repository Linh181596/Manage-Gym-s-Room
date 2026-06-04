<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${edit ? 'C&#7853;p nh&#7853;t th&#244;ng tin thi&#7871;t b&#7883;' : 'Th&#234;m thi&#7871;t b&#7883;'}</title>
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
            <a class="sub active" href="${pageContext.request.contextPath}/equipment?action=list">› Qu&#7843;n l&#253; Thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-issues?action=list">› Qu&#7843;n l&#253; S&#7921; c&#7889; Thi&#7871;t b&#7883;</a>
            <a class="sub" href="${pageContext.request.contextPath}/equipment-reports">› Xem B&#225;o c&#225;o Thi&#7871;t b&#7883;</a>
            <a class="sub" href="#">› Qu&#7843;n l&#253; L&#7883;ch B&#7843;o tr&#236;</a>
        </nav>
    </aside>
    <main class="main">
        <div class="topbar">
            <div class="breadcrumb">Dashboard / <strong>${edit ? 'C&#7853;p nh&#7853;t th&#244;ng tin thi&#7871;t b&#7883;' : 'Th&#234;m thi&#7871;t b&#7883;'}</strong></div>
            <div class="top-user"><span class="bell">♧</span><span class="user-photo"></span><strong>Administrator</strong></div>
        </div>
        <section class="content">
            <div class="page-header">
                <div>
                    <h1>${edit ? 'C&#7853;p nh&#7853;t th&#244;ng tin thi&#7871;t b&#7883;' : 'Th&#234;m thi&#7871;t b&#7883;'}</h1>
                </div>
                <a class="button secondary" href="${pageContext.request.contextPath}/equipment?action=list">Quay l&#7841;i</a>
            </div>

            <c:if test="${not empty error}"><div class="message">${error}</div></c:if>

            <form id="equipmentForm" class="panel form-card" method="post" action="${pageContext.request.contextPath}/equipment" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${equipment.equipmentId}">
                <input type="hidden" name="imageUrl" value="${equipment.imageUrl}">
                <div class="form-grid">
                    <div class="field">
                        <label>M&#227; thi&#7871;t b&#7883;</label>
                        <input name="equipmentCode" value="${equipment.equipmentCode}" required maxlength="50">
                    </div>
                    <div class="field">
                        <label>T&#234;n thi&#7871;t b&#7883;</label>
                        <input name="equipmentName" value="${equipment.equipmentName}" required maxlength="100">
                    </div>
                    <div class="field">
                        <label>Lo&#7841;i thi&#7871;t b&#7883;</label>
                        <select name="equipmentType" required>
                            <option value="">Ch&#7885;n lo&#7841;i</option>
                            <option value="Cardio" ${equipment.equipmentType == 'Cardio' ? 'selected' : ''}>Cardio</option>
                            <option value="Ta" ${equipment.equipmentType == 'Ta' ? 'selected' : ''}>T&#7841;</option>
                            <option value="May keo" ${equipment.equipmentType == 'May keo' ? 'selected' : ''}>M&#225;y k&#233;o</option>
                            <option value="Phu kien" ${equipment.equipmentType == 'Phu kien' ? 'selected' : ''}>Ph&#7909; ki&#7879;n</option>
                            <option value="Khac" ${equipment.equipmentType == 'Khac' || empty equipment.equipmentType ? 'selected' : ''}>Kh&#225;c</option>
                        </select>
                    </div>
                    <div class="field">
                        <label>Ng&#224;y mua</label>
                        <input type="date" name="purchaseDate" value="${equipment.purchaseDate}" required>
                    </div>
                    <div class="field">
                        <label>Ng&#224;y h&#7871;t b&#7843;o h&#224;nh</label>
                        <input type="date" name="warrantyDate" value="${equipment.warrantyDate}" required>
                    </div>
                    <div class="field">
                        <label>V&#7883; tr&#237;</label>
                        <input name="location" value="${equipment.location}" required maxlength="100">
                    </div>
                    <div class="field">
                        <label>Tr&#7841;ng th&#225;i</label>
                        <select name="status" required>
                            <option value="">Ch&#7885;n tr&#7841;ng th&#225;i</option>
                            <option value="Available" ${equipment.status == 'Available' ? 'selected' : ''}>Ho&#7841;t &#273;&#7897;ng</option>
                            <option value="Maintenance" ${equipment.status == 'Maintenance' ? 'selected' : ''}>B&#7843;o tr&#236;</option>
                            <option value="Broken" ${equipment.status == 'Broken' ? 'selected' : ''}>H&#7887;ng</option>
                        </select>
                    </div>
                    <div class="field full">
                        <label>&#7842;nh thi&#7871;t b&#7883;</label>
                        <input type="file" name="imageFile" accept="image/*" ${empty equipment.imageUrl ? 'required' : ''}>
                        <c:if test="${not empty equipment.imageUrl}">
                            <p class="muted">&#7842;nh hi&#7879;n t&#7841;i: ${equipment.imageUrl}</p>
                            <span class="thumb"><img src="${equipment.imageUrl}" alt=""></span>
                        </c:if>
                    </div>
                </div>
                <div class="form-actions">
                    <a class="button secondary" href="${pageContext.request.contextPath}/equipment?action=list">H&#7911;y</a>
                    <button class="button" type="submit">${edit ? 'C&#7853;p nh&#7853;t' : 'L&#432;u thi&#7871;t b&#7883;'}</button>
                </div>
            </form>
        </section>
    </main>
</div>
<script>
    const purchaseDateInput = document.querySelector('input[name="purchaseDate"]');
    const warrantyDateInput = document.querySelector('input[name="warrantyDate"]');
    const equipmentForm = document.getElementById('equipmentForm');

    function syncWarrantyMinDate() {
        if (purchaseDateInput.value) {
            warrantyDateInput.min = purchaseDateInput.value;
        } else {
            warrantyDateInput.removeAttribute('min');
        }
    }

    purchaseDateInput.addEventListener('change', syncWarrantyMinDate);
    warrantyDateInput.addEventListener('input', function () {
        warrantyDateInput.setCustomValidity('');
    });
    equipmentForm.addEventListener('submit', function (event) {
        syncWarrantyMinDate();
        if (purchaseDateInput.value && warrantyDateInput.value && warrantyDateInput.value < purchaseDateInput.value) {
            event.preventDefault();
            warrantyDateInput.setCustomValidity('Ng\u00e0y h\u1ebft b\u1ea3o h\u00e0nh kh\u00f4ng \u0111\u01b0\u1ee3c tr\u01b0\u1edbc ng\u00e0y mua.');
            warrantyDateInput.reportValidity();
        } else {
            warrantyDateInput.setCustomValidity('');
        }
    });
    syncWarrantyMinDate();
</script>
</body>
</html>
