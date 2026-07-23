/**
 * =========================================================================
 * @file          : ChatBotDAO.java
 * @description   : Data access interface for searching FAQ data used by the chatbot
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */

package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.FAQModel;
import java.sql.SQLException;
import java.util.List;

public interface ChatBotDAO {

    List<FAQModel> searchFAQs(String originalQuestion, List<String> keywords, int limit) throws SQLException;

    List<FAQModel> getActiveFAQs(int limit) throws SQLException;

    FAQModel getActiveFAQById(int faqId) throws SQLException;
}
