(function () {
    if (window.gymFAQChatBoxLoaded) {
        return;
    }
    window.gymFAQChatBoxLoaded = true;
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
        const searchInput = document.getElementById("chatBotSearch");
        const categoriesContainer = document.getElementById("chatBotCategories");
        const questionCount = document.getElementById("chatBotQuestionCount");
        const questionsContainer = document.getElementById("chatBotQuestions");
        const chatHeader = chatWindow ? chatWindow.querySelector(".chatbot__header") : null;

        if (!toggleButton || !closeButton || !chatWindow || !messagesContainer
                || !searchInput || !categoriesContainer || !questionsContainer) {
            return;
        }

        const positionStorageKey = "gymFAQChatBotPosition";
        const dragDistance = 5;
        const visibleQuestionLimit = 60;
        const supportsPointerEvents = "PointerEvent" in window;
        const categoryLabels = {
            "account": "Tài khoản",
            "contact": "Liên hệ",
            "equipment": "Thiết bị",
            "facilities": "Cơ sở vật chất",
            "feedback": "Góp ý/Khiếu nại",
            "general gym information": "Thông tin phòng gym",
            "goodbye": "Kết thúc",
            "greeting": "Chào hỏi",
            "invoice": "Hóa đơn",
            "membership management": "Quản lý hội viên",
            "membership package": "Gói hội viên",
            "membership registration": "Đăng ký hội viên",
            "opening hours": "Giờ mở cửa",
            "payment": "Thanh toán",
            "personal trainer": "Huấn luyện viên cá nhân",
            "policies": "Chính sách/Nội quy",
            "training advice": "Tư vấn tập luyện"
        };
        let historyLoaded = false;
        let faqsLoaded = false;
        let faqs = [];
        let currentCategory = "all";
        let loadingAnswer = false;
        let typingElement = null;
        let dragState = null;
        let ignoreNextToggleClick = false;

        function openChat() {
            root.classList.add("is-open");
            chatWindow.setAttribute("aria-hidden", "false");
            updateWindowPlacement();
            loadHistory();
            loadFAQs();
            setTimeout(function () {
                searchInput.focus();
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
                // Browser storage can be disabled; dragging still works during the current page view.
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
            const windowHeight = Math.min(760, viewport.height - 72);
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

        function getEventPoint(event) {
            const touch = event.touches && event.touches.length > 0
                    ? event.touches[0]
                    : event.changedTouches && event.changedTouches.length > 0
                            ? event.changedTouches[0]
                            : null;

            return {
                clientX: touch ? touch.clientX : event.clientX,
                clientY: touch ? touch.clientY : event.clientY
            };
        }

        function addDragListeners() {
            if (supportsPointerEvents) {
                document.addEventListener("pointermove", moveDrag);
                document.addEventListener("pointerup", endDrag);
                document.addEventListener("pointercancel", endDrag);
                return;
            }

            document.addEventListener("mousemove", moveDrag);
            document.addEventListener("mouseup", endDrag);
            document.addEventListener("touchmove", moveDrag, {passive: false});
            document.addEventListener("touchend", endDrag);
            document.addEventListener("touchcancel", endDrag);
        }

        function removeDragListeners() {
            if (supportsPointerEvents) {
                document.removeEventListener("pointermove", moveDrag);
                document.removeEventListener("pointerup", endDrag);
                document.removeEventListener("pointercancel", endDrag);
                return;
            }

            document.removeEventListener("mousemove", moveDrag);
            document.removeEventListener("mouseup", endDrag);
            document.removeEventListener("touchmove", moveDrag);
            document.removeEventListener("touchend", endDrag);
            document.removeEventListener("touchcancel", endDrag);
        }

        function beginDrag(event, fromToggle) {
            if (event.button !== undefined && event.button !== 0) {
                return;
            }
            if (!fromToggle && event.target.closest("button, textarea, input, a")) {
                return;
            }

            const rect = root.getBoundingClientRect();
            const point = getEventPoint(event);
            dragState = {
                startX: point.clientX,
                startY: point.clientY,
                startLeft: rect.left,
                startTop: rect.top,
                moved: false,
                fromToggle: fromToggle
            };

            root.classList.add("is-dragging");
            addDragListeners();
        }

        function moveDrag(event) {
            if (!dragState) {
                return;
            }

            const point = getEventPoint(event);
            const deltaX = point.clientX - dragState.startX;
            const deltaY = point.clientY - dragState.startY;
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
            removeDragListeners();

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
            icon.className = userMessage ? "fa fa-user" : "fa fa-database";
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
                noiDung: "Xin chào!\n\nVui lòng chọn một câu hỏi trong database FAQ bên dưới để xem câu trả lời từ hệ thống.",
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
            content.textContent = "Đang lấy câu trả lời từ database...";

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

        function setAnswerLoading(value) {
            loadingAnswer = value;
            root.classList.toggle("is-answering", value);
            Array.prototype.forEach.call(questionsContainer.querySelectorAll("button"), function (button) {
                button.disabled = value;
            });
        }

        function normalizeText(value) {
            return (value || "")
                    .toLowerCase()
                    .replace(/đ/g, "d")
                    .normalize("NFD")
                    .replace(/[\u0300-\u036f]/g, "")
                    .replace(/[^a-z0-9\s]/g, " ")
                    .replace(/\s+/g, " ")
                    .trim();
        }

        function getFAQQuestion(faq) {
            return faq ? (faq.cauHoi || faq.question || "") : "";
        }

        function getFAQCategoryValue(faq) {
            const category = faq ? (faq.danhMuc || faq.category || "") : "";
            return category && category.trim() ? category.trim() : "Khác";
        }

        function getFAQCategory(faq) {
            return getCategoryLabel(getFAQCategoryValue(faq));
        }

        function getCategoryLabel(category) {
            const safeCategory = category && category.trim() ? category.trim() : "Khác";
            const normalizedCategory = normalizeText(safeCategory);
            return categoryLabels[normalizedCategory] || safeCategory;
        }

        function getFAQKeywords(faq) {
            return faq ? (faq.tuKhoa || faq.keywords || "") : "";
        }

        function getFAQId(faq) {
            return Number(faq ? (faq.faqId || faq.faq_id || 0) : 0);
        }

        function getFAQSearchText(faq) {
            return normalizeText([
                getFAQQuestion(faq),
                getFAQCategoryValue(faq),
                getFAQCategory(faq),
                getFAQKeywords(faq)
            ].join(" "));
        }

        function renderQuestionLoading() {
            questionsContainer.innerHTML = "";
            const loading = document.createElement("div");
            loading.className = "chatbot__question-empty";
            loading.textContent = "Đang tải câu hỏi từ database...";
            questionsContainer.appendChild(loading);
            if (questionCount) {
                questionCount.textContent = "";
            }
        }

        function renderQuestionEmpty(message) {
            questionsContainer.innerHTML = "";
            const empty = document.createElement("div");
            empty.className = "chatbot__question-empty";
            empty.textContent = message;
            questionsContainer.appendChild(empty);
        }

        function buildCategories() {
            const counts = new Map();
            faqs.forEach(function (faq) {
                const category = getFAQCategoryValue(faq);
                counts.set(category, (counts.get(category) || 0) + 1);
            });

            categoriesContainer.innerHTML = "";
            appendCategoryButton("Tất cả", "all", faqs.length);
            Array.from(counts.keys())
                    .sort(function (first, second) {
                        return getCategoryLabel(first).localeCompare(getCategoryLabel(second), "vi");
                    })
                    .forEach(function (category) {
                        appendCategoryButton(getCategoryLabel(category), category, counts.get(category));
                    });
            updateCategoryButtons();
        }

        function appendCategoryButton(label, value, count) {
            const button = document.createElement("button");
            button.type = "button";
            button.className = "chatbot__category-button";
            button.dataset.category = value;
            button.setAttribute("aria-pressed", "false");

            const name = document.createElement("span");
            name.textContent = label;
            button.appendChild(name);

            const badge = document.createElement("small");
            badge.textContent = String(count || 0);
            button.appendChild(badge);

            button.addEventListener("click", function () {
                currentCategory = value;
                updateCategoryButtons();
                renderQuestions();
                if (value === "all") {
                    searchInput.focus();
                }
            });
            categoriesContainer.appendChild(button);
        }

        function updateCategoryButtons() {
            Array.prototype.forEach.call(categoriesContainer.querySelectorAll("button"), function (button) {
                const active = button.dataset.category === currentCategory;
                button.classList.toggle("is-active", active);
                button.setAttribute("aria-pressed", active ? "true" : "false");
            });
        }

        function getFilteredFAQs() {
            const query = normalizeText(searchInput.value);
            return faqs.filter(function (faq) {
                const categoryMatched = currentCategory === "all" || getFAQCategoryValue(faq) === currentCategory;
                if (!categoryMatched) {
                    return false;
                }
                if (!query) {
                    return true;
                }
                return getFAQSearchText(faq).indexOf(query) !== -1;
            });
        }

        function renderQuestions() {
            if (!faqsLoaded) {
                renderQuestionLoading();
                return;
            }

            if (faqs.length === 0) {
                if (questionCount) {
                    questionCount.textContent = "";
                }
                renderQuestionEmpty("Chưa có câu hỏi FAQ Active trong database.");
                return;
            }

            const filteredFAQs = getFilteredFAQs();
            const visibleFAQs = filteredFAQs.slice(0, visibleQuestionLimit);
            questionsContainer.innerHTML = "";

            if (questionCount) {
                if (filteredFAQs.length > 0) {
                    questionCount.textContent = "Hiển thị " + visibleFAQs.length + "/" + filteredFAQs.length + " câu hỏi";
                } else {
                    questionCount.textContent = "Không có câu hỏi phù hợp";
                }
            }

            if (filteredFAQs.length === 0) {
                renderQuestionEmpty("Không tìm thấy câu hỏi phù hợp.");
                return;
            }

            visibleFAQs.forEach(function (faq) {
                const button = document.createElement("button");
                button.type = "button";
                button.className = "chatbot__question-button";
                button.disabled = loadingAnswer;

                const title = document.createElement("span");
                title.className = "chatbot__question-title";
                title.textContent = getFAQQuestion(faq);

                const meta = document.createElement("small");
                meta.className = "chatbot__question-meta";
                meta.textContent = getFAQCategory(faq);

                button.appendChild(title);
                button.appendChild(meta);
                button.addEventListener("click", function () {
                    selectFAQ(faq);
                });
                questionsContainer.appendChild(button);
            });

            if (filteredFAQs.length > visibleQuestionLimit) {
                const hint = document.createElement("button");
                hint.type = "button";
                hint.className = "chatbot__question-hint";
                hint.textContent = "Bấm vào đây để nhập từ khóa ở ô Bộ lọc.";
                hint.addEventListener("click", function () {
                    searchInput.focus();
                });
                questionsContainer.appendChild(hint);
            }
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

        async function loadFAQs() {
            if (faqsLoaded) {
                return;
            }

            renderQuestionLoading();
            try {
                const response = await fetch(contextPath + "/chatbot/faqs", {
                    method: "GET",
                    headers: {
                        "Accept": "application/json"
                    }
                });
                const data = await response.json();
                faqs = data.thanhCong && Array.isArray(data.faqs) ? data.faqs : [];
            } catch (error) {
                faqs = [];
                showError("Không thể tải danh sách câu hỏi FAQ.");
            } finally {
                faqsLoaded = true;
                buildCategories();
                renderQuestions();
            }
        }

        async function selectFAQ(faq) {
            if (loadingAnswer) {
                return;
            }

            const faqId = getFAQId(faq);
            const question = getFAQQuestion(faq);
            if (!faqId || !question) {
                showError("Câu hỏi không hợp lệ.");
                return;
            }

            hideError();
            renderMessage({
                vaiTro: "user",
                noiDung: question,
                thoiGian: getLocalTime(),
                laNguoiDung: true
            });

            setAnswerLoading(true);
            renderSearching();

            try {
                const body = new URLSearchParams();
                body.append("faqId", String(faqId));

                const response = await fetch(contextPath + "/chatbot/answer", {
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
                    noiDung: "Có lỗi xảy ra khi lấy câu trả lời. Vui lòng thử lại sau.",
                    thoiGian: getLocalTime(),
                    laNguoiDung: false
                });
            } finally {
                setAnswerLoading(false);
                searchInput.focus();
            }
        }

        async function clearHistory() {
            if (loadingAnswer) {
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
                searchInput.focus();
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

        if (supportsPointerEvents) {
            toggleButton.addEventListener("pointerdown", function (event) {
                beginDrag(event, true);
            });
        } else {
            toggleButton.addEventListener("mousedown", function (event) {
                beginDrag(event, true);
            });
            toggleButton.addEventListener("touchstart", function (event) {
                beginDrag(event, true);
            }, {passive: true});
        }

        if (chatHeader) {
            if (supportsPointerEvents) {
                chatHeader.addEventListener("pointerdown", function (event) {
                    beginDrag(event, false);
                });
            } else {
                chatHeader.addEventListener("mousedown", function (event) {
                    beginDrag(event, false);
                });
                chatHeader.addEventListener("touchstart", function (event) {
                    beginDrag(event, false);
                }, {passive: true});
            }
        }

        closeButton.addEventListener("click", closeChat);

        if (clearButton) {
            clearButton.addEventListener("click", clearHistory);
        }

        searchInput.addEventListener("input", renderQuestions);

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
