// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PartTag.java

package common;

import java.io.PrintStream;
import java.util.Collection;
import java.util.Iterator;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package common:
//            SelectedPart

public abstract class PartTag extends TagSupport
{

    public PartTag()
    {
        INDX_PARA = "pageindex";
        iterator = null;
        collection = null;
        pageIndexValue = null;
        hasNext = true;
        hasPrev = false;
        part = null;
    }

    public int doStartTag()
        throws JspTagException
    {
        initParamPrefix();
        pageIndexValue = pageContext.getRequest().getParameter(prefix + INDX_PARA);
        System.out.println("parttag : " + pageIndexValue);
        if(pageIndexValue == null || pageIndexValue.equals(""))
            pageIndexValue = "1";
        try
        {
            pageIndex = Integer.parseInt(pageIndexValue);
        }
        catch(Exception exception)
        {
            System.out.println("part tag : ");
        }
        prevPageIndex = pageIndex - 1;
        nextPageIndex = pageIndex + 1;
        if(pageIndex > 1)
            hasPrev = true;
        else
            hasPrev = false;
        JspWriter jspwriter = pageContext.getOut();
        try
        {
            findCollection();
            if(collection == null || collection != null && collection.size() == 0)
            {
                jspwriter.print("<p align=center ><font color=#ff0000>\u6CA1\u6709\u7B26\u5408\u6761\u4EF6\u7684\u8BB0\u5F55</font>");
                return 0;
            }
            iterator = collection.iterator();
        }
        catch(Exception exception1)
        {
            collection = null;
            try
            {
                jspwriter.print("<p align=center><font color=#ff0000>\u51FA\u73B0\u9519\u8BEF\uFF0C\u8BF7\u91CD\u8BD5</font>");
            }
            catch(Exception exception2)
            {
                System.out.print(exception2.getMessage());
            }
            return 0;
        }
        return 1;
    }

    public int doEndTag()
    {
        collection = null;
        return 6;
    }

    public Iterator getIterator()
    {
        return iterator;
    }

    public String getPrefix()
    {
        return prefix;
    }

    public String getPageIndexPrefix()
    {
        return prefix + INDX_PARA;
    }

    public String getPrevPageIndex()
    {
        return String.valueOf(prevPageIndex);
    }

    public String getNextPageIndex()
    {
        return String.valueOf(nextPageIndex);
    }

    public void getNavInfo(SelectedPart selectedpart)
    {
    }

    protected void findCollection()
        throws Exception
    {
        part = findPart();
        collection = part.getCollection();
        allLines = part.getAll();
        pageIndex = part.getIndex();
        pageSize = part.getSize();
        factSize = part.getSelect();
        int i = allLines / pageSize;
        int j = allLines % pageSize;
        if(j > 0)
            i++;
        System.out.println("odd : " + j);
        System.out.println("allLines : " + allLines + " pages : " + i + " pagesize : " + pageSize + " pageindex: " + pageIndex);
        if(pageIndex < i)
            hasNext = true;
        else
            hasNext = false;
    }

    protected abstract SelectedPart findPart()
        throws Exception;

    protected abstract void initParamPrefix();

    protected int allLines;
    protected int pageIndex;
    protected int pageSize;
    protected int factSize;
    protected String section;
    protected String building;
    protected int prevPageIndex;
    protected int nextPageIndex;
    protected String prefix;
    protected String INDX_PARA;
    protected Iterator iterator;
    protected Collection collection;
    protected String pageIndexValue;
    protected boolean hasNext;
    protected boolean hasPrev;
    SelectedPart part;
}
