<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
=========================================================================
Document    : chatbot.jsp
Created on  : 2026-07-08
Author      : Nguyễn Trí Linh (linhnt)
Description : Reusable chatbot widget for gym-related customer support
=========================================================================
--%>

<c:if test="${empty sessionScope.currentUser || sessionScope.currentUser.role == 'Member'}">
<link href="${pageContext.request.contextPath}/css/chatbot.css" rel="stylesheet">

<div id="chatBot" class="chatbot" data-context-path="${pageContext.request.contextPath}">
    <button type="button" id="chatBotToggle" class="chatbot__toggle"
            aria-label="Mở trợ lý hỗ trợ" title="Trợ lý hỗ trợ">
        <i class="fa fa-comments"></i>
        <span class="chatbot__badge">FAQ</span>
    </button>

    <section id="chatBotWindow" class="chatbot__window" aria-label="Trợ lý hỗ trợ" aria-hidden="true">
        <div class="chatbot__header">
            <div class="chatbot__assistant">
                <span class="chatbot__avatar chatbot__avatar--bot">
                    <i class="fa fa-dumbbell"></i>
                </span>
                <div>
                    <h6>Trợ lý hỗ trợ Gym</h6>
                    <small>Tra cứu câu trả lời từ hệ thống</small>
                </div>
            </div>
            <div class="chatbot__actions">
                <button type="button" id="chatBotClear" class="chatbot__icon-button"
                        aria-label="Làm mới hội thoại" title="Làm mới hội thoại">
                    <i class="fa fa-redo"></i>
                </button>
                <button type="button" id="chatBotClose" class="chatbot__icon-button"
                        aria-label="Đóng trợ lý hỗ trợ" title="Đóng">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div id="chatBotMessages" class="chatbot__messages" aria-live="polite"></div>
        <div id="chatBotError" class="chatbot__error d-none"></div>

        <form id="chatBotForm" class="chatbot__form" autocomplete="off">
            <textarea id="chatBotInput" class="chatbot__input" rows="1" maxlength="1000"
                      placeholder="Nhập câu hỏi..."></textarea>
            <button type="submit" id="chatBotSend" class="chatbot__send" aria-label="Gửi câu hỏi">
                <i class="fa fa-paper-plane"></i>
                <span>Gửi</span>
            </button>
        </form>
    </section>
</div>

<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
</c:if>
