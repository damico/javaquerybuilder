/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import javax.ejb.Remote;

/**
 *
 * @author leoomoreira
 */
@Remote
public interface QueryRemote {

    public void execute();
    
}
