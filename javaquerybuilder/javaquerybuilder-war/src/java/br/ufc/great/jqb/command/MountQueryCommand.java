/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.command;

import br.ufc.great.jqb.config.JavaQueryBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 * 
 */
public class MountQueryCommand implements Command {

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if (session.getAttribute("configurationFile") != null && session.getAttribute("configurationFile") instanceof JavaQueryBuilder) {
            return "WEB-INF/jsp/mountQuery.jsp";
        }
        return null;
    }

}
