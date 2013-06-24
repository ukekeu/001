// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ConditionTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

public class ConditionTag extends TagSupport
{

    public ConditionTag()
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
        outStr = "<table border=0 cellspacing=1 cellpadding=1>\n";
        outStr += "\t<tr>\n";
        outStr += "\t\t<td>\n";
        outStr += "\t\t\t\u697C\u76D8&nbsp;<select name=Section> \n";
        String s3;
        for(outStr += "\t\t\t\t<option value=\"\">\n"; iterator.hasNext(); outStr += (String)hm.get(s3) + "\n")
        {
            s3 = (String)iterator.next();
            outStr += "\t\t\t\t<option value=" + s3 + ">";
        }

        outStr += "\t\t\t</select>\n";
        outStr += "\t\t\t&nbsp;\u680B\u53F7&nbsp;\n";
        outStr += "\t\t\t<input name=Building size=8>&nbsp;&nbsp;\n";
        outStr += "\t\t\t<input type=button id=findb name=Find value=\u67E5\u627E onclick=\"find('findb')\">&nbsp;&nbsp;\n";
        outStr += "\t\t</td>\n";
        outStr += "\t</tr>\n";
        outStr += "</table>\n";
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

    ResultSet sectionRS;
    HashMap hm;
    String outStr;
}
