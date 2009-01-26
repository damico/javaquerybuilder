/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import java.sql.ResultSet;
import javax.ejb.Remote;

/**
 *
 * @author leoomoreira
 */
@Remote
public interface QueryRemote {

    public ResultSet execute(String query, String jndi);
    
}
