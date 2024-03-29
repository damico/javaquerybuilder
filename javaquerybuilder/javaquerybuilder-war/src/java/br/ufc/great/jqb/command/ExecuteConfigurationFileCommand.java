package br.ufc.great.jqb.command;

import br.ufc.great.jqb.config.Configuration;
import br.ufc.great.jqb.config.JavaQueryBuilder;
import br.ufc.great.jqb.ejb.ConfigurationBean;
import br.ufc.great.jqb.ejb.ConfigurationRemote;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class ExecuteConfigurationFileCommand implements Command {

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {
            try {
                List items = (List) request.getAttribute("multipartItems");
                request.removeAttribute("multipartItems");
                Iterator iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (! item.isFormField()) {
                        String contentType = item.getContentType();
                        if (contentType.equalsIgnoreCase("text/xml")) {
                            String xml = "";
                            BufferedReader br = new BufferedReader(new InputStreamReader(item.getInputStream()));
                            String temp = br.readLine();
                            while (temp != null) {
                                xml += temp;
                                temp = br.readLine();
                            }
                            br.close();
                            HttpSession session = request.getSession();
                            ConfigurationRemote configurationRemote = new ConfigurationBean();
                            JavaQueryBuilder jqb = configurationRemote.createConfiguration(xml);
                            session.setAttribute("configurationFile", jqb);
                            return "WEB-INF/jsp/configuration.jsp";
                        }
                    }
                }
            }
            catch (IOException ex) {

            }
        }
        return null;
    }
}
