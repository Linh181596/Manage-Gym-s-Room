/**
 * =========================================================================
 * @file          : ChatBotController.java
 * @description   : Controller for handling chatbot requests, chat history, and conversation management
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.controller;

import com.mycompany.gymcentermanagement.model.entity.ChatMessageModel;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.ChatBotService;
import com.mycompany.gymcentermanagement.service.impl.ChatBotServiceImpl;
import com.mycompany.gymcentermanagement.utils.ChatBotConstant;
import com.mycompany.gymcentermanagement.utils.JsonUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ChatBotController", urlPatterns = {"/chatbot/send", "/chatbot/history", "/chatbot/clear"})
public class ChatBotController extends HttpServlet {

    private final ChatBotService chatBotService = new ChatBotServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAllowedToUseChatBot(request)) {
            writeForbiddenResponse(response);
            return;
        }
        
        if ("/chatbot/history".equals(request.getServletPath())) {
            writeHistoryResponse(response, chatBotService.getChatHistory(request.getSession(true)));
            return;
        }

        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAllowedToUseChatBot(request)) {
            writeForbiddenResponse(response);
            return;
        }
        
        String servletPath = request.getServletPath();

        if ("/chatbot/send".equals(servletPath)) {
            handleSendQuestion(request, response);
            return;
        }

        if ("/chatbot/clear".equals(servletPath)) {
            handleClearHistory(request, response);
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void handleSendQuestion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(true);
        ChatMessageModel botMessage = chatBotService.answerQuestion(request.getParameter("question"), session);
        writeMessageResponse(response, botMessage);
    }

    private void handleClearHistory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<ChatMessageModel> history = chatBotService.clearChatHistory(request.getSession(true));
        writeHistoryResponse(response, history);
    }
    
    private boolean isAllowedToUseChatBot(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Object currentUser = session == null ? null : session.getAttribute("currentUser");

        if (currentUser == null) {
            return true;
        }

        if (currentUser instanceof User user) {
            return user.getRole() == User.Role.Member;
        }

        return false;
    }

    private void writeForbiddenResponse(HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        writeJson(response, "{\"thanhCong\":false,\"thongBao\":\"Bạn không có quyền sử dụng chatbot.\"}");
    }

    private void writeMessageResponse(HttpServletResponse response, ChatMessageModel botMessage) throws IOException {
        StringBuilder builder = new StringBuilder();
        builder.append("{");
        builder.append("\"thanhCong\":true,");
        builder.append("\"thongBao\":\"\",");
        builder.append("\"tinNhan\":");
        if (botMessage == null) {
            builder.append(toMessageJson(ChatMessageModel.bot(ChatBotConstant.SYSTEM_ERROR_MESSAGE)));
        } else {
            builder.append(toMessageJson(botMessage));
        }
        builder.append("}");
        writeJson(response, builder.toString());
    }

    private void writeHistoryResponse(HttpServletResponse response, List<ChatMessageModel> history) throws IOException {
        StringBuilder builder = new StringBuilder();
        builder.append("{\"thanhCong\":true,\"lichSu\":");
        builder.append(toMessagesJson(history));
        builder.append("}");
        writeJson(response, builder.toString());
    }

    private String toMessagesJson(List<ChatMessageModel> messages) {
        StringBuilder builder = new StringBuilder("[");
        boolean firstMessage = true;

        if (messages != null) {
            for (ChatMessageModel message : messages) {
                if (message == null) {
                    continue;
                }
                if (!firstMessage) {
                    builder.append(",");
                }
                firstMessage = false;
                builder.append(toMessageJson(message));
            }
        }

        builder.append("]");
        return builder.toString();
    }

    private String toMessageJson(ChatMessageModel message) {
        StringBuilder builder = new StringBuilder();
        builder.append("{");
        builder.append("\"vaiTro\":\"").append(JsonUtils.escapeJson(message.getRole())).append("\",");
        builder.append("\"noiDung\":\"").append(JsonUtils.escapeJson(message.getContent())).append("\",");
        builder.append("\"thoiGian\":\"").append(JsonUtils.escapeJson(message.getDisplayTime())).append("\",");
        builder.append("\"laNguoiDung\":").append(message.isUserMessage());
        builder.append("}");
        return builder.toString();
    }

    private void writeJson(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter writer = response.getWriter()) {
            writer.write(json);
        }
    }
}
