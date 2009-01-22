package br.ufc.great.jqb.config;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class Payload implements Serializable {

    private List fields;

    public List getFields() {
        return fields;
    }

    public void setFields(List fields) {
        this.fields = fields;
    }
    
}

