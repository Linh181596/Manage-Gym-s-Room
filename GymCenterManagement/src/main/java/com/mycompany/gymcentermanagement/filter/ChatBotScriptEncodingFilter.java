package com.mycompany.gymcentermanagement.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Declares UTF-8 explicitly for the static chatbot script. Without a charset
 * on the JavaScript response, browsers can decode Vietnamese UTF-8 bytes as
 * a legacy single-byte charset.
 */
@WebFilter(filterName = "ChatBotScriptEncodingFilter", urlPatterns = "/js/chatbot.js")
public class ChatBotScriptEncodingFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/javascript; charset=UTF-8");
        chain.doFilter(request, response);
    }
}
