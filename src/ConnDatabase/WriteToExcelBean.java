// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   WriteToExcelBean.java

package ConnDatabase;

import java.io.*;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

// Referenced classes of package ConnDatabase:
//            SDatabase

public class WriteToExcelBean
{

    public WriteToExcelBean()
    {
    }

    public String WriteToExcel(SDatabase sdatabase, String s, String s1, String s2, String s3)
    {
        String s4 = "";
        String s5 = "";
        try
        {
            PrintWriter printwriter = new PrintWriter(new FileOutputStream(s3));
            printwriter.println(s);
            printwriter.println(s1);
            try
            {
                Object obj = null;
                ResultSet resultset = sdatabase.executeQuery(s2);
                int i = 0;
                if(resultset == null)
                {
                    System.out.println("result is null");
                } else
                {
                    ResultSetMetaData resultsetmetadata = resultset.getMetaData();
                    i = resultsetmetadata.getColumnCount();
                }
                int j = 0;
                String s6;
                for(; resultset.next(); printwriter.println(new String(s6.getBytes("iso-8859-1"))))
                {
                    s6 = "";
                    j++;
                    for(int k = 1; k <= i; k++)
                        if(resultset.getObject(k) != null)
                            if(k == i)
                                s6 = s6 + resultset.getObject(k).toString().trim();
                            else
                                s6 = s6 + resultset.getObject(k).toString().trim() + ",";

                }

                resultset.close();
                s4 = "ok";
            }
            catch(Exception exception)
            {
                System.out.println("system error");
            }
            printwriter.close();
        }
        catch(IOException ioexception)
        {
            System.out.println(ioexception.getMessage());
        }
        return s4;
    }
}
