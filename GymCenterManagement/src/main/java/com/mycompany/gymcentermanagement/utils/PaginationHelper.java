package com.mycompany.gymcentermanagement.utils;

import jakarta.servlet.http.HttpServletRequest;

public class PaginationHelper {

    public static final int DEFAULT_PAGE_SIZE = 10;

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

    public static int normalizePageSize(int pageSize) {
        return switch (pageSize) {
            case 5, 10, 20, 50 -> pageSize;
            default -> DEFAULT_PAGE_SIZE;
        };
    }

    public static int totalPages(int totalItems, int pageSize) {
        return Math.max(1, (int) Math.ceil(Math.max(0, totalItems) / (double) pageSize));
    }

    public static int normalizePage(int page, int totalPages) {
        return Math.min(Math.max(1, page), totalPages);
    }

    public static void setPaginationAttributes(HttpServletRequest request, int page, int pageSize, int totalItems, String queryBase, String itemUnit) {
        int safeTotalItems = Math.max(0, totalItems);
        int totalPages = totalPages(safeTotalItems, pageSize);
        int offset = (page - 1) * pageSize;
        int visiblePages = Math.min(5, totalPages);
        int start = Math.max(1, page - visiblePages / 2);
        int end = Math.min(totalPages, start + visiblePages - 1);
        int startPage = Math.max(1, end - visiblePages + 1);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        request.setAttribute("showPagination", true);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalItems", safeTotalItems);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startItem", safeTotalItems == 0 ? 0 : offset + 1);
        request.setAttribute("endItem", Math.min(safeTotalItems, offset + pageSize));
        request.setAttribute("hasPrevious", page > 1);
        request.setAttribute("hasNext", page < totalPages);
        request.setAttribute("previousPage", Math.max(1, page - 1));
        request.setAttribute("nextPage", Math.min(totalPages, page + 1));
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("queryBase", queryBase);
        request.setAttribute("itemUnit", itemUnit);
    }

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

    private static String urlEncode(String value) {
        return java.net.URLEncoder.encode(value, java.nio.charset.StandardCharsets.UTF_8);
    }
}
