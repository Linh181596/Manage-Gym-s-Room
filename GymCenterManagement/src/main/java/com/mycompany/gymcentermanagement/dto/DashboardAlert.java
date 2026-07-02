/**
 * =========================================================================
 * @file          : DashboardAlert.java
 * @description   : DTO biểu diễn một cảnh báo vận hành hiển thị trên bảng điều khiển quản trị.
 * @author        : Duongnd
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

public class DashboardAlert {
    private String type;
    private String title;
    private String message;
    private String severity;
    private String targetUrl;

    public DashboardAlert() {
    }

    public DashboardAlert(String type, String title, String message, String severity, String targetUrl) {
        this.type = type;
        this.title = title;
        this.message = message;
        this.severity = severity;
        this.targetUrl = targetUrl;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getTargetUrl() {
        return targetUrl;
    }

    public void setTargetUrl(String targetUrl) {
        this.targetUrl = targetUrl;
    }
}
