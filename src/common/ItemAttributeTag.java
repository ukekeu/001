// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ItemAttributeTag.java

package common;

import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package common:
//            ItemsTag

public abstract class ItemAttributeTag extends TagSupport
{

    public ItemAttributeTag()
    {
        item = null;
        attribute = null;
    }

    public int doStartTag()
        throws JspTagException
    {
        ItemsTag itemstag = (ItemsTag)TagSupport.findAncestorWithClass(this, common.ItemsTag.class);
        if(itemstag == null)
            throw new JspTagException("ItemAttributeTag: itemsAttribute tag notinside items tag");
        item = itemstag.getCurrentItem();
        try
        {
            JspWriter jspwriter = pageContext.getOut();
            jspwriter.print(createText());
        }
        catch(IOException ioexception)
        {
            System.out.println("ItemAttributeTag: Error printing attribute: " + ioexception);
        }
        return 0;
    }

    public void setAttribute(String s)
    {
        attribute = s;
    }

    protected abstract String createText();

    protected Object item;
    protected String attribute;
}
