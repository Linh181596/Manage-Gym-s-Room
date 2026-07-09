/**
 * =========================================================================
 * @file          : ChatBotConstant.java
 * @description   : Constants used by the chatbot including messages, limits, and session keys
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.utils;

public final class ChatBotConstant {

    public static final String SESSION_CHAT_HISTORY_KEY = "chatBotHistory";
    public static final int MAX_QUESTION_LENGTH = 1000;
    public static final int MAX_HISTORY_MESSAGES = 30;
    public static final int SEARCH_LIMIT = 80;
    public static final int MIN_MATCH_SCORE = 35;

    public static final String WELCOME_MESSAGE = """
            Xin chào!

            Tôi là trợ lý hỗ trợ của hệ thống Manage Gym's Room.
            Bạn có thể hỏi tôi về: gói tập, hội viên, huấn luyện viên, lớp học, thiết bị, thanh toán, giờ mở cửa và nội quy phòng tập.
            """;

    public static final String DEFAULT_NOT_FOUND_MESSAGE =
            "Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi. Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ.";

    public static final String EMPTY_QUESTION_MESSAGE = "Vui lòng nhập câu hỏi.";
    public static final String TOO_LONG_QUESTION_MESSAGE = "Câu hỏi quá dài. Vui lòng nhập tối đa 1000 ký tự.";
    public static final String SYSTEM_ERROR_MESSAGE = "Có lỗi xảy ra khi tìm câu trả lời. Vui lòng thử lại sau.";

    private ChatBotConstant() {
    }
}
