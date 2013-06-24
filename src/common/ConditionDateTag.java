// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ConditionDateTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

public class ConditionDateTag extends TagSupport
{

    public ConditionDateTag()
    {
        sectionRS = null;
        hm = null;
    }

    public int doStartTag()
        throws JspTagException
    {
        String s = "select serialno,name from section";
        ConnDatabase conndatabase = new ConnDatabase();
        try
        {
            sectionRS = conndatabase.executeQuery(s);
            hm = new HashMap();
            String s1;
            String s2;
            for(; sectionRS.next(); hm.put(s1, s2))
            {
                s1 = sectionRS.getString("serialno").trim();
                s2 = sectionRS.getString("name").trim();
            }

            if(sectionRS != null)
                sectionRS.close();
        }
        catch(Exception exception)
        {
            System.out.print("conditon tag : cant close sectionRS");
        }
        Set set = hm.keySet();
        Iterator iterator = set.iterator();
        outStr = "<table border=0 cellspacing=0 cellpadding=0>";
        outStr += "<tr>\n<td>";
        outStr += "\u697C\u76D8\u540D:&nbsp;<select name=Section onchange=\"changeCondition()\">\n";
        String s3;
        for(outStr += "<option value=\"\">\n"; iterator.hasNext(); outStr += (String)hm.get(s3) + "\n")
        {
            s3 = (String)iterator.next();
            outStr += "<option value=" + s3 + ">";
        }

        outStr += "</select>\n";
        outStr += "\n&nbsp;\u680B\u53F7:&nbsp;";
        outStr += "<input name=Building size=5 onchange=\"changeCondition()\">&nbsp;";
        outStr += "\u623F\u53F7:&nbsp;<input name=Room size=5 onchange=\"changeCondition()\">&nbsp;";
        outStr += getYearMonth();
        outStr += "&nbsp;&nbsp;</td></tr><tr><td align=right><input type=button id=findb name=Find value=\u67E5\u627E onclick=\"find('findb')\">&nbsp;&nbsp;";
        outStr += "</td></tr></table>";
        try
        {
            JspWriter jspwriter = pageContext.getOut();
            jspwriter.println(outStr);
        }
        catch(IOException ioexception)
        {
            System.out.println("Condition Tag : " + ioexception.getMessage());
        }
        return 0;
    }

    public String getYearMonth()
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int i = Integer.parseInt(timestamp.toString().substring(0, 4));
        int j = Integer.parseInt(timestamp.toString().substring(5, 7));
        String s = "\r\n\t<select name=Year onChange=\"changeCondition()\">";
        for(int k = 2000; k < 2007; k++)
        {
            s = s + "\r\n\t\t<option value=\"";
            s = s + String.valueOf(k) + "\"";
            if(k == i)
                s = s + " selected ";
            s = s + ">" + String.valueOf(k);
        }

        s = s + "\r\n\t</select>\u5E74\r\n";
        s = s + "\r\n\t<select name=Month onchange=\"changeCondition()\">";
        for(int l = 1; l < 13; l++)
        {
            s = s + "\r\n\t\t<option value=\"";
            s = s + String.valueOf(l) + "\"";
            if(l == j)
                s = s + " selected ";
            s = s + ">" + String.valueOf(l);
        }

        s = s + "\r\n\t</select>\u6708\r\n";
        return s;
    }

    ResultSet sectionRS;
    HashMap hm;
    String outStr;
}
