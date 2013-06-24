// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PageNavTag.java

package common;

import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package common:
//            PartTag

public class PageNavTag extends TagSupport
{

    public PageNavTag()
    {
        page = null;
        partTag = null;
    }

    public int doStartTag()
        throws JspTagException
    {
        partTag = (PartTag)TagSupport.findAncestorWithClass(this, common.PartTag.class);
        if(partTag == null)
            throw new JspTagException("pageNavTag: page nav tag not inside parttag");
        HttpServletRequest httpservletrequest = (HttpServletRequest)pageContext.getRequest();
        String s = partTag.getPageIndexPrefix();
        try
        {
            JspWriter jspwriter = pageContext.getOut();
            if(partTag.hasPrev || partTag.hasNext)
            {
                System.out.println(" pagenavpage : has next or prev");
                jspwriter.print("<input type=hidden name=\"" + s + "\">");
                if(partTag.hasPrev)
                {
                    String s1 = "<input type=hidden name=" + s + "_prev";
                    s1 = s1 + " value=" + partTag.getPrevPageIndex() + ">";
                    s1 = s1 + "<a href=\"javascript:find('preva')\" name=preva><<\u4E0A\u4E00\u9875</a>";
                    jspwriter.print(s1);
                }
                if(partTag.hasNext)
                {
                    String s2 = "<input type=hidden name=" + s + "_next";
                    s2 = s2 + " value=" + partTag.getNextPageIndex() + ">";
                    s2 = s2 + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    s2 = s2 + "<a href=\"javascript:find('nexta')\" name=nexta>\u4E0B\u4E00\u9875>></a>";
                    jspwriter.print(s2);
                }
            }
            return 1;
        }
        catch(IOException ioexception)
        {
            System.out.println("page nav Tag: error printing tag");
        }
        return 0;
    }

    public int doEndTag()
    {
        return 6;
    }

    public void setPage(String s)
    {
        page = s;
    }

    String page;
    private PartTag partTag;
}
