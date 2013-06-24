// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DateTag.java

package common;

import java.io.PrintStream;
import java.sql.Timestamp;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

public class DateTag extends TagSupport
{

    public DateTag()
    {
    }

    public int doStartTag()
    {
        return 0;
    }

    public int doEndTag()
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int i = Integer.parseInt(timestamp.toString().substring(0, 4));
        int j = Integer.parseInt(timestamp.toString().substring(5, 7));
        int k = Integer.parseInt(timestamp.toString().substring(8, 10));
        String s = "\r\n\t<select name=" + name + "Year>";
        for(int l = 2000; l < 2007; l++)
        {
            s = s + "\r\n\t\t<option value=\"";
            s = s + String.valueOf(l) + "\"";
            if(l == i)
                s = s + " selected ";
            s = s + ">" + String.valueOf(l);
        }

        s = s + "\r\n\t</select>\u5E74\r\n";
        s = s + "\r\n\t<select name=" + name + "Month>";
        for(int i1 = 1; i1 < 13; i1++)
        {
            s = s + "\r\n\t\t<option value=\"";
            s = s + String.valueOf(i1) + "\"";
            if(i1 == j)
                s = s + " selected ";
            s = s + ">" + String.valueOf(i1);
        }

        s = s + "\r\n\t</select>\u6708\r\n";
        s = s + "\r\n\t<select name=" + name + "Day>";
        for(int j1 = 1; j1 < 32; j1++)
        {
            s = s + "\r\n\t\t<option value=\"";
            s = s + String.valueOf(j1) + "\"";
            if(j1 == k)
                s = s + " selected ";
            s = s + ">" + String.valueOf(j1);
        }

        s = s + "\r\n\t</select>\u65E5\r\n";
        JspWriter jspwriter = pageContext.getOut();
        try
        {
            jspwriter.print(s);
        }
        catch(Exception exception)
        {
            System.out.print("datetag doendtag:" + exception.getMessage());
        }
        return 6;
    }

    public void setDays(String s)
    {
        days = s;
    }

    public void setName(String s)
    {
        name = s;
    }

    private String days;
    private String name;
}
