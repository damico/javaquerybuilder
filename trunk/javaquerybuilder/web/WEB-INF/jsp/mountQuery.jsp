<%-- 
    Document   : index
    Created on : Jan 14, 2009, 9:04:05 AM
    Author     : Leonardo Oliveira Moreira
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   
<%@ page import="br.ufc.great.jqb.config.Configuration" %>
<%@ page import="br.ufc.great.jqb.config.JavaQueryBuilder" %>
<%@ page import="br.ufc.great.jqb.config.Fieldref" %>

<%@ include file="header.jsp" %>

<% JavaQueryBuilder jqb = (JavaQueryBuilder) session.getAttribute("configurationFile"); %>

<h1>Mount Query</h1>

<h2>Parameters</h2>

<% if (jqb != null) { %>

<form action="ControllerServlet" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="command" value="loadConfiguration" />
    <select name="fieldRef">
        <% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) { %>
        <option value="<%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %>"><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %></option>        
        <% } %>
    </select>
    <input type="submit" value="Load" />
</form>

<% } %>

<%@ include file="footer.jsp" %>