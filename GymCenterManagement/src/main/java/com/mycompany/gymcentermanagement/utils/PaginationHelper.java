package com.mycompany.gymcentermanagement.utils;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Lớp tiện ích cung cấp các hàm hỗ trợ phân trang (Pagination) cho dữ liệu hiển thị trên View.
 */
public class PaginationHelper {

    // Số lượng mục hiển thị mặc định trên một trang
    public static final int DEFAULT_PAGE_SIZE = 10;

    /**
     * Chuyển đổi tham số phân trang dạng chuỗi sang số nguyên an toàn.
     */
    public static int parseInt(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    /**
     * Chuẩn hóa kích thước trang (Page Size) để đảm bảo người dùng chỉ được chọn 
     * các kích thước cho phép (5, 10, 20, 50). Tránh lỗi SQL injection hoặc tham số không hợp lệ.
     */
    public static int normalizePageSize(int pageSize) {
        return switch (pageSize) {
            case 5, 10, 20, 50 -> pageSize;
            default -> DEFAULT_PAGE_SIZE;
        };
    }

    /**
     * Tính toán tổng số trang dựa trên tổng số mục và kích thước của một trang.
     * Làm tròn lên (ceil) nếu số mục không chia hết cho kích thước trang.
     */
    public static int totalPages(int totalItems, int pageSize) {
        return Math.max(1, (int) Math.ceil(Math.max(0, totalItems) / (double) pageSize));
    }

    /**
     * Chuẩn hóa số trang hiện tại để đảm bảo trang không bé hơn 1 và không vượt quá tổng số trang.
     */
    public static int normalizePage(int page, int totalPages) {
        return Math.min(Math.max(1, page), totalPages);
    }

    /**
     * Tính toán và thiết lập các biến phân trang (Attributes) vào Request để đẩy lên JSP (View) hiển thị.
     * Xử lý thuật toán hiển thị thanh phân trang với tối đa 5 nút trang hiển thị liền kề.
     */
    public static void setPaginationAttributes(HttpServletRequest request, int page, int pageSize, int totalItems, String queryBase, String itemUnit) {
        int safeTotalItems = Math.max(0, totalItems);
        int totalPages = totalPages(safeTotalItems, pageSize);
        
        // Vị trí dòng bắt đầu (OFFSET trong SQL)
        int offset = (page - 1) * pageSize;
        
        // Số lượng trang hiển thị tối đa trên thanh điều hướng (Thường là 5 trang)
        int visiblePages = Math.min(5, totalPages);
        int start = Math.max(1, page - visiblePages / 2);
        int end = Math.min(totalPages, start + visiblePages - 1);
        
        // Dịch chuyển khoảng trang bắt đầu và kết thúc để luôn hiển thị đúng số lượng visiblePages
        int startPage = Math.max(1, end - visiblePages + 1);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        request.setAttribute("showPagination", true);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalItems", safeTotalItems);
        request.setAttribute("totalPages", totalPages);
        
        // Hiển thị text "Đang xem {startItem} tới {endItem} ..."
        request.setAttribute("startItem", safeTotalItems == 0 ? 0 : offset + 1);
        request.setAttribute("endItem", Math.min(safeTotalItems, offset + pageSize));
        
        // Nút trang Trước/Sau
        request.setAttribute("hasPrevious", page > 1);
        request.setAttribute("hasNext", page < totalPages);
        request.setAttribute("previousPage", Math.max(1, page - 1));
        request.setAttribute("nextPage", Math.min(totalPages, page + 1));
        
        // Khoảng trang để vẽ thanh chuyển trang trên HTML
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        
        // URL cơ sở kèm các filter để giữ lại trạng thái khi chuyển trang
        request.setAttribute("queryBase", queryBase);
        // Đơn vị của item (VD: "hóa đơn", "hội viên")
        request.setAttribute("itemUnit", itemUnit);
    }

    /**
     * Xây dựng chuỗi URL kèm theo các tham số truy vấn (Query Parameters)
     * nhằm bảo lưu lại các giá trị lọc (Filter/Search) khi bấm sang trang khác.
     */
    public static String buildQueryBase(HttpServletRequest request, String path, String... pairs) {
        StringBuilder query = new StringBuilder(request.getContextPath()).append(path);
        if (!path.endsWith("?") && !path.contains("?")) {
            query.append("?");
        }
        for (int i = 0; i < pairs.length; i += 2) {
            String key = pairs[i];
            String value = pairs[i + 1];
            if (value == null || value.isBlank()) {
                continue;
            }
            if (query.charAt(query.length() - 1) != '?' && query.charAt(query.length() - 1) != '&') {
                query.append('&');
            }
            query.append(urlEncode(key)).append('=').append(urlEncode(value));
        }
        if (query.charAt(query.length() - 1) != '?' && query.charAt(query.length() - 1) != '&') {
            query.append('&');
        }
        return query.toString();
    }

    /**
     * Mã hóa các tham số để xử lý đúng các ký tự đặc biệt trên URL.
     */
    private static String urlEncode(String value) {
        return java.net.URLEncoder.encode(value, java.nio.charset.StandardCharsets.UTF_8);
    }
}
