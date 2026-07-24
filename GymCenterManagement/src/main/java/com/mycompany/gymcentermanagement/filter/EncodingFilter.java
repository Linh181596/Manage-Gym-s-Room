package com.mycompany.gymcentermanagement.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filter này sẽ tự động chạy trước bất kỳ request nào đi vào hệ thống (urlPatterns = "/*").
 * Chức năng chính: Ép kiểu dữ liệu vào (Request) và dữ liệu ra (Response) đều là chuẩn UTF-8.
 * Điều này rất quan trọng để ứng dụng có thể lưu trữ và hiển thị tiếng Việt có dấu (Unicode)
 * mà không bị lỗi font (ví dụ: biến thành các ký tự dấu hỏi ???).
 */
@WebFilter(filterName = "EncodingFilter", urlPatterns = "/*")
public class EncodingFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Thiết lập bộ mã hóa ký tự đầu vào từ Client gửi lên (vd: Form Submit)
        request.setCharacterEncoding("UTF-8");
        // Thiết lập bộ mã hóa ký tự đầu ra trả về cho Client
        response.setCharacterEncoding("UTF-8");
        
        // Tiếp tục chuyển tiếp Request tới Filter tiếp theo hoặc tới Servlet (Controller)
        chain.doFilter(request, response);
    }
}
