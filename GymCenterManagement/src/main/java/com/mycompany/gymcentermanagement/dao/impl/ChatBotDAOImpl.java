/**
 * =========================================================================
 * @file          : ChatBotDAOImpl.java
 * @description   : DAO implementation for retrieving FAQ information from the database
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.ChatBotDAO;
import com.mycompany.gymcentermanagement.model.entity.FAQModel;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ChatBotDAOImpl extends BaseDAO implements ChatBotDAO {

    public ChatBotDAOImpl() {
        super();
    }

    public ChatBotDAOImpl(Connection connection) {
        super(connection);
    }

    private Connection getActiveConnection() throws SQLException {
        return (this.connection != null) ? this.connection : DBContext.getConnection();
    }

    @Override
    public List<FAQModel> searchFAQs(String originalQuestion, List<String> keywords, int limit) throws SQLException {
        List<FAQModel> faqs = new ArrayList<>();
        if ((originalQuestion == null || originalQuestion.isBlank()) && (keywords == null || keywords.isEmpty())) {
            return faqs;
        }

        String sql = buildSearchSql(keywords);
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getActiveConnection();
            stmt = conn.prepareStatement(sql);
            int index = 1;
            String phrasePattern = "%" + safeLikePattern(originalQuestion) + "%";

            index = bindPatternTriplet(stmt, index, phrasePattern);

            if (keywords != null) {
                for (String keyword : keywords) {
                    String keywordPattern = "%" + safeLikePattern(keyword) + "%";
                    index = bindPatternTriplet(stmt, index, keywordPattern);
                }
            }

            stmt.setString(index++, originalQuestion == null ? "" : originalQuestion.trim());
            index = bindPatternTriplet(stmt, index, phrasePattern);
            if (keywords != null) {
                for (String keyword : keywords) {
                    String keywordPattern = "%" + safeLikePattern(keyword) + "%";
                    index = bindPatternTriplet(stmt, index, keywordPattern);
                }
            }

            stmt.setInt(index, Math.max(1, limit));
            rs = stmt.executeQuery();
            while (rs.next()) {
                faqs.add(mapFAQ(rs));
            }
        } finally {
            closeResource(conn, stmt, rs);
        }
        return faqs;
    }

    private String buildSearchSql(List<String> keywords) {
        StringBuilder sql = new StringBuilder();
        sql.append("""
                SELECT faq_id, question, answer, category, keywords, status, created_at, updated_at
                FROM dbo.FAQ
                WHERE status = N'Active'
                  AND (
                        question COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                     OR keywords COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                     OR category COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                """);

        if (keywords != null) {
            for (String ignored : keywords) {
                sql.append("""
                     OR question COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                     OR keywords COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                     OR category COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\'
                    """);
            }
        }

        sql.append("""
                  )
                ORDER BY (
                        CASE WHEN question COLLATE Latin1_General_CI_AI = ? THEN 10000 ELSE 0 END
                      + CASE WHEN question COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 200 ELSE 0 END
                      + CASE WHEN keywords COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 180 ELSE 0 END
                      + CASE WHEN category COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 120 ELSE 0 END
                """);

        if (keywords != null) {
            for (String ignored : keywords) {
                sql.append("""
                      + CASE WHEN question COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 60 ELSE 0 END
                      + CASE WHEN keywords COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 80 ELSE 0 END
                      + CASE WHEN category COLLATE Latin1_General_CI_AI LIKE ? ESCAPE '\\' THEN 40 ELSE 0 END
                    """);
            }
        }

        sql.append("""
                  ) DESC,
                  updated_at DESC, created_at DESC, faq_id DESC
                OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY
                """);
        return sql.toString();
    }

    private int bindPatternTriplet(PreparedStatement stmt, int index, String pattern) throws SQLException {
        stmt.setString(index++, pattern);
        stmt.setString(index++, pattern);
        stmt.setString(index++, pattern);
        return index;
    }

    private FAQModel mapFAQ(ResultSet rs) throws SQLException {
        FAQModel faq = new FAQModel();
        faq.setFaqId(rs.getInt("faq_id"));
        faq.setQuestion(rs.getString("question"));
        faq.setAnswer(rs.getString("answer"));
        faq.setCategory(rs.getString("category"));
        faq.setKeywords(rs.getString("keywords"));
        faq.setStatus(rs.getString("status"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            faq.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            faq.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        return faq;
    }

    private String safeLikePattern(String value) {
        if (value == null) {
            return "";
        }
        return value.trim()
                .replace("\\", "\\\\")
                .replace("%", "\\%")
                .replace("_", "\\_")
                .replace("[", "\\[");
    }
}
