/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.great.jqb.servlet;

import br.ufc.great.jqb.command.Command;
import br.ufc.great.jqb.command.ExecuteConfigurationFileCommand;
import br.ufc.great.jqb.command.ExecuteQueryCommand;
import br.ufc.great.jqb.command.LoadConfigurationFileCommand;
import br.ufc.great.jqb.command.MountQueryCommand;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Leonardo Oliveira Moreira
 */
public class ControllerServlet extends GenericServlet {

    private Hashtable<String, Command> commands;

    public void init(ServletConfig servletConfig) throws ServletException {
        commands = new Hashtable<String, Command>();
        commands.put("loadConfiguration", new LoadConfigurationFileCommand());
        commands.put("executeConfiguration", new ExecuteConfigurationFileCommand());
        commands.put("mountQuery", new MountQueryCommand());
        commands.put("executeQuery", new ExecuteQueryCommand());
    }

    private String getCommandName(HttpServletRequest request) {
        String result = request.getParameter("command");
        if (result == null) {
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                try {
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List items = upload.parseRequest(request);
                    request.setAttribute("multipartItems", items);                    
                    Iterator iter = items.iterator();
                    while (iter.hasNext()) {
                        FileItem item = (FileItem) iter.next();
                        if (item.isFormField()) {
                            if (item.getFieldName().equalsIgnoreCase("command"))
                                return item.getString();
                        }
                    }
                }
                catch (FileUploadException ex) {
                    result = null;
                }
            }
        }
        return result;
    }

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String strCommand = getCommandName(request);
        System.out.println("Command: " + strCommand);
        Command command = commands.get(strCommand);
        String strReturn = command.execute(request, response);
        System.out.println("Return: " + strReturn);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(strReturn);
        requestDispatcher.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Controller Servlet";
    }// </editor-fold>
}
