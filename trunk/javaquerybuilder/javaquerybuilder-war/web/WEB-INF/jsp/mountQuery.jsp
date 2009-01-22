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

<script language="JavaScript" type="text/javascript">
    
    function getSelectDescription(obj, value) {
        for (var i = 0; i < obj.options.length; i++) {
            var opt = obj.options[i];
            if (opt.value == value)
                return opt.text;
        }
        return value;
    }
    
    function addItem(fieldRef, compType, compValue, logicValue) {
        if (fieldRef == null || fieldRef == '')
            return;
        if (compType == null || compType == '')
            return;
        if (compValue == null || compValue == '')
            return;
        if (logicValue == null || logicValue == '')
            return;

        var regs = document.getElementById('parameters').value;
        if (regs != '' && regs != null) {
            var temp = regs.split(';');
            if (temp != null) {
                regs = temp;
                document.getElementById('parameters').value = '';
                for (var i = 0; i < regs.length; i++) {
                    var dreg = regs[i].split('@');
                    if (document.getElementById('parameters').value.length > 0)
                        document.getElementById('parameters').value += ';';                        
                    document.getElementById('parameters').value += dreg[0] + '@' + dreg[1] + '@' + dreg[2] + '@' + dreg[3];
                }
            }
        }
        
        if (document.getElementById('parameters').value.length > 0)
            document.getElementById('parameters').value += ';';
        
        document.getElementById('parameters').value += fieldRef + '@' + compType + '@' + compValue + '@' + logicValue;
        document.getElementById('fieldRef').value = '';
        document.getElementById('compType').value = '';
        document.getElementById('compValue').value = '';
        document.getElementById('logicValue').value = '';
        
        updateItems();
    }
    
    function removeItem(index) {
        var list = document.getElementById('parameters').value.split(';');
        if (list != null && index < list.length) {
            var i = 0;
            var temp = '';
            for (i = 0; i < list.length; i++) {
                if (i != index) {
                    temp += list[i] + ';';
                }
            }
            if (temp.length > 0 && temp.substring(temp.length - 1, temp.length) == ';') {
                temp = temp.substring(0, temp.length - 1);
            }
        }
        document.getElementById('parameters').value = temp;
        updateItems();
    }
    
    function updateItems() {
        var html = '';
        html += '<table>';
        html += '<tr>';
        html += '<td>Field name</td>';
        html += '<td>Comparator</td>';
        html += '<td>Value</td>';
        html += '<td>Logical</td>';
        html += '<td>&nbsp;</td>';
        html += '</tr>';
        if (document.getElementById('parameters').value.length > 0) {
            var list = document.getElementById('parameters').value.split(';');
            if (list != null) {
                var i = 0;
                for (i = 0; i < list.length; i++) {
                    var fieldRef = list[i].split('@')[0];
                    var compType = list[i].split('@')[1];
                    var compValue = list[i].split('@')[2];
                    var logicValue = list[i].split('@')[3];
                    html +='<tr>';
                    html +='<td>' + getSelectDescription(document.getElementById('fieldRef'), fieldRef) + '</td>';
                    html +='<td>' + getSelectDescription(document.getElementById('compType'), compType) + '</td>';
                    html +='<td>' + compValue + '</td>';
                    html +='<td>' + getSelectDescription(document.getElementById('logicValue'), logicValue) + '</td>';
                    html +='<td><a href="javascript:' + 'removeItem(' + i + ');' + '">Remove</a></td>';
                    html += '</tr>';                
                }
            }
            html += '</table>';
        }
        else {
            html = '';
        }
        document.getElementById('queryParameters').innerHTML = html;
    }
    
</script>

<% JavaQueryBuilder jqb = (JavaQueryBuilder) session.getAttribute("configurationFile"); %>

<h1>Mount Query</h1>

<h2>Parameters</h2>

<% if (jqb != null) { %>

<table>
    <tr>
        <td>Field name</td>
        <td>Comparator</td>
        <td>Value</td>
        <td>Logical connector</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <select name="fieldRef" id="fieldRef">
                <option value="">Select</option>
                <% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) { %>
                <option value="<%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %>"><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn() %></option>        
                <% } %>
            </select>            
        </td>
        <td>
            <select name="compType" id="compType">
                <option value="">Select</option>
                <option value="<%= Configuration.COMPARATOR_CONTAINS %>">Contains</option>
                <option value="<%= Configuration.COMPARATOR_EQ %>">Equals</option>
                <option value="<%= Configuration.COMPARATOR_GT %>">Greater than</option>
                <option value="<%= Configuration.COMPARATOR_GT_OR_EQ %>">Greater than or equal</option>
                <option value="<%= Configuration.COMPARATOR_LT %>">Less than</option>
                <option value="<%= Configuration.COMPARATOR_LT_OR_EQ %>">Less than or equal</option>
                <option value="<%= Configuration.COMPARATOR_NOT_EQ %>">Not equal</option>
            </select>            
        </td>
        <td><input type="text" name="compValue" id="compValue"/></td>
        <td>
            <select name="logicValue" id="logicValue">
                <option value="">Select</option>
                <option value="<%= Configuration.LOGICAL_AND %>">And</option>
                <option value="<%= Configuration.LOGICAL_OR %>">Or</option>
            </select>                
        </td>
        <td><input type="button" value="Add" onclick="addItem(document.getElementById('fieldRef').value, document.getElementById('compType').value, document.getElementById('compValue').value, document.getElementById('logicValue').value);"/></td>
    </tr>    
</table>

<div id="queryParameters"></div>

<form action="ControllerServlet" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="command" value="executeQuery" />
    <input type="text" name="parameters" id="parameters" value="" />
    <input type="submit" value="Execute" />
</form>

<% } %>

<br />
<a href="ControllerServlet?command=loadConfiguration">Load configuration</a>


<%@ include file="footer.jsp" %>