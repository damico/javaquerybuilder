/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.command;

import br.ufc.great.jqb.config.Configuration;
import br.ufc.great.jqb.config.Fieldref;
import br.ufc.great.jqb.config.JavaQueryBuilder;
import br.ufc.great.jqb.ejb.QueryBean;
import br.ufc.great.jqb.ejb.QueryRemote;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        HttpSession session = request.getSession();
        JavaQueryBuilder jqb = (JavaQueryBuilder) session.getAttribute("configurationFile");
        QueryRemote queryRemote = new QueryBean();
        String sql = "from " + jqb.getHeader().getMainview();
        List fields = jqb.getPayload().getFields();
        String strFields = "";
        String strWhere = "";
        for (int i = 0; i < fields.size(); i++) {
            Fieldref f = (Fieldref) fields.get(i);
            strFields += f.getColumn() + " as " + f.getRepresentation();
            if (i != fields.size() - 1)
                strFields += ", ";
        }
        if (parametersQuery.trim().length() > 0) {
            strWhere = " where ";
            String[] parameters = parametersQuery.split(";");
            if (parameters == null)
                parameters = new String[] { parametersQuery };
            for (int i = 0; i < parameters.length; i++) {
                String[] reg = parameters[i].split("@");
                strWhere += reg[0] + " ";
                switch (Integer.parseInt(reg[1])) {
                    case Configuration.COMPARATOR_CONTAINS : {
                        strWhere += reg[0] + " like '%" + reg[2] + "%'";
                        break;
                    }
                    case Configuration.COMPARATOR_EQ : {
                        strWhere += reg[0] + " = '" + reg[2] + "'";
                        break;
                    }
                    case Configuration.COMPARATOR_GT : {
                        strWhere += reg[0] + " > ";
                        break;
                    }
                    case Configuration.COMPARATOR_GT_OR_EQ : {
                        strWhere += reg[0] + " >= ";
                        break;
                    }
                    case Configuration.COMPARATOR_LT : {
                        strWhere += reg[0] + " < ";
                        break;
                    }
                    case Configuration.COMPARATOR_LT_OR_EQ : {
                        strWhere += reg[0] + " <= ";
                        break;
                    }                    
                    case Configuration.COMPARATOR_NOT_EQ : {
                        strWhere += reg[0] + " <> '" + reg[2] + "'";
                        break;
                    }                                        
                }
                switch (Integer.parseInt(reg[3])) {
                    case Configuration.LOGICAL_AND : {
                        strWhere += " and";
                        break;
                    }
                    case Configuration.LOGICAL_OR : {
                        strWhere += " or";
                        break;
                    }
                }                
            }
            if (strWhere.endsWith("or"));
                strWhere = strWhere.substring(0, strWhere.length() - 3);
            if (strWhere.endsWith("and"));
                strWhere = strWhere.substring(0, strWhere.length() - 4);
        }
        sql = "select " + strFields + " " + sql + strWhere;
        ResultSet resultSet = queryRemote.execute(sql, jqb.getHeader().getSource());
        if (resultSet != null)
            request.setAttribute("resultSet", resultSet);
        return "WEB-INF/jsp/mountQuery.jsp";
    }

}
