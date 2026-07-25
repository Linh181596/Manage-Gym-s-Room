<%@ page import="com.mycompany.gymcentermanagement.service.impl.InvoiceServiceImpl" %>
<%@ page import="com.mycompany.gymcentermanagement.model.entity.Invoice" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%
    try {
        InvoiceServiceImpl invoiceService = new InvoiceServiceImpl();
        Invoice inv = invoiceService.getOrCreateInvoiceForPTRegistration(20, 2);
        out.print("SUCCESS! Invoice created with ID: " + inv.getInvoiceId());
    } catch (Exception ex) {
        out.print("ERROR CAUGHT!<br><pre>");
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        ex.printStackTrace(pw);
        out.print(sw.toString());
        out.print("</pre>");
    }
%>
