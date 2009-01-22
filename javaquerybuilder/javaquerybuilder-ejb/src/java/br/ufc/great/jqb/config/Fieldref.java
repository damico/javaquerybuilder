package br.ufc.great.jqb.config;

import java.io.Serializable;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class Fieldref implements Serializable {

    private String column;
    private String relationship;
    private String representation;
    private String type;

    public String getColumn() {
        return column;
    }

    public void setColumn(String column) {
        this.column = column;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getRepresentation() {
        return representation;
    }

    public void setRepresentation(String representation) {
        this.representation = representation;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
}
