package br.ufc.great.jqb.config;

import java.io.Serializable;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class Header implements Serializable {

    private String doctype;
    private String source;
    private String mainview;

    public String getDoctype() {
        return doctype;
    }

    public void setDoctype(String doctype) {
        this.doctype = doctype;
    }

    public String getMainview() {
        return mainview;
    }

    public void setMainview(String mainview) {
        this.mainview = mainview;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
    
}
