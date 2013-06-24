// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ItemsTag.java

package common;

import java.io.IOException;
import java.io.PrintStream;
import java.util.Iterator;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.*;

// Referenced classes of package common:
//            PartTag

public class ItemsTag extends BodyTagSupport
{

    public ItemsTag()
    {
        iterator = null;
        item = null;
    }

    public int doStartTag()
        throws JspTagException
    {
        PartTag parttag = (PartTag)TagSupport.findAncestorWithClass(this, common.PartTag.class);
        if(parttag == null)
            throw new JspTagException("ItemsTag: items tag not inside parttag tag");
        iterator = parttag.getIterator();
        if(iterator == null || !iterator.hasNext())
        {
            return 0;
        } else
        {
            item = iterator.next();
            return 2;
        }
    }

    public int doAfterBody()
    {
        if(iterator.hasNext())
        {
            item = iterator.next();
            return 2;
        } else
        {
            return 0;
        }
    }

    public int doEndTag()
    {
        try
        {
            BodyContent bodycontent = getBodyContent();
            if(bodycontent != null)
            {
                JspWriter jspwriter = bodycontent.getEnclosingWriter();
                jspwriter.print(bodycontent.getString());
            }
        }
        catch(IOException ioexception)
        {
            System.out.println("Error handling items tag: " + ioexception);
        }
        return 6;
    }

    public Object getCurrentItem()
    {
        return item;
    }

    private Iterator iterator;
    private Object item;
}
