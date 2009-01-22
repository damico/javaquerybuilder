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
        <option value="">Select</option>
        <% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) { %>
        <option value="<%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %>"><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %></option>        
        <% } %>
    </select>
    <select name="compType">
        <option value="">Select</option>
        <option value="<%= Configuration.COMPARATOR_CONTAINS %>">Contains</option>
        <option value="<%= Configuration.COMPARATOR_EQ %>">Equals</option>
        <option value="<%= Configuration.COMPARATOR_GT %>">Greater than</option>
        <option value="<%= Configuration.COMPARATOR_GT_OR_EQ %>">Greater than or equal</option>
        <option value="<%= Configuration.COMPARATOR_LT %>">Less than</option>
        <option value="<%= Configuration.COMPARATOR_LT_OR_EQ %>">Less than or equal</option>
        <option value="<%= Configuration.COMPARATOR_NOT_EQ %>">Not equal</option>
    </select>
    <input type="text" name="compValue" />
    <select name="compType">
        <option value="">Select</option>
        <option value="<%= Configuration.LOGICAL_AND %>">And</option>
        <option value="<%= Configuration.LOGICAL_OR %>">Or</option>
    </select>    
    <input type="submit" value="Execute" />
</form>

<% } %>

<br />
<a href="ControllerServlet?command=loadConfiguration">Load configuration</a>


<%@ include file="footer.jsp" %>