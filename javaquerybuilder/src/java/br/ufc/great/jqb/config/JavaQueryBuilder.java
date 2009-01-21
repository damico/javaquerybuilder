package br.ufc.great.jqb.config;

import java.io.Serializable;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class JavaQueryBuilder implements Serializable {

    private Header header;
    private Payload payload;

    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    public Payload getPayload() {
        return payload;
    }

    public void setPayload(Payload payload) {
        this.payload = payload;
    }
    
}
