/**
 * =========================================================================
 * @file          : ChatBotServiceImpl.java
 * @description   : Service implementation for processing user questions, matching FAQs, and managing chat history
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.ChatBotDAO;
import com.mycompany.gymcentermanagement.dao.impl.ChatBotDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.ChatMessageModel;
import com.mycompany.gymcentermanagement.model.entity.FAQModel;
import com.mycompany.gymcentermanagement.service.ChatBotService;
import com.mycompany.gymcentermanagement.utils.ChatBotConstant;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class ChatBotServiceImpl implements ChatBotService {

    private static final Logger LOGGER = Logger.getLogger(ChatBotServiceImpl.class.getName());
    private static final Pattern DIACRITICS_PATTERN = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    private static final Pattern SPECIAL_CHARACTER_PATTERN = Pattern.compile("[^a-z0-9\\s]");
    private static final Pattern MULTI_SPACE_PATTERN = Pattern.compile("\\s+");
    private static final Set<String> STOP_WORDS = new HashSet<>(Arrays.asList(
            "a", "ai", "anh", "ban", "bang", "bao", "bi", "biet", "cac", "cai", "can", "cho", "co",
            "cua", "duoc", "em", "gi", "giup", "hoi", "khong", "khi", "la", "lam", "luc", "may",
            "hay", "minh", "muon", "nao", "nay", "nen", "nhu", "nhung", "noi", "o", "phai", "phong",
            "ra", "sao", "the", "thi", "toi", "trong", "tu", "va", "ve", "voi", "vui", "xin"
    ));

    private final ChatBotDAO chatBotDAO = new ChatBotDAOImpl();

    @Override
    public List<ChatMessageModel> getChatHistory(HttpSession session) {
        return resolveChatHistory(session);
    }

    @Override
    public List<FAQModel> getAvailableFAQs() {
        try {
            return chatBotDAO.getActiveFAQs(ChatBotConstant.FAQ_LIST_LIMIT);
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Không thể tải danh sách FAQ cho chat box.", ex);
            return new ArrayList<>();
        }
    }

    @Override
    public ChatMessageModel answerQuestion(String question, HttpSession session) {
        String normalizedInput = normalizeInput(question);
        List<ChatMessageModel> history = resolveChatHistory(session);

        if (normalizedInput == null || normalizedInput.isBlank()) {
            ChatMessageModel botMessage = ChatMessageModel.bot(ChatBotConstant.EMPTY_QUESTION_MESSAGE);
            addMessage(history, botMessage);
            return botMessage;
        }

        if (normalizedInput.length() > ChatBotConstant.MAX_QUESTION_LENGTH) {
            ChatMessageModel botMessage = ChatMessageModel.bot(ChatBotConstant.TOO_LONG_QUESTION_MESSAGE);
            addMessage(history, botMessage);
            return botMessage;
        }

        ChatMessageModel userMessage = ChatMessageModel.user(normalizedInput);
        addMessage(history, userMessage);

        ChatMessageModel botMessage = ChatMessageModel.bot(findAnswer(normalizedInput));
        addMessage(history, botMessage);
        return botMessage;
    }

    @Override
    public ChatMessageModel answerFAQ(int faqId, HttpSession session) {
        List<ChatMessageModel> history = resolveChatHistory(session);

        try {
            FAQModel faq = chatBotDAO.getActiveFAQById(faqId);
            if (faq == null) {
                ChatMessageModel botMessage = ChatMessageModel.bot(ChatBotConstant.FAQ_NOT_AVAILABLE_MESSAGE);
                addMessage(history, botMessage);
                return botMessage;
            }

            addMessage(history, ChatMessageModel.user(faq.getQuestion()));
            ChatMessageModel botMessage = ChatMessageModel.bot(faq.getAnswer());
            addMessage(history, botMessage);
            return botMessage;
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Không thể lấy câu trả lời FAQ cho chat box.", ex);
            ChatMessageModel botMessage = ChatMessageModel.bot(ChatBotConstant.SYSTEM_ERROR_MESSAGE);
            addMessage(history, botMessage);
            return botMessage;
        }
    }

    @Override
    public List<ChatMessageModel> clearChatHistory(HttpSession session) {
        List<ChatMessageModel> history = createDefaultHistory();
        if (session != null) {
            session.setAttribute(ChatBotConstant.SESSION_CHAT_HISTORY_KEY, history);
        }
        return history;
    }

    private String findAnswer(String question) {
        String normalizedQuestion = normalizeForSearch(question);
        List<String> keywords = extractKeywords(normalizedQuestion);
        if (keywords.isEmpty() && normalizedQuestion != null && !normalizedQuestion.isBlank()) {
            keywords.add(normalizedQuestion);
        }
        if (keywords.isEmpty()) {
            return ChatBotConstant.DEFAULT_NOT_FOUND_MESSAGE;
        }

        try {
            List<FAQModel> candidates = chatBotDAO.searchFAQs(normalizedQuestion, keywords, ChatBotConstant.SEARCH_LIMIT);
            FAQModel bestFAQ = selectBestFAQ(normalizedQuestion, keywords, candidates);
            if (bestFAQ == null || bestFAQ.getAnswer() == null || bestFAQ.getAnswer().isBlank()) {
                return ChatBotConstant.DEFAULT_NOT_FOUND_MESSAGE;
            }
            return bestFAQ.getAnswer();
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Không thể tìm FAQ cho chatbot.", ex);
            return ChatBotConstant.SYSTEM_ERROR_MESSAGE;
        }
    }

    private FAQModel selectBestFAQ(String normalizedQuestion, List<String> keywords, List<FAQModel> candidates) {
        FAQModel bestFAQ = null;
        int bestScore = 0;
        String preferredCategory = resolvePreferredCategory(normalizedQuestion);

        if (candidates == null) {
            return null;
        }

        for (FAQModel faq : candidates) {
            int score = calculateScore(normalizedQuestion, keywords, faq, preferredCategory);
            if (score > bestScore) {
                bestScore = score;
                bestFAQ = faq;
            }
        }

        int minimumScore = normalizedQuestion.length() <= 8 ? 18 : ChatBotConstant.MIN_MATCH_SCORE;
        return bestScore >= minimumScore ? bestFAQ : null;
    }

    private int calculateScore(String normalizedQuestion, List<String> keywords, FAQModel faq, String preferredCategory) {
        if (faq == null) {
            return 0;
        }

        String question = normalizeForSearch(faq.getQuestion());
        String faqKeywords = normalizeForSearch(faq.getKeywords());
        String category = normalizeForSearch(faq.getCategory());
        String searchableText = (question + " " + faqKeywords + " " + category).trim();
        int score = 0;

        if (!normalizedQuestion.isBlank() && question.equals(normalizedQuestion)) {
            score += 300;
        }

        if (!normalizedQuestion.isBlank() && containsSearchPhrase(searchableText, normalizedQuestion)) {
            score += 80;
        }

        for (String keyword : keywords) {
            if (keyword.length() < 2) {
                continue;
            }
            if (containsSearchToken(question, keyword)) {
                score += 14;
            }
            if (containsSearchToken(faqKeywords, keyword)) {
                score += 18;
            }
            if (containsSearchToken(category, keyword)) {
                score += 6;
            }
            if (keyword.equals(question) || keyword.equals(category) || keyword.equals(faqKeywords)) {
                score += 40;
            }
        }

        if (!preferredCategory.isBlank() && preferredCategory.equals(category)) {
            score += 120;
        }
        return score;
    }

    private String resolvePreferredCategory(String normalizedQuestion) {
        if (normalizedQuestion == null || normalizedQuestion.isBlank()) {
            return "";
        }

        if (containsAny(normalizedQuestion, "pt", "personal trainer", "huan luyen vien", "hlv", "trainer")) {
            return "personal trainer";
        }
        if (containsAny(normalizedQuestion, "hoa don", "bien lai", "vat", "invoice")) {
            return "invoice";
        }
        if (containsAny(normalizedQuestion, "thanh toan", "chuyen khoan", "qr", "visa", "mastercard", "payment", "tien mat")) {
            return "payment";
        }
        if (containsAny(normalizedQuestion, "may tap", "thiet bi", "may chay", "dumbbell", "squat", "bao hong")) {
            return "equipment";
        }
        if (containsAny(normalizedQuestion, "phong tam", "locker", "wifi", "may lanh", "nuoc uong", "gui xe", "co so vat chat")) {
            return "facilities";
        }
        if (containsAny(normalizedQuestion, "mo cua", "dong cua", "gio mo", "gio dong", "chu nhat", "ngay le", "tet")) {
            return "opening hours";
        }
        if (containsAny(normalizedQuestion, "quen mat khau", "doi mat khau", "dang nhap", "doi email", "doi so dien thoai", "profile", "ho so", "account")) {
            return "account";
        }
        if (containsAny(normalizedQuestion, "dia chi", "hotline", "email", "facebook", "website", "google map", "lien he")) {
            return "contact";
        }
        if (containsAny(normalizedQuestion, "gop y", "khieu nai", "danh gia", "phan hoi", "feedback")) {
            return "feedback";
        }
        if (containsAny(normalizedQuestion, "hoan tien", "chinh sach", "noi quy", "bao luu", "chuyen nhuong")) {
            return "policies";
        }
        if (containsAny(normalizedQuestion, "gia han", "het han", "han goi", "han goi tap", "xem han", "ngay het han",
                "con may ngay", "thoi han", "doi goi", "nang cap", "huy goi", "membership renewal", "membership expiration")) {
            return "membership management";
        }
        if (containsAny(normalizedQuestion, "goi tap", "package", "membership package", "gia goi", "chi phi goi", "goi thang", "goi nam", "khuyen mai", "giam gia")) {
            return "membership package";
        }
        if (containsAny(normalizedQuestion, "dang ky", "dang ki", "hoi vien", "membership registration", "join gym", "tham gia", "tao tai khoan", "mo tai khoan")) {
            return "membership registration";
        }
        if (containsAny(normalizedQuestion, "tam biet", "bye", "goodbye", "hen gap lai")) {
            return "goodbye";
        }
        if (containsAny(normalizedQuestion, "xin chao", "chao", "hello", "hi", "hey", "alo", "chatbot")) {
            return "greeting";
        }
        return "";
    }

    private boolean containsAny(String value, String... keywords) {
        for (String keyword : keywords) {
            if (containsSearchToken(value, keyword)) {
                return true;
            }
        }
        return false;
    }

    private boolean containsSearchPhrase(String value, String phrase) {
        if (value == null || phrase == null || phrase.isBlank()) {
            return false;
        }
        if (!phrase.contains(" ") && phrase.length() <= 2) {
            return containsWholeToken(value, phrase);
        }
        return value.contains(phrase);
    }

    private boolean containsSearchToken(String value, String token) {
        if (value == null || token == null || token.isBlank()) {
            return false;
        }
        if (token.contains(" ") || token.length() > 2) {
            return value.contains(token);
        }
        return containsWholeToken(value, token);
    }

    private boolean containsWholeToken(String value, String token) {
        if (value == null || token == null || token.isBlank()) {
            return false;
        }
        for (String currentToken : value.split(" ")) {
            if (token.equals(currentToken)) {
                return true;
            }
        }
        return false;
    }

    private List<String> extractKeywords(String normalizedQuestion) {
        List<String> keywords = new ArrayList<>();
        if (normalizedQuestion == null || normalizedQuestion.isBlank()) {
            return keywords;
        }

        for (String token : normalizedQuestion.split(" ")) {
            if (token.isBlank() || STOP_WORDS.contains(token)) {
                continue;
            }
            if (!keywords.contains(token)) {
                keywords.add(token);
            }
        }
        return keywords;
    }

    private String normalizeInput(String value) {
        if (value == null) {
            return null;
        }
        return value.trim();
    }

    private String normalizeForSearch(String value) {
        if (value == null) {
            return "";
        }

        String normalized = value.toLowerCase()
                .replace('\u0111', 'd')
                .replace('\u0110', 'd');
        normalized = Normalizer.normalize(normalized, Normalizer.Form.NFD);
        normalized = DIACRITICS_PATTERN.matcher(normalized).replaceAll("");
        normalized = SPECIAL_CHARACTER_PATTERN.matcher(normalized).replaceAll(" ");
        return MULTI_SPACE_PATTERN.matcher(normalized).replaceAll(" ").trim();
    }

    @SuppressWarnings("unchecked")
    private List<ChatMessageModel> resolveChatHistory(HttpSession session) {
        if (session == null) {
            return createDefaultHistory();
        }

        Object value = session.getAttribute(ChatBotConstant.SESSION_CHAT_HISTORY_KEY);
        if (value instanceof List<?>) {
            return (List<ChatMessageModel>) value;
        }

        List<ChatMessageModel> history = createDefaultHistory();
        session.setAttribute(ChatBotConstant.SESSION_CHAT_HISTORY_KEY, history);
        return history;
    }

    private List<ChatMessageModel> createDefaultHistory() {
        List<ChatMessageModel> history = new ArrayList<>();
        history.add(ChatMessageModel.bot(ChatBotConstant.WELCOME_MESSAGE));
        return history;
    }

    private void addMessage(List<ChatMessageModel> history, ChatMessageModel message) {
        if (history == null || message == null) {
            return;
        }
        history.add(message);
        while (history.size() > ChatBotConstant.MAX_HISTORY_MESSAGES) {
            history.remove(0);
        }
    }
}
