// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   selecttag.java

package common;

import ConnDatabase.SDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class SelectTag extends BodyTagSupport
{

    public SelectTag()
    {
    }

    public int doStartTag()
    {
        return 6;
    }

    public int doEndTag()
    {
        try
        {
            BodyContent bodycontent = getBodyContent();
            JspWriter jspwriter = bodycontent.getEnclosingWriter();
            String s = bodycontent.getString();
            String s1 = "";
            String s3 = "";
            SDatabase sdatabase = new SDatabase();
            ResultSet resultset = sdatabase.executeQuery(s);
            String s4;
            String s5;
            for(s5 = "\r\n\t<select name=" + name + ">"; resultset.next(); s5 = s5 + "\">" + s4)
            {
                String s2;
                if(index.equals("1"))
                {
                    s2 = resultset.getString(codeName).trim();
                    s4 = resultset.getString(valueName).trim();
                } else
                {
                    s4 = resultset.getString(valueName).trim();
                    s2 = resultset.getString(codeName).trim();
                }
                s5 = s5 + "\r\n\t\t<option value=\"" + s2;
            }

            s5 = s5 + "\r\n\t</select>";
            jspwriter.print(s5);
        }
        catch(Exception exception)
        {
            System.out.println("selecttag : do endtag" + exception.getMessage());
        }
        return 6;
    }

    public void setName(String s)
    {
        name = s;
    }

    public void setValueName(String s)
    {
        valueName = s;
    }

    public void setCodeName(String s)
    {
        codeName = s;
    }

    public void setIndex(String s)
    {
        index = s;
    }

    private String name;
    private String index;
    private String valueName;
    private String codeName;
}
