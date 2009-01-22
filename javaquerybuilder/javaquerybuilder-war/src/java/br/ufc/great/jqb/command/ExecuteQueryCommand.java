/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.command;

import br.ufc.great.jqb.ejb.QueryBean;
import br.ufc.great.jqb.ejb.QueryRemote;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author leoomoreira
 */
public class ExecuteQueryCommand implements Command {

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String parametersQuery = request.getParameter("parametersQuery");
        if (parametersQuery != null && parametersQuery.trim().length() > 0) {
            request.setAttribute("parametersQuery", parametersQuery);
        }
        QueryRemote queryRemote = new QueryBean();
        ResultSet resultSet = queryRemote.execute("select * from person");
        if (resultSet != null)
            request.setAttribute("resultSet", resultSet);
        return "WEB-INF/jsp/mountQuery.jsp";
    }

}