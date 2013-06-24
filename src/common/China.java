// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   China.java

package common;

import java.io.PrintStream;
import javax.servlet.http.HttpServletRequest;

public class China
{

    public China()
    {
    }

    public static String getParameter(HttpServletRequest httpservletrequest, String s)
    {
        try
        {
            String s1 = "";
            String as[] = httpservletrequest.getParameterValues(s);
            if(as == null)
            {
                s1 = "";
                return "";
            }
            for(int i = 0; i < as.length; i++)
            {
                if(i != 0)
                    s1 = s1 + ",";
                s1 = s1 + new String(as[i].getBytes("ISO8859_1"), "GBK");
            }

            return s1;
        }
        catch(Exception exception)
        {
            System.out.println("china : has exception");
        }
        return "";
    }
}
