/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import javax.ejb.Local;

/**
 *
 * @author leoomoreira
 */
@Local
public interface QueryLocal {

    public void execute();
    
}
