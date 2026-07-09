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

        if (!toggleButton || !closeButton || !chatWindow || !messagesContainer || !chatForm || !input || !sendButton) {
            return;
        }

        let historyLoaded = false;
        let loading = false;
        let typingElement = null;

        function openChat() {
            root.classList.add("is-open");
            chatWindow.setAttribute("aria-hidden", "false");
            loadHistory();
            setTimeout(function () {
                input.focus();
            }, 180);
        }

        function closeChat() {
            root.classList.remove("is-open");
            chatWindow.setAttribute("aria-hidden", "true");
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
            if (root.classList.contains("is-open")) {
                closeChat();
            } else {
                openChat();
            }
        });

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
    });
})();
