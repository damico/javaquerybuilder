/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import br.ufc.great.jqb.config.JavaQueryBuilder;
import javax.ejb.Remote;

/**
 *
 * @author leoomoreira
 */
@Remote
public interface ConfigurationRemote {
    public JavaQueryBuilder createConfiguration(String xml);
}
