package br.ufc.great.jqb.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public interface Command {

    public String execute(HttpServletRequest request, HttpServletResponse response);
    
}
