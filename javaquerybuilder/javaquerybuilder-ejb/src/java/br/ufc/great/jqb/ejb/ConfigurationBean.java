/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.great.jqb.ejb;

import br.ufc.great.jqb.config.Configuration;
import br.ufc.great.jqb.config.JavaQueryBuilder;
import javax.ejb.Stateless;

/**
 *
 * @author leoomoreira
 */
@Stateless
public class ConfigurationBean implements ConfigurationRemote {

    public JavaQueryBuilder createConfiguration(String xml) {
        JavaQueryBuilder jqb = Configuration.getConfiguration(xml);
        return jqb;
    }
    
}
