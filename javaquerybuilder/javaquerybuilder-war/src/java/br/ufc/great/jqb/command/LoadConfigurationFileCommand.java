package br.ufc.great.jqb.command;

import br.ufc.great.jqb.config.Configuration;
import br.ufc.great.jqb.config.JavaQueryBuilder;
import br.ufc.great.jqb.ejb.ConfigurationBean;
import br.ufc.great.jqb.ejb.ConfigurationRemote;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class LoadConfigurationFileCommand implements Command {

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if (session.getAttribute("configurationFile") == null) {
            ConfigurationRemote configurationRemote = new ConfigurationBean();
            String xml = "";
            try {
                BufferedReader br = new BufferedReader(new InputStreamReader(Configuration.class.getResourceAsStream("config.xml")));
                String temp = br.readLine();
                while (temp != null) {
                    xml += temp;
                    temp = br.readLine();
                }
                br.close();
                JavaQueryBuilder jqb = configurationRemote.createConfiguration(xml);
                if (jqb != null)
                    session.setAttribute("configurationFile", jqb);
                return "ControllerServlet?command=mountQuery";
            }
            catch (Exception e) {

            }
        }
        return "WEB-INF/jsp/configuration.jsp";

    }
    
}
