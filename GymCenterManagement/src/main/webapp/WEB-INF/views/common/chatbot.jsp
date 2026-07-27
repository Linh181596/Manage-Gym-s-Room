<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty sessionScope.currentUser || sessionScope.currentUser.role == 'Member'}">
<link href="${pageContext.request.contextPath}/css/chatbot.css?v=faq-select-utf8-20260727" rel="stylesheet">

<div id="chatBot" class="chatbot" data-context-path="${pageContext.request.contextPath}">
    <button type="button" id="chatBotToggle" class="chatbot__toggle"
            aria-label="Mo FAQ" title="FAQ">
        <i class="fa fa-comments"></i>
        <span class="chatbot__badge">FAQ</span>
    </button>

    <section id="chatBotWindow" class="chatbot__window" aria-label="FAQ" aria-hidden="true">
        <div class="chatbot__header">
            <div class="chatbot__assistant">
                <span class="chatbot__avatar chatbot__avatar--bot">
                    <i class="fa fa-dumbbell"></i>
                </span>
                <div>
                    <h6>FAQ Gym</h6>
                    <small>Chọn câu hỏi để xem câu trả lời</small>
                </div>
            </div>
            <div class="chatbot__actions">
                <button type="button" id="chatBotClear" class="chatbot__icon-button"
                        aria-label="Lam moi hoi thoai" title="Làm mới">
                    <i class="fa fa-redo"></i>
                </button>
                <button type="button" id="chatBotClose" class="chatbot__icon-button"
                        aria-label="Dong FAQ" title="Đóng">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div id="chatBotMessages" class="chatbot__messages" aria-live="polite"></div>
        <div id="chatBotError" class="chatbot__error d-none"></div>

        <div class="chatbot__question-panel">
            <div id="chatBotCategories" class="chatbot__categories" aria-label="Danh mục câu hỏi"></div>
            <div id="chatBotQuestionCount" class="chatbot__question-count"></div>
            <div id="chatBotQuestions" class="chatbot__questions" aria-live="polite"></div>
        </div>
    </section>
</div>

<script charset="UTF-8" src="${pageContext.request.contextPath}/js/chatbot.js?v=faq-select-utf8-20260727"></script>
</c:if>
