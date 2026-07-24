/**
 * =========================================================================
 * @file          : DashboardAlert.java
 * @description   : DTO biểu diễn một cảnh báo vận hành hiển thị trên bảng điều khiển quản trị.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dto;

/**
 * DTO biểu diễn một cảnh báo (Alert) hệ thống hiển thị trên Dashboard.
 * Có thể là cảnh báo về thiết bị hỏng, hội viên sắp hết hạn gói tập, 
 * hoặc yêu cầu dời lịch tập từ PT.
 */
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
