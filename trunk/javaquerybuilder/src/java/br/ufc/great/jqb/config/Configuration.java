package br.ufc.great.jqb.config;

import com.thoughtworks.xstream.XStream;
import java.io.InputStream;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 */
public class Configuration {

    public static JavaQueryBuilder getConfiguration(InputStream inputStream) {
        XStream xStream = createXStreamObject();
        JavaQueryBuilder jqb = (JavaQueryBuilder) xStream.fromXML(inputStream);
        return jqb;        
    }
    
    public static JavaQueryBuilder getConfiguration(String xml) {
        XStream xStream = createXStreamObject();
        JavaQueryBuilder jqb = (JavaQueryBuilder) xStream.fromXML(xml);
        return jqb;        
    }
    
    private static XStream createXStreamObject() {
        XStream xStream = new XStream();
        xStream.alias("javaquerybuilder", JavaQueryBuilder.class);
        xStream.alias("header", Header.class);
        xStream.aliasAttribute(Header.class, "doctype", "doctype");
        xStream.aliasAttribute(Header.class, "source", "source");
        xStream.aliasAttribute(Header.class, "mainview", "mainview");
        xStream.alias("payload", Payload.class);
        xStream.alias("fields", java.util.List.class);
        xStream.alias("fieldref", Fieldref.class);
        xStream.aliasAttribute(Fieldref.class, "column", "column");
        xStream.aliasAttribute(Fieldref.class, "relationship", "relationship");
        xStream.aliasAttribute(Fieldref.class, "representation", "representation");
        xStream.aliasAttribute(Fieldref.class, "type", "type");
        return xStream;
    }
    
    public static void main(String[] args) {
        
    }
    
}
