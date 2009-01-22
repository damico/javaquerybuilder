package br.ufc.great.jqb.utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public final class Utils {

    public static Object getEJB(String jndiName, Class clazz) {
        Object ejb = null;
        try {
            InitialContext initialContext = new InitialContext();
            java.lang.Object ejbRemoteRef = initialContext.lookup(jndiName);
            ejb = javax.rmi.PortableRemoteObject.narrow(ejbRemoteRef, clazz);
        } 
        catch (NamingException e) {
            ejb = null;
        }        
        return ejb;
    }
    
    public static Connection getConnection() {
        Connection connection = null;
        try {
            InitialContext initialContext = new InitialContext();
            DataSource dataSource = (DataSource) initialContext.lookup("jdbc/portal");
            connection = dataSource.getConnection();
        } 
        catch (SQLException ex) {
            Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
            connection = null;
        }        
        catch (NamingException ex) {
            Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
            connection = null;
        }        
        return connection;
    }
    
}
