// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ConditionSearchTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

public class ConditionSearchTag extends TagSupport
{

    public ConditionSearchTag()
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
        outStr = "<table border=0 cellspacing=0 cellpadding=0>\n";
        outStr += "\t<tr>\n";
        outStr += "\t\t<td>\n";
        outStr += "\t\t\t&nbsp;\u697C\u76D8&nbsp;<select name=Section onchange=\"changeCondition()\">\n";
        String s3;
        for(outStr += "\t\t\t\t<option value=\"\">\n"; iterator.hasNext(); outStr += (String)hm.get(s3) + "\n")
        {
            s3 = (String)iterator.next();
            outStr += "\t\t\t\t<option value=" + s3 + ">";
        }

        outStr += "\t\t\t</select>\n";
        outStr += "\t\t\t&nbsp;\u680B\u53F7&nbsp;<input name=Building size=8 onchange=\"changeCondition()\">";
        outStr += getSearch();
        outStr += "\t\t\t&nbsp;<input type=button id=findb name=Find value=\u67E5\u627E onclick=\"find('findb')\">\n";
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

    public String getSearch()
    {
        String s = "\t\t\t&nbsp;\u6237\u578B&nbsp;<select name=RoomType onchange=\"changeCondition()\"> \n";
        s = s + "\t\t\t\t<option value=''>\n";
        s = s + "\t\t\t\t<option value=\"\u4E00\u623F\u4E00\u5385\">\u4E00\u623F\u4E00\u5385\n";
        s = s + "\t\t\t\t<option value=\"\u4E24\u623F\u4E00\u5385\">\u4E24\u623F\u4E00\u5385\n";
        s = s + "\t\t\t\t<option value=\"\u4E24\u623F\u4E24\u5385\">\u4E24\u623F\u4E24\u5385\n";
        s = s + "\t\t\t\t<option value=\"\u4E09\u623F\u4E24\u5385\">\u4E09\u623F\u4E24\u5385\n";
        s = s + "\t\t\t\t<option value=\"\u56DB\u623F\u4E8C\u5385\">\u56DB\u623F\u4E8C\u5385\n";
        s = s + "\t\t\t</select>\n";
        s = s + "\t\t\t&nbsp;\u9762\u79EF&nbsp;<select name=Area onChange=\"changeCondition()\">\n";
        s = s + "\t\t\t\t<option value=''>\n";
        s = s + "\t\t\t\t<option value=\"50-\">\u5C0F\u4E8E50\n";
        s = s + "\t\t\t\t<option value=\"50+100-\">50~100\n";
        s = s + "\t\t\t\t<option value=\"100+150-\">100~150\n";
        s = s + "\t\t\t\t<option value=\"150+\">\u5927\u4E8E150\n";
        s = s + "\t\t\t</select>\n";
        return s;
    }

    ResultSet sectionRS;
    HashMap hm;
    String outStr;
}
