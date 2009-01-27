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

<% JavaQueryBuilder jqb = (JavaQueryBuilder) session.getAttribute("configurationFile");%>

<div id="content">
    <h1><span id="formTitle">Mount Query</span></h1>
    
    <form action="ControllerServlet" method="POST" enctype="multipart/form-data">
        <label>Configuration file:</label>
        <input type="hidden" name="command" value="executeConfiguration" />
        <input type="file" name="upload" />
        <input type="submit" value="Load" />
    </form>
    
    <% if (jqb != null) {%>
    <br />
    <h1><span id="formTitle">Header</span></h1>
    <label>source:</label><%= jqb.getHeader().getSource()%><br />
    <label>doctype:</label><%= jqb.getHeader().getDoctype()%><br />
    <label>mainview:</label><%= jqb.getHeader().getMainview()%><br />
    <h1><span id="formTitle">Payload</span></h1>
    <% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) {%>
    <label>Field:</label><%= i + 1%><br />
    <label>column:</label><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn()%><br />
    <label>relationship:</label><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getRelationship()%><br />
    <label>representation:</label><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getRepresentation()%><br />
    <label>type:</label><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getType()%><br />
    <% if (i != jqb.getPayload().getFields().size() - 1) {%>
    <br />
    <% }%>
    <% }%>
    <br />
    <input type="button" value="Mount query" onclick="document.location = 'ControllerServlet?command=mountQuery';"/>    
    <% }%>
</div>

<%@ include file="footer.jsp" %>