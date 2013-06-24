// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CommonListBean.java

package crmzl;

import java.io.PrintStream;
import java.sql.ResultSet;

// Referenced classes of package crmzl:
//            crmzl

public class CommonListBean
{

    public CommonListBean()
    {
    }

    public String getList(crmzl crmzl1, String s, String s1, String s2)
    {
        String s3 = "";
        String s4 = (new StringBuilder()).append("select ").append(s).append(",").append(s1).append(" ").append(s2).toString();
        if(s.equals(s1))
            s4 = (new StringBuilder()).append("select ").append(s).append(" ").append(s2).toString();
        try
        {
            ResultSet resultset = crmzl1.executeQuery(s4);
            if(resultset == null)
                System.out.println("commonresult is null");
            while(resultset.next()) 
                if(s.equals(s1))
                {
                    String s5 = resultset.getObject(1).toString();
                    s3 = (new StringBuilder()).append(s3).append("<option value='").append(s5).append("'>").append(s5).append("</option>").toString();
                } else
                {
                    s3 = (new StringBuilder()).append(s3).append("<option value='").append(resultset.getObject(1).toString().trim()).append("'>").append(resultset.getObject(2).toString()).append("</option>").toString();
                }
            if(resultset != null)
                resultset.close();
        }
        catch(Exception exception)
        {
            System.out.println("commonlistbean error");
        }
        return s3;
    }
}
