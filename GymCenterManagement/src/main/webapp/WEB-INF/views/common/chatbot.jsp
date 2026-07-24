<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
=========================================================================
Document    : chatbot.jsp
Created on  : 2026-07-08
Author      : Nguyễn Trí Linh (linhnt)
Description : Reusable FAQ chat box powered by database questions
=========================================================================
--%>

<c:if test="${empty sessionScope.currentUser || sessionScope.currentUser.role == 'Member'}">
<link href="${pageContext.request.contextPath}/css/chatbot.css?v=faq-chatbox-20260723-4" rel="stylesheet">

<div id="chatBot" class="chatbot" data-context-path="${pageContext.request.contextPath}">
    <button type="button" id="chatBotToggle" class="chatbot__toggle"
            aria-label="Mở chat box FAQ" title="Chat box FAQ">
        <i class="fa fa-comments"></i>
        <span class="chatbot__badge">FAQ</span>
    </button>

    <section id="chatBotWindow" class="chatbot__window" aria-label="Chat box câu hỏi FAQ" aria-hidden="true">
        <div class="chatbot__header">
            <div class="chatbot__assistant">
                <span class="chatbot__avatar chatbot__avatar--bot">
                    <i class="fa fa-database"></i>
                </span>
                <div>
                    <h6>FAQ Assistant</h6>
                    <small>Chọn câu hỏi từ database</small>
                </div>
            </div>
            <div class="chatbot__actions">
                <button type="button" id="chatBotClear" class="chatbot__icon-button"
                        aria-label="Làm mới hội thoại" title="Làm mới hội thoại">
                    <i class="fa fa-redo"></i>
                </button>
                <button type="button" id="chatBotClose" class="chatbot__icon-button"
                        aria-label="Đóng chat box FAQ" title="Đóng">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div id="chatBotMessages" class="chatbot__messages" aria-live="polite"></div>
        <div id="chatBotError" class="chatbot__error d-none"></div>

        <div class="chatbot__question-panel">
            <label class="chatbot__search" for="chatBotSearch">
                <i class="fa fa-search" aria-hidden="true"></i>
                <span class="chatbot__search-label">Bộ lọc</span>
                <input id="chatBotSearch" class="chatbot__search-input" type="search" maxlength="120"
                       placeholder="Nhập từ khóa để thu hẹp câu hỏi">
            </label>
            <div id="chatBotCategories" class="chatbot__categories" aria-label="Danh mục câu hỏi"></div>
            <div id="chatBotQuestionCount" class="chatbot__question-count"></div>
            <div id="chatBotQuestions" class="chatbot__questions" aria-live="polite"></div>
        </div>
    </section>
</div>

<script src="${pageContext.request.contextPath}/js/chatbot.js?v=faq-chatbox-20260723-4"></script>
</c:if>
