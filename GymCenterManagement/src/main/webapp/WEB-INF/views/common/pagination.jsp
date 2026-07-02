<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (Boolean.TRUE.equals(request.getAttribute("showPagination"))) {
        int currentPage = (Integer) request.getAttribute("page");
        int totalItems = (Integer) request.getAttribute("totalItems");
        int totalPages = (Integer) request.getAttribute("totalPages");
        int startItem = (Integer) request.getAttribute("startItem");
        int endItem = (Integer) request.getAttribute("endItem");
        boolean hasPrevious = (Boolean) request.getAttribute("hasPrevious");
        boolean hasNext = (Boolean) request.getAttribute("hasNext");
        int previousPage = (Integer) request.getAttribute("previousPage");
        int nextPage = (Integer) request.getAttribute("nextPage");
        int startPage = (Integer) request.getAttribute("startPage");
        int endPage = (Integer) request.getAttribute("endPage");
        String queryBase = (String) request.getAttribute("queryBase");
        String itemUnit = (String) request.getAttribute("itemUnit");
        if (itemUnit == null) {
            itemUnit = "bản ghi";
        }
%>
<div class="d-flex align-items-center justify-content-between mt-4">
    <div class="text-muted small">
        Hiển thị <strong><%= startItem %></strong> - <strong><%= endItem %></strong> của tổng số <strong><%= totalItems %></strong> <%= itemUnit %>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination pagination-sm mb-0">
            <li class="page-item <%= !hasPrevious ? "disabled" : "" %>">
                <a class="page-link" href="<%= queryBase %>page=<%= previousPage %>">&lsaquo; Trước</a>
            </li>
            <% for (int p = startPage; p <= endPage; p++) { %>
                <li class="page-item <%= p == currentPage ? "active" : "" %>">
                    <% if (p == currentPage) { %>
                        <span class="page-link"><%= p %></span>
                    <% } else { %>
                        <a class="page-link" href="<%= queryBase %>page=<%= p %>"><%= p %></a>
                    <% } %>
                </li>
            <% } %>
            <li class="page-item <%= !hasNext ? "disabled" : "" %>">
                <a class="page-link" href="<%= queryBase %>page=<%= nextPage %>">Sau &rsaquo;</a>
            </li>
        </ul>
    </nav>
</div>
<% } %>
