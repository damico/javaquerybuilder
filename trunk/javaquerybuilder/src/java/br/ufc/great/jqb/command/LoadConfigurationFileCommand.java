package br.ufc.great.jqb.command;

import br.ufc.great.jqb.config.Configuration;
import br.ufc.great.jqb.config.JavaQueryBuilder;
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
public class LoadConfigurationFileCommand implements Command {

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
                        System.out.println(contentType);
                        if (contentType.equalsIgnoreCase("text/xml")) {
                            String xml = "";
                            BufferedReader br = new BufferedReader(new InputStreamReader(item.getInputStream()));
                            String temp = br.readLine();
                            while (temp != null) {
                                xml += temp;
                                temp = br.readLine();
                            }
                            br.close();
                            JavaQueryBuilder jqb = Configuration.getConfiguration(xml);
                            HttpSession session = request.getSession();
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
