/**
 * =========================================================================
 * @file          : ChatBotService.java
 * @description   : Service interface for chatbot conversation and FAQ response processing
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.ChatMessageModel;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public interface ChatBotService {

    List<ChatMessageModel> getChatHistory(HttpSession session);

    ChatMessageModel answerQuestion(String question, HttpSession session);

    List<ChatMessageModel> clearChatHistory(HttpSession session);
}
