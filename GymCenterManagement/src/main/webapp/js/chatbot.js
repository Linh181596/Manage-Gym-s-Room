(function () {
    if (window.gymFAQChatBotLoaded) {
        return;
    }
    window.gymFAQChatBotLoaded = true;

    function ready(callback) {
        if (document.readyState === "loading") {
            document.addEventListener("DOMContentLoaded", callback);
            return;
        }
        callback();
    }

    ready(function () {
        const root = document.getElementById("chatBot");
        if (!root) {
            return;
        }

        const contextPath = root.dataset.contextPath || "";
        const toggleButton = document.getElementById("chatBotToggle");
        const closeButton = document.getElementById("chatBotClose");
        const clearButton = document.getElementById("chatBotClear");
        const chatWindow = document.getElementById("chatBotWindow");
        const messagesContainer = document.getElementById("chatBotMessages");
        const errorBox = document.getElementById("chatBotError");
        const chatForm = document.getElementById("chatBotForm");
        const input = document.getElementById("chatBotInput");
        const sendButton = document.getElementById("chatBotSend");
        const chatHeader = chatWindow ? chatWindow.querySelector(".chatbot__header") : null;

        if (!toggleButton || !closeButton || !chatWindow || !messagesContainer || !chatForm || !input || !sendButton) {
            return;
        }

        const positionStorageKey = "gymFAQChatBotPosition";
        const dragDistance = 5;
        let historyLoaded = false;
        let loading = false;
        let typingElement = null;
        let dragState = null;
        let ignoreNextToggleClick = false;

        function openChat() {
            root.classList.add("is-open");
            chatWindow.setAttribute("aria-hidden", "false");
            updateWindowPlacement();
            loadHistory();
            setTimeout(function () {
                input.focus();
            }, 180);
        }

        function closeChat() {
            root.classList.remove("is-open");
            chatWindow.setAttribute("aria-hidden", "true");
        }
        
        function clamp(value, min, max) {
            return Math.min(Math.max(value, min), max);
        }

        function getViewportSize() {
            return {
                width: window.innerWidth || document.documentElement.clientWidth,
                height: window.innerHeight || document.documentElement.clientHeight
            };
        }

        function setChatPosition(left, top, shouldSave) {
            const viewport = getViewportSize();
            const rect = root.getBoundingClientRect();
            const margin = 8;
            const width = rect.width || 64;
            const height = rect.height || 64;
            const maxLeft = Math.max(margin, viewport.width - width - margin);
            const maxTop = Math.max(margin, viewport.height - height - margin);
            const nextLeft = clamp(left, margin, maxLeft);
            const nextTop = clamp(top, margin, maxTop);

            root.style.left = nextLeft + "px";
            root.style.top = nextTop + "px";
            root.style.right = "auto";
            root.style.bottom = "auto";
            root.classList.add("is-custom-position");
            updateWindowPlacement();

            if (shouldSave) {
                saveChatPosition(nextLeft, nextTop);
            }
        }

        function saveChatPosition(left, top) {
            try {
                localStorage.setItem(positionStorageKey, JSON.stringify({
                    left: Math.round(left),
                    top: Math.round(top)
                }));
            } catch (error) {
                // Browser storage can be disabled; dragging should still work in the current page.
            }
        }

        function restoreChatPosition() {
            try {
                const savedPosition = JSON.parse(localStorage.getItem(positionStorageKey) || "null");
                if (!savedPosition || typeof savedPosition.left !== "number" || typeof savedPosition.top !== "number") {
                    updateWindowPlacement();
                    return;
                }
                setChatPosition(savedPosition.left, savedPosition.top, false);
            } catch (error) {
                updateWindowPlacement();
            }
        }

        function updateWindowPlacement() {
            const viewport = getViewportSize();
            const rootRect = root.getBoundingClientRect();
            const windowWidth = Math.min(380, viewport.width - 32);
            const windowHeight = Math.min(560, viewport.height - 120);
            const windowOffset = 82;
            const edgeMargin = 16;
            const spaceAbove = rootRect.top - windowOffset - edgeMargin;
            const spaceBelow = viewport.height - rootRect.bottom - windowOffset - edgeMargin;
            const spaceLeft = rootRect.right - edgeMargin;
            const spaceRight = viewport.width - rootRect.left - edgeMargin;
            const shouldOpenBelow = spaceAbove < windowHeight && spaceBelow > spaceAbove;
            const shouldAlignLeft = spaceLeft < windowWidth && spaceRight > spaceLeft;

            root.classList.toggle("is-window-below", shouldOpenBelow);
            root.classList.toggle("is-window-left", shouldAlignLeft);
        }

        function beginDrag(event, fromToggle) {
            if (event.button !== undefined && event.button !== 0) {
                return;
            }
            if (!fromToggle && event.target.closest("button, textarea, input, a")) {
                return;
            }

            const rect = root.getBoundingClientRect();
            dragState = {
                startX: event.clientX,
                startY: event.clientY,
                startLeft: rect.left,
                startTop: rect.top,
                moved: false,
                fromToggle: fromToggle
            };

            root.classList.add("is-dragging");
            document.addEventListener("pointermove", moveDrag);
            document.addEventListener("pointerup", endDrag);
            document.addEventListener("pointercancel", endDrag);
        }

        function moveDrag(event) {
            if (!dragState) {
                return;
            }

            const deltaX = event.clientX - dragState.startX;
            const deltaY = event.clientY - dragState.startY;
            if (!dragState.moved && Math.hypot(deltaX, deltaY) > dragDistance) {
                dragState.moved = true;
            }

            if (dragState.moved) {
                event.preventDefault();
                setChatPosition(dragState.startLeft + deltaX, dragState.startTop + deltaY, false);
            }
        }

        function endDrag() {
            if (!dragState) {
                return;
            }

            const endedState = dragState;
            const rect = root.getBoundingClientRect();
            dragState = null;
            root.classList.remove("is-dragging");
            document.removeEventListener("pointermove", moveDrag);
            document.removeEventListener("pointerup", endDrag);
            document.removeEventListener("pointercancel", endDrag);

            if (endedState.moved) {
                saveChatPosition(rect.left, rect.top);
                if (endedState.fromToggle) {
                    ignoreNextToggleClick = true;
                }
            }
        }

        function scrollToBottom() {
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function getLocalTime() {
            const now = new Date();
            return now.toLocaleTimeString("vi-VN", {
                hour: "2-digit",
                minute: "2-digit"
            });
        }

        function showError(message) {
            if (!errorBox) {
                return;
            }
            errorBox.textContent = message || "Có lỗi xảy ra.";
            errorBox.classList.remove("d-none");
        }

        function hideError() {
            if (errorBox) {
                errorBox.classList.add("d-none");
                errorBox.textContent = "";
            }
        }

        function createAvatar(userMessage) {
            const avatar = document.createElement("span");
            avatar.className = userMessage
                    ? "chatbot__avatar chatbot__avatar--user"
                    : "chatbot__avatar chatbot__avatar--bot";

            const icon = document.createElement("i");
            icon.className = userMessage ? "fa fa-user" : "fa fa-dumbbell";
            avatar.appendChild(icon);
            return avatar;
        }

        function renderMessage(message) {
            if (!message || !message.noiDung) {
                return;
            }

            const userMessage = message.laNguoiDung || message.vaiTro === "user";
            const wrapper = document.createElement("div");
            wrapper.className = "chatbot__message " + (userMessage
                    ? "chatbot__message--user"
                    : "chatbot__message--bot");

            const bubble = document.createElement("div");
            bubble.className = "chatbot__bubble";

            const content = document.createElement("p");
            content.className = "chatbot__content";
            content.textContent = message.noiDung;

            const time = document.createElement("span");
            time.className = "chatbot__time";
            time.textContent = message.thoiGian || getLocalTime();

            bubble.appendChild(content);
            bubble.appendChild(time);
            wrapper.appendChild(createAvatar(userMessage));
            wrapper.appendChild(bubble);
            messagesContainer.appendChild(wrapper);
            scrollToBottom();
        }

        function renderWelcomeFallback() {
            if (messagesContainer.children.length > 0) {
                return;
            }
            renderMessage({
                vaiTro: "bot",
                noiDung: "Xin chào!\n\nTôi là trợ lý hỗ trợ của hệ thống Manage Gym's Room.\nBạn có thể hỏi tôi về: gói tập, hội viên, huấn luyện viên, lớp học, thiết bị, thanh toán, giờ mở cửa và nội quy phòng tập.",
                thoiGian: getLocalTime(),
                laNguoiDung: false
            });
        }

        function renderSearching() {
            removeSearching();

            typingElement = document.createElement("div");
            typingElement.className = "chatbot__message chatbot__message--bot";

            const bubble = document.createElement("div");
            bubble.className = "chatbot__bubble";

            const content = document.createElement("p");
            content.className = "chatbot__content";
            content.textContent = "Đang tìm câu trả lời...";

            const typing = document.createElement("span");
            typing.className = "chatbot__typing";
            typing.innerHTML = "<span class=\"chatbot__typing-dot\"></span><span class=\"chatbot__typing-dot\"></span><span class=\"chatbot__typing-dot\"></span>";

            bubble.appendChild(content);
            bubble.appendChild(typing);
            typingElement.appendChild(createAvatar(false));
            typingElement.appendChild(bubble);
            messagesContainer.appendChild(typingElement);
            scrollToBottom();
        }

        function removeSearching() {
            if (typingElement && typingElement.parentNode) {
                typingElement.parentNode.removeChild(typingElement);
            }
            typingElement = null;
        }

        function setLoading(value) {
            loading = value;
            sendButton.disabled = value;
            input.disabled = value;
            sendButton.querySelector("span").textContent = value ? "Đang gửi..." : "Gửi";
        }

        function adjustInputHeight() {
            input.style.height = "auto";
            input.style.height = Math.min(input.scrollHeight, 112) + "px";
        }

        async function loadHistory() {
            if (historyLoaded) {
                return;
            }
            historyLoaded = true;

            try {
                const response = await fetch(contextPath + "/chatbot/history", {
                    method: "GET",
                    headers: {
                        "Accept": "application/json"
                    }
                });
                const data = await response.json();

                messagesContainer.innerHTML = "";
                if (data.thanhCong && Array.isArray(data.lichSu) && data.lichSu.length > 0) {
                    data.lichSu.forEach(renderMessage);
                } else {
                    renderWelcomeFallback();
                }
            } catch (error) {
                renderWelcomeFallback();
            }
        }

        async function sendQuestion() {
            const question = input.value.trim();
            if (!question) {
                showError("Vui lòng nhập câu hỏi.");
                input.focus();
                return;
            }

            if (loading) {
                return;
            }

            hideError();
            renderMessage({
                vaiTro: "user",
                noiDung: question,
                thoiGian: getLocalTime(),
                laNguoiDung: true
            });

            input.value = "";
            adjustInputHeight();
            setLoading(true);
            renderSearching();

            try {
                const body = new URLSearchParams();
                body.append("question", question);

                const response = await fetch(contextPath + "/chatbot/send", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
                    },
                    body: body.toString()
                });
                const data = await response.json();

                removeSearching();
                if (data.thanhCong && data.tinNhan) {
                    renderMessage(data.tinNhan);
                } else {
                    showError(data.thongBao || "Có lỗi xảy ra.");
                }
            } catch (error) {
                removeSearching();
                renderMessage({
                    vaiTro: "bot",
                    noiDung: "Có lỗi xảy ra khi tìm câu trả lời. Vui lòng thử lại sau.",
                    thoiGian: getLocalTime(),
                    laNguoiDung: false
                });
            } finally {
                setLoading(false);
                input.focus();
            }
        }

        async function clearHistory() {
            if (loading) {
                return;
            }

            hideError();
            messagesContainer.innerHTML = "";

            try {
                const response = await fetch(contextPath + "/chatbot/clear", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json"
                    }
                });
                const data = await response.json();
                if (data.thanhCong && Array.isArray(data.lichSu)) {
                    data.lichSu.forEach(renderMessage);
                } else {
                    renderWelcomeFallback();
                }
            } catch (error) {
                renderWelcomeFallback();
            } finally {
                input.focus();
            }
        }

        toggleButton.addEventListener("click", function () {
            if (ignoreNextToggleClick) {
                ignoreNextToggleClick = false;
                return;
            }
            
            if (root.classList.contains("is-open")) {
                closeChat();
            } else {
                openChat();
            }
        });
        
        toggleButton.addEventListener("pointerdown", function (event) {
            beginDrag(event, true);
        });

        if (chatHeader) {
            chatHeader.addEventListener("pointerdown", function (event) {
                beginDrag(event, false);
            });
        }
        
        closeButton.addEventListener("click", closeChat);

        if (clearButton) {
            clearButton.addEventListener("click", clearHistory);
        }

        chatForm.addEventListener("submit", function (event) {
            event.preventDefault();
            sendQuestion();
        });

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter" && !event.shiftKey) {
                event.preventDefault();
                sendQuestion();
            }
        });

        input.addEventListener("input", adjustInputHeight);
        
        window.addEventListener("resize", function () {
            if (root.classList.contains("is-custom-position")) {
                const rect = root.getBoundingClientRect();
                setChatPosition(rect.left, rect.top, true);
                return;
            }
            updateWindowPlacement();
        });

        restoreChatPosition();
    });
})();
