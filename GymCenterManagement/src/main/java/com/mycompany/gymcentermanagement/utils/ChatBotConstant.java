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

/**
 * Lớp lưu trữ các hằng số cấu hình và nội dung tin nhắn mặc định cho ChatBot.
 * Được sử dụng để thiết lập giới hạn hội thoại, cấu hình thuật toán tìm kiếm
 * và các thông báo phản hồi cơ bản tới người dùng.
 */
public final class ChatBotConstant {

    // Khóa lưu trữ lịch sử trò chuyện trong Session người dùng
    public static final String SESSION_CHAT_HISTORY_KEY = "chatBotHistory";
    
    // Giới hạn độ dài tối đa của câu hỏi đầu vào để chống spam/lỗi bộ nhớ (1000 ký tự)
    public static final int MAX_QUESTION_LENGTH = 1000;
    
    // Số lượng tin nhắn tối đa được lưu lại trong lịch sử một phiên chat
    public static final int MAX_HISTORY_MESSAGES = 30;
    
    // Số lượng ký tự tối đa hoặc giới hạn tìm kiếm nội dung trong tài liệu mẫu
    public static final int SEARCH_LIMIT = 80;

    public static final int FAQ_LIST_LIMIT = 1000;
    
    // Điểm khớp (match score) tối thiểu để thuật toán xác định là câu hỏi hợp lệ (theo %)
    public static final int MIN_MATCH_SCORE = 35;

    // Lời chào mặc định khi khởi tạo ChatBot
    public static final String WELCOME_MESSAGE = """
            Xin chào!

            Vui lòng chọn một câu hỏi trong database FAQ bên dưới để xem câu trả lời từ hệ thống Manage Gym's Room.
            """;

    // Phản hồi khi điểm khớp (match score) dưới mức MIN_MATCH_SCORE
    public static final String DEFAULT_NOT_FOUND_MESSAGE =
            "Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi. Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ.";

    // Thông báo lỗi khi người dùng gửi tin nhắn rỗng
    public static final String EMPTY_QUESTION_MESSAGE = "Vui lòng nhập câu hỏi.";
    
    // Thông báo lỗi khi tin nhắn vượt quá MAX_QUESTION_LENGTH
    public static final String TOO_LONG_QUESTION_MESSAGE = "Câu hỏi quá dài. Vui lòng nhập tối đa 1000 ký tự.";
    
    // Phản hồi khi có lỗi ngoại lệ (Exception) xảy ra ở server
    public static final String SYSTEM_ERROR_MESSAGE = "Có lỗi xảy ra khi tìm câu trả lời. Vui lòng thử lại sau.";

    public static final String FAQ_NOT_AVAILABLE_MESSAGE = "Câu hỏi này hiện không còn trong database FAQ. Vui lòng chọn câu hỏi khác.";

    private ChatBotConstant() {
        // Ngăn chặn khởi tạo đối tượng từ class chứa hằng số
    }
}
