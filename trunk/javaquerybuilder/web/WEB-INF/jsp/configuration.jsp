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

<form action="ControllerServlet" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="command" value="processMountQuery" />
    <input type="file" name="upload" />
    <input type="submit" value="Load" />
</form>

<% if (jqb != null) { %>

<h2>Header</h2>
source: <b><%= jqb.getHeader().getSource() %></b><br />
doctype: <b><%= jqb.getHeader().getDoctype() %></b><br />
mainview: <b><%= jqb.getHeader().getMainview() %></b><br />
<h2>Payload</h2>
<% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) { %>
<h3>Field <%= i + 1 %></h3>
column: <b><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %></b><br />
relationship: <b><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getRelationship() %></b><br />
representation: <b><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getRepresentation() %></b><br />
type: <b><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getType() %></b><br />
<% } %>

<% } %>
        
<%@ include file="footer.jsp" %>