/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import br.ufc.great.jqb.utils.Utils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;

/**
 *
 * @author leoomoreira
 */
@Stateless
public class QueryBean implements QueryRemote {

    public ResultSet execute(String query, String jndi) {
        Connection connection = Utils.getConnection(jndi);
        ResultSet resultSet = null;
        try {
            if (! connection.isClosed()) {
                Statement statement = connection.createStatement();
                resultSet = statement.executeQuery(query);
            }
        } 
        catch (SQLException ex) {
            Logger.getLogger(ConfigurationBean.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultSet;
    }
    
    // Add business logic below. (Right-click in editor and choose
    // "EJB Methods > Add Business Method" or "Web Service > Add Operation")
 
}
