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
        const searchInput = document.getElementById("chatBotSearch");
        const categoriesContainer = document.getElementById("chatBotCategories");
        const questionCount = document.getElementById("chatBotQuestionCount");
        const questionsContainer = document.getElementById("chatBotQuestions");
        const chatHeader = chatWindow ? chatWindow.querySelector(".chatbot__header") : null;
        const hasTextForm = !!(chatForm && input && sendButton);
        const hasQuestionPanel = !!(categoriesContainer && questionCount && questionsContainer);

        if (!toggleButton || !closeButton || !chatWindow || !messagesContainer || (!hasTextForm && !hasQuestionPanel)) {
            return;
        }

        const faqCategories = [
            {
                label: "Thông tin phòng gym",
                icon: "fa-info-circle",
                questions: [
                    "Địa chỉ phòng gym?",
                    "Thông tin liên hệ?",
                    "Thời gian mở cửa?"
                ]
            },
            {
                label: "Hội viên",
                icon: "fa-id-card",
                questions: [
                    "Làm sao để đăng ký hội viên?",
                    "Đăng ký cần những thông tin gì?",
                    "Chỉnh sửa thông tin cá nhân như thế nào?",
                    "Quên mật khẩu thì phải làm sao?"
                ]
            },
            {
                label: "Gói tập",
                icon: "fa-dumbbell",
                questions: [
                    "Đăng ký gói tập như thế nào?",
                    "Có những gói tập nào?",
                    "Có gói tập kèm PT không?",
                    "Làm sao để gia hạn gói tập?",
                    "Có thể chuyển giao gói tập không?"
                ]
            },
            {
                label: "Thủ tục thanh toán",
                icon: "fa-credit-card",
                questions: [
                    "Có thể thanh toán bằng những hình thức nào?",
                    "Có thể thanh toán ở đâu?",
                    "Có thể xem lại hóa đơn không?"
                ]
            }
        ];

        const faqAnswers = {
            "Địa chỉ phòng gym?": "Địa chỉ phòng gym: QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội",
            "Thông tin liên hệ?": "Thông tin liên hệ: 0987654321, support@gcms.com",
            "Thời gian mở cửa?": "Thời gian mở cửa: 8:00-20:30 tất cả các ngày trong tuần",
            "Làm sao để đăng ký hội viên?": "Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc đăng ký qua mục đăng ký thành viên trên website",
            "Đăng ký cần những thông tin gì?": "Khi đăng ký hội viên bạn cần những thông tin như sau họ tên, email, số điện thoại, mật khẩu.",
            "Chỉnh sửa thông tin cá nhân như thế nào?": "Bạn có thể đăng nhập vào tài khoản cá nhân của mình và chỉnh sửa thông tin cá nhân của mình",
            "Quên mật khẩu thì phải làm sao?": "Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc đổi mật khẩu qua website",
            "Đăng ký gói tập như thế nào?": "Bạn có thể ra quầy lễ tân để được hỗ trợ hoặc thao tác trực tiếp qua website",
            "Có những gói tập nào?": "Bạn có thể xem chi tiết các gói tập trên hệ thống",
            "Có gói tập kèm PT không?": "Có. Bạn có thể xem chi tiết các gói tập với PT trên hệ thống",
            "Làm sao để gia hạn gói tập?": "Bạn có thể ra quầy lễ tân để được hỗ trợ gia hạn gói tập hoặc đăng ký gói tập mới.",
            "Có thể chuyển giao gói tập không?": "Có thể. Tuy nhiên bạn cần ra quầy lễ tân để kiểm tra thông tin gói tập và chuyển giao",
            "Có thể thanh toán bằng những hình thức nào?": "Có thể thanh toán bằng phương thức chuyển khoản và tiền mặt.",
            "Có thể thanh toán ở đâu?": "Có thể thanh toán trực tiếp tại quầy lễ tân hoặc trên website",
            "Có thể xem lại hóa đơn không?": "Bạn có thể xem lại lịch giao dịch và chi tiết hóa đơn trên website. Ngoài ra bạn có thể in biên lai cho hóa đơn đó nếu cần thiết"
        };

        const positionStorageKey = "gymFAQChatBotPosition";
        const dragDistance = 5;
        let historyLoaded = false;
        let faqsLoaded = false;
        let loading = false;
        let typingElement = null;
        let dragState = null;
        let ignoreNextToggleClick = false;
        let allFAQs = [];
        let selectedCategory = "";

        function openChat() {
            root.classList.add("is-open");
            chatWindow.setAttribute("aria-hidden", "false");
            updateWindowPlacement();
            loadHistory();
            loadFAQs();
            setTimeout(function () {
                focusMainControl();
            }, 180);
        }

        function closeChat() {
            root.classList.remove("is-open");
            chatWindow.setAttribute("aria-hidden", "true");
        }

        function focusMainControl() {
            if (hasQuestionPanel) {
                const activeCategory = categoriesContainer.querySelector(".chatbot__category-button.is-active") 
                                     || categoriesContainer.querySelector(".chatbot__category-button");
                if (activeCategory) {
                    activeCategory.focus();
                }
                return;
            }
            if (hasTextForm) {
                input.focus();
            }
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

        function createQuickReplyButton(label, onClick) {
            const button = document.createElement("button");
            button.type = "button";
            button.className = "chatbot__quick-reply";
            button.textContent = label;
            button.addEventListener("click", function () {
                if (!loading) {
                    onClick();
                }
            });
            return button;
        }

        function renderQuickReplyMessage(content, labels, onSelect) {
            const wrapper = document.createElement("div");
            wrapper.className = "chatbot__message chatbot__message--bot";

            const bubble = document.createElement("div");
            bubble.className = "chatbot__bubble chatbot__bubble--choices";

            const paragraph = document.createElement("p");
            paragraph.className = "chatbot__content";
            paragraph.textContent = content;

            const choices = document.createElement("div");
            choices.className = "chatbot__quick-replies";

            labels.forEach(function (label) {
                choices.appendChild(createQuickReplyButton(label, function () {
                    onSelect(label);
                }));
            });

            const time = document.createElement("span");
            time.className = "chatbot__time";
            time.textContent = getLocalTime();

            bubble.appendChild(paragraph);
            bubble.appendChild(choices);
            bubble.appendChild(time);
            wrapper.appendChild(createAvatar(false));
            wrapper.appendChild(bubble);
            messagesContainer.appendChild(wrapper);
            scrollToBottom();
        }

        function renderFormCategories() {
            if (!hasTextForm || hasQuestionPanel) {
                return;
            }
            renderQuickReplyMessage(
                    "Bạn muốn tìm hiểu nhóm thông tin nào?",
                    faqCategories.map(function (category) {
                        return category.label;
                    }),
                    renderFormCategoryQuestions
                    );
        }

        function renderFormCategoryQuestions(categoryLabel) {
            const category = faqCategories.find(function (item) {
                return item.label === categoryLabel;
            });
            if (!category) {
                return;
            }

            hideError();
            renderMessage({
                vaiTro: "user",
                noiDung: category.label,
                thoiGian: getLocalTime(),
                laNguoiDung: true
            });
            renderQuickReplyMessage("Bạn chọn câu hỏi cụ thể nhé:", category.questions, answerQuestion);
        }

        function renderWelcomeFallback() {
            if (messagesContainer.children.length > 0) {
                return;
            }
            renderMessage({
                vaiTro: "bot",
                noiDung: "Xin chào! Bạn có thể chọn nhóm câu hỏi bên dưới để xem các câu hỏi cụ thể.",
                thoiGian: getLocalTime(),
                laNguoiDung: false
            });
            renderFormCategories();
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
            if (sendButton) {
                sendButton.disabled = value;
                const label = sendButton.querySelector("span");
                if (label) {
                    label.textContent = value ? "Đang gửi..." : "Gửi";
                }
            }
            if (input) {
                input.disabled = value;
            }
            if (questionsContainer) {
                questionsContainer.querySelectorAll("button").forEach(function (button) {
                    button.disabled = value;
                });
            }
        }

        function adjustInputHeight() {
            if (!input) {
                return;
            }
            input.style.height = "auto";
            input.style.height = Math.min(input.scrollHeight, 112) + "px";
        }

        function hasUserMessage(messages) {
            if (!Array.isArray(messages)) {
                return false;
            }
            return messages.some(function (message) {
                return message && (message.laNguoiDung || message.vaiTro === "user");
            });
        }

        function normalizeText(value) {
            return (value || "")
                    .toLowerCase()
                    .normalize("NFD")
                    .replace(/[\u0300-\u036f]/g, "")
                    .replace(/đ/g, "d")
                    .replace(/[^a-z0-9\s]/g, " ")
                    .replace(/\s+/g, " ")
                    .trim();
        }

        function findFAQByQuestion(question) {
            const normalizedQuestion = normalizeText(question);
            return allFAQs.find(function (faq) {
                return normalizeText(faq.cauHoi) === normalizedQuestion;
            }) || null;
        }

        function clearElement(element) {
            if (element) {
                element.innerHTML = "";
            }
        }

        function renderCategories() {
            if (!hasQuestionPanel) {
                return;
            }

            clearElement(categoriesContainer);
            faqCategories.forEach(function (category) {
                const button = document.createElement("button");
                button.type = "button";
                button.className = "chatbot__category-button";
                button.classList.toggle("is-active", category.label === selectedCategory);
                button.innerHTML = "<i class=\"fa " + category.icon + "\" aria-hidden=\"true\"></i><span></span>";
                button.querySelector("span").textContent = category.label;
                button.addEventListener("click", function () {
                    selectedCategory = category.label;
                    renderCategories();
                    renderCategoryQuestions(category);
                });
                categoriesContainer.appendChild(button);
            });

            if (!selectedCategory) {
                questionCount.textContent = "Ch\u1ecdn m\u1ed9t nh\u00f3m c\u00e2u h\u1ecfi \u0111\u1ec3 xem c\u00e1c c\u00e2u h\u1ecfi c\u1ee5 th\u1ec3.";
                questionsContainer.innerHTML = "<div class=\"chatbot__empty\">Vui l\u00f2ng ch\u1ecdn m\u1ed9t nh\u00f3m c\u00e2u h\u1ecfi.</div>";
            }
        }

        function renderCategoryQuestions(category) {
            if (!hasQuestionPanel || !category) {
                return;
            }

            clearElement(questionsContainer);
            questionCount.textContent = "C\u00f3 " + category.questions.length + " c\u00e2u h\u1ecfi trong nh\u00f3m \"" + category.label + "\".";

            category.questions.forEach(function (question) {
                const button = document.createElement("button");
                button.type = "button";
                button.className = "chatbot__question-button";
                button.innerHTML = "<span></span><i class=\"fa fa-chevron-right\" aria-hidden=\"true\"></i>";
                button.querySelector("span").textContent = question;
                button.addEventListener("click", function () {
                    answerQuestion(question);
                });
                questionsContainer.appendChild(button);
            });
        }

        async function loadFAQs() {
            if (!hasQuestionPanel || faqsLoaded) {
                renderCategories();
                return;
            }

            try {
                const response = await fetch(contextPath + "/chatbot/faqs", {
                    method: "GET",
                    headers: {
                        "Accept": "application/json"
                    }
                });
                const data = await response.json();
                if (data.thanhCong && Array.isArray(data.faqs) && data.faqs.length > 0) {
                    allFAQs = data.faqs;
                    
                    // Clear the local static answers to enforce server-side clean answers
                    for (let key in faqAnswers) {
                        delete faqAnswers[key];
                    }
                    
                    // Group faqs into categories dynamically!
                    const categoriesMap = {};
                    allFAQs.forEach(function (faq) {
                        const cat = faq.danhMuc || "Khác";
                        if (!categoriesMap[cat]) {
                            categoriesMap[cat] = [];
                        }
                        categoriesMap[cat].push(faq.cauHoi);
                    });
                    
                    // Clear existing elements in faqCategories array
                    faqCategories.length = 0;
                    
                    // Map categories map to faqCategories structure
                    const iconMap = {
                        "Thông tin phòng gym": "fa-info-circle",
                        "Hội viên": "fa-id-card",
                        "Gói tập": "fa-dumbbell",
                        "Thủ tục thanh toán": "fa-credit-card"
                    };
                    
                    Object.keys(categoriesMap).forEach(function (catName) {
                        faqCategories.push({
                            label: catName,
                            icon: iconMap[catName] || "fa-question-circle",
                            questions: categoriesMap[catName]
                        });
                    });
                }
            } catch (error) {
                console.error("Failed to load FAQs dynamically, using static fallback", error);
            }

            faqsLoaded = true;
            renderCategories();
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
                    if (!hasUserMessage(data.lichSu)) {
                        renderWelcomeFallback();
                        renderFormCategories();
                    }
                } else {
                    renderWelcomeFallback();
                }
            } catch (error) {
                renderWelcomeFallback();
            }
        }

        async function postAnswer(endpoint, body) {
            setLoading(true);
            renderSearching();

            try {
                const response = await fetch(contextPath + endpoint, {
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
                    showError(data.thongBao || "C\u00f3 l\u1ed7i x\u1ea3y ra.");
                }
            } catch (error) {
                removeSearching();
                renderMessage({
                    vaiTro: "bot",
                    noiDung: "C\u00f3 l\u1ed7i x\u1ea3y ra khi t\u00ecm c\u00e2u tr\u1ea3 l\u1eddi. Vui l\u00f2ng th\u1eed l\u1ea1i sau.",
                    thoiGian: getLocalTime(),
                    laNguoiDung: false
                });
            } finally {
                setLoading(false);
                focusMainControl();
            }
        }

        async function answerFAQ(faq) {
            if (!faq || loading) {
                return;
            }

            hideError();
            renderMessage({
                vaiTro: "user",
                noiDung: faq.cauHoi,
                thoiGian: getLocalTime(),
                laNguoiDung: true
            });

            const body = new URLSearchParams();
            body.append("faqId", faq.faqId);
            postAnswer("/chatbot/answer", body);
        }

        async function answerQuestion(question) {
            if (faqAnswers[question]) {
                hideError();
                renderMessage({
                    vaiTro: "user",
                    noiDung: question,
                    thoiGian: getLocalTime(),
                    laNguoiDung: true
                });
                renderMessage({
                    vaiTro: "bot",
                    noiDung: faqAnswers[question],
                    thoiGian: getLocalTime(),
                    laNguoiDung: false
                });
                return;
            }

            const faq = findFAQByQuestion(question);
            if (faq) {
                answerFAQ(faq);
                return;
            }
            sendQuestionText(question);
        }

        async function sendQuestionText(question) {
            if (!question) {
                showError("Vui l\u00f2ng nh\u1eadp c\u00e2u h\u1ecfi.");
                focusMainControl();
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

            if (input) {
                input.value = "";
                adjustInputHeight();
            }

            const body = new URLSearchParams();
            body.append("question", question);
            postAnswer("/chatbot/send", body);
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
                    if (!hasUserMessage(data.lichSu)) {
                        renderWelcomeFallback();
                        renderFormCategories();
                    }
                } else {
                    renderWelcomeFallback();
                }
            } catch (error) {
                renderWelcomeFallback();
            } finally {
                selectedCategory = "";
                renderCategories();
                focusMainControl();
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

        if (hasTextForm) {
            chatForm.addEventListener("submit", function (event) {
                event.preventDefault();
                sendQuestionText(input.value.trim());
            });

            input.addEventListener("keydown", function (event) {
                if (event.key === "Enter" && !event.shiftKey) {
                    event.preventDefault();
                    sendQuestionText(input.value.trim());
                }
            });

            input.addEventListener("input", adjustInputHeight);
        }

        if (hasQuestionPanel) {
            renderCategories();
        }

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
