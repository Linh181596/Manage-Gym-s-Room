package com.mycompany.gymcentermanagement.controller;

import com.mycompany.gymcentermanagement.model.entity.PublicContent;
import com.mycompany.gymcentermanagement.model.entity.PublicContent.ContentType;
import com.mycompany.gymcentermanagement.service.PublicContentService;
import com.mycompany.gymcentermanagement.service.impl.PublicContentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "PublicContentController", urlPatterns = {"/blogs", "/policies"})
public class PublicContentController extends HttpServlet {

    private static final int BLOG_PAGE_SIZE = 6;
    private static final List<String> BLOG_CATEGORIES = Arrays.asList(
            "Khởi động",
            "Phục hồi",
            "Dinh dưỡng",
            "Tăng cơ",
            "Giảm mỡ",
            "Cardio",
            "Yoga",
            "Boxing",
            "Kinh nghiệm tập luyện"
    );
    private final PublicContentService publicContentService = new PublicContentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        ContentType type = "/policies".equals(path) ? ContentType.POLICY : ContentType.BLOG;

        try {
            if (type == ContentType.POLICY) {
                List<PublicContent> contents = publicContentService.getPublishedByType(type);
                PublicContent selectedPolicy = null;

                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isBlank()) {
                    int contentId = Integer.parseInt(idParam);
                    selectedPolicy = publicContentService.getPublishedById(contentId, type);
                    if (selectedPolicy == null) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }
                } else if (!contents.isEmpty()) {
                    selectedPolicy = contents.get(0);
                }

                request.setAttribute("contents", contents);
                request.setAttribute("selectedPolicy", selectedPolicy);
                request.setAttribute("contentType", type.name());
                request.getRequestDispatcher("/WEB-INF/views/public/content-list.jsp").forward(request, response);
                return;
            }

            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isBlank()) {
                int contentId = Integer.parseInt(idParam);
                PublicContent content = publicContentService.getPublishedById(contentId, type);
                if (content == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                request.setAttribute("content", content);
                request.setAttribute("contentType", type.name());
                request.getRequestDispatcher("/WEB-INF/views/public/content-detail.jsp").forward(request, response);
                return;
            }

            int currentPage = parsePage(request.getParameter("page"));
            String keyword = trim(request.getParameter("q"));
            String category = trim(request.getParameter("category"));
            int totalItems = publicContentService.countPublishedByType(type, keyword, category);
            int totalPages = Math.max(1, (int) Math.ceil((double) totalItems / BLOG_PAGE_SIZE));
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            List<PublicContent> contents = publicContentService.getPublishedByType(type, keyword, category, currentPage, BLOG_PAGE_SIZE);
            request.setAttribute("contents", contents);
            request.setAttribute("keyword", keyword);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("blogCategories", BLOG_CATEGORIES);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("contentType", type.name());
            request.getRequestDispatcher("/WEB-INF/views/public/content-list.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Không thể tải nội dung công khai.");
            request.getRequestDispatcher("/WEB-INF/views/public/content-list.jsp").forward(request, response);
        }
    }

    private int parsePage(String pageParam) {
        if (pageParam == null || pageParam.isBlank()) {
            return 1;
        }
        return Math.max(1, Integer.parseInt(pageParam));
    }

    private String trim(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }
}
