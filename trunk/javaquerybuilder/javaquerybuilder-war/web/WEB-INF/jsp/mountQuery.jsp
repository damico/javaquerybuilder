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
<%@ page import="java.sql.ResultSet" %>

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

        var regs = document.getElementById('parametersQuery').value;
        if (regs != '' && regs != null) {
            var temp = regs.split(';');
            if (temp != null) {
                regs = temp;
                document.getElementById('parametersQuery').value = '';
                for (var i = 0; i < regs.length; i++) {
                    var dreg = regs[i].split('@');
                    if (document.getElementById('parametersQuery').value.length > 0)
                        document.getElementById('parametersQuery').value += ';';                        
                    document.getElementById('parametersQuery').value += dreg[0] + '@' + dreg[1] + '@' + dreg[2] + '@' + dreg[3];
                }
            }
        }
        
        if (document.getElementById('parametersQuery').value.length > 0)
            document.getElementById('parametersQuery').value += ';';
        
        document.getElementById('parametersQuery').value += fieldRef + '@' + compType + '@' + compValue + '@' + logicValue;
        document.getElementById('fieldRef').value = '';
        document.getElementById('compType').value = '';
        document.getElementById('compValue').value = '';
        document.getElementById('logicValue').value = '';
        
        updateItems();
    }
    
    function removeItem(index) {
        var list = document.getElementById('parametersQuery').value.split(';');
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
        document.getElementById('parametersQuery').value = temp;
        updateItems();
    }
    
    function updateItems() {
        var html = '';
        html += '<table>';
        html += '<tr class="table-header">';
        html += '<td>Field name</td>';
        html += '<td>Comparator</td>';
        html += '<td>Value</td>';
        html += '<td>Logical</td>';
        html += '<td>&nbsp;</td>';
        html += '</tr>';
        if (document.getElementById('parametersQuery').value.length > 0) {
            var list = document.getElementById('parametersQuery').value.split(';');
            if (list != null) {
                var i = 0;
                for (i = 0; i < list.length; i++) {
                    var fieldRef = list[i].split('@')[0];
                    var compType = list[i].split('@')[1];
                    var compValue = list[i].split('@')[2];
                    var logicValue = list[i].split('@')[3];
                    html +='<tr' + ((i % 2 == 0) ? ' class="row-admin"' : '') + '>';
                    html +='<td>' + getSelectDescription(document.getElementById('fieldRef'), fieldRef) + '</td>';
                    html +='<td>' + getSelectDescription(document.getElementById('compType'), compType) + '</td>';
                    html +='<td>' + compValue + '</td>';
                    html +='<td>' + getSelectDescription(document.getElementById('logicValue'), logicValue) + '</td>';
                    html +='<td class="manage-column"><img class="img-button" src="images/icon-remove.gif" alt="Remove record" title="Remove record" onclick="removeItem(' + i + ');" /></td>';
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

<% JavaQueryBuilder jqb = (JavaQueryBuilder) session.getAttribute("configurationFile");%>

<% if (jqb != null) {%>

<div id="content">
    <h1><span id="formTitle">Mount Query</span></h1>
    <label for="fieldRef">Field name:</label>
    <select name="fieldRef" id="fieldRef">
        <option value="">Select</option>
        <% for (int i = 0; (jqb.getPayload() != null) && (jqb.getPayload().getFields() != null) && i < jqb.getPayload().getFields().size(); i++) {%>
        <option value="<%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn()%>"><%= ((Fieldref) jqb.getPayload().getFields().get(i)).getColumn()%></option>        
        <% }%>
    </select>            
    <br />
    <label for="compType">Comparator:</label>
    <select name="compType" id="compType">
        <option value="">Select</option>
        <option value="<%= Configuration.COMPARATOR_CONTAINS%>">Contains</option>
        <option value="<%= Configuration.COMPARATOR_EQ%>">Equals</option>
        <option value="<%= Configuration.COMPARATOR_GT%>">Greater than</option>
        <option value="<%= Configuration.COMPARATOR_GT_OR_EQ%>">Greater than or equal</option>
        <option value="<%= Configuration.COMPARATOR_LT%>">Less than</option>
        <option value="<%= Configuration.COMPARATOR_LT_OR_EQ%>">Less than or equal</option>
        <option value="<%= Configuration.COMPARATOR_NOT_EQ%>">Not equal</option>
    </select>            
    <br />
    <label for="compValue">Value:</label>
    <input type="text" name="compValue" id="compValue"/>
    <br />
    <label for="logicValue">Logical connector:</label>
    <select name="logicValue" id="logicValue">
        <option value="">Select</option>
        <option value="<%= Configuration.LOGICAL_AND%>">And</option>
        <option value="<%= Configuration.LOGICAL_OR%>">Or</option>
    </select>                
    <br />
    <input type="button" value="Add" onclick="addItem(document.getElementById('fieldRef').value, document.getElementById('compType').value, document.getElementById('compValue').value, document.getElementById('logicValue').value);"/>
    <br />
    <div id="queryParameters"></div>
    <br />
    <form action="ControllerServlet" method="POST">
        <input type="hidden" name="command" value="executeQuery" />
        <input type="hidden" name="parametersQuery" id="parametersQuery" value="" size="100" />
        <input type="submit" value="Execute" />
    </form>
    <br />
    <% String sql = (String) request.getAttribute("sql"); %>
    <% if (sql != null) { %>
    <div class="box-query"\>
        <%= sql %>
    </div>
    <% } %>
    <br />
    <div id="divList">
    <div id="divResultList">
        <% ResultSet resultSet = (ResultSet) request.getAttribute("resultSet");%>
        <% if (resultSet != null) {%>
        <table>
            <tr class="table-header">
                <% int colCount = resultSet.getMetaData().getColumnCount();%>
                <% for (int j = 1; j <= colCount; j++) {%>
                <td><%= resultSet.getMetaData().getColumnName(j)%></td>
                <% }%>
            </tr>
            <% int k = 0;%>
            <% while (resultSet.next()) {%>
            <tr<%= ((k % 2 == 0) ? " class=\"row-admin\"" : "")%>>
                <% for (int j = 1; j <= colCount; j++) {%>
                <td><%= resultSet.getString(j)%></td>
            <% }%>
            <% k++;%>
            </tr>    
            <% }%>
        </table>
        <% }%>    
    </div>  
    </div>
    
    <% }%>
    <br />  
    <input type="button" value="Load configuration" onclick="document.location = 'ControllerServlet?command=loadConfiguration';"/>    
</div>


<script language="JavaScript" type="text/javascript">
    <% if (request.getAttribute("parametersQuery") != null) {%>
        document.getElementById('parametersQuery').value = '<%= request.getAttribute("parametersQuery").toString()%>';
        updateItems();
    <% }%>
</script>

<%@ include file="footer.jsp" %>