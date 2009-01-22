package br.ufc.great.jqb.utils;

import java.sql.Connection;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public final class Utils {

    public static Connection getConnection(String jndiName) {
        Connection connection = null;
        try {
            InitialContext initialContext = new InitialContext();
            java.lang.Object ejbRemoteRef = initialContext.lookup(jndiName);
            connection = (Connection) javax.rmi.PortableRemoteObject.narrow(ejbRemoteRef, Connection.class);
        } 
        catch (NamingException e) {
            connection = null;
        }        
        return connection;
    }
    
}
