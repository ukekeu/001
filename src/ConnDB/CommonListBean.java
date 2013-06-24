// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CommonListBean.java

package ConnDB;

import java.io.PrintStream;
import java.sql.ResultSet;

// Referenced classes of package ConnDB:
//            ConnODBC

public class CommonListBean
{

    public CommonListBean()
    {
    }

    public String getList(ConnODBC connodbc, String s, String s1, String s2)
    {
        String s3 = "";
        String s4 = "select " + s + "," + s1 + " " + s2;
        if(s.equals(s1))
            s4 = "select " + s + " " + s2;
        try
        {
            ResultSet resultset = connodbc.executeQuery(s4);
            if(resultset == null)
                System.out.println("commonresult is null");
            while(resultset.next()) 
                if(s.equals(s1))
                {
                    String s5 = resultset.getObject(1).toString();
                    s3 = s3 + "<option value='" + s5 + "'>" + s5 + "</option>";
                } else
                {
                    s3 = s3 + "<option value='" + resultset.getObject(1).toString().trim() + "'>" + resultset.getObject(2).toString() + "</option>";
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
